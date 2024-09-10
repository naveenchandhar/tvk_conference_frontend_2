
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


import '../appstaticdata/colorfile.dart';
import '../appstaticdata/routes.dart';
import '../appstaticdata/staticdata.dart';

import '../main.dart';

import '../provider/provide_colors.dart';
import '../responsivePackage.dart';
import '../staticdata.dart';
import 'onHoverText.dart';


class SignInTitleBar extends StatefulWidget {
  final String title;
  final String path;
  final TabController? tabController;
  const SignInTitleBar({Key? key, required this.title, required this.path,  this.tabController}) : super(key: key);

  @override
  State<SignInTitleBar> createState() => _SignInTitleBarState();
}

class _SignInTitleBarState extends State<SignInTitleBar> {
  final AppConst controller = Get.put(AppConst());
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    String currentLanguage = Get.locale?.languageCode ?? 'en';
    isSwitched = currentLanguage == 'ta';
  }

  @override
  Widget build(BuildContext context) {
    bool ispresent = false;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Consumer<ColorNotifire>(
          builder: (context, value, child) =>
              GetBuilder<AppConst>(
                builder: (context2) {
                  return Column(
                    children: [
                      Container(
                        height: 30,
                        color: signUpTopBarcolor,
                        child: Container(
                          color: Colors.transparent.withOpacity(0.5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () async {

                                        if (await canLaunchUrl(Uri.parse('fb://page/tvkvijayhq'))) {
                                          await launchUrl(Uri.parse('fb://page/tvkvijayhq'));
                                        }else {
                                          if (await canLaunchUrl(
                                              Uri.parse("https://www.facebook.com/tvkvijayhq/"))) {
                                            await launchUrl(Uri.parse("https://www.facebook.com/tvkvijayhq/"));
                                          } else {
                                            throw 'Could not launch url';
                                          }
                                        }
                                        // await launchUrl(Uri.parse("https://www.facebook.com/tvkvijayhq/"),  );
                                      },
                                      icon: const FaIcon(FontAwesomeIcons.squareFacebook), // Facebook icon
                                      iconSize: 20.0,
                                      color: Colors.blue,
                                    ),
                                    // const SizedBox(width: 20.0),
                                    IconButton(
                                      onPressed: () async {
                                        if (await canLaunchUrl(Uri.parse('twitter://user?screen_name=tvkvijayhq'))) {
                                          await launchUrl(Uri.parse('twitter://user?screen_name=tvkvijayhq'));
                                        }else {
                                          if (await canLaunchUrl(
                                              Uri.parse("https://x.com/tvkvijayhq?lang=en"))) {
                                            await launchUrl(Uri.parse("https://x.com/tvkvijayhq?lang=en"));
                                          } else {
                                            throw 'Could not launch url';
                                          }
                                        }
                                        // await launchUrl(Uri.parse("https://x.com/tvkvijayhq?lang=en") );
                                      },
                                      icon: const FaIcon(FontAwesomeIcons.squareXTwitter), // Twitter icon
                                      iconSize: 20.0,
                                      color: Colors.black,
                                    ),
                                    // const SizedBox(width: 20.0),
                                    IconButton(
                                      onPressed: () async {
                                        if (await canLaunchUrl(Uri.parse('instagram://user?username=tvkvijayhq'))) {
                                          await launchUrl(Uri.parse('instagram://user?username=tvkvijayhq'));
                                        }else {
                                          if (await canLaunchUrl(
                                              Uri.parse("https://www.instagram.com/tvkvijayhq"))) {
                                            await launchUrl(Uri.parse("https://www.instagram.com/tvkvijayhq"));
                                          } else {
                                            throw 'Could not launch url';
                                          }
                                        }
                                        // await launchUrl(Uri.parse("https://www.instagram.com/tvkvijayhq") );
                                      },
                                      icon: const FaIcon(FontAwesomeIcons.squareInstagram), // Instagram icon
                                      iconSize: 20.0,
                                      color: Colors.pink,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(10)
                        // ),
                        height: Responsive.isMobile(context) ? 60 : 100,
                        color: signUpTopBarcolor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            SizedBox(
                              child: Row(
                                children: [
                                  (Responsive.isMobile(context) && !(MediaQuery
                                      .sizeOf(context)
                                      .width > 680) && (MediaQuery
                                      .sizeOf(context)
                                      .width < 900) && (Responsive.screenOrientation(
                                      context) ==
                                      Orientation.portrait) && !Responsive.isDesktop(context))?
                                    InkWell(
                                        onTap: () {
                                          Scaffold.of(context).openDrawer();
                                        },
                                        child: SizedBox(
                                            height: 27,
                                            width: 27,
                                            child: Center(
                                                child: SvgPicture.asset(
                                                  "assets/menu-left.svg",
                                                  height: 25,
                                                  width: 25,
                                                  color: Colors.black,
                                                )))):(MediaQuery
                         .sizeOf(context)
                    .width >= 668)&&(MediaQuery
                    .sizeOf(context)
                    .width <= 767)&&!(Responsive.screenOrientation(
                                      context) ==
                                      Orientation.portrait)?InkWell(
                                      onTap: () {
                                        Scaffold.of(context).openDrawer();
                                      },
                                      child: SizedBox(
                                          height: 27,
                                          width: 27,
                                          child: Center(
                                              child: SvgPicture.asset(
                                                "assets/menu-left.svg",
                                                height: 25,
                                                width: 25,
                                                color: Colors.black,
                                              )))):Container(),
                                  Align(
                                    heightFactor: 1,
                                    widthFactor: 1,
                                    child: Image.asset(
                                      "assets/img/tvk-logo-new.png",
                                      fit: BoxFit.fill,
                                      height: Responsive.isMobile(context)
                                          ? 40
                                          : 100.0,
                                      width: Responsive.isMobile(context)
                                          ? 50.0
                                          : 150.0,
                                    ),
                                  ),
                                ],
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
                                  height: Responsive.isMobile(context)
                                      ? 50
                                      : 100.0,
                                  width: Responsive.isMobile(context)
                                      ? 125.0
                                      : 400.0,
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
                                  height: Responsive.isMobile(context)
                                      ? 50
                                      : 140.0,
                                  width: Responsive.isMobile(context)
                                      ? 60
                                      : 150.0,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      (Responsive.isDesktop(context)) ?
                      Container(
                        height: 40,
                        color: signUpTopFontcolor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 50),
                            Row(
                              children: [
                                OnHoverText(
                                  builder: (bool isHovered) {
                                    return IconButton(
                                      onPressed: () {
                                        // Get.offAllNamed(Routes.newHome);
                                        // deleteUserPost(tweedleDataList[index].id!);
                                      },
                                      icon: const Icon(Icons.home),
                                      iconSize: Responsive.isDesktop(
                                          context) ? 20.0 : 10.0,
                                      color: isHovered
                                          ? continercolor
                                          : signUpTopBarcolor,
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Row(
                              children: [
                                PopupMenuButton(
                                  offset: Offset(0,
                                      constraints.maxWidth >= 800 ? 30 : 10),
                                  tooltip: "",
                                  itemBuilder: (ctx) =>
                                  [
                                    _buildPopupPartyMenuItem(),
                                  ],
                                  child: OnHoverText(
                                    builder: (bool isHovered) {
                                      return Text(
                                        'Party'.tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: _getTermsFontSize(
                                              context2),
                                          color: isHovered
                                              ? continercolor
                                              : signUpTopBarcolor,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 50,),
                            Row(
                              children: [
                                OnHoverText(
                                  builder: (bool isHovered) {
                                    return InkWell(
                                      onTap: () {
                                        // Get.offAllNamed(Routes.news);
                                      },
                                      child: Text(
                                        'news'.tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: _getTermsFontSize(
                                              context2),
                                          color: isHovered
                                              ? continercolor
                                              : signUpTopBarcolor,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(width: 50,),
                            Row(
                              children: [
                                OnHoverText(
                                  builder: (bool isHovered) {
                                    return InkWell(
                                      onTap: () async {
                                        Get.offAllNamed(Routes.signup);
                                      },
                                      child: Text(
                                        'member'.tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: _getTermsFontSize(
                                              context2),
                                          color: isHovered
                                              ? continercolor
                                              : signUpTopBarcolor,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(width: 50,),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                OnHoverText(

                                  builder: (bool isHovered) {
                                    return InkWell(
                                      onTap: () {
                                        // Get.offAllNamed(Routes.contact);
                                      },
                                      child: Text(
                                        'contact'.tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: _getTermsFontSize(
                                              context2),
                                          color: isHovered
                                              ? continercolor
                                              : signUpTopBarcolor,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    // width: 100.0,
                                    height: 30.0,
                                    decoration: const BoxDecoration(
                                      //  color: signUpTopFontcolor,
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: signUpTopBarcolor,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: !kIsWeb
                                              ? 0.0
                                              : Responsive.isMobile(context)
                                              ? 0.0
                                              : 11,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0),
                                        ),
                                      ),
                                      onPressed: () async {
                            Get.offAllNamed(Routes.signup);
                                      },
                                      child: Text("commonLoginTamilMobile".tr, style: TextStyle(
                                        color: signUpTopFontcolor,
                                        fontWeight: FontWeight.w900,
                                      )),

                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  // FlutterSwitch(
                                  //   activeText: commonTamil,
                                  //   inactiveText: commonEnglish,
                                  //   value: isSwitched,
                                  //   valueFontSize: 10.0,
                                  //   width: 55,
                                  //   borderRadius: 30.0,
                                  //   activeColor: Colors.blue,
                                  //   inactiveColor: Colors.blue,
                                  //   showOnOff: true,
                                  //   onToggle: (val) {
                                  //     setState(() {
                                  //       isSwitched = val;
                                  //     });
                                  //     if (val) {
                                  //       // Switched to Tamil
                                  //       Get.updateLocale(
                                  //           const Locale('ta', 'IN'));
                                  //     } else {
                                  //       // Switched to English
                                  //       Get.updateLocale(
                                  //           const Locale('en', 'US'));
                                  //     }
                                  //   },
                                  // ),
                                  const SizedBox(width: 50,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ) :
                      !Responsive.isMobile(context) ?
                      Container(
                        height: 40,
                        color: signUpTopFontcolor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 50),

                            Row(
                              children: [
                                OnHoverText(
                                  builder: (bool isHovered) {
                                    return IconButton(
                                      onPressed: () {
                                        // Get.offAllNamed(Routes.newHome);
                                        // deleteUserPost(tweedleDataList[index].id!);
                                      },
                                      icon: const Icon(Icons.home),
                                      iconSize: 20.0,
                                      color: isHovered
                                          ? continercolor
                                          : signUpTopBarcolor,
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Row(
                              children: [
                                PopupMenuButton(
                                  itemBuilder: (ctx) =>
                                  [
                                    _buildPopupPartyMenuItem(),
                                  ],
                                  child: OnHoverText(
                                    builder: (bool isHovered) {
                                      return Text(
                                        'Party'.tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: _getTermsFontSize(
                                              context2),
                                          color: isHovered
                                              ? continercolor
                                              : signUpTopBarcolor,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 50,),
                            Row(
                              children: [
                                OnHoverText(
                                  builder: (bool isHovered) {
                                    return InkWell(
                                      onTap: () {
                                        // Get.offAllNamed(Routes.news);
                                      },
                                      child: Text(
                                        'news'.tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: _getTermsFontSize(
                                              context2),
                                          color: isHovered
                                              ? continercolor
                                              : signUpTopBarcolor,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(width: 50,),
                            Row(
                              children: [
                                OnHoverText(
                                  builder: (bool isHovered) {
                                    return InkWell(
                                      onTap: () {
                                        Get.offAllNamed(Routes.signup);
                                      },
                                      child: Text(
                                        'member'.tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: _getTermsFontSize(
                                              context2),
                                          color: isHovered
                                              ? continercolor
                                              : signUpTopBarcolor,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(width: 50,),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                OnHoverText(
                                  builder: (bool isHovered) {
                                    return InkWell(
                                      child: Text(
                                        'contact'.tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: _getTermsFontSize(
                                              context2),
                                          color: isHovered
                                              ? continercolor
                                              : signUpTopBarcolor,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    // width: 100.0,
                                    height: 30.0,
                                    decoration: const BoxDecoration(
                                      //  color: signUpTopFontcolor,
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: signUpTopBarcolor,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: !kIsWeb
                                              ? 0.0
                                              : Responsive.isMobile(context)
                                              ? 0.0
                                              : 11,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0),
                                        ),
                                      ),
                                      onPressed: () async {
                                        Get.offAllNamed(Routes.signup);
                                      },
                                      child: Text("commonLoginTamilMobile".tr, style: TextStyle(
                                        color: signUpTopFontcolor,
                                        fontWeight: FontWeight.w900,
                                      )),

                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  // FlutterSwitch(
                                  //   activeText: commonTamil,
                                  //   inactiveText: commonEnglish,
                                  //   value: isSwitched,
                                  //   valueFontSize: 10.0,
                                  //   width: 55,
                                  //   borderRadius: 30.0,
                                  //   activeColor: Colors.blue,
                                  //   inactiveColor: Colors.blue,
                                  //   showOnOff: true,
                                  //   onToggle: (val) {
                                  //     setState(() {
                                  //       isSwitched = val;
                                  //     });
                                  //     if (val) {
                                  //       // Switched to Tamil
                                  //       Get.updateLocale(
                                  //           const Locale('ta', 'IN'));
                                  //     } else {
                                  //       // Switched to English
                                  //       Get.updateLocale(
                                  //           const Locale('en', 'US'));
                                  //     }
                                  //   },
                                  // ),
                                  const SizedBox(width: 50,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ) :
                      (MediaQuery
                          .sizeOf(context)
                          .width > 680) && (MediaQuery
                          .sizeOf(context)
                          .width < 900) && (Responsive.screenOrientation(
                          context) ==
                          Orientation.portrait) ?
                      Container(
                        height: 40,
                        color: signUpTopFontcolor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 50),
                            Row(
                              children: [
                                OnHoverText(
                                  builder: (bool isHovered) {
                                    return IconButton(
                                      onPressed: () {
                                        // Get.offAllNamed(Routes.newHome);
                                        // deleteUserPost(tweedleDataList[index].id!);
                                      },
                                      icon: const Icon(Icons.home),
                                      iconSize: 20.0,
                                      color: isHovered
                                          ? continercolor
                                          : signUpTopBarcolor,
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Row(
                              children: [
                                PopupMenuButton(
                                  itemBuilder: (ctx) =>
                                  [
                                    _buildPopupPartyMenuItem(),
                                  ],
                                  child: OnHoverText(
                                    builder: (bool isHovered) {
                                      return Text(
                                        'Party'.tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: _getTermsFontSize(
                                              context2),
                                          color: isHovered
                                              ? continercolor
                                              : signUpTopBarcolor,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 50,),
                            Row(
                              children: [
                                OnHoverText(
                                  builder: (bool isHovered) {
                                    return InkWell(
                                      onTap: () {
                                        // Get.offAllNamed(Routes.news);
                                      },
                                      child: Text(
                                        'news'.tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: _getTermsFontSize(
                                              context2),
                                          color: isHovered
                                              ? continercolor
                                              : signUpTopBarcolor,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(width: 50,),
                            Row(
                              children: [
                                OnHoverText(
                                  builder: (bool isHovered) {
                                    return InkWell(
                                      onTap: () {
                                        Get.offAllNamed(Routes.signup);
                                      },
                                      child: Text(
                                        'member'.tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: _getTermsFontSize(
                                              context2),
                                          color: isHovered
                                              ? continercolor
                                              : signUpTopBarcolor,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(width: 50,),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                OnHoverText(
                                  builder: (bool isHovered) {
                                    return InkWell(
                                      child: Text(
                                        'contact'.tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: _getTermsFontSize(
                                              context2),
                                          color: isHovered
                                              ? continercolor
                                              : signUpTopBarcolor,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    // width: 100.0,
                                    height: 30.0,
                                    decoration: const BoxDecoration(
                                      //  color: signUpTopFontcolor,
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: signUpTopBarcolor,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: !kIsWeb
                                              ? 0.0
                                              : Responsive.isMobile(context)
                                              ? 0.0
                                              : 11,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4.0),
                                        ),
                                      ),
                                      onPressed: () async {
                                        Get.offAllNamed(Routes.signup);
                                      },
                                      child: Text("commonLoginTamilMobile".tr, style: TextStyle(
                                        color: signUpTopFontcolor,
                                        fontWeight: FontWeight.w900,
                                      )),

                                    ),
                                  ),
                                  const SizedBox(width: 10,),
                                  // FlutterSwitch(
                                  //   activeText: commonTamil,
                                  //   inactiveText: commonEnglish,
                                  //   value: isSwitched,
                                  //   valueFontSize: 10.0,
                                  //   width: 55,
                                  //   borderRadius: 30.0,
                                  //   activeColor: Colors.blue,
                                  //   inactiveColor: Colors.blue,
                                  //   showOnOff: true,
                                  //   onToggle: (val) {
                                  //     setState(() {
                                  //       isSwitched = val;
                                  //     });
                                  //     if (val) {
                                  //       // Switched to Tamil
                                  //       Get.updateLocale(
                                  //           const Locale('ta', 'IN'));
                                  //     } else {
                                  //       // Switched to English
                                  //       Get.updateLocale(
                                  //           const Locale('en', 'US'));
                                  //     }
                                  //   },
                                  // ),
                                  const SizedBox(width: 50,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ) : Container(),
                    ],
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

  PopupMenuItem _buildPopupPartyMenuItem() {
    return PopupMenuItem(
      enabled: false,
      padding: const EdgeInsets.all(0),

      child: Center(
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  // Get.offAllNamed(Routes.pledge);
                },
                child: Container(
                  decoration: const BoxDecoration(

                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, right: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                                child: Text(
                                  "commonUserReference".tr,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,
                                    color: themblack,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ),
              InkWell(
                onTap: () {
                  // Get.offAllNamed(Routes.principle
                  // );
                },
                child: Container(
                  decoration: const BoxDecoration(

                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, right: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                                child: Text(
                                  "principle".tr,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.ellipsis,
                                    color: themblack,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ),

            ],
          )
      ),
    );
  }
}






