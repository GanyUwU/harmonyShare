import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/session_mng.dart';
import '../home/response.dart';

class FormNGO extends StatefulWidget {
  const FormNGO({super.key});

  @override
  State<FormNGO> createState() => _FormNGOState();
}

class _FormNGOState extends State<FormNGO> {
  String? userId = SessionController().userId;

  final _items = TextEditingController();
  final _quantity = TextEditingController();

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

              ElevatedButton(
                onPressed: () {
                  String userId = FirebaseAuth.instance.currentUser!.uid;

                  String status = 'pending';
                  CollectionReference collRef = FirebaseFirestore.instance.collection('Request');
                  collRef.add({
                    'items' : _items.text,
                    'quantity' : _quantity.text,
                    'status': status,
                    'timestamp' : Timestamp.now(),
                    'userId': userId,

                    // 'latitude': currentLocation!.latitude,
                    // 'longitude': currentLocation!.longitude,
                  });
                  // Increment the counter field in the user document


                  DocumentReference docRef = collRef.doc(); // Get the DocumentReference object for the added document
                  docRef.update({'status': 'completed'}); // Update the status of the request

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



