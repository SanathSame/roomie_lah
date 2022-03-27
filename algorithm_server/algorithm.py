from flask import Flask, request, jsonify
import json

app = Flask(__name__)


@app.route("/", methods=["GET"])
def home():
    print("hello home")
    return """<h1>ROOMIE LAH!"""


@app.route("/getRecommendations", methods=["GET", "POST"])
def getRecommendation():
    print("here")
    if request.method == "POST":
        request_data = request.data
        request_data = request_data.decode("utf-8")
        # response = filterData(data_df, request_data)
        print(request_data)
        return jsonify({"list of profiles": ["user1", "user2", "user3"]})
    else:
        return jsonify({"name": ["user4", "user5", "user6"]})


if __name__ == "__main__":
    # WSGIRequestHandler.protocol_version = "HTTP/1.1"
    # app.run(host="127.0.0.1", debug=True, port=5000)
    app.run()