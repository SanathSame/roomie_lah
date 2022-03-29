import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import os
import random
from random import randint

path = os.path.abspath(
    'secrets/roomielahbackup-firebase-adminsdk-k0k3g-f5b455a030.json')
cred = credentials.Certificate(path)
firebase_admin.initialize_app(cred)
db = firestore.client()

users = ['Nami', 'Robin', 'Zoro', 'Jinbei', 'Luffy']
profilePicURL = {
    'Nami': "https://firebasestorage.googleapis.com/v0/b/roomielahbackup.appspot.com/o/profilePic%2Fnami?alt=media&token=88071ddc-e177-4203-ae5f-b71b9bb2a1e3",
    'Robin': "https://firebasestorage.googleapis.com/v0/b/roomielahbackup.appspot.com/o/profilePic%2Frobin?alt=media&token=cb7008c4-23a6-43be-8813-17391244e0b5",
    'Zoro': "https://firebasestorage.googleapis.com/v0/b/roomielahbackup.appspot.com/o/profilePic%2Fzoro?alt=media&token=5cba3031-a710-416e-b5ff-e186f6f0b4ec",
    'Jinbei': "https://firebasestorage.googleapis.com/v0/b/roomielahbackup.appspot.com/o/profilePic%2Fjinbei?alt=media&token=dd6d71d8-4224-43a8-913d-d288e4fe55cc",
    'Luffy': "https://firebasestorage.googleapis.com/v0/b/roomielahbackup.appspot.com/o/profilePic%2Fluffy?alt=media&token=cb2e17a3-15c6-4eb0-992c-8d8c11d5f7fe",
}

def populate_user():
    for user in users:
        for i in range(1, 11):
            uni = ['NTU', 'NUS']
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
def populate_preferences():
    for user in users:
        for i in range(1, 11):
            uni = ['NTU', 'NUS']
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
                'profilePicURL': profilePicURL[user],
                'interests': my_interests

            })
            print(f'updated {user}{i} ')

if __name__ == '__main__':
    populate_user()
    populate_preferences()