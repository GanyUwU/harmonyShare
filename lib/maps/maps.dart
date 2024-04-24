import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location_package;

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  List<Ngo> _ngos = [
    Ngo(
      name: 'anna daan',
      location: 'thane south',
      coordinates: LatLng(19.26709175525647, 72.9607516663911), // San Francisco as an example
    ),
    Ngo(
      name: 'food serving',
      location: 'Nearby Location 2',
      coordinates: LatLng(19.262711236786437, 72.97418969989013), // Oakland as an example
    ),
    Ngo(
      name: 'anna dan kendra',
      location: 'Nearby Location 3',
      coordinates: LatLng(19.25422923955947, 72.97811844221371), // Oakland as an example
    ),
    Ngo(
      name: 'ayush anna kendra',
      location: 'Nearby Location 4',
      coordinates: LatLng(19.21329722452927, 72.96290337535669), // Oakland as an example
    ),

  ];
  location_package.LocationData? _currentLocation;
  bool _locationRequested = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    location_package.Location location = location_package.Location();
    bool _serviceEnabled;
    location_package.PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == location_package.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != location_package.PermissionStatus.granted) {
        return;
      }
    }

    _currentLocation = await location.getLocation();

    setState(() {
      _locationRequested = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = _ngos.map((ngo) => Marker(
      markerId: MarkerId(ngo.name!),
      position: ngo.coordinates!,
      infoWindow: InfoWindow(
        title: ngo.name,
        snippet: ngo.location,
      ),
    )).toSet();

    if (_currentLocation != null && _locationRequested) {
      markers.add(Marker(
        markerId: MarkerId('Current Location'),
        position: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: InfoWindow(
          title: 'Your Location',
          snippet: 'This is your current location.',
        ),
      ));

      final LatLng currentLocationLatLng = LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);
      mapController.animateCamera(CameraUpdate.newLatLng(currentLocationLatLng));
    }

    return GoogleMap(
      initialCameraPosition: _currentLocation != null && _locationRequested
          ? CameraPosition(
        target: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
        zoom: 12,
      )
          : CameraPosition(
        target: _ngos[0].coordinates!,
        zoom: 12,
      ),
      onMapCreated: (GoogleMapController controller) {
        mapController = controller;
      },
      markers: markers,
    );
  }
}

class Ngo {
  final String? name;
  final String? location;
  final LatLng? coordinates;

  Ngo({this.name, this.location, this.coordinates});
}