import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String,dynamic> userInfoMap , String id)async{
    return await FirebaseFirestore.instance.collection("User").doc(id).set(userInfoMap);
  }

  Future updateUserDetails(Map<String,dynamic> updateInfo , String uid)async{
    return await FirebaseFirestore.instance.collection("User").doc(uid).update(updateInfo);
  }


  // Define the function to fetch the order details from Firestore
  Future<Stream<QuerySnapshot<Object?>>> getOrderDetails() async {
    // Get the current user
    final user = FirebaseAuth.instance.currentUser;
    // If the user is not null, fetch the order details from Firestore
    if (user != null) {
      // Get the orders collection from Firestore where the userId matches the current user's id
      final ordersCollection = FirebaseFirestore.instance
          .collection('form')
          .where('userId', isEqualTo: user.uid);
      // Return the stream of query snapshots from Firestore
      return ordersCollection.snapshots();
    }

    // If the user is null, return an empty stream
    return const Stream.empty();
  }
}