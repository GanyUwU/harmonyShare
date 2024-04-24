import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String photoUrl;

  User({required this.id, required this.name, required this.email, required this.photoUrl});

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc.id,
      name: doc['name'],
      email: doc['email'],
      photoUrl: doc['photoUrl'],
    );
  }
}