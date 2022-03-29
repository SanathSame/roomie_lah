import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import os
import random
from random import randint
import numpy as np

path = os.path.abspath(
    'lib/secrets/roomielah-firebase-adminsdk-nu0rq-713c6fcae8.json')
cred = credentials.Certificate(path)
firebase_admin.initialize_app(cred)
db = firestore.client()

users = ['Franky', 'Nami', 'Robin', 'Zoro', 'Jinbe', 'user']
for user in users:
    for i in range(20):
        uni = ['NTU', 'NUS', 'SMU', 'SUTD', 'NAFA']
        courses = ['CSC', 'MAE', 'EEE', 'BUS', 'ECO', 'DSAI', 'CE']
        flag = [True, False]
        gender = ['Male', 'Female', 'Non Binary']
        nationality = ['Indian', 'Singaporean',
                       'Malaysian', 'Korean', 'Chinese']
        interests = ['Netflix', 'Gaming', 'Photography', 'Music',
                     'Football', 'Baking', 'Board Games', 'Eating', 'Trekking', 'Gigs']
        len_of_interests = random.randint(1, len(interests))
        my_interests = []
        for _ in range(len_of_interests):
            choice = random.choice(interests)
            if choice not in my_interests:
                my_interests.append(choice)
        # adding subsequent data
        doc_ref = db.collection('users').document(f'{user}{i}@gmail.com')
        doc_ref.set({

            'username': f'{user}{i}',
            'name': f'{user}{i}',
            'age': randint(18, 25),
            'university': random.choice(uni),
            'course': random.choice(courses),
            'nationality': random.choice(nationality),
            'smoke': random.choice(flag),
            'dayPerson': random.choice(flag),
            'veg': random.choice(flag),
            'gender': random.choice(gender),
            'alcohol': random.choice(flag),
            'stayingIn': random.choice(flag),
            'profilePicURL': '',
            'interests': my_interests

        })
        print(f'updated {user}{i} ')
