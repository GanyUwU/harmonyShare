

import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String name;
  final String email;
  final String phoneNo;
  final String password;

  const UserModel({
  this.id,
  required this.name,
  required this.email,
  required this.phoneNo,
  required this.password,
});

  toJson(){
    return{
      "FullName" : name,
      "Email" : email,
      "Phone" : phoneNo,
      "Password" : password
    };
  }
  factory UserModel.fromSnapShot(DocumentSnapshot <Map<String , dynamic >> document){
    final data = document.data()!;
    return UserModel(
        id :document.id,
        name:data['name'],
        email: data['email'],
        phoneNo: data['phone'],
        password: data['password'],
    );
  }
}