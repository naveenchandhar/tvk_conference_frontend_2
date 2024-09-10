


import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../responsivePackage.dart';
import '../../theme/color.dart';


class CustomizedAppBar {

  bool isSwitched = false;

  customizedAppBarWidget(BuildContext context, String? screenName,
      GlobalKey<ScaffoldState> scaffoldKey,) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: SafeArea(
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              // gradient: LinearGradient(
              //     colors: <Color>[
              //       CustomTheme.loginGradientStart,
              //       CustomTheme.loginGradientEnd
              //     ],
              //     begin: FractionalOffset(0.0, 0.0),
              //     end: FractionalOffset(1.0, 1.0),
              //     stops: <double>[0.0, 1.0],
              //     tileMode: TileMode.clamp),
            ),
          ),

          backgroundColor: darker,
          leadingWidth: 30.0,
          elevation: 0,
          automaticallyImplyLeading: Responsive.isDesktop(context)
              ? false
              : true,
          leading: Image.asset(
            "assets/img/vmi_logo.png",
            // fit: BoxFit.fill,
            height: 120.0,
            width: 120.0,
          ),
          centerTitle: true,
          title: Container(
            margin: EdgeInsets.only(top: 5.0),
            // padding: EdgeInsets.only(right: 10.0),
            // color: blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Responsive.isDesktop(context) ?
                screenNameShowWidget(
                    screenName!, context)
                    : mobileLogo(screenName!, context),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "commonEnglish",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: light,
                    fontSize: 14.0,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                Switch(
                  value: isSwitched,
                  onChanged: (value) async {
                    isSwitched = value;


                    // setState(() {
                    //
                    // });

                    // Get.find<LocaleCont>()
                    //     .updateLocale(_changeLanguage(isSwitched, context));
                  },
                ),
                Text(
                  "tamilName",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: light,
                    fontSize: 14.0,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ],
            ),

            Tooltip(
              message: "Logout",
              textStyle: const TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                fontSize: 12.0,
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
              child: IconButton(
                hoverColor: const Color.fromRGBO(194, 193, 193, 1.0),
                splashRadius: 25.0,
                iconSize: 25.0,
                padding: const EdgeInsets.only(right: 5.0, top: 3.0),
                icon: const Icon(
                  Icons.logout,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
                onPressed: () async {

                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget screenNameShowWidget(String screenName, BuildContext context) {
    return Row(
      children: [

        Container(
          width: MediaQuery
              .of(context)
              .size
              .width / 4.5,
          // color: green,
          child: AutoSizeText(
            screenName,
            style: const TextStyle(
              color: light,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: 18.0,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Widget mobileLogo(String screenName, BuildContext context) {
    return Row(
      children: [

        Container(
          width: MediaQuery
              .of(context)
              .size
              .width / 4.5,
          // color: green,
          child: AutoSizeText(
            screenName,
            style: const TextStyle(
              color: light,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: 18.0,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}