
import 'package:finals/screens/auth/register.dart';
import 'package:finals/screens/auth/register_ngo.dart';
import 'package:flutter/material.dart';

class Option extends StatefulWidget {
  const Option({super.key});

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: ()
              {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>Register())
                );
              },
                child: Text('User'),
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
              ),
              ElevatedButton(onPressed: ()
              {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>RegisterNgo())
                );
              },
                child: Text('NGO'),
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
        )
    );
  }
}
