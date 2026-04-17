from flask import Flask, render_template, request
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text

app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = "mysql+pymysql://root:Gaming@localhost/videogame_project"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db = SQLAlchemy(app)

@app.route("/", methods=["GET"])
def home():
    search = request.args.get("search", "")

    try:
        with db.engine.connect() as connection:
            if search:
                result = connection.execute(
                    text("SELECT title, year, platform, age_rec, companyName FROM videogames WHERE title LIKE :search"),
                    {"search": f"%{search}%"}
                )
            else:
                result = connection.execute(
                    text("SELECT title, year, platform, age_rec, companyName FROM videogames")
                )

            games = result.fetchall()

        return render_template("index.html", games=games, search=search)

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


if __name__ == "__main__":
    app.run(debug=True)