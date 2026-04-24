from flask import Flask, render_template, request, redirect, url_for, session
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = "mysql+pymysql://root:@localhost/videogame_project"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.secret_key = "gamingproject"

db = SQLAlchemy(app)


@app.route("/")
def home():
    if "username" not in session:
        return redirect(url_for("login"))

   
    search = request.args.get("search", "").strip()
    filter_by = request.args.get("filter_by", "title")

    allowed_filters = {
        "title": "title",
        "genre": "genre",
        "platform": "platform",
        "company": "companyName",
        "age": "age_rec"
    }

    column = allowed_filters.get(filter_by, "title")

    try:
        with db.engine.connect() as connection:
            if search:
                query = text(f"""
                    SELECT title, year, platform, age_rec, companyName, genre
                    FROM videogames
                    WHERE {column} LIKE :search
                """)
                result = connection.execute(query, {"search": f"%{search}%"})
            else:
                result = connection.execute(text("""
                    SELECT title, year, platform, age_rec, companyName, genre
                    FROM videogames
                """))

            games = result.fetchall()

        return render_template("index.html", games=games, search=search, filter_by=filter_by)

    except Exception as e:
        return f"<h1>Error</h1><p>{str(e)}</p>"


@app.route("/game/<title>")
def game_detail(title):
    if "username" not in session:
        return redirect(url_for("login"))

    try:
        with db.engine.connect() as connection:
            game_result = connection.execute(
                text("""
                    SELECT videogames.title, videogames.year, videogames.platform,
                           videogames.age_rec, videogames.companyName, videogames.genre, company.address
                    FROM videogames
                    LEFT JOIN company ON videogames.companyName = company.name
                    WHERE videogames.title = :title
                """),
                {"title": title}
            )
            game = game_result.fetchone()

            review_result = connection.execute(
                text("""
                    SELECT rating, caption, date, username
                    FROM review
                    WHERE gameTitle = :title
                    ORDER BY date DESC
                """),
                {"title": title}
            )
            reviews = review_result.fetchall()

        return render_template("game.html", game=game, reviews=reviews)

    except Exception as e:
        return f"<h1>Error</h1><p>{str(e)}</p>"


@app.route("/users")
def users():
    if "username" not in session:
        return redirect(url_for("login"))
    try:
        with db.engine.connect() as connection:
            result = connection.execute(text("""
                SELECT username, age, interest
                FROM users
                ORDER BY username
            """))
            users = result.fetchall()

        return render_template("users.html", users=users)

    except Exception as e:
        return f"<h1>Error</h1><p>{str(e)}</p>"


@app.route("/user/<username>")
def user_profile(username):
    if "username" not in session:
        return redirect(url_for("login"))


    try:
        with db.engine.connect() as connection:
            result = connection.execute(
                text("""
                    SELECT username, age, interest
                    FROM users
                    WHERE username = :username
                """),
                {"username": username}
            )
            user = result.fetchone()

            if not user:
                return "<h1>User not found</h1>"

            owned_count_result = connection.execute(
                text("""
                    SELECT COUNT(*) AS total
                    FROM plays
                    WHERE username = :username
                """),
                {"username": username}
            )
            owned_count = owned_count_result.fetchone()

        return render_template(
            "user_profile.html",
            user=user,
            owned_count=owned_count.total
        )

    except Exception as e:
        return f"<h1>Error</h1><p>{str(e)}</p>"

@app.route("/my-profile")
def my_profile():
    if "username" not in session:
        return redirect(url_for("login"))

    return redirect(url_for("user_profile", username=session["username"]))


@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        username = request.form["username"].strip()
        age = request.form["age"].strip()
        interest = request.form["interest"].strip()
        password = request.form["password"].strip()

        password_hash = generate_password_hash(password)

        try:
            with db.engine.begin() as connection:
                existing_user = connection.execute(
                    text("""
                        SELECT username
                        FROM users
                        WHERE username = :username
                    """),
                    {"username": username}
                ).fetchone()

                if existing_user:
                    return "<h1>Error</h1><p>Username already exists</p>"

                connection.execute(
                    text("""
                        INSERT INTO users (username, age, interest, password_hash)
                        VALUES (:username, :age, :interest, :password_hash)
                    """),
                    {
                        "username": username,
                        "age": age,
                        "interest": interest,
                        "password_hash": password_hash
                    }
                )

            return redirect(url_for("login"))

        except Exception as e:
            return f"<h1>Error</h1><p>{str(e)}</p>"

    return render_template("register.html")


