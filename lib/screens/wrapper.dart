import 'package:finals/screens/auth/authenticate.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //return either home or authenticate widget
    return Container(
      child: Authenticate(),
    );
  }
}
