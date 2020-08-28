import 'dart:io';

import 'package:Kampus/liveBusTracking/deviceBasedTracking.dart';
import 'package:Kampus/liveBusTracking/liveBusTrackingHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Strings.dart';

class trackingHome extends StatefulWidget {
  @override
  _trackingHomeState createState() => new _trackingHomeState();
}

class _trackingHomeState extends State<trackingHome> {
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
    return new MaterialApp(
      title: Strings.appTitleBar,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: new Color(0xFFFFFFFF),
      ),
      home: Container(
        color: Color(0xFFFFFFFF),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              getAppBarUI(),
              Container(
                height: MediaQuery.of(context).size.height - 105,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: Container(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView(
                                //shrinkWrap: true,
                                padding: const EdgeInsets.only(top: 5.0),
                                children: <Widget>[
                                  customNewCard(context, 1),
                                  customNewCard(context, 2)
                                ],
                              ))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget customNewCard(BuildContext context, int type) {
  String title;
  if(type == 1) title = "Phone Based Tracking";
  else title = "Device Based Tracking";
  final _deviceHeight = MediaQuery.of(context).size.height;
  final _deviceWidth = MediaQuery.of(context).size.width;
  return Container(
    padding: EdgeInsets.all(10.0),
    child: GestureDetector(
      onTap: () {
        if(type == 1) {
          Navigator.push<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) =>
                  liveBusTrackingHome(),
            ),
          );
        }else{
          Navigator.push<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) =>
                  deviceBasedTracking(),
            ),
          );
        }
      },
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Container(
            height: _deviceHeight / 3.5,
            width: _deviceWidth / 1,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: Offset(0, 0))
              ],
              borderRadius: BorderRadius.circular(10),
              color: Colors.teal,
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: <Widget>[
                ClipPath(
                  clipper: CardClipPathFront(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Opacity(
                  opacity: 0.6,
                  child: ClipPath(
                    clipper: CardClipPathBack(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Text(
                          title,
                          style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "",
                          style: TextStyle(
                              fontSize: 35,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class CardClipPathFront extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.moveTo(0.0, size.height * 0.75);

    var firstControlPoint = Offset(size.width / 5, size.height - 30);
    var firstEndPoint = Offset(size.width / 2, size.height - 50.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 5 - 20), size.height - 75);
    var secondEndPoint = Offset(size.width, size.height - 70);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CardClipPathBack extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.moveTo(0.0, size.height * 0.70);

    var firstControlPoint = Offset(size.width / 6, size.height - 40);
    var firstEndPoint = Offset(size.width / 2 + 30, size.height * 0.6);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width * 0.5 - 60), size.height - 85);
    var secondEndPoint = Offset(size.width, size.height - 70);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

Widget getAppBarUI() {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Mobile",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  letterSpacing: 0.2,
                  color: Color(0xFF3A5160),
                ),
              ),
              Text(
                "Kampus",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  letterSpacing: 0.27,
                  color: Color(0xFF3A3A3A),
                ),
              ),
              Text(
                "Live Tracking",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  letterSpacing: 0.2,
                  color: Color(0xFF3A5160),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 36,
          height: 36,
          child: Image.asset('assets/images/userImage.png'),
        )
      ],
    ),
  );
}
