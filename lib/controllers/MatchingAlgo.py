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
    matched_users = []
    for doc in matches_docs:
        if doc.id == username:
            matches_dict = doc.to_dict()
            for i in matches_dict['matches']:
                matched_users.append(i['username'])

    # Reading user data
    users = db.collection('users')
    docs = users.stream()

    all_users_dict = {}
    try:
        for doc in docs:
            usr_dict = doc.to_dict()

            vec = [int(usr_dict['dayPerson']), int(usr_dict['drink']), int(usr_dict['football']), int(usr_dict['movies']),
                   int(usr_dict['Smoking']), int(usr_dict['vegetarian']), int(usr_dict['party'])]
            usr_dict['vector'] = vec
            all_users_dict[usr_dict['username']] = usr_dict
    except:
        print(usr_dict['username'], 'exception')

    # Reading user preferences
    pref = db.collection('preferences')
    docs = pref.stream()

    for doc in docs:
        pref_dict = doc.to_dict()
        if pref_dict['username'] == username:
            my_pref = pref_dict

    # Recommendation Algo
    recommendations_score = {}
    # this is a list of users sorted in desc order on the rec score
    recommended_usernames = []
    try:
        my_vector = all_users_dict[username]['vector']
    except:
        print(username, ' does not exist')

    for user in all_users_dict:
        if user == username:
            continue
        if user in matched_users:
            continue
        if all_users_dict[user]['gender'] != all_users_dict[username]['gender']:
            continue
        if all_users_dict[user]['university'] != all_users_dict[username]['university']:
            continue
        for i in my_pref:
            if my_pref[i] != all_users_dict[user][i]:
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


# rec = get_recommendations('user1')
# for i in rec:
#     print(i)
