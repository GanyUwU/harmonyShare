import 'package:finals/main.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackForm extends StatefulWidget {
  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  final _rate = TextEditingController();
  final _ngoName = TextEditingController();
  double _rating = 0.0;

  // Future<List<String>> fetchNames() async {
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('ngo').get();
  //   return querySnapshot.docs.map((doc) => doc['name'] as String).toList();
  // }

  String selectedNgo = "0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('ngo').snapshots(),
                  builder: (context,snapshot){
                    List<DropdownMenuItem> ngoNames = [];
                    if(!snapshot.hasData)
                    {
                      const CircularProgressIndicator();
                    }
                    else{
                      final names = snapshot.data?.docs.reversed.toList();
                      ngoNames.add(DropdownMenuItem(
                          value :"0",
                          child: Text('Selected : ')
                        )
                      );
                      for(var name in names!){
                        ngoNames.add(DropdownMenuItem(
                          value: name.id,
                            child:Text(
                              name['name'],
                            ),
                          ),
                        );
                      }
                    }
                    return DropdownButton(items: ngoNames,
                        onChanged: (ngoValue){
                      setState(() {
                        selectedNgo = ngoValue;
                      });
                      print(selectedNgo);
                     // print(ngoValue);
                      },
                      value: selectedNgo,
                      isExpanded: false,
                    );

                  }
              ),
              TextFormField(
                controller: _ngoName,
                decoration: InputDecoration(labelText: 'NGO name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Feedback'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some feedback';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _rate,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'rate out of 10'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some rating';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _rating = double.parse(value);
                  });
                },
              ),
              Slider(
                value: _rating,
                min: 0.0,
                max: 10.0,
                divisions: 10,
                label: '${_rating.round()}',
                onChanged: (value) {
                  setState(() {
                    _rating = value;
                    _rate.text = value.toString();
                  });
                },
              ),
              TextButton(
                child: const Text('Send'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Only if the input form is valid (the user has entered text)
                    // We will use this var to show the result
                    // of this operation to the user
                    String message;
                    String userId = FirebaseAuth.instance.currentUser!.uid;
                    try {

                      // Get a reference to the `feedback` collection
                      final collection = FirebaseFirestore.instance.collection('feedback');
                       //final ngoId= FirebaseFirestore.instance.collection('ngo').doc("2P5VR9Mb21gQ1wFKf5YvmvjeZPI2").get();
                      // Write the server's timestamp and the user's feedback
                      await collection.doc(userId).set({
                        'name' : _ngoName.text,
                        'feedback': _controller.text,
                        'rating': _rate.text,
                        'timestamp': FieldValue.serverTimestamp(),
                        'Uid': userId,
                        'ngo' : _ngoName.text
                       // 'NgoId': ngoId,
                      });



                      FirebaseFirestore firestore = FirebaseFirestore.instance;
                      CollectionReference collectionReference = firestore.collection('ngo');

                        // Assuming you have a document with id 'document_id'
                      DocumentReference documentReference = collectionReference.doc(selectedNgo);

                         // Create a map with the new field and its value
                      Map<String, dynamic> newField = {
                        'rating': _rate.text
                      };
                        // Use updateData to add the new field to the document
                      documentReference.update(newField);
          
                      message = 'Feedback sent successfully';
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> MyApp()));
                    } catch (e) {
                      message = e.toString();
                    }
                
                    // Show a snack-bar with the result
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(message)));
                
                    // Clear the text field
                    _controller.clear();
                
                    // Close the keyboard
                    FocusScope.of(context).unfocus();
                  }
          
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}