// import 'package:flutter/material.dart';
// import 'package:finals/screens/home/form.dart';
//
// class History extends StatelessWidget {
//   const History({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Align(
//                       alignment: Alignment.centerLeft,
//                       child: Container(
//                           child: Text(
//                             "History",
//                             style: TextStyle(
//                                 fontSize: 15.0,
//                                 letterSpacing: 2.0,
//                                 fontWeight: FontWeight.bold
//                             ),
//                           )
//                       )
//                   ),
//                   IconButton(
//                       onPressed: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => FormD()));
//                       },
//                       icon: Icon(Icons.add)
//                   )
//                 ],
//               ),
//               SizedBox(height: 5),
//               historys("Food item", "Food description"),
//               SizedBox(height: 20),
//               historys("Food item", "Food description"),
//               SizedBox(height: 40),
//               Align(
//                   alignment: Alignment.centerLeft,
//                   child: Container(
//                       child: Text(
//                         "Requests",
//                         style: TextStyle(
//                             fontSize: 15.0,
//                             letterSpacing: 2.0,
//                             fontWeight: FontWeight.bold
//                         ),
//                       )
//                   )
//               ),
//               SizedBox(height: 20),
//               messages("NGO Name", "NGO Description"),
//               SizedBox(height: 20),
//               messages("NGO Name", "NGO Description"),
//               SizedBox(height: 20),
//               messages("NGO Name", "NGO Description"),
//               SizedBox(height: 20),
//               // messages("NGO Name", "NGO Description")
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   historys(String title, String subtitle) {
//     return Container(
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//                 offset: Offset(0, 7),
//                 color: Colors.amber.withOpacity(.2),
//                 spreadRadius: 2,
//                 blurRadius: 10
//             )
//           ]
//       ),
//       child: ListTile(
//         title: Text(title),
//         subtitle: Text(subtitle),
//         leading: CircleAvatar(
//           radius: 30,
//           child: ClipOval(
//             child: Image.asset('assets/food.png'),
//           ),
//         ),
//         tileColor: Colors.white,
//       ),
//     );
//   }
//   messages(String title, String subtitle) {
//     return Container(
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//                 offset: Offset(0, 7),
//                 color: Colors.amber.withOpacity(.2),
//                 spreadRadius: 2,
//                 blurRadius: 10
//             )
//           ]
//       ),
//       child: ListTile(
//         title: Text(title),
//         subtitle: Text(subtitle),
//         leading: CircleAvatar(
//           radius: 30,
//           child: ClipOval(
//             child: Image.asset('assets/ngo.png'),
//           ),
//         ),
//         trailing: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             IconButton(onPressed: () { }, icon: Icon(Icons.message),iconSize: 20),
//             IconButton(onPressed: () { }, icon: Icon(Icons.call),iconSize: 20)
//           ],
//         ),
//         tileColor: Colors.white,
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Widget allOrderDetails() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("form")
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        const TextSpan(text: 'item:\n'),
                                        TextSpan(text: data['items'] ?? 'N/A')
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        const TextSpan(text: 'Order Time:\n'),
                                        TextSpan(text: data['time'] ?? 'N/A')
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        const TextSpan(text: 'Address:\n'),
                                        TextSpan(text: data['pickupAddress'] ?? 'N/A')
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        const TextSpan(text: 'Quantity:\n'),
                                        TextSpan(text: data['quantity'] ?? 'N/A')
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flexible(
        fit: FlexFit.tight,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(left: 8),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start, // Add this line to align the children to the start of the cross axis
                    children: [
                      allOrderDetails(),
                    ],
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
