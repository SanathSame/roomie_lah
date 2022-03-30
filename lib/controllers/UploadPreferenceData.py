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

users = ['Franky', 'Nami', 'Robin', 'Zoro', 'Jinbe', 'user']
for user in users:
    for i in range(20):
        uni = ['NTU', 'NUS', 'SMU', 'SUTD', 'NAFA']
        courses = ['CSC', 'MAE', 'EEE', 'BUS', 'ECO', 'DSAI', 'CE']
        flag = [True, False]
        gender = ['Male', 'Female', 'others']
        # adding subsequent data
        doc_ref = db.collection('preferences').document(f'{user}{i}@gmail.com')
        doc_ref.set({

            'username': f'{user}{i}',
            'smoke': random.choice(flag),
            'dayPerson': random.choice(flag),
            'veg': random.choice(flag),
            'alcohol': random.choice(flag),
            'stayingIn': random.choice(flag)
        })
