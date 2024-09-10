import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget? mobile;
  final Widget? desktop;
  final Widget? tab;

  const Responsive({
    Key? key,
    this.mobile,
    this.desktop,
    this.tab,
  }) : super(key: key);

  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 767;

  static bool isTab(BuildContext context) =>
      MediaQuery.of(context).size.width <= 991;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 992;

  static Orientation screenOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 767) {
          return mobile!;
        } else if(constraints.maxWidth <=991) {
          return tab!;
        } else {
          return desktop!;
        }
      },
    );
  }
}
