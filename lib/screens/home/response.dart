import 'package:finals/screens/home/home.dart';
import 'package:finals/screens/home/info.dart';
import 'package:finals/services/auth.dart';
import 'package:flutter/material.dart';

class Response extends StatefulWidget {
  const Response({super.key});

  @override
  State<Response> createState() => _ResponseState();
}

class _ResponseState extends State<Response> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Thank you'),
              TextButton(
                  onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context)=>Auth()));
              },
                child: Text('Go back'),
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

      )

    );
  }
}


