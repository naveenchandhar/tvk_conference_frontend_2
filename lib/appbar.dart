// ignore_for_file: deprecated_member_use


import 'dart:convert';

import 'package:tvk_maanadu/provider/provide_colors.dart';
import 'package:tvk_maanadu/staticdata.dart';

import '../responsivePackage.dart';
// import 'package:TamilgaVetriKalagam/sign_up/signup_service.dart';
import 'package:tvk_maanadu/Toast_message/toast_message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
// import '../provider/proviercolors.dart';
// import 'package:TamilgaVetriKalagam/staticdata.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'appstaticdata/routes.dart';
import 'appstaticdata/staticdata.dart';
// import 'constants/i18n_en.dart';
import 'main.dart';
import 'member/member_data_model.dart' as mdm;
import 'member/member_service.dart';

class AppBarCode extends StatefulWidget implements PreferredSizeWidget {
  const AppBarCode({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<AppBarCode> createState() => _AppBarCodeState();
}

class _AppBarCodeState extends State<AppBarCode> {
  bool search = false;
  bool darkMood = false;
  final AppConst controller = Get.put(AppConst());
  bool isSwitched=Get.locale?.languageCode=='ta'?true:false;
  FToast fToast = FToast();
  // int memberid = 0;
  // int adminflag = 0;
  mdm.Data? memberData;
  String username= "";
  String role = "";
  // String profileimg ='';

  @override
  void initState() {
    super.initState();
    fToast.init(context);
    // memberid =box.read('memberId')??11;
    // adminflag = box.read("adminFlag")??0;
    // getSignUpData(context,memberId);   //edited by vignesh
    // String currentLanguage = Get.locale?.languageCode ?? 'en';
    // isSwitched = currentLanguage == 'ta';
    isSwitched = currentLanguage;
    if(isSwitched==true){
      Get.updateLocale(const Locale('ta', 'IN'));
    }
    // globolProfile.addListener(() {
    //   profileGlobol = globolProfile.value;
    //   profileRefreshMethod();
    // });

  }

  void profileRefreshMethod() {
    profileGlobol;
    setState(() {});
  }

  getSignUpData(BuildContext context,int memberid) async {
    await MemberService.getMemberListById(memberid).then((backendData) async {
      memberData= backendData.data;

      username = memberData!.nameFirstEn!;
      role = memberData!.role!.role;
      profileGlobol= memberData!.voterId!;
      setState(() {

      });



    });
  }
  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<ColorNotifire>(context);
    final screenwidth = Get.width;
    bool ispresent = false;
    // getting the value from the provider instance

    const breakpoint = 800.0;

    if (screenwidth >= breakpoint) {
      setState(() {
        ispresent = true;
      });
    }
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return GetBuilder<AppConst>(builder: (controller) {
            return AppBar(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: notifier.getbordercolor)),
              backgroundColor: notifier.getprimerycolor,
              elevation: 1,
              leading:
              ispresent
                  ? InkWell(
                  onTap: () {
                    controller.updateshowDrawer();
                  },
                  child: SizedBox(
                      height: 27,
                      width: 27,
                      child: Center(
                          child: SvgPicture.asset(
                            "assets/menu-left.svg",
                            height: 25,
                            width: 25,
                            color: notifier.geticoncolor,
                          ))))
                  :
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
                            color: notifier.geticoncolor,
                          )))),
              title: search
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                      height: 42,
                      width: Get.width * 0.3,
                      child: TextField(
                        style: TextStyle(color: notifier.getMainText),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(top: 5),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: notifier.getbordercolor, width: 2)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: notifier.getbordercolor, width: 2)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: notifier.getbordercolor, width: 2)),
                          hintStyle: TextStyle(color: notifier.getMainText),
                          hintText: "Search..",
                          prefixIcon: SizedBox(
                              height: 16,
                              width: 16,
                              child: Center(
                                  child: SvgPicture.asset(
                                    "assets/search.svg",
                                    height: 16,
                                    width: 16,
                                    color: notifier.geticoncolor,
                                  ))),
                        ),
                      )),
                ],
              )
                  : const SizedBox(),
              actions: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlutterSwitch(
                          activeText: 't',
                          inactiveText: "Ta",
                          // activeText: commonTamil,
                          // inactiveText: commonEnglish,
                          value: isSwitched,
                          valueFontSize: 10.0,
                          width: 55,
                          height: 30.0,
                          borderRadius: 30.0,
                          activeColor: Colors.blue,
                          inactiveColor:Colors.blue,
                          showOnOff: true,
                          onToggle: (val) async {
                            setState(() {
                              isSwitched = val;
                            });
                            if (isSwitched == true) {
                              Get.updateLocale(const Locale('ta', 'IN'));
                              final SharedPreferences pref = await prefs;
                              pref.setBool('isSwitched', true);
                              // notifire.setLocale(true);
                            } else {
                              // notifire.setLocale(false);
                              //
                              Get.updateLocale(const Locale('en', 'US'));
                              final SharedPreferences pref = await prefs;
                              pref.setBool('isSwitched', false);
                            }
                          },
                        ),

                      ],
                    ),
                    const SizedBox(width: 5.0,),

                    PopupMenuButton(
                      // color: Colors.transparent,
                      // shadowColor: Colors.grey.withOpacity(0.5),
            // elevation: 0.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      tooltip: "Account",
                      offset: Offset(0, constraints.maxWidth >= 800 ? 60 : 50),
                      child: constraints.maxWidth >= 800
                          ? SizedBox(
                        // color: Colors.green,
                        width: 160,
                        child: ListTile(
                          leading: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.transparent,
                              child: Container(
                                // width: 40.0,
                                // height: 40.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xff7c94b6),
                                  image: DecorationImage(
                                    image: NetworkImage(profileGlobol),
                                    fit: BoxFit.cover,
                                  ),
                                  // borderRadius: BorderRadius.all( Radius.circular(50.0)),
                                  border: Border.all(
                                    // color: Colors.red,
                                    width: 1.0,
                                  ),
                                ),
                              )
                          ),
                          title: Text(username,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                  color: notifier.getMainText)),
                          trailing: null,
                          subtitle: Row(
                            children: [
                              Text(role,
                                  style: TextStyle(
                                      fontSize:9,
                                      overflow: TextOverflow.ellipsis,
                                      color: notifier.getMaingey)),
                              Icon(
                                Icons.arrow_drop_down_outlined,
                                size: 12,
                                color: notifier.geticoncolor,
                              )
                            ],
                          ),
                        ),
                      )
                          : Row(
                            children: [
                              CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.transparent,
                              child: Container(
                                // width: 40.0,
                                // height: 40.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xff7c94b6),
                                  image: DecorationImage(
                                    image: NetworkImage(profileGlobol),
                                    fit: BoxFit.cover,
                                  ),
                                  // borderRadius: BorderRadius.all( Radius.circular(50.0)),
                                  border: Border.all(
                                    // color: Colors.red,
                                    width: 1.0,
                                  ),
                                ),
                              )),
                              Icon(
                                Icons.arrow_drop_down_outlined,
                                size: 25,
                                color: notifier.geticoncolor,
                              )
                            ],
                          ),

                      itemBuilder: (ctx) => [
                        // if(!kIsWeb)
                        // PopupMenuItem(
                        //   enabled: false,
                        //   padding: const EdgeInsets.all(0),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                        //       // color: Colors.yellow, // Adjust the background color as needed
                        //     ),
                        //     child: Column(
                        //       children: [
                        //         Row(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           // mainAxisSize: MainAxisSize.min,
                        //           children: [
                        //             Padding(
                        //               padding: const EdgeInsets.only( left: 20, right: 10),
                        //               child: Text(
                        //                 username,
                        //                 style: TextStyle(
                        //                   fontSize: 11,
                        //                   fontWeight: FontWeight.w600,
                        //                   overflow: TextOverflow.ellipsis,
                        //                   color: notifire?.getMainText,
                        //                 ),
                        //               ),
                        //             ),
                        //
                        //           ],
                        //         ),
                        //         Row(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           // mainAxisSize: MainAxisSize.min,
                        //           children: [
                        //             Padding(
                        //               padding: const EdgeInsets.only( left: 20,  right: 10),
                        //               child: Text(
                        //                 role,
                        //                 style: TextStyle(
                        //                   fontSize: 11,
                        //                   overflow: TextOverflow.ellipsis,
                        //                   color: notifire?.getMainText,
                        //                 ),
                        //               ),
                        //             ),
                        //
                        //           ],
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        //
                        // ),

                        _buildPopupAdminMenuItem(),

                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            );
          });
        });
  }

  // PopupMenuItem _buildPopupCartMenuItem() {
  //   return PopupMenuItem(
  //     enabled: false,
  //     child: Column(
  //       children: [
  //         const SizedBox(
  //           height: 20,
  //         ),
  //         Text(
  //           "Cart",
  //           style: TextStyle(
  //               color: notifire!.getMainText,
  //               fontWeight: FontWeight.bold,
  //               fontSize: 18),
  //         ),
  //         const SizedBox(
  //           height: 25,
  //         ),
  //         Divider(
  //           height: 1,
  //           color: notifire!.getbordercolor,
  //         ),
  //         const SizedBox(
  //           height: 10,
  //         ),
  //         SizedBox(
  //             height: 100,
  //             width: 300,
  //             child: Row(
  //               children: [
  //                 Container(
  //                   height: 70,
  //                   width: 60,
  //                   decoration: BoxDecoration(
  //                       image: const DecorationImage(
  //                           image: AssetImage(
  //                               "assets/dance-shoes-png-transparent-dance-shoes-images-5-min.png"),
  //                           fit: BoxFit.fill),
  //                       borderRadius: BorderRadius.circular(12)),
  //                 ),
  //                 const SizedBox(
  //                   width: 10,
  //                 ),
  //                 SizedBox(
  //                   height: 80,
  //                   width: 178,
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Row(
  //                         crossAxisAlignment: CrossAxisAlignment.center,
  //                         children: [
  //                           Text("Nike Shoes",
  //                               style: TextStyle(
  //                                   fontSize: 13,
  //                                   color: notifire!.getMainText)),
  //                           const SizedBox(
  //                             width: 10,
  //                           ),
  //                           SvgPicture.asset(
  //                             "assets/times.svg",
  //                             height: 10,
  //                             width: 10,
  //                             color: Colors.red,
  //                           )
  //                         ],
  //                       ),
  //                       const SizedBox(
  //                         height: 12,
  //                       ),
  //                       Wrap(
  //                         children: [
  //                           CircleAvatar(
  //                             radius: 10,
  //                             backgroundColor: Colors.grey.shade200,
  //                             child: Center(
  //                                 child:
  //                                 Text("-", style: mediumBlackTextStyle)),
  //                           ),
  //                           const SizedBox(
  //                             width: 8,
  //                           ),
  //                           Padding(
  //                             padding: const EdgeInsets.only(top: 3),
  //                             child: Text("0",
  //                                 style: mediumBlackTextStyle.copyWith(
  //                                     color: notifire!.getMainText)),
  //                           ),
  //                           const SizedBox(
  //                             width: 8,
  //                           ),
  //                           CircleAvatar(
  //                             radius: 10,
  //                             backgroundColor: Colors.grey.shade200,
  //                             child: Center(
  //                                 child:
  //                                 Text("+", style: mediumBlackTextStyle)),
  //                           ),
  //                         ],
  //                       ),
  //                       const SizedBox(
  //                         height: 12,
  //                       ),
  //                       const Text("\$800",
  //                           style: TextStyle(
  //                               fontSize: 14,
  //                               color: appMainColor,
  //                               fontWeight: FontWeight.bold)),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             )),
  //         Divider(
  //           height: 1,
  //           color: notifire!.getbordercolor,
  //         ),
  //         SizedBox(
  //             height: 100,
  //             width: 300,
  //             child: Row(
  //               children: [
  //                 Container(
  //                   height: 70,
  //                   width: 60,
  //                   decoration: BoxDecoration(
  //                       image: const DecorationImage(
  //                           image: AssetImage(
  //                               "assets/fashion-shoes-sneakers-removebg-preview-min.png"),
  //                           fit: BoxFit.cover),
  //                       borderRadius: BorderRadius.circular(12)),
  //                 ),
  //                 const SizedBox(
  //                   width: 10,
  //                 ),
  //                 SizedBox(
  //                   height: 80,
  //                   width: 178,
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Row(
  //                         crossAxisAlignment: CrossAxisAlignment.center,
  //                         children: [
  //                           Text("Jorden Shoes",
  //                               style: TextStyle(
  //                                   fontSize: 13,
  //                                   color: notifire!.getMainText)),
  //                           const SizedBox(width: 10),
  //                           SvgPicture.asset(
  //                             "assets/times.svg",
  //                             height: 10,
  //                             width: 10,
  //                             color: Colors.red,
  //                           )
  //                         ],
  //                       ),
  //                       const SizedBox(
  //                         height: 12,
  //                       ),
  //                       Wrap(
  //                         children: [
  //                           CircleAvatar(
  //                             radius: 10,
  //                             backgroundColor: Colors.grey.shade200,
  //                             child: Center(
  //                                 child:
  //                                 Text("-", style: mediumBlackTextStyle)),
  //                           ),
  //                           const SizedBox(
  //                             width: 8,
  //                           ),
  //                           Padding(
  //                             padding: const EdgeInsets.only(top: 3),
  //                             child: Text("0",
  //                                 style: mediumBlackTextStyle.copyWith(
  //                                     color: notifire!.getMainText)),
  //                           ),
  //                           const SizedBox(
  //                             width: 8,
  //                           ),
  //                           CircleAvatar(
  //                             radius: 10,
  //                             backgroundColor: Colors.grey.shade200,
  //                             child: Center(
  //                                 child:
  //                                 Text("+", style: mediumBlackTextStyle)),
  //                           ),
  //                         ],
  //                       ),
  //                       const SizedBox(
  //                         height: 12,
  //                       ),
  //                       const Text("\$1900",
  //                           style: TextStyle(
  //                               fontSize: 14,
  //                               color: appMainColor,
  //                               fontWeight: FontWeight.bold)),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             )),
  //         const SizedBox(
  //           height: 10,
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text("Order Total :",
  //                 style: mediumBlackTextStyle.copyWith(
  //                     color: notifire!.getMainText)),
  //             Text("\$2700.00",
  //                 style: mediumBlackTextStyle.copyWith(
  //                     color: notifire!.getMainText))
  //           ],
  //         ),
  //         const SizedBox(
  //           height: 30,
  //         ),
  //         const Text(
  //           "GO TO YOUR CART",
  //           style: TextStyle(
  //               color: appMainColor,
  //               decoration: TextDecoration.underline,
  //               fontSize: 12,
  //               fontWeight: FontWeight.bold),
  //         ),
  //         const SizedBox(
  //           height: 15,
  //         ),
  //         ElevatedButton(
  //             onPressed: () {
  //               controller.changePage(11);
  //               Get.back();
  //             },
  //             style: ElevatedButton.styleFrom(
  //                 backgroundColor: appMainColor,
  //                 fixedSize: const Size(140, 35)),
  //             child: const Text(
  //               "CHECK OUT",
  //               style:
  //               TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
  //             )),
  //         const SizedBox(
  //           height: 15,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  PopupMenuItem _buildPopupAdminMenuItem() {
    return PopupMenuItem(
      enabled: false,
      padding: const EdgeInsets.all(0),

      child: Container(

        child: Center(
          child:
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
            //   InkWell(
            //    onTap: (){
            //
            //   //   navigatedPage=23;
            //   //
            //   // Get.offAllNamed(Routes.homepage);
            // },
            //     child: Container(
            //       decoration: const BoxDecoration(
            //         border: Border(
            //           bottom: BorderSide(width: 1.5, color: Colors.black),
            //         ),
            //       ),
            //       child: Row(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           SizedBox(
            //
            //             width:35,
            //             child: IconButton(
            //               onPressed: () async {
            //                 // String fcmToken = box.read('fcmToken')??"";
            //                 // var memberId = box.read('memberId');
            //                 // adminFlag=11;
            //                 // deleteUserFcm(fcmToken, memberId,fToast);
            //                 // navigatedPage=0;
            //                 // fcmToken="";
            //                 // // showSuccessToast("User logout successfully", fToast);
            //                 // final SharedPreferences pref = await prefs;
            //                 // await pref.clear();
            //                 // box.erase();
            //                 // isPledgeView=true;
            //                 // isPledgeView=isPledgeView;
            //                 // Get.offAllNamed(Routes.signup);
            //                 //
            //               },
            //               icon: SvgPicture.asset('assets/settings.svg',height:12), // Provide the path to your logout icon
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(top: 8,left: 5.0),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Container(
            //             // color: Colors.blue,
            //                   child: SizedBox(
            //                     height:15,
            //                     child: Text(
            //                       username,
            //                       style: TextStyle(
            //                         fontSize: 11,
            //                         fontWeight:FontWeight.w700,
            //                         overflow: TextOverflow.ellipsis,
            //                         color: notifire?.getMainText,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //                 SizedBox(
            //                   height:15,
            //                   child: Text(
            //                     role,
            //                     style: TextStyle(
            //                       fontSize: 11,
            //                       overflow: TextOverflow.ellipsis,
            //                       color: notifire?.getMainText,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     // Container(
            //     //   // color: Colors.green,
            //     //   height:50,
            //     //   width: 160,
            //     //   decoration: const BoxDecoration(
            //     //     border: Border(
            //     //       bottom: BorderSide(width: 1.5, color: Colors.black),
            //     //     ),
            //     //   ),
            //     //   child: Padding(
            //     //     padding: const EdgeInsets.only(bottom: 20.0),
            //     //     child: ListTile(
            //     //       contentPadding: EdgeInsets.zero,
            //     //       leading: IconButton(
            //     //         onPressed: () async {
            //     //           // String fcmToken = box.read('fcmToken')??"";
            //     //           // var memberId = box.read('memberId');
            //     //           // adminFlag=11;
            //     //           // deleteUserFcm(fcmToken, memberId,fToast);
            //     //           // navigatedPage=0;
            //     //           // fcmToken="";
            //     //           // // showSuccessToast("User logout successfully", fToast);
            //     //           // final SharedPreferences pref = await prefs;
            //     //           // await pref.clear();
            //     //           // box.erase();
            //     //           // isPledgeView=true;
            //     //           // isPledgeView=isPledgeView;
            //     //           // Get.offAllNamed(Routes.signup);
            //     //           //
            //     //         },
            //     //         icon: SvgPicture.asset('assets/log-out.svg',height:12), // Provide the path to your logout icon
            //     //       ),
            //     //       title: Text(username,
            //     //           style: const TextStyle(
            //     //               fontSize: 10,
            //     //               fontWeight: FontWeight.w500,
            //     //               overflow: TextOverflow.ellipsis,
            //     //               color: Colors.black)),
            //     //       trailing: null,
            //     //       subtitle: Row(
            //     //         children: [
            //     //           Text(role,
            //     //               style: TextStyle(
            //     //                   fontSize:9,
            //     //                   overflow: TextOverflow.ellipsis,
            //     //                   color: Colors.black)),
            //     //
            //     //         ],
            //     //       ),
            //     //     ),
            //     //   ),
            //     // )
            //   ),


              // InkWell(
              //   onTap: (){
              //
              //       navigatedPage=11;
              //
              //     Get.offAllNamed(Routes.homepage);
              //   },
              //   child: Container(
              //     height:30,
              //     width: double.infinity,
              //     decoration: const BoxDecoration(
              //       border: Border(
              //         bottom: BorderSide(width: 1.0, color: Colors.black),
              //       ),
              //     ),
              //     child: Row(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         SizedBox(
              //           width:35,
              //           child: IconButton(
              //             onPressed: () async {
              //               // String fcmToken = box.read('fcmToken')??"";
              //               // var memberId = box.read('memberId');
              //               // adminFlag=11;
              //               // deleteUserFcm(fcmToken, memberId,fToast);
              //               // navigatedPage=0;
              //               // fcmToken="";
              //               // // showSuccessToast("User logout successfully", fToast);
              //               // final SharedPreferences pref = await prefs;
              //               // await pref.clear();
              //               // box.erase();
              //               // isPledgeView=true;
              //               // isPledgeView=isPledgeView;
              //               // Get.offAllNamed(Routes.signup);
              //               //
              //             },
              //             icon: SvgPicture.asset('assets/log-out.svg',height:12), // Provide the path to your logout icon
              //           ),
              //         ),
              //         Column(
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.only(top: 8,left: 5.0),
              //               child: SizedBox(
              //                 height:15,
              //                 child: Text(
              //                   "Account",
              //                   style: TextStyle(
              //                     fontSize: 11,
              //                     overflow: TextOverflow.ellipsis,
              //                     color: notifire?.getMainText,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              InkWell(
                onTap: ()async {
                  // String fcmToken = box.read('fcmToken')??"";
                  // var memberId = box.read('memberId');
                  // adminFlag=11;
                  // deleteUserFcm(fcmToken, memberId,fToast);
                  // navigatedPage=0;
                  // fcmToken="";
                  // showSuccessToast("User logout successfully", fToast);
                  final SharedPreferences pref = await prefs;
                  await pref.clear();
                  box.erase();
                  // isPledgeView=true;
                  // isPledgeView=isPledgeView;
                  Get.offAllNamed(Routes.signup);

                },
                child: SizedBox(height:30,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width:35,
                        child: IconButton(
                          onPressed: () async {
                            // String fcmToken = box.read('fcmToken')??"";
                            // var memberId = box.read('memberId');
                            // adminFlag=11;
                            // deleteUserFcm(fcmToken, memberId,fToast);
                            // navigatedPage=0;
                            // fcmToken="";
                            // // showSuccessToast("User logout successfully", fToast);
                            // final SharedPreferences pref = await prefs;
                            // await pref.clear();
                            // box.erase();
                            // isPledgeView=true;
                            // isPledgeView=isPledgeView;
                            // Get.offAllNamed(Routes.signup);
                            //
                          },
                          icon: SvgPicture.asset('assets/log-out.svg',height:12), // Provide the path to your logout icon
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8,left: 5.0),
                        child: SizedBox(
                          height:15,
                          child: Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 11,
                              overflow: TextOverflow.ellipsis,
                              color: notifire?.getMainText,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  bool light1 = true;

  TableRow row(
      {required String title, required String icon, required int index}) {
    return TableRow(children: [
      TableRowInkWell(
        onTap: () {
          controller.changePage(index);
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SvgPicture.asset(icon,
              width: 18, height: 18, color: notifire!.geticoncolor),
        ),
      ),
      TableRowInkWell(
        onTap: () {
          controller.changePage(index);
          Get.back();
        },
        child: Padding(
          padding:
          const EdgeInsets.only(bottom: 5, left: 20, top: 12, right: 20),
          child: Text(title,
              style:
              mediumBlackTextStyle.copyWith(color: notifire!.getMainText)),
        ),
      ),
    ]);
  }

  _getAlertFontSize(BuildContext context) {
    var currentLocale = Get.locale;
    if (currentLocale?.languageCode == 'ta') {
      // Font size for Tamil
      return 8.0;
    } else {
      // Font size for English
      return 12;
    }
  }
}

deleteUserFcm(String fcmToken, int id, FToast fToast) async {
  try {
    var body = jsonEncode({
      'fcmToken': fcmToken,
      'memberId': id,
    });
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString('fcm_token', fcmToken);
    // await SIgnUpService.deleteUserFcmToken(body, fToast);
  } catch (e) {

    throw Exception(e);
  }
}



Widget _buildcomuntile(
    {required String title,
      required String subtile,
      EdgeInsetsGeometry? padding,
      required Color color,
      required String backgroundImage,
      Color? backcolor,
      FontWeight? fontWeight,
      Color? colors,
      double? width,
      double? height,
      required Color colorsub}) {
  return Container(
    color: backcolor,
    child: Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(left: 15),
          //   child: Container(
          //     width: 7,
          //     height: 7,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(100), color: color),
          //   ),
          // ),
          Flexible(
            flex: 3,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              trailing: Text(
                "just now",
                style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 11,
                    overflow: TextOverflow.ellipsis),
              ),
              title: Text(
                title,
                style: TextStyle(
                    color: colors,
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis),
              ),
              subtitle: Text(subtile,
                  style: TextStyle(
                      color: colorsub,
                      fontWeight: fontWeight,
                      overflow: TextOverflow.ellipsis)),
              leading: Material(
                // elevation: 3,
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  padding: padding,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        backgroundImage,
                        width: width,
                        height: height,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
