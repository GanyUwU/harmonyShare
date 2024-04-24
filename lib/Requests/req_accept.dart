import 'package:finals/main.dart';
import 'package:finals/screens/Home_Ngo/history_ngo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'maps.dart';

class ReqAccepted extends StatefulWidget {
  final String documentId;
  const ReqAccepted({super.key, required this.documentId});




  @override
  State<ReqAccepted> createState() => _ReqAcceptedState();
}

class _ReqAcceptedState extends State<ReqAccepted> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Stream<DocumentSnapshot> userStream;
  Future<void> acceptRequest(AsyncSnapshot<DocumentSnapshot> snapshot) async {
    final userData = snapshot.data!.data() as Map<String, dynamic>?;
    if (userData == null) {
      return;
    }
    // Update the Firestore database to mark the request as accepted
    await FirebaseFirestore.instance.collection('form').doc(widget.documentId).update({
      'status': 'accepted',
      'accepted_by': FirebaseAuth.instance.currentUser!.uid,
      'accepted_at': Timestamp.now(),
    });

    // Perform any other actions that are necessary when a request is accepted
  }

  // @override
  // void initState() {
  //   super.initState();
  //   userStream = firestore.collection('form').doc(widget.documentId).snapshots();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donor Request'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: firestore.collection('form').doc(widget.documentId).snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          if (snapshot.hasError) return Text('Something went wrong');

          final userData = snapshot.data!.data() as Map<String, dynamic>?;
          print(snapshot.data!.data());

          if (userData == null) {
            return Text('data not found');
          }
          return Column(
            children: [
              SizedBox(height: 20.0),
              itemProfile('Items:', ' ${userData['items']}', Icons.person,),
              SizedBox(height: 20.0),
              itemProfile('Quantity:', ' ${userData['quantity']}', Icons.email),
              SizedBox(height: 20.0),
              itemProfile(
                  'Pick up Time:', ' ${userData['pickupTime']}', Icons.phone),
              SizedBox(height: 20.0),
              itemProfile('Pick up Address', '${userData['pickupAddress']}',
                  Icons.location_city),
              // display other user data as needed
              SizedBox(height: 30,),

              ElevatedButton(

                onPressed: () async {
                  await acceptRequest(snapshot);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HistoryNgo()
                      ));
                },
                child: Text("Accept?"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.amber),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                  textStyle: MaterialStateTextStyle.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return TextStyle(fontSize: 20);
                    }
                    return TextStyle(fontSize: 15);
                  }),
                ),
              ),
            ],
          );
        },
      ),
    );
  }


  itemProfile(String title, String subtitle, IconData iconData) {
    return Flexible(
      child: Container(
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
          tileColor: Colors.white,
        ),
      ),
    );
  }
}





