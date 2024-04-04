import 'package:flutter/material.dart';

class ProfileNgo extends StatelessWidget {
  const ProfileNgo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
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
              SizedBox(height: 20),
              itemProfile('NGO Name', 'XYZ NGO', Icons.assured_workload),
              SizedBox(height: 20),
              itemProfile("Phone Number", "9876543210", Icons.phone),
              SizedBox(height: 20),
              itemProfile("Email", "abc123@gmail.com", Icons.email),
              SizedBox(height: 20),
              itemProfile("Address", "Mumbai", Icons.location_pin),
              SizedBox(height: 20),
              itemProfile("Change password", " ", Icons.password),
              SizedBox(height: 20),
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
          ),
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