import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finals/screens/home/response.dart';
import 'package:flutter/material.dart';

class FormD extends StatefulWidget {
  const FormD({super.key});

  @override
  State<FormD> createState() => _FormDState();
}

class _FormDState extends State<FormD> {
  final _pickupAddress = TextEditingController();
  final _instruction = TextEditingController();
  final _items = TextEditingController();
  final _quantity = TextEditingController();
  final _pickupTime = TextEditingController();
  final _time = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HarmonyShare"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _pickupAddress,
                decoration: InputDecoration(
                  hintText: "Pickup address",
                  labelText: "Pickup address",
                  prefixIcon: Icon(Icons.location_pin),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _instruction,
                decoration: InputDecoration(
                  hintText: "Pickup instructions",
                  labelText: "Pickup instructions",
                  prefixIcon: Icon(Icons.integration_instructions),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _items,
                decoration: InputDecoration(
                  hintText: "Food item",
                  labelText: "Food item",
                  prefixIcon: Icon(Icons.food_bank),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _quantity,
                decoration: InputDecoration(
                  hintText: "Food quantity",
                  labelText: "Food quantity",
                  prefixIcon: Icon(Icons.numbers),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),

              TextField(
                controller: _pickupTime,
                decoration: InputDecoration(
                  hintText: "Pickup time",
                  labelText: "Pickup time",
                  prefixIcon: Icon(Icons.access_time),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _time,
                decoration: InputDecoration(
                  hintText: "When was the food made?",
                  labelText: "When was the food made?",
                  prefixIcon: Icon(Icons.timelapse),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  CollectionReference collRef = FirebaseFirestore.instance.collection('form');
                  collRef.add({
                    'pickupAddress' : _pickupAddress.text,
                    'instructions' : _instruction.text,
                    'items' : _items.text,
                    'quantity' : _quantity.text,
                    'pickupTime': _pickupTime.text,
                    'time' : _time.text,
                  });
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> Response()));
                },
                child: Text("Submit"),
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
}
