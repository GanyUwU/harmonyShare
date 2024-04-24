//
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Maps',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MapView(),
//     );
//   }
// }
//
// class MapView extends StatefulWidget {
//   @override
//   _MapViewState createState() => _MapViewState();
// }
//
// class _MapViewState extends State<MapView> {
//   // Initial location of the Map view
//   CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
//
// // For controlling the view of the Map
//   late GoogleMapController mapController;
//   final Geolocator _geolocator = Geolocator();
//
// // For storing the current position
//   late Position _currentPosition;
//   _getCurrentLocation() async {
//     await _geolocator
//         .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) async {
//       setState(() {
//         // Store the position in the variable
//         _currentPosition = position;
//
//         print('CURRENT POS: $_currentPosition');
//
//         // For moving the camera to current location
//         mapController.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               target: LatLng(position.latitude, position.longitude),
//               zoom: 18.0,
//             ),
//           ),
//         );
//       });
//     }).catchError((e) {
//       print(e);
//     });
//   }
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }
//   @override
//   Widget build(BuildContext context) {
//     // Determining the screen width & height
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//
//
//     return Container(
//       height: height,
//       width: width,
//       child: Scaffold(
//         body: Stack(
//           children: <Widget>[
//             // TODO: Add Map View
//             GoogleMap(
//               initialCameraPosition: _initialLocation,
//               myLocationEnabled: true,
//               myLocationButtonEnabled: false,
//               mapType: MapType.normal,
//               zoomGesturesEnabled: true,
//               zoomControlsEnabled: false,
//               onMapCreated: (GoogleMapController controller) {
//                 mapController = controller;
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
