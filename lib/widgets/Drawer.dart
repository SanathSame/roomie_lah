import 'package:flutter/material.dart';
import "package:roomie_lah/constants.dart";
import 'package:roomie_lah/controllers/AuthenticationController.dart';
import 'package:roomie_lah/entity/CurrentUser.dart';
import 'package:roomie_lah/screens/EditProfileScreen.dart';
import 'package:roomie_lah/screens/LoginScreen.dart';
import 'package:roomie_lah/screens/UserProfileScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MaterialApp(
    title: 'RoomieLah',
    home: CustomDrawer(),
    theme: ThemeData(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: Colors.white,
    ),
  ));
}

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.teal.shade800,
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              child: DrawerHeader(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: CircleAvatar(
                        backgroundImage: CurrentUser().profilePicURL == ""
                            ? AssetImage('assets/images/hasbullah.jpg')
                                as ImageProvider
                            : NetworkImage(CurrentUser().profilePicURL),
                        backgroundColor: Theme.of(context).backgroundColor,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      CurrentUser().username,
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xfffafaff),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text(
                      CurrentUser().email,
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xfffafaff),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Profile Page',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xfffafaff),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, UserProfileScreen.id);
              },
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              title: Text(
                'Edit Preferences',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xfffafaff),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, EditProfileScreen.id);
              },
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              title: Text(
                'Sign Out',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xfffafaff),
                ),
              ),
              onTap: () {
                AuthenticationController().signOut();
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              title: Text(
                'Help',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xfffafaff),
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('How to use the app?'),
                    content: Text(
                        'Right Swipe on the card if you want to match with the user, Swipe left on the card if you do not like the user '),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
            Divider(
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
