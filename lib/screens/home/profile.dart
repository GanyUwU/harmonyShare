import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finals/read%20data/get_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser!;

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CircleAvatar(
              radius: 70,
              child: ClipOval(
                child: Image.asset('assets/profile2.jpg'),
              ),
            ),
          Expanded(
            child: FutureBuilder(
              future: getDocId(),
              builder: (context,snapshot) {
                return ListView.builder(
                  itemCount: docIDs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ListTile(
                        title: GetUserName(documentId:docIDs[index],),
                        tileColor: Colors.amber,
                        
                      ),
                    );
                  },
                );
              },
            ),
          ),
            ElevatedButton(
              onPressed: () { },
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
              child: Text("Edit Profile"),
            )
          ],
        ),
      ),
    );
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
}
/*
Future<UserModel> getUserDetails(String email) async{
  final snapshot = await FirebaseFirestore.instance.collection("Users").where("email", isEqualTo:email).get();
  final userData = snapshot.docs.map((e) => UserModel.fromSnapShot(e)).single;
  return userData;
}*/