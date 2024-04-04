import 'package:finals/screens/home/history.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/home/home.dart';
import '../screens/home/info.dart';
import '../screens/home/profile.dart';

class DonorDisplay extends StatefulWidget {
  const DonorDisplay({super.key});

  @override
  State<DonorDisplay> createState() => _DonorDisplayState();
}

class _DonorDisplayState extends State<DonorDisplay> {
  int _currentIndex = 0;
  final tabs = [
    HomePage(),
    History(),
    Info(),
    Profile()
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
      body: tabs[_currentIndex],
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