@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        username = request.form["username"].strip()
        password = request.form["password"].strip()

        try:
            with db.engine.connect() as connection:
                result = connection.execute(
                    text("""
                        SELECT username, password_hash
                        FROM users
                        WHERE username = :username
                    """),
                    {"username": username}
                )
                user = result.fetchone()

            if user and check_password_hash(user.password_hash, password):
                session["username"] = user.username
                return redirect(url_for("home"))
            else:
                return "<h1>Error</h1><p>Invalid username or password</p>"

        except Exception as e:
            return f"<h1>Error</h1><p>{str(e)}</p>"

    return render_template("login.html")


@app.route("/logout")
def logout():
    session.pop("username", None)
    return redirect(url_for("login"))


@app.route("/user/edit/<username>", methods=["GET", "POST"])
def edit_user(username):
    if "username" not in session:
        return redirect(url_for("login"))

    if session["username"] != username:
        return "<h1>Error</h1><p>You can only edit your own profile</p>"

    try:
        with db.engine.connect() as connection:
            result = connection.execute(
                text("""
                    SELECT username, age, interest
                    FROM users
                    WHERE username = :username
                """),
                {"username": username}
            )
            user = result.fetchone()

        if not user:
            return "<h1>User not found</h1>"

        if request.method == "POST":
            age = request.form["age"].strip()
            interest = request.form["interest"].strip()

            with db.engine.begin() as connection:
                connection.execute(
                    text("""
                        UPDATE users
                        SET age = :age, interest = :interest
                        WHERE username = :username
                    """),
                    {
                        "age": age,
                        "interest": interest,
                        "username": username
                    }
                )

            return redirect(url_for("user_profile", username=username))

        return render_template("edit_user.html", user=user)

    except Exception as e:
        return f"<h1>Error</h1><p>{str(e)}</p>"


@app.route("/user/delete/<username>", methods=["POST"])
def delete_user(username):
    if "username" not in session:
        return redirect(url_for("login"))

    if session["username"] != username:
        return "<h1>Error</h1><p>You can only delete your own profile</p>"

    try:
        with db.engine.begin() as connection:
            connection.execute(
                text("""
                    DELETE FROM users
                    WHERE username = :username
                """),
                {"username": username}
            )

        session.pop("username", None)
        return redirect(url_for("home"))

    except Exception as e:
        return f"<h1>Error</h1><p>{str(e)}</p>"

@app.route("/quiz", methods=["GET", "POST"])
def quiz():
    if "username" not in session:
        return redirect(url_for("login"))

    if request.method == "POST":
        genre = request.form["genre"]
        platform = request.form["platform"]
        age = request.form["age"]

        try:
            with db.engine.connect() as connection:
                result = connection.execute(
    text("""
        SELECT title, year, platform, age_rec, companyName, genre
        FROM videogames
        WHERE platform LIKE :platform
        AND age_rec <= :age
        AND genre LIKE :genre
        ORDER BY year DESC
        LIMIT 10
    """),
    {
        "platform": f"%{platform}%",
        "age": age,
        "genre": f"%{genre}%"
    }
)
                games = result.fetchall()

            return render_template("quiz_results.html", games=games)

        except Exception as e:
            return f"<h1>Error</h1><p>{str(e)}</p>"

    return render_template("quiz.html")


@app.route("/add_review/<title>", methods=["POST"])
def add_review(title):
    if "username" not in session:
        return redirect(url_for("login"))

    rating = request.form["rating"]
    caption = request.form["caption"]
    username = session["username"]

    try:
        with db.engine.begin() as connection:
            connection.execute(
                text("""
                    INSERT INTO review (rating, caption, date, gameTitle, username)
                    VALUES (:rating, :caption, CURDATE(), :gameTitle, :username)
                """),
                {
                    "rating": rating,
                    "caption": caption,
                    "gameTitle": title,
                    "username": username
                }
            )

        return redirect(url_for("game_detail", title=title))

    except Exception as e:
        return f"<h1>Error</h1><p>{str(e)}</p>"



if __name__ == "__main__":
    app.run(debug=True)