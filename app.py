from flask import Flask, render_template_string
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text
import os

app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = "mysql+pymysql://root:Gaming@localhost/videogame_project"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db = SQLAlchemy(app)

@app.route("/")
def home():
    try:
        with db.engine.connect() as connection:
            result = connection.execute(text("SELECT title, year, platform, age_rec FROM videogames"))
            games = result.fetchall()

        html = """
        <html>
        <head>
            <title>Game Database</title>
            <style>
                body {
                    font-family: Arial;
                    background: #f4f4f4;
                    padding: 40px;
                }
                .card {
                    background: white;
                    padding: 20px;
                    margin-bottom: 20px;
                    border-radius: 10px;
                    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                }
            </style>
        </head>
        <body>
            <h1>Game Database</h1>

            {% for game in games %}
                <div class="card">
                    <h2>{{ game.title }}</h2>
                    <p>Year: {{ game.year }}</p>
                    <p>Platform: {{ game.platform }}</p>
                    <p>Recommended Age: {{ game.age_rec }}+</p>
                </div>
            {% endfor %}

        </body>
        </html>
        """

        return render_template_string(html, games=games)

    except Exception as e:
        return f"<h1>Database Error</h1><p>{str(e)}</p>"

if __name__ == "__main__":
    app.run(debug=True)