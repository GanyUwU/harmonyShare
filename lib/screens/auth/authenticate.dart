import 'dart:async';
import 'package:finals/screens/auth/sign_in.dart';
import 'package:finals/services/donor_dis.dart';
import 'package:finals/services/ngo_dis.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showPage = true;
  void toggleScreens(){
    setState(() {
      showPage = ! showPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    // if(showPage) {
      // return DonorDisplay(showDonorPage: toggleScreens);
    // }
      // else{
        // return NgoDisplay(showNgoPage: toggleScreens);

    // }
    return Text("hello");
  }
}
