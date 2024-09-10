// import 'package:buzz/provider/proviercolors.dart';
// import 'package:buzz/staticdata.dart';
import 'package:tvk_maanadu/provider/provide_colors.dart';
import 'package:tvk_maanadu/responsivePackage.dart';

import '../main.dart';
// import 'package:TamilgaVetriKalagam/pushnotification/notification_services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
// import 'package:TamilgaVetriKalagam/provider/proviercolors.dart';
// import 'package:TamilgaVetriKalagam/responsivePackage.dart';
// import 'package:TamilgaVetriKalagam/staticdata.dart';
import 'package:tvk_maanadu/staticdata.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'appbar.dart';
import 'appbar.dart';
import 'appstaticdata/colorfile.dart';
import 'appstaticdata/staticdata.dart';
import 'comunbottombar.dart';
import 'darwer.dart';
import 'firebase_config/notification_services.dart';
import 'main.dart';
// import 'darwer.dart';

class HomePage extends StatefulWidget {
  final int? pageNavigation;
  const HomePage({super.key, this.pageNavigation});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NotificationServices notificationServices = NotificationServices();
  AppConst obj = AppConst();
  final AppConst controller = Get.put(AppConst());
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    controller.pageselecter.value = widget.pageNavigation ?? 0;
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
    isSwitched = currentLanguage;
  }



  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: false);
    RxDouble? screenwidth = Get.width.obs;
    double? breakpoint = 800.0;
    if (screenwidth >= breakpoint) {
      return GetBuilder<AppConst>(builder: (controller) {
        return Scaffold(
          body: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.showDrawer
                      ? SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: 260,
                      child: const DarwerCode())
                      : const SizedBox(),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Container(
                            height: 30,
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
                          const AppBarCode(),
                          Expanded(
                            child:
                            Obx(() {
                              Widget selectedPage =
                              // widget.pageNavigation==0?
                              controller
                                  .page[controller.pageselecter.value]
                              // :controller
                              // .page[widget.pageNavigation!]
                                  ;
                              return selectedPage;
                            }),


                            // builderFunction(controller),


                          ),
                          // ComunBottomBar(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

        );
      });
    }
    else {
      return GetBuilder<AppConst>(builder: (controller) {
        return WillPopScope(
          onWillPop: () => _onWillPop(context),
          child: Scaffold(
            appBar: const AppBarCode(),
            // drawer: ((Responsive.isTab(context)||Responsive.screenOrientation(context) == Orientation.landscape) ||kIsWeb)?const Drawer(width: 260, child: DarwerCode()):Container(),
            drawer: LayoutBuilder(
              builder: (context, constraints) {
                if ((Responsive.isTab(context) || Responsive.screenOrientation(context) == Orientation.landscape) || kIsWeb) {
                  return Drawer(width: 260, child: DarwerCode());
                } else {
                  return Container();
                }
              },
            ),
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Obx(() {
                Widget selectedPage =
                controller.page[controller.pageselecter.value];
                return selectedPage;
              }),
            ),
            // bottomNavigationBar:
            // ComunBottomBar(),
          ),
        );
      });
    }
  }

  Widget builderFunction(AppConst controller) {
    Widget selectedPage =
    controller.page[controller.pageselecter.value];
    return selectedPage;
  }

  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
    return exitResult ?? false;
  }

  AlertDialog _buildExitDialog(BuildContext context) {
    return AlertDialog(
      title: Container(
        height: MediaQuery.of(context).size.height/13,
        width:  MediaQuery.of(context).size.width/1,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
              "appExit_homepage".tr, // "Do you really want to exit the app?",
              style: Theme.of(context).textTheme.titleLarge,
              overflow: TextOverflow.ellipsis,
              maxLines:2
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: FittedBox(
            child: Text(
              'Cancel_app'.tr,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: FittedBox(
            child: Text(
              'EXIT'.tr,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  double _getFontSize(BuildContext context) {
    var currentLocale = Get.locale;
    if (currentLocale?.languageCode == 'ta') {
      // Font size for Tamil
      return 10.0;
    } else {
      // Font size for English
      return 12.0;
    }
  }

  // AlertDialog _buildExitDialog(BuildContext context) {
  //   return Container(
  //     child: AlertDialog(
  //       title: FittedBox(
  //         fit: BoxFit.scaleDown,
  //         child: Text(
  //           "appExit".tr, // "Do you really want to exit the app?",
  //           style: Theme.of(context).textTheme.headline6,
  //         ),
  //       ),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(false),
  //           child: FittedBox(
  //             fit: BoxFit.scaleDown,
  //             child: Text('Cancel_app'.tr),
  //           ),
  //         ),
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(true),
  //           child: FittedBox(
  //             fit: BoxFit.scaleDown,
  //             child: Text('EXIT'.tr),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
