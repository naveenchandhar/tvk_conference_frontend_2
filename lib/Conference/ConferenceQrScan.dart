import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:io' as io;
import 'package:intl/intl.dart';

import '../Toast_message//toast_message.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:simple_vcard_parser/simple_vcard_parser.dart';
import '/appstaticdata/staticdata.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../appstaticdata/colorfile.dart';
import '../main.dart';
import '../responsivePackage.dart';
import '../staticdata.dart';
import '../theme/color.dart';
import 'AdminCountModel.dart';
import 'AssemblyWiseCount.dart'as ASC;
import 'ConferenceFIrebaseModel.dart'as conFire;
import 'ConferenceService.dart';
import 'dart:math' as math;
import 'ConferenceModel.dart' as conDatum;
import 'package:flutter_platform_alert/flutter_platform_alert.dart';


class ConferenceQrScan extends StatefulWidget {
  const ConferenceQrScan({super.key});

  @override
  State<ConferenceQrScan> createState() => _ConferenceQrScanState();
}

class _ConferenceQrScanState extends State<ConferenceQrScan>
    with TickerProviderStateMixin {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  late TabController _tabController;
  bool isPaused = false;
  bool isFlashOn = false;
  // FToast fToast = FToast();
  late FToast fToast;
  bool showLoader = true;
  int conferenceId = 0;
  String conferenceName = '';
  conDatum.Data confData = new conDatum.Data();
  bool qrReviewed =false;
  bool firebaseWidgetLoad =false;
  int currentMember = 0;
  int totalMembers = 0;
  conFire.ConferenceFirebaseModel conferencescanData = new conFire.ConferenceFirebaseModel();
  List<ASC.Datum> assemblyWiseCount =[];
  bool showTick = false; // State variable to control the tick visibility

  @override
  void initState() {
    super.initState();
    fToast = FToast();

    if (!kIsWeb) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    conferenceId = box.read('conferenceId')??0;
    conferenceName = box.read('conferenceName') ?? '';
    _tabController = TabController(length: 3, vsync: this); // Use `this` as vsync
    getPageName();
    firebaseRefresh();
    getConferenceData(conferenceId);
    getAssemblyWise();
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        // When the second tab (Assembly) is selected
        if (_tabController.index == 1) {
          getAssemblyWise(); // Trigger the function
        }
      }
    });
    showLoader = false;


  }

  void getConferenceData(int conferenceId) async {
    conferencescanData = await ConferenceService.getCardConferenceData(conferenceId);
    setState(() { });
    // box.write("policeCount", conferencescanData.policeCount!);
    // box.write("publicCount", conferencescanData.publicCount!);
    // box.write("pressCount", conferencescanData.pressCount!);
  }
  void getAssemblyWise() async {
    // assemblyWiseCount = await ConferenceService().assemblyWiseCount();
    Map<String, dynamic> jsonData = {
      "conference_id": conferenceId,
    };
    await ConferenceService().assemblyWiseCountCardScan(jsonData).then((result) {
      assemblyWiseCount = result;
    });
    setState(() { });
    // box.write("policeCount", conferencescanData.policeCount!);
    // box.write("publicCount", conferencescanData.publicCount!);
    // box.write("pressCount", conferencescanData.pressCount!);
  }



  void firebaseRefresh() async {
    Map<String, dynamic> jsonData = {
      "conference_id":conferenceId,
      "conference_name":conferenceName,
    };
    // var firebaseRefresh = await ConferenceService().refreshConference(jsonData, fToast);
    // firebaseWidgetLoad = firebaseRefresh;
    setState(() { });
  }

  getPageName() async {
    final SharedPreferences pref = await prefs;
    pref.setInt('navigatedPage', 32);
  }

  @override
  void dispose() {
    _tabController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
  void togglePauseResume() async {
    if (isPaused) {
      await controller?.resumeCamera();
    } else {
      await controller?.pauseCamera();
    }
    setState(() {
      isPaused = !isPaused;
    });
  }

  void toggleFlash() async {
    await controller?.toggleFlash();
    bool flashStatus = await controller?.getFlashStatus() ?? false;
    setState(() {
      isFlashOn = flashStatus;
    });
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    fToast.init(context); // Initialize FToast with the correct context
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              height: MediaQuery.of(context).size.height * 0.27,
              child: _buildQrView(context),
            ),
            SizedBox(height: 5),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Scan a code',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 5),
            Expanded(child: buildTabExpanded()),
            Container(
              child: ElevatedButton(
                  onPressed: () {
                    Get.find<AppConst>().changePage(2);
                  },
                  child: Text(
                    "back".tr,
                    style: TextStyle(fontSize: 16),
                  )),
            ),
          ],
        ),
      ),
    );
  }
  Expanded buildTabExpanded() {
    return Expanded(
      child: Container(
          decoration: BoxDecoration(
            color: Color(0xffDFF1FF),
            borderRadius: BorderRadius.circular(25),
          ),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('conference_card_scan').doc(conferenceName).snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              // Check if data is empty
              if (snapshot.data!.data() == null || (snapshot.data!.data() as Map<String, dynamic>).isEmpty) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: Text('No data available')),
                );
              }

              final data = snapshot.data!.data() as Map<String, dynamic> ?? {};
              conFire.ConferenceFirebaseModel conferenceMember =
              conFire.ConferenceFirebaseModel.fromJson(data);
              box.write("policeCount", conferenceMember.policeCount!);
              box.write("publicCount", conferenceMember.publicCount!);
              box.write("pressCount", conferenceMember.pressCount!);

              box.write("memberLimit", conferenceMember.totalCount!);
              return Column(
                children: <Widget>[
                  TabBar(
                    controller: _tabController,
                    tabs: [
                      buildTab("Allowed".tr,"members_count".tr),
                      buildTab("Assembly".tr,"count".tr),
                      buildTab("Admin".tr,"count".tr),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        SingleChildScrollView(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if(confData.noPeopleAllowed !=0)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if (confData.noPeopleAllowed != null && confData.noPeopleAllowed != 0)
                                          Padding(
                                            padding: const EdgeInsets.only(right: 8.0),
                                            child: Text(
                                              'Count: ${conferenceMember.totalCount!} / ${confData.noPeopleAllowed != null? confData.noPeopleAllowed:0}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  buildRowMember(
                                      "Male count".tr, conferenceMember.maleCount),
                                  buildRowMember(
                                      "Female count".tr, conferenceMember.femaleCount),
                                  buildRowMember(
                                      "Total".tr, conferenceMember.totalCount),
                                  buildRow(
                                      "Public".tr,conferenceMember.publicCount!),
                                  buildRow(
                                      "Police".tr,conferenceMember.policeCount!),
                                  buildRow(
                                      "Press".tr,conferenceMember.pressCount!),
                                ],
                              ),
                            ),
                          ),
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    // color: Colors.green,
                                      width: constraints.maxWidth,
                                      height: constraints.maxHeight,
                                  child: _buildTable(
                                    width: constraints.maxWidth,
                                    // totalData: conferenceMember,
                                    context: context, conferenceName: conferenceName,
                                  )),
                                ],
                              ),
                            );
                          },
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    // color: Colors.green,
                                      width: constraints.maxWidth,
                                      height: constraints.maxHeight,
                                      child: Expanded(
                                        // child: _buildTableAssembly(
                                        //   width: constraints.maxWidth,
                                        //   totalData: conferenceMember,
                                        //   context: context,
                                        // ),
                                          child: _buildTableadminCount(
                                            width: constraints.maxWidth,
                                            // totalData: conferenceMember,
                                            context: context, conferenceName: conferenceName,
                                          ),
                                      )),
                                ],
                              ),
                            );
                          },
                        ),
                        // Icon(Icons.directions_transit),
                      ],
                    ),
                  ),
                ],
              );
            },
          )
        //       :Container(
        //   width: MediaQuery.of(context).size.width,
        //   child: Center(child: Text("No data please scan")),
        // ),
      ),
    );
  }

  Tab buildTab(String text1,String text2) {
    return Tab(
      icon: Icon(Icons.supervisor_account_rounded, color: Colors.black54),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text1,
              style: TextStyle(color: Colors.black87,fontSize:_getTabFontSize(context)),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text2,
              style: TextStyle(color: Colors.black87,fontSize:_getTabFontSize(context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable({
    required double width,
    required String conferenceName,
    required BuildContext context,
  }) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('card_scan_assemblywise_count')
          .doc(conferenceName)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        // Check if data is empty
        if (snapshot.data!.data() == null ||
            (snapshot.data!.data() as Map<String, dynamic>).isEmpty) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Center(child: Text('No data available')),
          );
        }

        final data = snapshot.data!.data() as Map<String, dynamic>? ?? {};
        final listData = data['assemblyList'] as List<dynamic>? ?? [];
        List<ASC.Datum> assemblycount = listData.map((item) {
          if (item is Map<String, dynamic>) {
            return ASC.Datum.fromJson(item);
          } else {
            throw Exception('Unexpected item type in assemblyList');
          }
        }).toList();

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.only(top: 0, left: 5, right: 5, bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.lightGreen,
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0.0, top: 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: light,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: signUpTopFontcolor.withOpacity(0.8),
                                  border: Border(right: BorderSide.none),
                                ),
                                width: width,
                                child: Table(
                                  border: TableBorder.symmetric(
                                    inside: BorderSide.none,
                                  ),
                                  defaultColumnWidth: IntrinsicColumnWidth(),
                                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                  children: [
                                    TableRow(
                                      decoration: BoxDecoration(
                                        color: signUpTopFontcolor.withOpacity(0.8),
                                        border: Border(right: BorderSide.none),
                                      ),
                                      children: [
                                        TableCell(
                                          child: Container(
                                            height: 45,
                                            padding: Responsive.isMobile(context)
                                                ? EdgeInsets.only(left: 10)
                                                : EdgeInsets.only(left: 50),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "assembly".tr,
                                              style: mediumBlackTextStyle.copyWith(
                                                fontSize: _getTermsFontSize(context),
                                                fontWeight: FontWeight.w700,
                                                color: signUpTopBarcolor,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            height: 45,
                                            padding: Responsive.isMobile(context)
                                                ? EdgeInsets.only(left: 10)
                                                : EdgeInsets.only(left: 50),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "male".tr,
                                              style: mediumBlackTextStyle.copyWith(
                                                fontSize: _getTermsFontSize(context),
                                                fontWeight: FontWeight.w700,
                                                color: signUpTopBarcolor,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: SizedBox(
                                            height: 45,
                                            child: Center(
                                              child: Text(
                                                "female".tr,
                                                style: mediumBlackTextStyle.copyWith(
                                                  fontSize: _getTermsFontSize(context),
                                                  fontWeight: FontWeight.w700,
                                                  color: signUpTopBarcolor,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ...assemblycount.asMap().entries.map(
                                          (entry) => TableRow(
                                        decoration: BoxDecoration(
                                          color: entry.key.isOdd
                                              ? const Color.fromRGBO(255, 255, 255, 1)
                                              : const Color.fromRGBO(235, 239, 245, 1),
                                          border: Border(
                                            top: BorderSide(
                                              color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        children: [
                                          TableCell(
                                            child: SizedBox(
                                              height: 45,
                                              child: Padding(
                                                padding: Responsive.isMobile(context)
                                                    ? EdgeInsets.only(left: 10, top: 15)
                                                    : EdgeInsets.only(left: 50, top: 15),
                                                child: Text(entry.value.name.toString(),),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 45,
                                              child: Padding(
                                                padding: Responsive.isMobile(context)
                                                    ? EdgeInsets.only(left: 10, top: 15)
                                                    : EdgeInsets.only(left: 50, top: 15),
                                                child: Text(entry.value.maleCount!.toString(),),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Padding(
                                              padding: EdgeInsets.zero,
                                              child: Center(
                                                child: Text(entry.value.femaleCount.toString()),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ).toList(),
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
              ],
            ),
          ),
        );
      },
    );
  }


  Widget _buildTableadminCount({
    required double width,
    required String conferenceName,
    required BuildContext context,
  }) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('con_adminwise_scan')
          .doc(conferenceName)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        // Check if data is empty
        if (snapshot.data!.data() == null ||
            (snapshot.data!.data() as Map<String, dynamic>).isEmpty) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Center(child: Text('No data available')),
          );
        }

        final data = snapshot.data!.data() as Map<String, dynamic>? ?? {};
        final listData = data['adminWiseList'] as List<dynamic>? ?? [];
        List<AdminCount> assemblycount = listData.map((item) {
          if (item is Map<String, dynamic>) {
            return AdminCount.fromJson(item);
          } else {
            throw Exception('Unexpected item type in assemblyList');
          }
        }).toList();

        // final data = snapshot.data!.data() as Map<String, dynamic>? ?? {};
        // final listData = data as List<dynamic>? ?? [];
        // List<AdminCount> assemblycount = listData.map((item) {
        //   if (item is Map<String, dynamic>) {
        //     return AdminCount.fromJson(item);
        //   } else {
        //     throw Exception('Unexpected item type in admin data');
        //   }
        // }).toList();
        // List<AdminCount> assemblycount = AdminCount.fromJson(item);
        // List<AdminCount> assemblycount = data.entries.map((entry) {
        //   // Convert the map entry to AdminCount
        //   final item = data;
        //   if (item is Map<String, dynamic>) {
        //     return AdminCount.fromJson(item);
        //   } else {
        //     throw Exception('Unexpected item type in admin data');
        //   }
        // }).toList();
        //
        // ConferenceFirebaseModel.fromJson(jsonDecode(response.body));
        // final listData = data as List<dynamic>? ?? [];
        // List<AdminCount> assemblycount = listData.map((item) {
        //   if (item is Map<String, dynamic>) {
        //     return AdminCount.fromJson(item);
        //   } else {
        //     throw Exception('Unexpected item type in assemblyList');
        //   }
        // }).toList();

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.only(top: 0, left: 5, right: 5, bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.lightGreen,
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0.0, top: 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: light,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: signUpTopFontcolor.withOpacity(0.8),
                                  border: Border(right: BorderSide.none),
                                ),
                                width: width,
                                child: Table(
                                  border: TableBorder.symmetric(
                                    inside: BorderSide.none,
                                  ),
                                  // defaultColumnWidth: FlexColumnWidth(),
                                  columnWidths: {
                                    0: FlexColumnWidth(2),  // District column
                                    1: FlexColumnWidth(2),  // Assembly column
                                    2: FlexColumnWidth(2),  // Name column
                                    3: FlexColumnWidth(1),  // Count column (smaller width)
                                  },
                                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                  children: [
                                    TableRow(
                                      decoration: BoxDecoration(
                                        color: signUpTopFontcolor.withOpacity(0.8),
                                        border: Border(right: BorderSide.none),
                                      ),
                                      children: [
                                        TableCell(
                                          child: Container(
                                            height: 45,
                                            padding: Responsive.isMobile(context)
                                                ? EdgeInsets.only(left: 10)
                                                : EdgeInsets.only(left: 50),
                                            alignment: Alignment.centerLeft,
                                            child: Center(
                                              child: Text(
                                                "District".tr,
                                                style: mediumBlackTextStyle.copyWith(
                                                  fontSize: _getTermsFontSize(context),
                                                  fontWeight: FontWeight.w700,
                                                  color: signUpTopBarcolor,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            height: 45,
                                            padding: Responsive.isMobile(context)
                                                ? EdgeInsets.only(left: 10)
                                                : EdgeInsets.only(left: 50),
                                            alignment: Alignment.centerLeft,
                                            child: Center(
                                              child: Text(
                                                "Assembly_Cons".tr,
                                                style: mediumBlackTextStyle.copyWith(
                                                  fontSize: _getTermsFontSize(context),
                                                  fontWeight: FontWeight.w700,
                                                  color: signUpTopBarcolor,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            height: 45,
                                            padding: Responsive.isMobile(context)
                                                ? EdgeInsets.only(left: 10)
                                                : EdgeInsets.only(left: 50),
                                            alignment: Alignment.centerLeft,
                                            child: Center(
                                              child: Text(
                                                "Name".tr,
                                                style: mediumBlackTextStyle.copyWith(
                                                  fontSize: _getTermsFontSize(context),
                                                  fontWeight: FontWeight.w700,
                                                  color: signUpTopBarcolor,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: SizedBox(
                                            height: 45,
                                            child: Center(
                                              child: Text(
                                                "count".tr,
                                                style: mediumBlackTextStyle.copyWith(
                                                  fontSize: _getTermsFontSize(context),
                                                  fontWeight: FontWeight.w700,
                                                  color: signUpTopBarcolor,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ...assemblycount.asMap().entries.map(
                                          (entry) => TableRow(
                                        decoration: BoxDecoration(
                                          color: entry.key.isOdd
                                              ? const Color.fromRGBO(255, 255, 255, 1)
                                              : const Color.fromRGBO(235, 239, 245, 1),
                                          border: Border(
                                            top: BorderSide(
                                              color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        children: [
                                          TableCell(
                                            child: SizedBox(
                                              height: 45,
                                              child: Padding(
                                                padding: Responsive.isMobile(context)
                                                    ? EdgeInsets.only(left: 10, top: 15)
                                                    : EdgeInsets.only(left: 50, top: 15),
                                                child: Center(child: Text(entry.value.district.toString(),style: TextStyle(
                                                    fontSize: 13),),),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 45,
                                              child: Padding(
                                                padding: Responsive.isMobile(context)
                                                    ? EdgeInsets.only(left: 10, top: 15)
                                                    : EdgeInsets.only(left: 50, top: 15),
                                                child: Center(child: Text(entry.value.assembly.toString(),style: TextStyle(
                                                    fontSize: 13),),),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 45,
                                              child: Padding(
                                                padding: Responsive.isMobile(context)
                                                    ? EdgeInsets.only(left: 10, top: 15)
                                                    : EdgeInsets.only(left: 50, top: 15),
                                                child: Center(child: Text(entry.value.adminName.toString(),style: TextStyle(
                                                    fontSize: 13),),),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: SizedBox(
                                              height: 45,
                                              child: Padding(
                                                padding: Responsive.isMobile(context)
                                                    ? EdgeInsets.only(left: 10, top: 15)
                                                    : EdgeInsets.only(left: 50, top: 15),
                                                child: Center(
                                                  child: Text(entry
                                                      .value.count
                                                      .toString(),style: TextStyle(
                                                      fontSize: 13),),
                                                ),
                                                  ),
                                            ),
                                          ),
                                          // TableCell(
                                          //   child: Padding(
                                          //     padding: EdgeInsets.zero,
                                          //     child: Center(
                                          //       child: Text(entry.value.femaleCount.toString()),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ).toList(),
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
              ],
            ),
          ),
        );
      },
    );
  }


  // Widget _buildTableAssembly({
  //   required double width,
  //   required conFire.ConferenceFirebaseModel totalData,
  //   required BuildContext context,
  // }) {
  //   return Padding(
  //     padding: EdgeInsets.only(top: 0, left: 5, right: 5, bottom: 0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Container(
  //           color:Colors.lightGreen,
  //           width: width,
  //           child: Padding(
  //             padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0.0, top: 0.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Container(
  //                   color: light,
  //                   child: SingleChildScrollView(
  //                     scrollDirection: Axis.horizontal,
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Container(
  //                         decoration: BoxDecoration(
  //                           color: signUpTopFontcolor.withOpacity(0.8),
  //                           border: Border(right: BorderSide.none),
  //                         ),
  //                         width: width,
  //                         child: Table(
  //                           border: TableBorder.symmetric(
  //                             inside: BorderSide.none,
  //                           ),
  //                           defaultColumnWidth: IntrinsicColumnWidth(),
  //                           defaultVerticalAlignment: TableCellVerticalAlignment.middle,
  //                           children: [
  //                             TableRow(
  //                               decoration: BoxDecoration(
  //                                 color: signUpTopFontcolor.withOpacity(0.8),
  //                                 border: Border(right: BorderSide.none),
  //                               ),
  //                               children: [
  //                                 TableCell(
  //                                   child: Container(
  //                                     height: 45,
  //                                     padding: Responsive.isMobile(context)
  //                                         ? EdgeInsets.only(left: 10)
  //                                         : EdgeInsets.only(left: 50),
  //                                     alignment: Alignment.centerLeft,
  //                                     child: Text(
  //                                       "assembly".tr,
  //                                       style: mediumBlackTextStyle.copyWith(
  //                                         fontSize: _getTermsFontSize(context),
  //                                         fontWeight: FontWeight.w700,
  //                                         color: signUpTopBarcolor,
  //                                       ),
  //                                       textAlign: TextAlign.center,
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 TableCell(
  //                                   child: SizedBox(
  //                                     height: 45,
  //                                     child: Center(
  //                                       child: Text(
  //                                         "count".tr,
  //                                         style: mediumBlackTextStyle.copyWith(
  //                                           fontSize: _getTermsFontSize(context),
  //                                           fontWeight: FontWeight.w700,
  //                                           color: signUpTopBarcolor,
  //                                         ),
  //                                         textAlign: TextAlign.center,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                             // Map totalListPerDistrict to TableRow widgets
  //                             // ...assemblyWiseCount.totalListPerAssembly!.asMap().entries.map(
  //                             //       (entry) => TableRow(
  //                             //     decoration: BoxDecoration(
  //                             //       color: entry.key.isOdd
  //                             //           ? const Color.fromRGBO(255, 255, 255, 1)
  //                             //           : const Color.fromRGBO(235, 239, 245, 1),
  //                             //       border: Border(
  //                             //         top: BorderSide(
  //                             //           color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
  //                             //           width: 1.0,
  //                             //         ),
  //                             //       ),
  //                             //     ),
  //                             //     children: [
  //                             //       TableCell(
  //                             //         child: SizedBox(
  //                             //           height: 45,
  //                             //           child: Padding(
  //                             //             padding: Responsive.isMobile(context)
  //                             //                 ? EdgeInsets.only(left: 10, top: 15)
  //                             //                 : EdgeInsets.only(left: 50, top: 15),
  //                             //             child: Text(entry.value.assembly!.toString()),
  //                             //           ),
  //                             //         ),
  //                             //       ),
  //                             //       TableCell(
  //                             //         child: Padding(
  //                             //           padding: EdgeInsets.zero,
  //                             //           child: Center(
  //                             //             child: Text(entry.value.count!.toString()),
  //                             //           ),
  //                             //         ),
  //                             //       ),
  //                             //     ],
  //                             //   ),
  //                             // ).toList(),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }



  Widget intrinsWidth() {
    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Divider(
              thickness: 0.8,
              color: Colors.grey,
              // endIndent: 0,
              // startIndent: 0,
            ),
          ),
          Flexible(
            child: Text(
              "",
              style: const TextStyle(
                fontSize: 45,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRowMember(String label, int? count) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 8.0),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: _getTabRowWidthSize(context),
                child: Text(
                  label,
                  style: TextStyle(fontSize: _getTabRowFontSize(context), fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          // Column(
          //   children: [
          //     Container(
          //       width: MediaQuery
          //           .of(context)
          //           .size
          //           .width * 0.2,
          //       child: Align(
          //         alignment: Alignment.centerLeft,
          //         child: FittedBox(
          //           fit: BoxFit.scaleDown,
          //           child: Text(
          //             label,
          //             textAlign: TextAlign.left,
          //             style: TextStyle(
          //                 color: Colors.black87,
          //                 fontSize: 16),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: MediaQuery.of(context).size.width*0.5, // Adjust width as needed
                  height: 45, // Adjust width as needed
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black54, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      count != null ? count.toString() : 'N/A',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text('          '),
            ],
          )
        ],
      ),
    );
  }

  Widget buildRow(String label, int count) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 8.0),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: _getTabRowWidthSize(context),
                child: Text(
                  label,
                  style: TextStyle(fontSize: _getTabRowFontSize(context), fontWeight: FontWeight.bold),
                ),
                // child: Align(
                //   alignment: Alignment.centerLeft,
                //   child: FittedBox(
                //     fit: BoxFit.scaleDown,
                //     child: Text(
                //       label,
                //       textAlign: TextAlign.left,
                //       style: TextStyle(
                //           color: Colors.black87,
                //           fontSize: 16),
                //     ),
                //   ),
                // ),
              ),
            ],
          ),

          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: MediaQuery.of(context).size.width*0.5,
                  height: 45, // Adjust width as needed
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black54, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      count != null ? count.toString() : 'N/A',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  int policeCount = box.read("policeCount") ?? 0;
                  int publicCount = box.read("publicCount") ?? 0;
                  int pressCount = box.read("pressCount") ?? 0;
                  if (label == "Public") {
                    Map<String, dynamic> jsonData = {
                      "public_count": publicCount + 1,
                    };
                    await ConferenceService().updateScanCardMember(jsonData,fToast,conferenceId);
                    getConferenceData(conferenceId);

                    setState(() {
                      showTick = true;
                    });
                    await FlutterPlatformAlert.playAlertSound();
                    Future.delayed(Duration(seconds: 0), () {
                      setState(() {
                        showTick = false;
                      });
                      qrReviewed = false;
                    });
                  } else if (label == "Police") {
                    Map<String, dynamic> jsonData = {
                      "police_count":policeCount+1,
                    };
                    await ConferenceService().updateScanCardMember(jsonData,fToast,conferenceId);
                    getConferenceData(conferenceId);

                    setState(() {
                      showTick = true;
                    });
                    await FlutterPlatformAlert.playAlertSound();
                    Future.delayed(Duration(seconds: 0), () {
                      setState(() {
                        showTick = false;
                      });
                      qrReviewed = false;
                    });
                  } else if (label == "Press") {
                    Map<String, dynamic> jsonData = {
                      "press_count":pressCount+1,
                    };
                    await ConferenceService().updateScanCardMember(jsonData,fToast,conferenceId);
                    getConferenceData(conferenceId);

                    setState(() {
                      showTick = true;
                    });
                    await FlutterPlatformAlert.playAlertSound();
                    Future.delayed(Duration(seconds: 0), () {
                      setState(() {
                        showTick = false;
                      });
                      qrReviewed = false;
                    });
                  }
                  setState(() {

                  });
                },
                child: Text('Add',style:TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAvatar(int number) {
    return CircleAvatar(
      backgroundColor: Colors.blue,
      child: Text(
        number.toString(),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderColor: Colors.red,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: scanArea,
          ),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        ),
        if (showTick)
          Center(
            child: Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
          ),
        Positioned(
          right: 16.0,
          top: MediaQuery.of(context).size.height *
              0.04, // Adjust the top position as needed
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black26, width: 2),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.lightBlue.shade300,
                  child: IconButton(
                    icon: Icon(Icons.flash_on,
                        color: isFlashOn ? Colors.yellow : Colors.white),
                    onPressed: toggleFlash,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black26, width: 2),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.lightBlue.shade300,
                  child: IconButton(
                    icon: Icon(Icons.cameraswitch, color: Colors.white),
                    onPressed: () async {
                      await controller?.flipCamera();
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black26, width: 2),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.lightBlue.shade300,
                  child: IconButton(
                    icon: Icon(isPaused ? Icons.play_arrow : Icons.pause,
                        color: Colors.white),
                    onPressed: togglePauseResume,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      try {
        // memberLimit
        // var memberLimit =box.read("memberLimit");
        // if(memberLimit == confData.noPeopleAllowed){
        //   showSuccessToast("Maximum limit exceeded", fToast);
        //   return;
        // }
        if (qrReviewed == false) {
          final decodedData = scanData.code;
          // VCard vc = VCard(decodedData!);
          var vc =  decodedData!.split('-');
          String? assemblyNo;
          String? gender;
          if (vc != null && vc.isNotEmpty) {
            qrReviewed =true;
            assemblyNo = vc[1];
            gender = vc[2];
            Map<String, dynamic> jsonData = {
              "scan_card_id":vc[5],
              "gender": vc[4] == "1" ? "Male" : "Female",
              "mst_conference_card_id":vc[3],
              "conference_id":conferenceId
            };
            await ConferenceService().saveScanCardMember(jsonData, fToast).then((eventMember) async{
              if(eventMember == "Member Already existed"){
                showSuccessToast(eventMember, fToast);
                qrReviewed = false;
                setState(() {

                });
              } else{
                getAssemblyWise();
                showSuccessToast(eventMember, fToast);
                setState(() {
                  showTick = true;
                });
                await FlutterPlatformAlert.playAlertSound();
                Future.delayed(Duration(seconds: 0), () {
                  qrReviewed = false;
                  setState(() {
                    showTick = false;
                  });
                });
              }

            }).catchError((error) {
              print(error);
              qrReviewed =false;
            });
            setState(() {

            });
          }
        }
      } catch (e) {
        print(e);
        qrReviewed =false;
        setState(() {

        });
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  double _getTabRowWidthSize(BuildContext context) {
    var currentLocale = Get.locale;
    if (currentLocale?.languageCode == 'ta') {
      // Font size for Tamil
      return MediaQuery.of(context).size.width * 0.22;
    } else {
      // Font size for English
      return MediaQuery.of(context).size.width * 0.2;
    }
  }

  double _getTabRowFontSize(BuildContext context) {
    var currentLocale = Get.locale;
    if (currentLocale?.languageCode == 'ta') {
      // Font size for Tamil
      return 10.0;
    } else {
      // Font size for English
      return 16.0;
    }
  }

  double _getTabFontSize(BuildContext context) {
    var currentLocale = Get.locale;
    if (currentLocale?.languageCode == 'ta') {
      // Font size for Tamil
      return 10.0;
    } else {
      // Font size for English
      return 12.0;
    }
  }


  double _getTermsFontSize(BuildContext context) {
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
