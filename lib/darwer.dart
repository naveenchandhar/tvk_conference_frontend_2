// ignore_for_file: deprecated_member_use, unrelated_type_equality_checks

import 'dart:io';
import 'dart:math';


// import 'package:TamilgaVetriKalagam/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tvk_maanadu/provider/provide_colors.dart';
import 'package:tvk_maanadu/staticdata.dart';
// import 'package:TamilgaVetriKalagam/provider/proviercolors.dart';
// import 'package:TamilgaVetriKalagam/staticdata.dart';
import 'appstaticdata/staticdata.dart';
import 'download_Id/identity_card_model.dart' as icm;
// import 'download_Id/identity_card_service.dart';
import 'package:http/http.dart' as http;

import 'main.dart';


class DarwerCode extends StatefulWidget {
  const DarwerCode({super.key});

  @override
  State<DarwerCode> createState() => _DarwerCodeState();
}

class _DarwerCodeState extends State<DarwerCode> {
  AppConst obj = AppConst();
  final AppConst controller = Get.put(AppConst());
  icm.Data IdentityModelData = icm.Data(fileName: '', imgUrl: '', phoneNumber: '');
  final screenwidth = Get.width;
  bool ispresent = false;
  FToast fToast = FToast();
  static const breakpoint = 600.0;
  int userId = 0;

  String completePath = "";
  String directoryPath = "";
// int adminFlag=0;
// int userRole=0;
  late AppConst appConst;
  bool isSwitched = false;


  @override
  void initState() {
    super.initState();

    if(kIsWeb) {
      // controller.pageselecter.value = navigatedPage;
    }

    userId = box.read('memberId')??0;
    isSwitched = currentLanguage;
    // setState(() {
    //
    // });
    // adminFlag = box.read('adminFlag')??3;
    // userRole = box.read('userRole')??3;


  }

