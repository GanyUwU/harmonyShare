import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finals/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth/session_mng.dart';
import 'form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});



  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ref = FirebaseFirestore.instance.collection('Users').doc(SessionController().userId);
  String? userId = SessionController().userId;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
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
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text("Share your love with donation"),
                        SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => FormD()));
                            },
                            child: Text("Donate")
                        ),

                      ],
                    ),
                    Image.asset(
                        'assets/donate.png',
                        height: 120,
                        width: 120,
                        fit:BoxFit.cover
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
// REQUESTS
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
              /*
              SizedBox(height: 20),
              requests("NGO Name", "NGO Description"),
              SizedBox(height: 20),
              requests("NGO Name", "NGO Description"),
              SizedBox(height: 20),
              requests("NGO Name", "NGO Description"),
              SizedBox(height: 20),       
              */

              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      child: Text(
                        "Top NGO's",
                        style: TextStyle(
                            fontSize: 15.0,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold
                        ),
                      )
                  )
              ),
              SizedBox(height: 20),
              top_ngos("NGO Name", "NGO Description"),
              SizedBox(height: 20),
              top_ngos("NGO Name", "NGO Description"),
              SizedBox(height: 20),
              top_ngos("NGO Name", "NGO Description"),
              SizedBox(height: 20),
              top_ngos("NGO Name", "NGO Description"),
              SizedBox(height: 20),
              top_ngos("NGO Name", "NGO Description"),
            ],
          ),
        ),
      ),
    );
  }
/*
  requests(String title, String subtitle) {
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
      child: StreamBuilder(
      stream: widget.firestore.collection('Users').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return ListTile(
              title: Text(data['email'] ?? ''),
              subtitle: Text(subtitle),
              leading: CircleAvatar(
                radius: 30,
                child: ClipOval(
                  child: Image.asset('assets/ngo.png'),
                ),
              ),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.check), iconSize: 20),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.close), iconSize: 20)
                ],
              ),
              tileColor: Colors.white,
            );
          }).toList(),
        );
      },
      ),
    );
  }
*/
  top_ngos(String title, String subtitle) {
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
            child: Image.asset('assets/ngo.png'),
          ),
        ),
        tileColor: Colors.white,
      ),
    );
  }
}





Widget requests() {
  String? userId = SessionController().userId;
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection("form")
        .where("userId", isEqualTo: userId)
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
      if (!snapshot.hasData) {
        return const CircularProgressIndicator();
      }

      return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot document = snapshot.data!.docs[index];
            Map<dynamic, dynamic> data = document.data()! as Map<dynamic, dynamic>;
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Card(
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  splashColor: Colors.redAccent.withAlpha(30),
                  onTap: () {
                    debugPrint('Card tapped.');
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      const TextSpan(text: 'Order Id:\n'),
                                      TextSpan(text: data['orderId'].length > 15
                                          ? '${data['orderId'].substring(0, 15)}...'
                                          : data['orderId'],),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      const TextSpan(text: 'Order Date:\n'),
                                      TextSpan(text: data['timestamp']?.toDate()?.toString().substring(0, 10) ?? 'N/A')
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      const TextSpan(text: 'Status:\n'),
                                      TextSpan(text: data['orderStatus'] ?? 'N/A')
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Auth(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red[400],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              fixedSize: const Size(100, 40),
                            ),
                            child:const Text(
                              'Track Service',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}


