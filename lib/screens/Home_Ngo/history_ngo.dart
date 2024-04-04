import 'package:flutter/material.dart';

class HistoryNgo extends StatelessWidget {
  const HistoryNgo ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          child: Text(
                            "History",
                            style: TextStyle(
                                fontSize: 15.0,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold
                            ),
                          )
                      )
                  ),
                ],
              ),
              SizedBox(height: 5),
              historys("Food item", "Food description"),
              SizedBox(height: 20),
              historys("Food item", "Food description"),
              SizedBox(height: 40),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      child: Text(
                        "Requests",
                        style: TextStyle(
                            fontSize: 15.0,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold
                        ),
                      )
                  )
              ),
              SizedBox(height: 20),
              messages("Donor Name", "Donar Description"),
              SizedBox(height: 20),
              messages("Donor Name", "Donar Description"),
              SizedBox(height: 20),
              messages("Donor Name", "Donar Description"),
              SizedBox(height: 20),
              // messages("Donor Name", "Donar Description"),
            ],
          ),
        ),
      ),
    );
  }
  historys(String title, String subtitle) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 7),
                color: Colors.amber.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10
            )
          ]
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: CircleAvatar(
          radius: 30,
          child: ClipOval(
            child: Image.asset('assets/food.png'),
          ),
        ),
        tileColor: Colors.white,
      ),
    );
  }
  messages(String title, String subtitle) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 7),
                color: Colors.amber.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10
            )
          ]
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: CircleAvatar(
          radius: 30,
          child: ClipOval(
            child: Image.asset('assets/donar.png'),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(onPressed: () { }, icon: Icon(Icons.message),iconSize: 20),
            IconButton(onPressed: () { }, icon: Icon(Icons.call),iconSize: 20)
          ],
        ),
        tileColor: Colors.white,
      ),
    );
  }
}
