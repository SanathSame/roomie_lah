import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import os
# from scipy import spatial


def get_recommendations(username):
    path = os.path.abspath(
        'lib/secrets/roomielah-firebase-adminsdk-nu0rq-713c6fcae8.json')
    cred = credentials.Certificate(path)
    firebase_admin.initialize_app(cred)
    db = firestore.client()

    # Reading matches data
    matches_db = db.collection('matches')
    matches_docs = matches_db.stream()
    for doc in matches_docs:
        matches = doc.to_dict()

    # Reading user data
    users = db.collection('users')
    docs = users.stream()

    all_vectors = []
    all_users_dict = {}

    for doc in docs:
        usr_dict = doc.to_dict()

        vec = [int(usr_dict['dayPerson']), int(usr_dict['drink']), int(usr_dict['football']), int(usr_dict['movies']),
               int(usr_dict['Smoking']), int(usr_dict['vegetarian'])]
        # all_vectors.append(vec)
        usr_dict['vector'] = vec
        all_users_dict[usr_dict['username']] = usr_dict

    # Recommendation Algo
    all_recommendations = {}
    recommendations_score = {}
    # this is a list of users sorted in desc order on the rec score
    recommended_usernames = []
    my_vector = all_users_dict[username]['vector']
    for user in all_users_dict:
        if user == username:
            continue
        if all_users_dict[user]['gender'] != all_users_dict[username]['gender']:
            continue
        if all_users_dict[user]['university'] != all_users_dict[username]['university']:
            continue
        recommendations_score[user] = 0
        your_vector = all_users_dict[user]['vector']
        for i in range(len(your_vector)):
            if your_vector[i] == my_vector[i]:
                recommendations_score[user] += 1

        if len(recommended_usernames) > 0:
            i = 0
            while i < len(recommended_usernames) and recommendations_score[recommended_usernames[i]] > recommendations_score[user]:
                i += 1
            recommended_usernames.insert(i, user)
        else:
            recommended_usernames.append(user)

    return recommended_usernames


# rec, score = get_recommendations('Robin1_')
# for i in rec:
#     print(i, ':', score[i])
