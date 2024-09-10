// ignore_for_file: deprecated_member_use, unrelated_type_equality_checks

import 'dart:io';
import 'dart:math';



import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/svg.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tvk_maanadu/provider/provide_colors.dart';

import 'package:tvk_maanadu/staticdata.dart';
import 'appstaticdata/colorfile.dart';
import 'appstaticdata/routes.dart';
import 'appstaticdata/staticdata.dart';

import 'package:http/http.dart' as http;

import 'main.dart';


class DarwerSignInCode extends StatefulWidget {
  const DarwerSignInCode({super.key});

  @override
  State<DarwerSignInCode> createState() => _DarwerSignInCodeState();
}

class _DarwerSignInCodeState extends State<DarwerSignInCode> {
  AppConst obj = AppConst();
  final AppConst controller = Get.put(AppConst());

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

  bool isSwitched=Get.locale?.languageCode=='ta'?true:false;


  @override
  void initState() {
    super.initState();

    if(kIsWeb) {
      // controller.pageselecter.value = navigatedPage;
    }

    userId = box.read('memberId')??0;
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
            backgroundColor: notifire?.getprimerycolor,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: bordercolor)),
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
                      Get.offAllNamed(Routes.signup );
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
                 Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                      const SizedBox(width: 10,),
                    ],
                  ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left:15.0,right:15.0,bottom:15.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox(
                              height: ispresent ? 10 : 8,
                            ),

                              _buildSingletile(
                                  header: "Home".tr,
                                  iconpath: "assets/home.svg",
                                  index: 0,
                                  ontap: () {
                                    // Get.offAllNamed(Routes.newHome );
                                  }),

                              _buildexpansiontilt(
                                  index: 0,
                                  children: Row(
                                    children: [
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            height: ispresent ? 12 : 10,
                                          ),
                                          InkWell(
                                              onTap: () {
                                                // Get.offAllNamed(Routes.pledge);
                                              },
                                              child: Row(
                                                children: [
                                                  _buildcomunDesh(index:1),
                                                  _buildcomuntext(
                                                      title: "commonUserReference".tr,
                                                      index: 1)
                                                ],
                                              )),
                                          _buildsizeboxwithheight(),

                                          InkWell(
                                              onTap: () {
                                                // Get.offAllNamed(Routes.principle
                                                // );
                                              },
                                              child: Row(
                                                children: [
                                                  _buildcomunDesh(index: 2),
                                                  _buildcomuntext(
                                                      title:  "principle".tr,
                                                      index: 2),
                                                ],
                                              )),




                                          // if(adminFlag==0)
                                            _buildsizeboxwithheight(),
                                        ],
                                      ),
                                    ],
                                  ),
                                  header: 'Party'.tr,
                                  iconpath: 'assets/img/team.svg'),




                              _buildSingletile(
                                header:"member".tr,
                                iconpath: 'assets/img/team.svg',
                                index:1,
                                ontap: () async {
                                  Get.offAllNamed(Routes.signup);
                                },
                              ),
                            _buildSingletile(
                              header:"news".tr,
                              iconpath: 'assets/img/news.svg',
                              index:1,
                              ontap: () async {
                                // Get.offAllNamed(Routes.news );
                              },
                            ),

                              _buildSingletile(
                                header:"contact".tr,
                                iconpath: 'assets/img/news.svg',
                                index:1,
                                ontap: () async {
                                  // Get.offAllNamed(Routes.contact);
                                },
                              ),
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
                  : darkbordercolor)),
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
                  : darkbordercolor,
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
              fontSize: 14, color: darkbordercolor),
        ),
        leading: SvgPicture.asset(iconpath,
            height: 18, width: 18, color: darkbordercolor),
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
                  : darkbordercolor),
        ),
        leading: SvgPicture.asset(iconpath,
            height: 18,
            width: 18,
            color: controller.pageselecter.value == index
                ? appMainColor
                : darkbordercolor),
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
                child: Divider(color: darkbordercolor, height: 1))),
        SizedBox(
          height: ispresent ? 15 : 10,
        ),
        Text(
          title,
          style: mainTextStyle.copyWith(
              fontSize: 14, color: darkbordercolor),
        ),
        SizedBox(
          height: ispresent ? 10 : 8,
        ),
      ],
    );
  }

  // _downloadImage()  async {
  //   String url = await IdentityCardService.getIdentityCardForMember(
  //       fToast, userId,context); //userId
  //   if(kIsWeb){
  //     await WebImageDownloader.downloadImageFromWeb(
  //       url,
  //       name: url.split("/").last,
  //       imageType: ImageType.png,
  //     );
  //   }else{
  //     var random = Random();
  //     _saveImage(context,url,random);
  //   }
  //   setState(() {
  //
  //   });
  // }

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

  // Future<void> _saveImage(BuildContext context, String url, Random random) async {
  //   final scaffoldMessenger = ScaffoldMessenger.of(context);
  //   late String message;
  //   final splitted = url.split(
  //       "/");
  //   final splitted2 = splitted.last.split(
  //       ".");
  //   try {
  //     // Download image
  //     final http.Response response = await http.get(
  //         Uri.parse(url));
  //
  //     // Get temporary directory
  //     final dir = await getTemporaryDirectory();
  //
  //     // Create an image name
  //     var filename = '${dir.path}/${splitted2.first}${random.nextInt(100)}.png';
  //
  //     // Save to filesystem
  //     final file = File(filename);
  //     await file.writeAsBytes(response.bodyBytes);
  //
  //     // Ask the user to save it
  //     final params = SaveFileDialogParams(sourceFilePath: file.path);
  //     final finalPath = await FlutterFileDialog.saveFile(params: params);
  //
  //     if (finalPath != null) {
  //       message = 'Image saved to disk';
  //     }
  //   } catch (e) {
  //     message = e.toString();
  //     scaffoldMessenger.showSnackBar(SnackBar(
  //       content: Text(
  //         message,
  //         style:  const TextStyle(
  //           fontSize: 12,
  //           color: Colors.white,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       backgroundColor: const Color(0xFFe91e63),
  //     ));
  //   }
  //
  //   scaffoldMessenger.showSnackBar(SnackBar(
  //     content: Text(
  //       message,
  //       style:  const TextStyle(
  //         fontSize: 12,
  //         color: Colors.white,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //     backgroundColor: const Color(0xFFe91e63),
  //   ));
  //
  // }

}

//9c9caa
