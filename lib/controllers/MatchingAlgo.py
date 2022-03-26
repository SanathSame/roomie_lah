import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import os
from scipy import spatial


def get_recommendations():
    path = os.path.abspath(
        'lib/secrets/roomielah-firebase-adminsdk-nu0rq-713c6fcae8.json')
    cred = credentials.Certificate(path)
    firebase_admin.initialize_app(cred)
    db = firestore.client()

    # Reading data
    users = db.collection('users')
    docs = users.stream()

    all_vectors = []
    all_users = {}

    for doc in docs:
        usr_dict = doc.to_dict()

        vec = [int(usr_dict['dayPerson']), int(usr_dict['drink']), int(usr_dict['football']), int(usr_dict['movies']),
               int(usr_dict['Smoking']), int(usr_dict['vegetarian'])]
        all_vectors.append(vec)
        all_users[len(all_vectors) - 1] = doc

    all_recommendations = {}
    for i in all_vectors:
        recommend_i = []
        for j in all_vectors:
            if i == j:
                continue
            cosine_similarity = 1 - spatial.distance.cosine(i, j)
            if cosine_similarity > 0.5:
                recommend_i.append(all_users[all_vectors.index(j)])

        all_recommendations[all_vectors.index(i)] = recommend_i

    return all_recommendations
