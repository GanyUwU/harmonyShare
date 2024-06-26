
import 'package:finals/screens/auth/register.dart';
import 'package:finals/screens/auth/register_ngo.dart';
import 'package:finals/screens/auth/sign_in.dart';
import 'package:finals/screens/auth/signin_NGO.dart';
import 'package:flutter/material.dart';

class Option_s extends StatefulWidget {
  const Option_s({super.key});

  @override
  State<Option_s> createState() => _Option_sState();
}

class _Option_sState extends State<Option_s> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HarmonyShare"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
        body: Center(
          child: SingleChildScrollView(
              // child: Padding(
              //   padding: EdgeInsets.all(20.0) ,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                 //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                        alignment: Alignment.center,
                        'assets/donate.png',
                       // height: 200,
                       //width: 300,
                        fit:BoxFit.cover
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: ()
                    {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>SignIn())
                      );
                    },
                      child: Text('User Sign in'),
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
                    SizedBox(height: 10.0),
                    ElevatedButton(onPressed: ()
                    {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>SignInNgo())
                      );
                    },
                      child: Text('NGO sign in'),
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
       // ),
    );
  }
}
