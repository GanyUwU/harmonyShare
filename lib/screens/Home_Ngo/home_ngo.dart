import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Requests/req_accept.dart';


class HomeNgo extends StatefulWidget {
  const HomeNgo({super.key});

  @override
  State<HomeNgo> createState() => _HomeNgoState();
}

class _HomeNgoState extends State<HomeNgo> {


  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      child: Text(
                        "Requests",
                        style: TextStyle(
                            fontSize: 15.0,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold
                        ),
                      )
                  )
              ),
              SizedBox(height: 20),
              requests("Donor Name", "Donor Description"),
              SizedBox(height: 20),
              requests("Donor Name", "Donor Description"),
              SizedBox(height: 20),
              requests("Donor Name", "Donor Description"),
              SizedBox(height: 20),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      child: Text(
                        "Top Donors's",
                        style: TextStyle(
                            fontSize: 15.0,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold
                        ),
                      )
                  )
              ),
              SizedBox(height: 20),
              top_donors("Donor Name", "Donor Description"),
              SizedBox(height: 20),
              top_donors("Donor Name", "Donor Description"),
              SizedBox(height: 20),
              top_donors("Donor Name", "Donor Description"),
              SizedBox(height: 20),
              top_donors("Donor Name", "Donor Description"),
              SizedBox(height: 20),
              top_donors("NGO Name", "NGO Description"),
            ],
          ),
        ),
      ),
    );
  }

  requests(String title, String subtitle) {
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
        leading: CircleAvatar(
          radius: 30,
          child: ClipOval(
            child: Image.asset('assets/donar.png'),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(onPressed: () {
             Navigator.push(context,
                 MaterialPageRoute(builder: (context)=>ReqAccepted())
             );
            },
                icon: Icon(Icons.check),iconSize: 20),
            IconButton(onPressed: () {
              Navigator.pop(context);
            }, icon: Icon(Icons.close),iconSize: 20)
          ],
        ),
        tileColor: Colors.white,
      ),
    );
  }

  top_donors(String title, String subtitle) {
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
        leading: CircleAvatar(
          radius: 30,
          child: ClipOval(
            child: Image.asset('assets/donar.png'),
          ),
        ),
        tileColor: Colors.white,
      ),
    );
  }
}