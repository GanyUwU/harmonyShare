import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/Home_Ngo/history_ngo.dart';
import '../screens/Home_Ngo/home_ngo.dart';
import '../screens/Home_Ngo/info_ngo.dart';
import '../screens/Home_Ngo/profile_ngo.dart';

class NgoDisplay extends StatefulWidget {
  const NgoDisplay({super.key});

  @override
  State<NgoDisplay> createState() => _NgoDisplayState();
}

class _NgoDisplayState extends State<NgoDisplay> {
  int _currentIndex = 0;
  final tab=[
    HomeNgo(),
    HistoryNgo(),
    InfoNgo(),
    UserInformation(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HarmonyShare"),
        centerTitle: true,
        backgroundColor: Colors.amber,
        actions: [
          IconButton(onPressed: ()async{
            await FirebaseAuth.instance.signOut();
          },
            icon: Icon(Icons.login),
          )
        ],
      ),
      body: tab[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        fixedColor: Colors.amber,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: "Information",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
