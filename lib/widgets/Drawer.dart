import 'package:flutter/material.dart';
import "package:roomie_lah/constants.dart";
import 'package:roomie_lah/entity/CurrentUser.dart';

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
                    // Text(
                    //   "83581893",
                    //   style: TextStyle(
                    //     fontSize: 20,
                    //     color: Color(0xfffafaff),
                    //   ),
                    // ),
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
                //Navigator.of(context).pushNamed('/profile');
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
                //Navigator.of(context).pushNamed('/profile');
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
                //Navigator.of(context).pushNamed('/login');
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
