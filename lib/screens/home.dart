import 'package:flutter/material.dart';
import 'package:project/screens/profile.dart';

import 'dashboard.dart';
import 'listview.dart';

class HomeScreen extends StatefulWidget {
  var profilemail;
  var profilepassword;
  HomeScreen({
    Key? key,
    required this.profilemail,
    required this.profilepassword,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      Dashboard(),
      SearchListViewFromAPI(),
      UserProfileScreen(
        email: widget.profilemail,
        name: widget.profilemail,
      ),
    ];
  }

  int _selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _widgetOptions[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.indigo,
          currentIndex: _selectedIndex,
          onTap: onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "HOME",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.document_scanner),
              label: "RESULT",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "PROFILE",
            ),
          ],
        ),
      ),
    );
  }
}
