import 'package:finals/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'maps.dart';
class ReqAcceptedNgo extends StatefulWidget {
  final String documentId;
  const ReqAcceptedNgo({super.key, required this.documentId});

  @override
  State<ReqAcceptedNgo> createState() => _ReqAcceptedStateNgo();
}

class _ReqAcceptedStateNgo extends State<ReqAcceptedNgo> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donor Request'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection('Request').doc(widget.documentId).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final food = snapshot.data;
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        itemProfile(food?['items'], "", Icons.fastfood),
                        itemProfile(food?['quantity'],' ', Icons.food_bank),
                        // Add other items here
                      ],
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),


              SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder:(context)=> MyApp()
                      ));
                },
                child: Text("Accept?"),
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
              ),
            ],
          ),
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
      tileColor: Colors.white,
    ),
  );
}

