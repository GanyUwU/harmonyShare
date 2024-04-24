
import 'package:finals/feedback/feedback_form.dart';
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
      appBar: AppBar(
        title: Text("HarmonyShare"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 7),
                          color: Colors.amber.withOpacity(1),
                          spreadRadius: 2,
                          blurRadius: 10
                      )
                    ]
                ),
                child: Text('Thank you',
                style: TextStyle(

                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextButton(
                  onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context)=>FeedbackForm()));
              },
                child: Text('Feedback'),
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

            ],
          ),
        ),

      )

    );
  }
}


