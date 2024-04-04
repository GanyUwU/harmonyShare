import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName({super.key, required this.documentId});

  @override
  Widget build(BuildContext context) {

    //get collection
    CollectionReference user = FirebaseFirestore.instance.collection('Users');
    return FutureBuilder<DocumentSnapshot>(
      future: user.doc(documentId).get(),
      builder: ((context,snapshot){
      if(snapshot.connectionState == ConnectionState.done){
        Map<String , dynamic> data =
        snapshot.data!.data() as Map<String , dynamic>;
        return Text(('${data['Name']}'));
      }
      return Text('Loading...');
    }),
    );
  }
}
