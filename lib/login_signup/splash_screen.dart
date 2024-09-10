import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../appstaticdata/routes.dart';
import '../common/commonWidget/common_widgets.dart';
import '../main.dart';
import '../responsivePackage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var selected = 0;

  @override
  initState() {
    super.initState();

    if (loggedIn == true) {
      Future.delayed(
        const Duration(seconds: 3),
        () {
          // Get.offAllNamed(Routes.homepage);
        },
      );
    } else {
      Future.delayed(
        const Duration(seconds: 3),
        () {
          String currentRoute = Get.currentRoute;
          Get.offAllNamed(Routes.signup);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !kIsWeb
          ? Container(
              color: Color.fromRGBO(254, 231, 31, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/img/tvk-new-name-design.png",
                        fit: BoxFit.fill,
                        height: 100.0,
                        width: 250.0,
                      )
                    ],
                  )
                ],
              ),
            )
          : SizedBox(
              width: Responsive.isDesktop(context)
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    circularProgress(),
                  ],
                ),
              ),
            ),
    );
  }
}
