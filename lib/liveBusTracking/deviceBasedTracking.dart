import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:mqtt_client/mqtt_client.dart';

class deviceBasedTracking extends StatefulWidget {
  @override
  _deviceBasedTrackingState createState() => _deviceBasedTrackingState();
}

class _deviceBasedTrackingState extends State<deviceBasedTracking> {
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
        body: _buildGoogleMap(context)
    );
  }

  Widget _buildGoogleMap(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        //myLocationEnabled: true,
        myLocationButtonEnabled: true,
        initialCameraPosition:  CameraPosition(target: LatLng(27.0, 77.0), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        /*markers: {
          ownLocation
        },*/
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

  Future<int> ttnMqttClient() async {
    const String url = 'as.thethings.network';
    const int port = 8883;
    const String clientId = 'lab_node/devices/lab_node';
    const String username = 'lab_node';
    const String password = 'ttn-account-v2.yvMqirMgQkhx-451PiaoW3Gisz_AFPUhw3IQUyB0FZY';
    final MqttClient client = MqttClient(url, clientId);
    client.port = port;
    client.secure = true;
    final String currDir = '${path.current}${path.separator}example${path.separator}';
    final SecurityContext context = SecurityContext.defaultContext;
    context.setTrustedCertificates(currDir + path.join('pem', 'roots.pem'));
    client.securityContext = context;
    //client.setProtocolV311();
    client.logging(on: true);
    await client.connect(username, password);
    if (client.connectionStatus.state == MqttConnectionState.connected) {
      print('iotcore client connected');
    } else {
      print(
          'ERROR iotcore client connection failed - disconnecting, state is ${client.connectionStatus.state}');
      client.disconnect();
    }
    const String topic = 'lab_node/devices/lab_node';
    print('Sleeping....');
    await MqttUtilities.asyncSleep(10);
    print('Disconnecting');
    client.disconnect();
    return 0;
  }
}