  @override
  Widget build(BuildContext context) {
    if (screenwidth >= breakpoint) {
      setState(() {
        ispresent = true;
      });
    }

    return GetBuilder<AppConst>(builder: (controller) {

      return SafeArea(
        child: Consumer<ColorNotifire>(
          builder: (context, value, child) => Drawer(
            backgroundColor: notifire!.getprimerycolor,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: notifire!.getbordercolor)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      // left: ispresent ? 30 : 15,
                      // top: ispresent ? 24 : 20,
                      bottom: ispresent ? 10 : 12),
                  child: InkWell(
                    onTap: () {
                      if(adminFlag==0) {
                        controller.changePage(0);
                        Get.back();
                      }else
                        {
                          controller.changePage(11);
                          Get.back();
                        }
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Image.asset(
                          "assets/img/Tvk_party_name_only.png",
                          fit: BoxFit.fill,
                          height: 55.0,
                          width: 260.0,

                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox(
                              height: ispresent ? 10 : 8,
                            ),
                            // if(adminFlag==0||adminFlag==1||adminFlag==2)
                            // _buildSingletile(
                            //     header: "dashboard".tr,
                            //     iconpath: "assets/home.svg",
                            //     index: 0,
                            //     ontap: () {
                            //       controller.changePage(0);
                            //       Get.back();
                            //     }),
                            // _buildSingletile(
                            //     header: "Tweedle".tr,
                            //     iconpath: 'assets/img/press-release.svg',
                            //     index:11,
                            //     ontap: () {
                            //       controller.changePage(11);
                            //       Get.back();
                            //     }),
                            // _buildSingletile(
                            //     header:"download_ID_Card".tr,
                            //     iconpath: 'assets/img/id-card.svg',
                            //     index:20,
                            //     ontap: () async {
                            //       controller.changePage(20);
                            //       Get.back();
                            //    // await   _downloadImage();
                            //     },
                            //
                            // ),
                            //
                            // _buildSingletile(
                            //   header:"Volunteer".tr,
                            //   iconpath: 'assets/img/volunteer.svg',
                            //   index:14,
                            //   ontap: () async {
                            //     controller.changePage(14);
                            //     Get.back();
                            //   },
                            // ),
                            // // if(adminFlag==0||adminFlag==1||adminFlag==2)
                            // // _buildSingletile(
                            // //   header:"survey".tr,
                            // //   iconpath: 'assets/img/survey-icon.svg',
                            // //   index:22,
                            // //   ontap: () async {
                            // //     controller.changePage(22);
                            // //     Get.back();
                            // //   },
                            // // ),
                            //
                            //
                            // _buildSingletile(
                            //     header: "Helpline".tr,
                            //     iconpath: 'assets/img/helpline.svg',
                            //     index:24,
                            //     ontap: () {
                            //       controller.changePage(24);
                            //       Get.back();
                            //     }),
                            // if(adminFlag==0||adminFlag==1||adminFlag==2)
                            // _buildexpansiontilt(
                            //     index: 0,
                            //     children: Row(
                            //       children: [
                            //         const SizedBox(
                            //           width: 12,
                            //         ),
                            //         Column(
                            //           crossAxisAlignment:
                            //           CrossAxisAlignment.start,
                            //           mainAxisAlignment:
                            //           MainAxisAlignment.spaceAround,
                            //           children: [
                            //             SizedBox(
                            //               height: ispresent ? 12 : 10,
                            //             ),
                            //             InkWell(
                            //                 onTap: () {
                            //
                            //                   controller.changePage(15);
                            //
                            //                   Get.back();
                            //                 },
                            //                 child: Row(
                            //                   children: [
                            //                     _buildcomunDesh(index: 15),
                            //                     _buildcomuntext(
                            //                         title: "create_member".tr,
                            //                         index: 15)
                            //                   ],
                            //                 )),
                            //             _buildsizeboxwithheight(),
                            //
                            //             InkWell(
                            //                 onTap: () {
                            //                   controller.changePage(25);
                            //                   Get.back();
                            //                 },
                            //                 child: Row(
                            //                   children: [
                            //                     _buildcomunDesh(index: 25),
                            //                     _buildcomuntext(
                            //                         title: 'user_create_memberlist'.tr,
                            //                         index: 25),
                            //                   ],
                            //                 )),
                            //
                            //
                            //
                            //
                            //             if(adminFlag==0)
                            //               _buildsizeboxwithheight(),
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //     header: 'Member_creation'.tr,
                            //     iconpath: 'assets/img/person-add.svg'),
                            //
                            // _buildexpansiontilt(
                            //     index: 0,
                            //     children: Row(
                            //       children: [
                            //         const SizedBox(
                            //           width: 12,
                            //         ),
                            //         Column(
                            //           crossAxisAlignment:
                            //           CrossAxisAlignment.start,
                            //           mainAxisAlignment:
                            //           MainAxisAlignment.spaceAround,
                            //           children: [
                            //             SizedBox(
                            //               height: ispresent ? 12 : 10,
                            //             ),
                            //             InkWell(
                            //                 onTap: () {
                            //
                            //                   controller.changePage(17);
                            //
                            //                   Get.back();
                            //                 },
                            //                 child: Row(
                            //                   children: [
                            //                     _buildcomunDesh(index: 17),
                            //                     _buildcomuntext(
                            //                         title: "create_family_member".tr,
                            //                         index: 17)
                            //                   ],
                            //                 )),
                            //             _buildsizeboxwithheight(),
                            //
                            //             InkWell(
                            //                 onTap: () {
                            //                   controller.changePage(16);
                            //                   Get.back();
                            //                 },
                            //                 child: Row(
                            //                   children: [
                            //                     _buildcomunDesh(index: 16),
                            //                     _buildcomuntext(
                            //                         title: "family_member_list".tr,
                            //                         index: 16),
                            //                   ],
                            //                 )),
                            //
                            //
                            //
                            //
                            //             if(adminFlag==0)
                            //               _buildsizeboxwithheight(),
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //     header: 'Joint_Family_Member'.tr,
                            //     iconpath: 'assets/img/member_group.svg'),

                            // if(adminFlag==0||adminFlag==1||adminFlag==2)
                            // _buildSingletile(
                            //     header: "create_survey".tr,
                            //     iconpath: 'assets/img/survey.svg',
                            //     index:21,
                            //     ontap: () {
                            //       controller.changePage(21);
                            //       Get.back();
                            //     }),
                            // if(adminFlag==0)
                            // _buildSingletile(
                            //   header:"create_events".tr,
                            //   iconpath: 'assets/img/Events.svg',
                            //   index:26,
                            //   ontap: () async {
                            //     controller.changePage(26);
                            //     Get.back();
                            //   },
                            // ),
                            //
                            // if(adminFlag==0)
                            // _buildSingletile(
                            //   header:"event_list".tr,
                            //   iconpath: 'assets/img/Events.svg',
                            //   index:28,
                            //   ontap: () async {
                            //     controller.changePage(28);
                            //     Get.back();
                            //   },
                            // ),
                            // if(adminFlag==0)
                            //   _buildSingletile(
                            //     header:"Conference".tr,
                            //     iconpath: 'assets/img/conference_img.png',
                            //     index:30,
                            //     ontap: () async {
                            //       controller.changePage(30);
                            //       Get.back();
                            //     },
                            //   ),
                            // if(adminFlag==0)
                            //   _buildSingletile(
                            //     header:"Conference_List".tr,
                            //     iconpath: 'assets/img/conference.svg',
                            //     index:32,
                            //     ontap: () async {
                            //       controller.changePage(32);
                            //       Get.back();
                            //     },
                            //   ),
                            // if(adminFlag==0)
                            //   _buildSingletile(
                            //     header:"create_news".tr,
                            //     iconpath: 'assets/img/news1.svg',
                            //     index:27,
                            //     ontap: () async {
                            //       controller.changePage(27);
                            //       Get.back();
                            //     },
                            //   ),
                            //
                            // if(adminFlag==0||adminFlag==1||adminFlag==2)
                            //   _buildDivider(title: 'report'.tr),
                            // if(adminFlag==0||adminFlag==1||adminFlag==2)
                            // _buildSingletile(
                            //   header:"Assembly_Wise_Report".tr,
                            //   iconpath: 'assets/img/constituency.svg',
                            //   index:18,
                            //   ontap: () async {
                            //     controller.changePage(18);
                            //     Get.back();
                            //   },
                            // ),
                            // if(adminFlag==0||adminFlag==1||adminFlag==2)
                            // _buildSingletile(
                            //   header:"Parliment_Wise_Report".tr,
                            //   iconpath: 'assets/img/parliament.svg',
                            //   index:19,
                            //   ontap: () async {
                            //     controller.changePage(19);
                            //     Get.back();
                            //   },
                            // ),
                            // if(adminFlag==0||adminFlag==1||adminFlag==2)
                            // _buildSingletile(
                            //   header:"member_list".tr,
                            //   iconpath: 'assets/img/sex-ratio.svg',
                            //   index:1,
                            //   ontap: () async {
                            //     controller.changePage(1);
                            //     Get.back();
                            //   },
                            // ),
                            // if(adminFlag==0)
                              _buildSingletile(
                                header:"Conference".tr,
                                iconpath: 'assets/img/conference_img.svg',
                                index:0,
                                ontap: () async {
                                  controller.changePage(0);
                                  Get.back();
                                },
                              ),
                            // if(adminFlag==0 ||adminFlag==1)
                            // _buildSingletile(
                            //   header:"Conference Scan".tr,
                            //   iconpath: 'assets/img/sex-ratio.svg',
                            //   index:1,
                            //   ontap: () async {
                            //     controller.changePage(1);
                            //     Get.back();
                            //   },
                            // ),

                            _buildSingletile(
                              header:"Conference List".tr,
                              iconpath: 'assets/img/sex-ratio.svg',
                              index:2,
                              ontap: () async {
                                controller.changePage(2);
                                Get.back();
                              },
                            ),
                            // if(adminFlag==0 ||adminFlag==1)

                            // if(adminFlag==0||adminFlag==1||adminFlag==2)
                            // _buildexpansiontilt(
                            //     index: 0,
                            //     children: Row(
                            //       children: [
                            //         const SizedBox(
                            //           width: 12,
                            //         ),
                            //         Column(
                            //           crossAxisAlignment:
                            //           CrossAxisAlignment.start,
                            //           mainAxisAlignment:
                            //           MainAxisAlignment.spaceAround,
                            //           children: [
                            //             SizedBox(
                            //               height: ispresent ? 12 : 10,
                            //             ),
                            //             InkWell(
                            //                 onTap: () {
                            //                   controller.changePage(1);
                            //                   Get.back();
                            //                 },
                            //                 child: Row(
                            //                   children: [
                            //                     _buildcomunDesh(index: 1),
                            //                     _buildcomuntext(
                            //                         title: "member_list".tr,
                            //                         index: 1),
                            //                   ],
                            //                 )),
                            //             _buildsizeboxwithheight(),
                            //
                            //             if(adminFlag==0)
                            //
                            //             InkWell(
                            //                 onTap: () {
                            //                   controller.changePage(2);
                            //                   Get.back();
                            //                 },
                            //                 child: Row(
                            //                   children: [
                            //                     _buildcomunDesh(index: 2),
                            //                     _buildcomuntext(
                            //                         title: "admin_List".tr,
                            //                         index: 2)
                            //                   ],
                            //                 )),
                            //             if(adminFlag==0)
                            //             _buildsizeboxwithheight(),
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //     header: 'admin_menu'.tr,
                            //     iconpath: 'assets/grid-circle.svg'),

                            // _buildexpansiontilt(
                            //     index: 0,
                            //     children: Row(
                            //       children: [
                            //         const SizedBox(
                            //           width: 12,
                            //         ),
                            //         Column(
                            //           crossAxisAlignment:
                            //           CrossAxisAlignment.start,
                            //           mainAxisAlignment:
                            //           MainAxisAlignment.spaceAround,
                            //           children: [
                            //             SizedBox(
                            //               height: ispresent ? 12 : 10,
                            //             ),
                            //             InkWell(
                            //                 onTap: () {
                            //                   appConst = Get.find<AppConst>();
                            //                   appConst.argumentForPage=0;
                            //                   controller.changePage(10);
                            //                   Get.back();
                            //                 },
                            //                 child: Row(
                            //                   children: [
                            //                     _buildcomunDesh(index: 10),
                            //                     _buildcomuntext(
                            //                         title: "create".tr,
                            //                         index: 10),
                            //                   ],
                            //                 )),
                            //
                            //             _buildsizeboxwithheight(),
                            //             InkWell(
                            //                 onTap: () {
                            //
                            //                   controller.changePage(12);
                            //                   Get.back();
                            //                 },
                            //                 child: Row(
                            //                   children: [
                            //                     _buildcomunDesh(index: 12),
                            //                     _buildcomuntext(
                            //                         title: "List".tr,
                            //                         index: 12),
                            //                   ],
                            //                 )),
                            //
                            //             _buildsizeboxwithheight(),
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //     header: 'local_Issue'.tr,
                            //     iconpath: 'assets/grid-circle.svg'),

                            // _buildDivider(title: 'communication'.tr),
                            // _buildexpansiontilt(
                            //     index: 1,
                            //     children: Row(
                            //       children: [
                            //         const SizedBox(
                            //           width: 12,
                            //         ),
                            //         Column(
                            //           crossAxisAlignment:
                            //           CrossAxisAlignment.start,
                            //           mainAxisAlignment:
                            //           MainAxisAlignment.spaceAround,
                            //           children: [
                            //             SizedBox(
                            //               height: ispresent ? 12 : 10,
                            //             ),
                            //
                            //             InkWell(
                            //                 onTap: () {
                            //                   controller.changePage(3);
                            //                   Get.back();
                            //                 },
                            //                 child: Row(
                            //                   children: [
                            //                     _buildcomunDesh(index: 3),
                            //                     _buildcomuntext(
                            //                         title: 'join_Call'.tr,
                            //                         index: 3),
                            //                   ],
                            //                 )),
                            //             _buildsizeboxwithheight(),
                            //             if(adminFlag==0||adminFlag==1)
                            //             InkWell(
                            //                 onTap: () {
                            //                   controller.changePage(4);
                            //                   Get.back();
                            //                 },
                            //                 child: Row(
                            //                   children: [
                            //                     _buildcomunDesh(index: 4),
                            //                     _buildcomuntext(
                            //                         title: 'create_Call'.tr,
                            //                         index: 4),
                            //                   ],
                            //                 )),
                            //             if(adminFlag==0||adminFlag==1)
                            //             _buildsizeboxwithheight(),
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //     header: 'group_Call'.tr,
                            //     iconpath: 'assets/octagon-check.svg'),
                            if(adminFlag==0)
                            _buildDivider(title: 'master_screen'.tr),
                            if(adminFlag==0)
                            _buildSingletile(
                                header: "state".tr,
                                iconpath: 'assets/img/state.svg',
                                index: 5,
                                ontap: () {
                                  controller.changePage(5);
                                  Get.back();
                                }),
                            if(adminFlag==0)
                            _buildSingletile(
                                header: "district".tr,
                                iconpath: 'assets/img/District.svg',
                                index: 6,
                                ontap: () {
                                  controller.changePage(6);
                                  Get.back();
                                }),
                            if(adminFlag==0)
                            _buildSingletile(
                                header: "region".tr,
                                iconpath: 'assets/img/region.svg',
                                index: 7,
                                ontap: () {
                                  controller.changePage(7);
                                  Get.back();
                                }),
                            if(adminFlag==0)
                            _buildSingletile(
                                header: "parlimentary_Constituency".tr,
                                iconpath: 'assets/img/parliament.svg',
                                index:8,
                                ontap: () {
                                  controller.changePage(8);
                                  Get.back();
                                }),
                            if(adminFlag==0)
                            _buildSingletile(
                                header: "assembly_Constituency".tr,
                                iconpath: 'assets/img/constituency.svg',
                                index:9,
                                ontap: () {
                                  controller.changePage(9);
                                  Get.back();
                                }),


                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildsizeboxwithheight() {
    return SizedBox(
      height: ispresent ? 25 : 20,
    );
  }

  Widget _buildcomuntext({required String title, required int index}) {
    return Obx(
          () => Text(title,
          style: mediumGreyTextStyle.copyWith(
              fontSize: _getTermsFontSize(context),
              color: controller.pageselecter.value == index
                  ? appMainColor
                  : notifire!.getMainText)),
    );
  }


  double _getTermsFontSize(BuildContext context) {
    var currentLocale = Get.locale;

    // Define font sizes for English and Tamil
    if (currentLocale?.languageCode == 'ta') {
      // Font size for Tamil
      return 10.0;
    } else {
      // Font size for English
      return 13.0;
    }
  }

  Widget _buildcomunDesh({required int index}) {
    return Obx(
          () => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("assets/minus.svg",
              color: controller.pageselecter.value == index
                  ? appMainColor
                  : notifire!.getMainText,
              width: 6),
          const SizedBox(
            width: 25,
          ),
        ],
      ),
    );
  }

  Widget _buildexpansiontilt(
      {required Widget children,
        required String header,
        required String iconpath,
        required int index}) {
    return ListTileTheme(
      horizontalTitleGap: 12.0,
      dense: true,
      child: ExpansionTile(
        title: Text(
          header,
          style: mediumBlackTextStyle.copyWith(
              fontSize: 14, color: notifire!.getMainText),
        ),
        leading: SvgPicture.asset(iconpath,
            height: 18, width: 18, color: notifire!.getMainText),
        tilePadding:
        EdgeInsets.symmetric(vertical: ispresent ? 5 : 2, horizontal: 8),
        iconColor: appMainColor,
        collapsedIconColor: Colors.grey,
        children: <Widget>[children],
      ),
    );
  }

  Widget _buildSingletile(
      {required String header,
        required String iconpath,
        required int index,
        required void Function() ontap}) {
    return Obx(() => ListTileTheme(
      horizontalTitleGap: 12.0,
      dense: true,
      child: ListTile(
        hoverColor: Colors.transparent,
        onTap: ontap,
        title: Text(
          header,
          style: mediumBlackTextStyle.copyWith(
              fontSize: 14,
              color: controller.pageselecter.value == index
                  ? appMainColor
                  : notifire!.getMainText),
        ),
        leading: SvgPicture.asset(iconpath,
            height: 18,
            width: 18,
            color: controller.pageselecter.value == index
                ? appMainColor
                : notifire!.getMainText),
        trailing: const SizedBox(),
        contentPadding: EdgeInsets.symmetric(
            vertical: ispresent ? 5 : 2, horizontal: 8),
      ),
    ));
  }

  Widget _buildDivider({required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            height: ispresent ? 15 : 10,
            width: ispresent ? 230 : 260,
            child: Center(
                child: Divider(color: notifire!.getbordercolor, height: 1))),
        SizedBox(
          height: ispresent ? 15 : 10,
        ),
        Text(
          title,
          style: mainTextStyle.copyWith(
              fontSize: 14, color: notifire!.getMainText),
        ),
        SizedBox(
          height: ispresent ? 10 : 8,
        ),
      ],
    );
  }

  _downloadImage()  async {
    // String url = await IdentityCardService.getIdentityCardForMember(
    //     fToast, userId,context); //userId
    String url = '';
if(kIsWeb){
  await WebImageDownloader.downloadImageFromWeb(
    url,
    name: url.split("/").last,
    imageType: ImageType.png,
  );
}else{
   var random = Random();
   _saveImage(context,url,random);
}
    setState(() {

    });
  }

  Future<String> _directoryPath() async {
    var directory = await getExternalStorageDirectory();
    var directoryPath = directory!.path;
    return "$directoryPath/records/";
  }

  Future<String> _completePath(String directory, String formattedDate) async {
    var fileName = _fileName(formattedDate);
    return "$directory$fileName";
  }
  String _fileName(String formattedDate) {
    return formattedDate;
  }

  void _createDirectory() async {
    bool isDirectoryCreated = await Directory(directoryPath).exists();
    if (!isDirectoryCreated) {
      Directory(directoryPath).create()
          .then((Directory directory) {
        if (kDebugMode) {
          print("DIRECTORY CREATED AT : ${directory.path}");
        }
      });
    }
  }

  Future _createFile() async {
    File(completePath)
        .create(recursive: true)
        .then((File file) async {
      //write to file
      Uint8List bytes = await file.readAsBytes();
      file.writeAsBytes(bytes);
      if (kDebugMode) {
        print("FILE CREATED AT : ${file.path}");
      }
    });
  }

  Future<void> _saveImage(BuildContext context, String url, Random random) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    late String message;
    final splitted = url.split(
        "/");
    final splitted2 = splitted.last.split(
        ".");
    try {
      // Download image
      final http.Response response = await http.get(
          Uri.parse(url));

      // Get temporary directory
      final dir = await getTemporaryDirectory();

      // Create an image name
      var filename = '${dir.path}/${splitted2.first}${random.nextInt(100)}.png';

      // Save to filesystem
      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);

      // Ask the user to save it
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);

      if (finalPath != null) {
        message = 'Image saved to disk';
      }
    } catch (e) {
      message = e.toString();
      scaffoldMessenger.showSnackBar(SnackBar(
        content: Text(
          message,
          style:  const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFe91e63),
      ));
    }

    scaffoldMessenger.showSnackBar(SnackBar(
      content: Text(
        message,
        style:  const TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xFFe91e63),
    ));

    }

}

//9c9caa
