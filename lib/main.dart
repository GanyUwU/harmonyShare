import 'package:finals/screens/Home_Ngo/history_ngo.dart';
import 'package:finals/screens/Home_Ngo/home_ngo.dart';
import 'package:finals/screens/Home_Ngo/info_ngo.dart';
import 'package:finals/screens/Home_Ngo/profile_ngo.dart';
import 'package:finals/screens/auth/register_ngo.dart';
import 'package:finals/screens/home/history.dart';
import 'package:finals/screens/home/info.dart';
import 'package:finals/screens/home/profile.dart';
import 'package:finals/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:finals/screens/home/home.dart';
// Import the generated file
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );
  runApp(MaterialApp(
    home: Auth(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  final tabs = [
    HomePage(),
    History(),
    Info(),
    Profile()
  ];
  final tab=[
    HomeNgo(),
    HistoryNgo(),
    InfoNgo(),
    ProfileNgo(),
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
      body:tabs[_currentIndex],
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