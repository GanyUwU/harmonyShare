import 'package:finals/main.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
        
             // SizedBox(height: 20),
             //  itemProfile('Pick up Location', '', Icons.location_pin),
             //  SizedBox(height: 20),
             //  itemProfile("Pick up Instructions", "ABED", Icons.integration_instructions),
             //  SizedBox(height: 20),
             //  itemProfile("Food Items", "Biryani", Icons.email),
             //  SizedBox(height: 20),
             //  itemProfile("Food Quantity", "5 kg", Icons.location_pin),
             //  SizedBox(height: 20),
             //  itemProfile("Pick up Time", " 10:00 ", Icons.password),
             //  SizedBox(height: 20),
             //  itemProfile("When was the food made", " 8:00", Icons.password),
             //  SizedBox(height: 20),
        

             /* StreamBuilder<QuerySnapshot>(
                stream:FirebaseFirestore.instance.collection('form').snapshots(),
                  builder: (context,snapshot){
                  List<Row> items = [];
                  if(snapshot.hasData)
                  {
                    final food = snapshot.data?.docs.toList();
                    for(var foodItem in food!)
                    {
                      final item = Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          itemProfile(foodItem['pickupAddress']," ",Icons.location_pin),
                          itemProfile(foodItem['pickupTime'], ' ', Icons.timer),
                          itemProfile(foodItem['instructions'], " ", Icons.email),
                          // Text(foodItem['items']),
                          // Text(foodItem['quantity']),
                          // Text(foodItem['time']),
/*
                          SizedBox(height: 20),
                          Expanded(
                            child: itemProfile(foodItem['pickupAddress'], '', Icons.location_pin),
                          ),
                          SizedBox(height: 20),
                          Expanded(child: itemProfile(foodItem['pickupTime'], "", Icons.integration_instructions),
                          ),
                          SizedBox(height: 20),
                          Expanded(child: itemProfile(foodItem['instructions'], "", Icons.email),
                          ),
                          SizedBox(height: 20),
                          Expanded(child:itemProfile(foodItem['items'], "", Icons.location_pin)
                          ),
                          SizedBox(height: 20),
                          Expanded(child:  itemProfile(foodItem['quantity'], "", Icons.password)
                          ),
                          SizedBox(height: 20),
                          Expanded(child: itemProfile(foodItem['time'], "", Icons.password)
                          ),*/
                          const SizedBox(height: 20),
                        ],
                      );
                      items.add(item);
                    }
                  }
                  return ListView(
                    shrinkWrap: true,
                    children: items
                   );
                }
              ),*/

              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection('form').doc("mLSboouRBTZ0XJEmPjvY").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final food = snapshot.data;
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        itemProfile(food?['pickupAddress']," ",Icons.location_pin),
                        itemProfile(food?['pickupTime'], ' ', Icons.timer),
                        itemProfile(food?['instructions'], " ", Icons.email),
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

