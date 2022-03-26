import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import os
import random
from random import randint

path = os.path.abspath(
    'lib/secrets/roomielah-firebase-adminsdk-nu0rq-713c6fcae8.json')
cred = credentials.Certificate(path)
firebase_admin.initialize_app(cred)
db = firestore.client()

for i in range(20):
    uni = ['NTU', 'NUS', 'SMU', 'SUTD', 'NAFA']
    courses = ['CSC', 'MAE', 'EEE', 'BUS', 'ECO', 'DSAI', 'CE']
    flag = [True, False]
    gender = ['Male', 'Female', 'others']
    # adding subsequent data
    doc_ref = db.collection('users').document(f'user{i+2}@gmail.com')
    doc_ref.set({

        'username': f'user{i+2}',
        'name': f'Srish{i+2}',
        'age': randint(18, 25),
        'year_of_study': randint(1, 5),
        'university': random.choice(uni),
        'course': random.choice(courses),
        'Smoking': random.choice(flag),
        'dayPerson': random.choice(flag),
        'profilePicURL': '',
        'vegetarian': random.choice(flag),
        'gender': random.choice(gender),
        'football': random.choice(flag),
        'movies': random.choice(flag),
        'drink': random.choice(flag)
    })
