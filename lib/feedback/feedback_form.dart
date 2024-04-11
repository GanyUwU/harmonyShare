import 'package:finals/screens/home/home.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            ),
            TextButton(
              child: const Text('Send'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // Only if the input form is valid (the user has entered text)
                  // We will use this var to show the result
                  // of this operation to the user
                  String message;
      
                  try {
                    // Get a reference to the `feedback` collection
                    final collection =
                    FirebaseFirestore.instance.collection('feedback');
      
                    // Write the server's timestamp and the user's feedback
                    await collection.doc().set({
                      'name' : _ngoName.text,
                      'timestamp': FieldValue.serverTimestamp(),
                      'feedback': _controller.text,
                      'rating': _rate.text,
                    });


                    FirebaseFirestore firestore = FirebaseFirestore.instance;
                    CollectionReference collectionReference = firestore.collection('ngo');

                      // Assuming you have a document with id 'document_id'
                    DocumentReference documentReference = collectionReference.doc('zBJC3177RX0tvk6byTta');

                       // Create a map with the new field and its value
                    Map<String, dynamic> newField = {
                      'rating': _rate.text
                    };
                      // Use updateData to add the new field to the document
                    documentReference.update(newField);

                    message = 'Feedback sent successfully';
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
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
    );
  }
}