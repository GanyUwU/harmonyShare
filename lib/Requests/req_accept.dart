import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'maps.dart';

class ReqAccepted extends StatefulWidget {
  const ReqAccepted({super.key});

  @override
  State<ReqAccepted> createState() => _ReqAcceptedState();
}

class _ReqAcceptedState extends State<ReqAccepted> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donor Request'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          /*  SizedBox(height: 20),
            itemProfile('Pick up Location', '', Icons.location_pin),
            SizedBox(height: 20),
            itemProfile("Pick up Instructions", "ABCD", Icons.integration_instructions),
            SizedBox(height: 20),
            itemProfile("Food Items", "Biryani", Icons.email),
            SizedBox(height: 20),
            itemProfile("Food Quantity", "5 kg", Icons.location_pin),
            SizedBox(height: 20),
            itemProfile("Pick up Time", " 10:00 ", Icons.password),
            SizedBox(height: 20),
            itemProfile("When was the food made", " 8:00", Icons.password),
            SizedBox(height: 20),*/
        ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder:(context)=>Maps()
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

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('form').snapshots(),
                builder: (context,snapshot){
                List<Row> items = [];
                if(snapshot.hasData)
                {
                  final food = snapshot.data?.docs.reversed.toList();
                  for(var foodItem in food!)
                  {
                    final item = Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(foodItem['pickupAddress']),
                        Text(foodItem['pickupTime']),
                        Text(foodItem['instructions']),
                        Text(foodItem['items']),
                        Text(foodItem['quantity']),
                        Text(foodItem['time']),
                      ],
                    );
                    items.add(item);
                  }
                }
                return Expanded(
                  child: ListView(
                    children: items,
                   ),
                );
              }
            )
          ],
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

