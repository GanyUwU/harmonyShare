import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../auth/session_mng.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

/*
  // Document ID
  List<String> docIDs = [];

  // get doc id
  Future getDocId() async{
    await FirebaseFirestore.instance.collection('Users').get().then(
            (snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            }),
    );
  }

*/


  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? user;

  @override
  Widget build(BuildContext context) {
    String user = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(

      body: Padding(
        padding: EdgeInsets.only(left: 10.0,right: 10.0,top:10.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: firestore.collection('Users').doc(user).snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            if (snapshot.hasError) return Text('Something went wrong');
            print(user);
            final userData = snapshot.data!.data() as Map<String, dynamic>?;
            print(snapshot.data!.data());
            if (userData == null) {
              return Text('User data not found');
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CircleAvatar(
                  radius: 70,
                  child: ClipOval(
                    child: Image.asset('assets/profile2.jpg'),
                  ),
                ),
                SizedBox(height: 20.0),
                itemProfile('Name:',' ${userData['name']}',Icons.person,),
                SizedBox(height: 20.0),
                itemProfile('Email:',' ${userData['email']}',Icons.email),
                SizedBox(height: 20.0),
                itemProfile('Phone:',' ${userData['phone']}', Icons.phone),
                SizedBox(height: 20.0),
                itemProfile('City', '${userData['city']}',Icons.location_city),
                // display other user data as needed
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () { },
                  child: Text("Edit Profile"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.amber),
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    textStyle: MaterialStateTextStyle.resolveWith((states) {
                      if(states.contains(MaterialState.pressed)) {
                        return TextStyle(fontSize: 20);
                      }
                      return TextStyle(fontSize: 15);
                    }),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

itemProfile(String title, String subtitle, IconData iconData) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 7),
              color: Colors.amber.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 10
          )
        ]
    ),
    child: ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Icon(iconData),
      trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
      tileColor: Colors.white,
    ),
  );
}
