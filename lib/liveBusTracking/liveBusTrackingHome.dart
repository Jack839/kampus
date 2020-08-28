import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:Kampus/models/gpsData.dart';

class liveBusTrackingHome extends StatefulWidget {
  @override
  _liveBusTrackingHomeState createState() => _liveBusTrackingHomeState();
}

class _liveBusTrackingHomeState extends State<liveBusTrackingHome> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
      Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: "Bus Tracking",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: new Color(0xFFFFFFFF),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();
  Map<String, double> currentLocationValue = new Map();
  StreamSubscription<LocationData> locationSubscription;
  Location location = new Location();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  /*@override
  void initState() {
    super.initState();
    location.requestService();
    currentLocationValue['latitude'] = 0.0;
    currentLocationValue['longitude'] = 0.0;

    getInitialLocation();
    locationSubscription = location.onLocationChanged().listen((LocationData currentLocation) {
      if(currentLocation != null){
        currentLocationValue['latitude'] = currentLocation.latitude;
        currentLocationValue['longitude'] = currentLocation.longitude;
        setCamera();
      }
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bus Tracking",
        ),
      ),
      body: _buildBody(context)
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('gpsID').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildGoogleMap(context, snapshot.data.documents[0]);
      },
    );
  }

  Widget _buildGoogleMap(BuildContext context, DocumentSnapshot data) {
    final record = gpsData.fromSnapshot(data);
    try{
      Marker currentLocationMarker = Marker(
        markerId: MarkerId("currentLocation"),
        infoWindow: InfoWindow(
            title: "Current Location",
            snippet: "Drivers/Bus Current location"),
        position: LatLng(record.latitude,
            record.longitude),
      );
      setState(() {
        markers[currentLocationMarker.markerId] = currentLocationMarker;
        setCamera(record);
      });
    }catch(e){
    }
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        //myLocationEnabled: true,
        myLocationButtonEnabled: true,
        initialCameraPosition:  CameraPosition(target: LatLng(record.latitude, record.longitude), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
          markers: Set<Marker>.of(markers.values)
      ),
    );
  }

  /* Marker ownLocation = Marker(
    markerId: MarkerId('Your Location'),
    position: LatLng(currentLocationValue['latitude'], currentLocationValue['logitude']),
    infoWindow: InfoWindow(title: 'Your Location'),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueViolet,
    ),
  );*/

  Future<void> setCamera(final gData) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(gData.latitude, gData.longitude), zoom: 12)));
  }

  void getInitialLocation() async {
    LocationData currentLocation = null;
    bool error = false;
    try {
      currentLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = true;
      }
    }
    setState(() {
      if (currentLocation != null){
        currentLocationValue['latitude'] = currentLocation.latitude;
        currentLocationValue['longitude'] = currentLocation.longitude;
      }
    });
  }
}