from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text

app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = "mysql+pymysql://root:Gaming@localhost/videogame_project"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db = SQLAlchemy(app)





@app.route("/", methods=["GET"])
def home():
    search = request.args.get("search", "").strip()
    filter_by = request.args.get("filter_by", "title")

    allowed_filters = {
        "title": "title",
        "platform": "platform",
        "company": "companyName",
        "age": "age_rec"
    }

    column = allowed_filters.get(filter_by, "title")

    try:
        with db.engine.connect() as connection:
            if search:
                query = text(f"""
                    SELECT title, year, platform, age_rec, companyName
                    FROM videogames
                    WHERE {column} LIKE :search
                """)
                result = connection.execute(query, {"search": f"%{search}%"})
            else:
                result = connection.execute(
                    text("""
                        SELECT title, year, platform, age_rec, companyName
                        FROM videogames
                    """)
                )

            games = result.fetchall()

        return render_template(
            "index.html",
            games=games,
            search=search,
            filter_by=filter_by
        )

    except Exception as e:
        return f"<h1>Error</h1><p>{str(e)}</p>"





@app.route("/game/<title>")
def game_detail(title):
    try:
        with db.engine.connect() as connection:
            result = connection.execute(
                text("""
                    SELECT videogames.title, videogames.year, videogames.platform,
                           videogames.age_rec, videogames.companyName, company.address
                    FROM videogames
                    LEFT JOIN company ON videogames.companyName = company.name
                    WHERE videogames.title = :title
                """),
                {"title": title}
            )
            game = result.fetchone()

        return render_template("game.html", game=game)

    except Exception as e:
        return f"<h1>Error</h1><p>{str(e)}</p>"




@app.route("/users")
def users():
    try:
        with db.engine.connect() as connection:
            result = connection.execute(
                text("""
                    SELECT username, age, interest
                    FROM users
                    ORDER BY username
                """)
            )
            users = result.fetchall()

        return render_template("users.html", users=users)

    except Exception as e:
        return f"<h1>Error</h1><p>{str(e)}</p>"





@app.route("/user/<username>")
def user_profile(username):
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




@app.route("/user/add", methods=["GET", "POST"])
def add_user():
    if request.method == "POST":
        username = request.form["username"].strip()
        age = request.form["age"].strip()
        interest = request.form["interest"].strip()

        try:
            with db.engine.begin() as connection:
                connection.execute(
                    text("""
                        INSERT INTO users (username, age, interest)
                        VALUES (:username, :age, :interest)
                    """),
                    {
                        "username": username,
                        "age": age,
                        "interest": interest
                    }
                )

            return redirect(url_for("users"))

        except Exception as e:
            return f"<h1>Error</h1><p>{str(e)}</p>"

    return render_template("add_user.html")





@app.route("/user/edit/<username>", methods=["GET", "POST"])
def edit_user(username):
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
    try:
        with db.engine.begin() as connection:
            connection.execute(
                text("""
                    DELETE FROM users
                    WHERE username = :username
                """),
                {"username": username}
            )

        return redirect(url_for("users"))

    except Exception as e:
        return f"<h1>Error</h1><p>{str(e)}</p>"


if __name__ == "__main__":
    app.run(debug=True)