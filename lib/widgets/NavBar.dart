import 'package:flutter/material.dart';
import 'package:roomie_lah/screens/UserProfileScreen.dart';
import 'package:roomie_lah/screens/preferences.dart';
import 'package:roomie_lah/screens/chat_list.dart';
import 'package:roomie_lah/screens/recommendation_screen.dart';
import 'package:roomie_lah/screens/LoginScreen.dart';

class BasicBottomNavBar extends StatefulWidget {
  const BasicBottomNavBar({Key? key}) : super(key: key);

  @override
  _BasicBottomNavBarState createState() => _BasicBottomNavBarState();
}

class _BasicBottomNavBarState extends State<BasicBottomNavBar> {
  static int _selectedIndex = 1;

  //TODO: change to profile page
  static String _profileScreenID = UserProfileUI.id;
  static String _recommendationScreenID = RecommendationScreen.id;
  static String _chatListID = ChatListPage.id;

  static List<String> _pages = <String>[
    _profileScreenID,
    _recommendationScreenID,
    _chatListID
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pushNamed(context, _pages[_selectedIndex]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'View/Edit Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.create_sharp),
          label: 'Recommendations',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chats',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
    // );
  }
}
