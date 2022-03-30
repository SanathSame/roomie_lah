import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import os

from matplotlib.style import use
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

            vec = [int(usr_dict['dayPerson']), int(usr_dict['alcohol']),
                   int(usr_dict['smoke']), int(usr_dict['veg']), int(usr_dict['stayingIn'])]
            usr_dict['vector'] = vec
            all_users_dict[usr_dict['username']] = usr_dict
    except:
        print(usr_dict['username'], 'exception')

    # Reading user preferences
    pref = db.collection('preferences')
    docs = pref.stream()
    doc = pref.document(f'{username}@gmail.com').get()
    my_pref = doc.to_dict()

    # Recommendation Algo
    recommendations_score = {}
    # this is a list of users sorted in desc order on the rec score
    recommended_user_emails = []
    try:
        my_vector = all_users_dict[username]['vector']
        my_interests = all_users_dict[username]['interests']
    except:
        print(f'{username} does not exist')

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

        your_interests = all_users_dict[user]['interests']
        for i in range(len(your_interests)):
            if your_interests[i] in my_interests:
                recommendations_score[user] += 1

        if len(recommended_user_emails) > 0:
            i = 0
            while i < len(recommended_user_emails) and recommendations_score[recommended_user_emails[i]] > recommendations_score[user]:
                i += 1
            recommended_user_emails.insert(f'{i}@gmail.com', user)
        else:
            recommended_user_emails.append(user)

    return recommended_user_emails


# rec = get_recommendations('Zoro1')
# for i in rec:
#     print(i)
