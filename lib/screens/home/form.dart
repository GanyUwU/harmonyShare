import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finals/screens/home/response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

import '../auth/session_mng.dart';


class FormD extends StatefulWidget {
  const FormD({super.key});

  @override
  State<FormD> createState() => _FormDState();
}

class _FormDState extends State<FormD> {
  String? userId = SessionController().userId;
  final _pickupAddress = TextEditingController();
  final _instruction = TextEditingController();
  final _items = TextEditingController();
  final _quantity = TextEditingController();
  final _pickupTime = TextEditingController();
  final _time = TextEditingController();
  double _quantityValue = 0.0;
  TimeOfDay? _selectedTime;
  Future<void> _selectTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }
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

              TextFormField(
                controller: _quantity,
                decoration: InputDecoration(
                  labelText: 'Quantity (in KG) ',
                  prefixIcon: Icon(Icons.production_quantity_limits),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _quantityValue = double.parse(value);
                  });
                },
              ),
              Slider(
                value: _quantityValue,
                min: 0.0,
                max: 20.0,
                divisions: 20,
                label: '${_quantityValue.round()}',
                onChanged: (value) {
                  setState(() {
                    _quantityValue = value;
                    _quantity.text = value.toString();
                  });
                },
              ),
              SizedBox(height: 20),

              TextField(
                controller: _pickupTime,
                decoration: InputDecoration(
                  hintText: "Pickup time",
                  labelText: 'Pickup time:',
                  prefixIcon: Icon(Icons.access_time),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () async {
                      final TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) {
                        final String formattedTime = picked.format(context);
                        setState(() {
                          _pickupTime.text = formattedTime;
                        });
                      }
                    },
                  ),
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
                  labelText: 'Time:',
                  prefixIcon: Icon(Icons.timelapse),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () async {
                      final TimeOfDay? selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (selectedTime != null) {
                        setState(() {
                          _time.text = selectedTime.format(context);
                          _selectTime(context, _time);
                        });
                      }
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  TimeOfDay selectedTime = TimeOfDay.now();
                  DateTime dateTime = DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                    selectedTime.hour,
                    selectedTime.minute,
                  );
                  String userId = FirebaseAuth.instance.currentUser!.uid;

                  String status = 'pending';
                  CollectionReference collRef = FirebaseFirestore.instance.collection('form');
                  collRef.doc(userId).set({
                    'pickupAddress' : _pickupAddress.text,
                    'instructions' : _instruction.text,
                    'items' : _items.text,
                    'quantity' : _quantity.text,
                    'pickupTime': _pickupTime.text,
                    'time' : _time.text,
                    'status': status,
                    'timestamp' : Timestamp.now(),
                    'userId': userId,
                    'reqId':  randomNumeric(10),

                    // 'latitude': currentLocation!.latitude,
                    // 'longitude': currentLocation!.longitude,
                  });
                  // Increment the counter field in the user document
                  // DocumentReference userRef = FirebaseFirestore.instance.collection('Users').doc(userId);
                  // userRef.set({
                  // 'form_submissions_counter': 1,
                  //   'items' : _items.text
                  // //'form_submissions_counter': FieldValue.increment(1),
                  // });
                  // DocumentReference  u = FirebaseFirestore.instance.collection('Users').doc(userId);
                  // u.update({
                  //   'form_submissions_counter': FieldValue.increment(1),
                  // });

                  //DocumentReference docRef = collRef.doc(); // Get the DocumentReference object for the added document
                 // docRef.update({'status': 'completed'}); // Update the status of the request

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


