from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
# Gaming is the database password
app.config["SQLALCHEMY_DATABASE_URI"] = "mysql+pymysql://root:Gaming@localhost/group_project_db"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db = SQLAlchemy(app)

@app.route("/")
def home():
    return "API running!"

if __name__ == "__main__":
    app.run(debug=True)