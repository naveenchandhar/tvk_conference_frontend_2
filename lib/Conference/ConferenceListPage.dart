
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;

// import '../Widgets/sizebox.dart';
import '../appstaticdata/colorfile.dart';
import '../appstaticdata/staticdata.dart';
import '../common/commonWidget/common_widgets.dart';
import '../conferenceQr_generator/ConferenceQrgenator.dart';
import '../main.dart';
import '../provider/provide_colors.dart';
// import 'provider/proviercolors.dart';
import '../responsivePackage.dart';
import '../staticdata.dart';
import '../theme/color.dart';
import 'ConferenceListModel.dart';
import 'ConferenceService.dart';

class ConferenceListPage extends StatefulWidget {
  const ConferenceListPage({super.key});

  @override
  State<ConferenceListPage> createState() => _ConferenceListPageState();
}

class _ConferenceListPageState extends State<ConferenceListPage> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('people').snapshots();
  bool showLoader = true;
  FToast fToast = FToast();
  int row = 8;
  int pageNo = 0;
  String searchText = '';
  int totalPages = 0;
  int totalElements = 0;
  int currentPage = 0;

  ConferenceListModel? conferenceDataFetched;
  List<ConferenceList> ConferenceListData = [];

  @override
  void initState() {
    super.initState();
    eventsListData(row, pageNo,searchText);
    fToast.init(context);
    getPageName();
  }

  getPageName() async {
    final SharedPreferences pref = await prefs;

    pref.setInt('navigatedPage', 32);
  }

  void eventsListData(int row, int pageNo, String searchText) {
    ConferenceService().findAllConference(row, pageNo,searchText).then((eventsDataList) {
      ConferenceListData = eventsDataList.conferenceList;
      totalPages = eventsDataList!.totalPages;
      totalElements = eventsDataList!.totalElements;
      showLoader = false;
      setState(() {});
    });
  }

  // void eventsListData(
  //     int rowsPerPage, int currentPage, searchText, String stateId) async {
  //   if (stateId == "0") {
  //     stateId = "";
  //   }
  //   await ConferenceService().findAllConference(row, pageNo,searchText)
  //       .then((districtDataList) {
  //     districtDataFetched = districtDataList;
  //     districtMasterList = districtDataFetched!.districtList;
  //     totalPages = districtDataFetched!.totalPages!;
  //     totalElements = districtDataFetched!.totalElements!;
  //     showLoader=false;
  //     setState(() {});
  //   });
  // }
  //
  // Future<void> deleteIssueType(BuildContext context, int id) async {
  //   if (await CreateEventService.eventDeleteService(id, fToast)) {
  //     await CreateEventService.eventsListData(row, pageNo)
  //         .then((eventsDataList) {
  //       eventsList = eventsDataList.events.eventList;
  //       totalPages = eventsDataList!.events.totalPages;
  //       totalElements = eventsDataList!.events.totalElements;
  //       setState(() {});
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final screenWidth = MediaQuery.of(context).size.width;
    double stateWidth;

    if (MediaQuery.of(context).size.width >= 630 &&
        MediaQuery.of(context).size.width <= 767) {
      stateWidth = MediaQuery.of(context).size.width / 3;
    } else if (MediaQuery.of(context).size.width < 350) {
      stateWidth = MediaQuery.of(context).size.width;
    } else {
      stateWidth = MediaQuery.of(context).size.width / 2;
    }
    return Consumer<ColorNotifire>(
      builder: (context, value, child) => Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: value.getbgcolor,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SizedBox(
              height: constraints.maxWidth < 600 ? 900 : 1000,
              width: constraints.maxWidth < 600 ? MediaQuery.of(context).size.width / 2 : double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: isMobile ? 0 : 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: isMobile ? MainAxisAlignment.end : MainAxisAlignment.start,
                                children: [
                                  if (!isMobile)
                                    Flexible(
                                      child: Wrap(
                                        runSpacing: 5,
                                        crossAxisAlignment: WrapCrossAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: SvgPicture.asset(
                                              "assets/home.svg",
                                              height: screenWidth < 600 ? 14 : 16,
                                              width: screenWidth < 600 ? 14 : 16,
                                              color: value.getMainText,
                                            ),
                                          ),
                                          Text(
                                            '   /   ',
                                            style: TextStyle(
                                              color: value.getMainText,
                                              fontSize: screenWidth < 600 ? 12 : 14,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            '${"Create_Conference".tr}',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: screenWidth < 600 ? 12 : 14,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  Container(
                                    height: 30.0,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              width: Responsive.isMobile(context)
                                  ? stateWidth
                                  : MediaQuery.of(context).size.width / 4.8,
                              height: 40.0,
                              // padding: const EdgeInsets.all(8.0),
                              color: Colors.white,
                              child: TextFormField(
                                textAlign: TextAlign.left,
                                style: const TextStyle(fontSize: 15.0),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "search".tr,
                                  prefixIcon: const Padding(
                                    padding:
                                    EdgeInsets.symmetric(vertical: 5.0),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  counterText: "",
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 30.0),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(128, 128, 128, 1),
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.lightBlueAccent,
                                        width: 3.0),
                                  ),
                                  hintStyle: const TextStyle(
                                      color: Color.fromRGBO(128, 128, 128, 1),
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3, color: Colors.red),
                                  ),
                                  focusedErrorBorder:
                                  const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 3,
                                      color: Color.fromRGBO(255, 0, 0, 1),
                                    ),
                                  ),
                                ),
                                onChanged: (text) {
                                  searchText = text;
                                  currentPage = 0;
                                  eventsListData(row, pageNo,searchText);
                                },
                              ),
                            ),
                          ),
                          _buildtable(width: constraints.maxWidth, context: context),
                          const SizedBox(),
                          // SingleChildScrollView(
                          //   child:SingleChildScrollView(
                          //     scrollDirection: Axis.horizontal,
                          //     child: Table(
                          //       border: TableBorder.all(),
                          //       columnWidths: const {
                          //         0: FixedColumnWidth(100),
                          //         1: FixedColumnWidth(180),
                          //         2: FixedColumnWidth(180),
                          //         3: FixedColumnWidth(180),
                          //         4: FixedColumnWidth(180),
                          //         5: FixedColumnWidth(180),
                          //       },
                          //       // columnWidths: const {
                          //       //   0: FlexColumnWidth(0),
                          //       //   // 1: FlexColumnWidth(2),
                          //       //   // 2: FlexColumnWidth(2),
                          //       //   // 3: FlexColumnWidth(2),
                          //       //   // 4: FlexColumnWidth(2),
                          //       //   // 5: FlexColumnWidth(2),
                          //       // },
                          //       // defaultColumnWidth: FlexColumnWidth(0),
                          //       children: [
                          //         TableRow(
                          //           decoration: BoxDecoration(color: Colors.grey[300]),
                          //           children: [
                          //             TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold)))),
                          //             TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Type', style: TextStyle(fontWeight: FontWeight.bold)))),
                          //             TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('State', style: TextStyle(fontWeight: FontWeight.bold)))),
                          //             TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('District', style: TextStyle(fontWeight: FontWeight.bold)))),
                          //             TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Address1', style: TextStyle(fontWeight: FontWeight.bold)))),
                          //             TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Address2', style: TextStyle(fontWeight: FontWeight.bold)))),
                          //           ],
                          //         ),
                          //         ...data.map((row) {
                          //           return TableRow(
                          //             children: [
                          //               TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(row["Name"]!))),
                          //               TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(row["Type"]!))),
                          //               TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(row["State"]!))),
                          //               TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(row["District"]!))),
                          //               TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(row["Address1"]!))),
                          //               TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(row["Address2"]!))),
                          //             ],
                          //           );
                          //         }).toList(),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),

              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildtable({required double width, required BuildContext context}) {
    return GetBuilder<AppConst>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.only(top: 8,left: 5.0, right: 10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: notifire!.getcontiner,
            boxShadow: boxShadow,
          ),
          child: Padding(
              padding: const EdgeInsets.only(
                  right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  showLoader
                      ? SizedBox(
                    width: Responsive.isDesktop(context)
                        ? MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          circularProgress(),
                        ],
                      ),
                    ),
                  )
                      : ConferenceListData.isEmpty
                      ? SizedBox(
                    // color: Colors.green,
                    width: Responsive.isDesktop(context)
                        ? MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.width,
                    height: Responsive.isMobile(context)
                        ? MediaQuery.of(context).size.height / 5
                        : MediaQuery.of(context).size.height / 2,
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("No Data"),
                        ],
                      ),
                    ),
                  )
                      : Container(
                    // width: screenSize.width,
                    decoration: BoxDecoration(
                      // color: appMainColor.withOpacity(0.8),
                      // borderRadius: BorderRadius.circular(25),
                        border:
                        Border.all(color: signUpTopFontcolor)),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Table(
                        defaultVerticalAlignment:
                        TableCellVerticalAlignment.middle,
                        columnWidths: const {
                          0: FixedColumnWidth(85),
                          1: FixedColumnWidth(150),
                          2: FixedColumnWidth(180),
                          3: FixedColumnWidth(180),
                          4: FixedColumnWidth(180),
                          5: FixedColumnWidth(180),
                          6: FixedColumnWidth(180),
                          7: FixedColumnWidth(180),
                          8: FixedColumnWidth(180),
                          9: FixedColumnWidth(180),
                          10: FixedColumnWidth(200),
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              color:
                              signUpTopFontcolor.withOpacity(0.8),
                              border: const Border(
                                right: BorderSide
                                    .none, // Remove right border
                              ),
                            ),
                            children: [
                              TableCell(
                                child: SizedBox(
                                  height: 50,
                                  child: Align(
                                    alignment: Alignment.center,
                                    // Align content to center-left
                                    child: Text(
                                      's.no'.tr,
                                      style: mediumBlackTextStyle
                                          .copyWith(
                                          fontSize: 16,
                                          fontWeight:
                                          FontWeight.w700,
                                          color:
                                          signUpTopBarcolor),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  // Align content to center-left
                                  child: Text(
                                    "event_name".tr,
                                    style:
                                    mediumBlackTextStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight:
                                        FontWeight.w700,
                                        color: signUpTopBarcolor),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  // Align content to center-left
                                  child: Text(
                                    "date".tr,
                                    style:
                                    mediumBlackTextStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight:
                                        FontWeight.w700,
                                        color: signUpTopBarcolor),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  // Align content to center-left
                                  child: Text(
                                    "time".tr,
                                    style:
                                    mediumBlackTextStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight:
                                        FontWeight.w700,
                                        color: signUpTopBarcolor),
                                  ),
                                ),
                              ),
                              //check
                              TableCell(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  // Align content to center-left
                                  child: Text(
                                    "No_peo_allowed".tr,
                                    style:
                                    mediumBlackTextStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight:
                                        FontWeight.w700,
                                        color: signUpTopBarcolor),
                                  ),
                                ),
                              ),

                              TableCell(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  // Align content to center-left
                                  child: Text(
                                    "approvalRequired".tr,
                                    style:
                                    mediumBlackTextStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight:
                                        FontWeight.w700,
                                        color: signUpTopBarcolor),
                                  ),
                                ),
                              ),

                              TableCell(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  // Align content to center-left
                                  child: Text(
                                    "venue_Address1".tr,
                                    style:
                                    mediumBlackTextStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight:
                                        FontWeight.w700,
                                        color: signUpTopBarcolor),
                                  ),
                                ),
                              ),

                              TableCell(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  // Align content to center-left
                                  child: Text(
                                    "venue_Address2".tr,
                                    style:
                                    mediumBlackTextStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight:
                                        FontWeight.w700,
                                        color: signUpTopBarcolor),
                                  ),
                                ),
                              ),

                              TableCell(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  // Align content to center-left
                                  child: Text(
                                    "state".tr,
                                    style:
                                    mediumBlackTextStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight:
                                        FontWeight.w700,
                                        color: signUpTopBarcolor),
                                  ),
                                ),
                              ),

                              TableCell(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  // Align content to center-left
                                  child: Text(
                                    "district".tr,
                                    style:
                                    mediumBlackTextStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight:
                                        FontWeight.w700,
                                        color: signUpTopBarcolor),
                                  ),
                                ),
                              ),

                              //check

                              TableCell(
                                child: Align(
                                  alignment: Alignment.center,
                                  // Align content to center-left
                                  child: Text(
                                    'action'.tr,
                                    style:
                                    mediumBlackTextStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight:
                                        FontWeight.w700,
                                        color: signUpTopBarcolor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //divider(color: const Color(0xff7366ff)),
                          for (int index = 0;
                          index < ConferenceListData.length;
                          index++)
                            TableRow(
                              decoration: BoxDecoration(
                                color: index.isOdd
                                    ? const Color.fromRGBO(
                                    255, 255, 255, 1)
                                    : const Color.fromRGBO(
                                    235, 239, 245, 1),
                                border: Border(
                                  top: BorderSide(
                                      color: Color((math.Random()
                                          .nextDouble() *
                                          0xFFFFFF)
                                          .toInt())
                                          .withOpacity(1.0),
                                      width:
                                      1.0), // Apply color as divider
                                ),
                              ),
                              children: [
                                TableCell(
                                  child: SizedBox(
                                    height: 50,
                                    child: Align(
                                      alignment: Alignment.center,
                                      // Align content to center-left
                                      child: Text(
                                        (pageNo * row + index + 1)
                                            .toString(),
                                        style: TextStyle(
                                            color: notifire!
                                                .getMainText),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    // Align content to center-left
                                    child: Text(ConferenceListData[index]
                                        .name
                                        .toString()),
                                  ),
                                ),
                                TableCell(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    // Align content to center-left
                                    child: Text(ConferenceListData[index]
                                        .date
                                        .toString()),
                                  ),
                                ),
                                TableCell(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    // Align content to center-left
                                    child: Text(
                                        ConferenceListData[index]
                                            .startTime.toString()!,
                                    ),
                                  ),
                                ),
                                // check
                                TableCell(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    // Align content to center-left
                                    child: Text(
                                      ConferenceListData[index]
                                          .noPeopleAllowed.toString()!,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    // Align content to center-left
                                    child: Text(
                                      ConferenceListData[index]
                                          .approvelRequired.toString()!,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    // Align content to center-left
                                    child: Text(
                                      ConferenceListData[index]
                                          .venueAddress1.toString()!,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    // Align content to center-left
                                    child: Text(
                                      ConferenceListData[index]
                                          .venueAddress2.toString()!,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    // Align content to center-left
                                    child: Text(
                                      ConferenceListData[index]
                                          .mstDistrict.dstctEnglish.toString()!,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    // Align content to center-left
                                    child: Text(
                                      ConferenceListData[index]
                                          .mstState.english.toString()!,
                                    ),
                                  ),
                                ),
                                // check
                                TableCell(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        if(!kIsWeb)
                                        IconButton(
                                          icon: const Icon(
                                            Icons.qr_code_scanner,
                                            color: Colors.black,
                                          ),
                                          onPressed: () async {
                                            final SharedPreferences
                                            pref = await prefs;
                                            // pref.setInt("conferenceId",
                                            //     ConferenceListData[index].id);
                                            box.write("conferenceId", ConferenceListData[index].id);
                                            box.write("conferenceName", ConferenceListData[index].name);
                                            controller.changePage(1);
                                          },
                                          tooltip: 'Scan',
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.keyboard_alt_outlined,
                                            // color: appMainColor,
                                          ),
                                          onPressed: () async {
                                            final SharedPreferences
                                            pref = await prefs;
                                            // pref.setInt("conferenceId",
                                            //     ConferenceListData[index].id);
                                            box.write("conferenceId", ConferenceListData[index].id);
                                            box.write("conferenceName", ConferenceListData[index].name);
                                            controller.changePage(3);
                                            // _showCreatePopup(context,
                                            //     ConferenceListData[index]);
                                          },
                                          tooltip: 'Manual entry',
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.download_outlined,
                                            // color: appMainColor,
                                          ),
                                          onPressed: () async {
                                            box.write("conferenceId", ConferenceListData[index].id);
                                            box.write("conferenceName", ConferenceListData[index].name);
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Center(child: Text('Qr Generator')),
                                                  content: Conferenceqrgenator(ConferenceListData[index].id),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop(); // Close the dialog
                                                      },
                                                      child: Text('Close'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          tooltip: 'Download',
                                        ),
                                        // IconButton(
                                        //   icon: const Icon(
                                        //     Icons.edit,
                                        //     color: appMainColor,
                                        //   ),
                                        //   onPressed: () {
                                        //     // _showCreatePopup(context,
                                        //     //     ConferenceListData[index]);
                                        //   },
                                        //   tooltip: 'Edit',
                                        // ),
                                        // IconButton(
                                        //   icon: Icon(
                                        //     Icons.delete,
                                        //     color: actionColor
                                        //         .withOpacity(0.8),
                                        //   ),
                                        //   onPressed: () {
                                        //     // deleteDataAlert(
                                        //     //   context,
                                        //     //   eventsList[index].id,
                                        //     //   deleteText,
                                        //     //   yes,
                                        //     //   "No".tr, // Provide the value for 'no' here
                                        //     // );
                                        //   },
                                        //   tooltip: "Delete",
                                        // ),
                                        // if (!kIsWeb &&
                                        //     isEventWithinOneHour(
                                        //         eventsList[index]
                                        //             .eventFromTime!,
                                        //         eventsList[index]
                                        //             .eventDate!))
                                        //   IconButton(
                                        //     icon: const Icon(
                                        //       Icons.people,
                                        //       color: Colors.black,
                                        //     ),
                                        //     onPressed: () {
                                        //       Navigator.push(
                                        //         context,
                                        //         MaterialPageRoute(builder: (context) => QRViewExample()),
                                        //       );
                                        //     },
                                        //     tooltip: "Allow People",
                                        //   ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Text(
                            ' ${(((pageNo) * (8)) + 1)}-${(pageNo + 1) * (8)} of $totalElements ',
                            style: TextStyle(
                              color: notifire!.getMainText,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            pageNo > 0
                                ? IconButton(
                              onPressed: () {
                                setState(() {
                                  pageNo--;
                                  eventsListData(row, pageNo,searchText);
                                });
                              },
                              icon: const Icon(Icons
                                  .keyboard_arrow_left), // Disable the button if currentPage is already at its lower limit
                            )
                                : IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.chevron_left,
                                  color: darker.withOpacity(0.5)),
                            ),
                            Text("page".tr),
                            // const SizedBox(width: 5.0),
                            Text('${pageNo + 1}'),
                            (pageNo < totalPages - 1 && ConferenceListData.isNotEmpty)
                                ? IconButton(
                              onPressed: () {
                                setState(() {
                                  pageNo++;
                                  eventsListData(row, pageNo,searchText);
                                });
                              },
                              icon: Icon(Icons.chevron_right,
                                  color: notifire!
                                      .getMainText), // Disable the button if currentPage is already at its upper limit
                            )
                                : IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.chevron_right,
                                  color: darker.withOpacity(0.5)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      );
    });
  }


  // SingleChildScrollView buildSingleChildScrollView() {
  //   return SingleChildScrollView(
  //   scrollDirection: Axis.horizontal,
  //   child: Table(
  //     border: TableBorder.all(),
  //     columnWidths: const {
  //       0: FixedColumnWidth(100),
  //       1: FixedColumnWidth(180),
  //       2: FixedColumnWidth(180),
  //       3: FixedColumnWidth(180),
  //       4: FixedColumnWidth(180),
  //       5: FixedColumnWidth(180),
  //     },
  //     // columnWidths: const {
  //     //   0: FlexColumnWidth(0),
  //     //   // 1: FlexColumnWidth(2),
  //     //   // 2: FlexColumnWidth(2),
  //     //   // 3: FlexColumnWidth(2),
  //     //   // 4: FlexColumnWidth(2),
  //     //   // 5: FlexColumnWidth(2),
  //     // },
  //     // defaultColumnWidth: FlexColumnWidth(0),
  //     children: [
  //       TableRow(
  //         decoration: BoxDecoration(color: Colors.grey[300]),
  //         children: [
  //           TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold)))),
  //           TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Type', style: TextStyle(fontWeight: FontWeight.bold)))),
  //           TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('State', style: TextStyle(fontWeight: FontWeight.bold)))),
  //           TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('District', style: TextStyle(fontWeight: FontWeight.bold)))),
  //           TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Address1', style: TextStyle(fontWeight: FontWeight.bold)))),
  //           TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text('Address2', style: TextStyle(fontWeight: FontWeight.bold)))),
  //         ],
  //       ),
  //       ...data.map((row) {
  //         return TableRow(
  //           children: [
  //             TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(row["Name"]!))),
  //             TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(row["Type"]!))),
  //             TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(row["State"]!))),
  //             TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(row["District"]!))),
  //             TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(row["Address1"]!))),
  //             TableCell(child: Padding(padding: EdgeInsets.all(8.0), child: Text(row["Address2"]!))),
  //           ],
  //         );
  //       }).toList(),
  //     ],
  //   ),
  // );
  // }
}