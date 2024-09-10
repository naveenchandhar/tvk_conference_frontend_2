

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';


import '../appstaticdata/colorfile.dart';

import '../provider/provide_colors.dart';
import '../responsivePackage.dart';
import '../staticdata.dart';

class ProfileTitleBar extends StatefulWidget {
  final String title;
  final String path;
  const ProfileTitleBar({Key? key, required this.title, required this.path}) : super(key: key);

  @override
  State<ProfileTitleBar> createState() => _ProfileTitleBarState();
}

class _ProfileTitleBarState extends State<ProfileTitleBar> {
  // final AppConst controller = Get.put(AppConst());
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    String currentLanguage = Get.locale?.languageCode ?? 'en';
    isSwitched = currentLanguage == 'ta';
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Consumer<ColorNotifire>(
          builder: (context, value, child) => GetBuilder<AppConst>(
            builder: (context2) {
              return Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  // left: 20.0,
                  // right: 20.0,
                ),
                child: Column(
                  children: [
                    Container(
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(10)
                      // ),
                      height:Responsive.isMobile(context)?60: 100,
                      color: signUpTopBarcolor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            heightFactor: 1,
                            widthFactor: 1,
                            child: Image.asset(
                              "assets/img/tvk-logo-new.png",
                              fit: BoxFit.fill,
                              height:Responsive.isMobile(context)?40:  100.0,
                              width:Responsive.isMobile(context)?50.0:  150.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Align(
                              heightFactor: 1,
                              widthFactor: 1,
                              child: Image.asset(
                                "assets/img/tvk-new-name-design.png",
                                fit: BoxFit.fill,
                                height:Responsive.isMobile(context)?50:  100.0,
                                width:Responsive.isMobile(context)?125.0:  400.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Align(
                              heightFactor: 1,
                              widthFactor: 1,
                              child: Image.asset(
                                "assets/img/new-vijay.png",
                                fit: BoxFit.fill,
                                height: Responsive.isMobile(context)?50: 140.0,
                                width:Responsive.isMobile(context)?60:  150.0,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(10)
                      // ),
                      height:Responsive.isMobile(context)?60: 150,
                      color: signUpTopBarcolor,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  double _getTermsFontSize(AppConst context) {
    var currentLocale = Get.locale;

    // Define font sizes for English and Tamil
    if (currentLocale?.languageCode == 'ta') {
      // Font size for Tamil
      return 13.0;
    } else {
      // Font size for English
      return 16.0;
    }
  }
}
