import 'package:Kampus/liveBusTracking/liveBusTrackingHome.dart';
import 'package:flutter/widgets.dart';
import 'package:Kampus/liveBusTracking/trackingHome.dart';

class MenuList {
  MenuList({
    this.navigateScreen,
  });

  Widget navigateScreen;
  String imagePath;

  static List<MenuList> menuList = [
    MenuList(
      navigateScreen: trackingHome(),
    ),
    MenuList(
      navigateScreen: liveBusTrackingHome(),
    ),
    MenuList(
      navigateScreen: liveBusTrackingHome(),
    ),
    MenuList(
      navigateScreen: liveBusTrackingHome(),
    ),
  ];
}