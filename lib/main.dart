import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Strings.dart';
import 'menuButtonsListView.dart';

void main() {
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(new MyApp()));
  // runApp(new MyApp());
}

class MyApp extends StatelessWidget {
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
        title: Strings.appTitleBar,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: new Color(0xFFFFFFFF),
        ),
        home: menuListView());
  }
}

class menuListView extends StatefulWidget {
  @override
  createState() => new menuListViewState();
}

class menuListViewState extends State<menuListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              height: MediaQuery.of(context).size.height - 88,
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: getMainUI(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget getMainUI(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: menuButtonsListView(),
        )
      ],
    ),
  );
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
