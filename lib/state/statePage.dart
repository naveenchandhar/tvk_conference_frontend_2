// import 'dart:math' as math;
//
// import 'package:TamilgaVetriKalagam/main.dart';
// import 'package:TamilgaVetriKalagam/state/state_list_master_model.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_utils/src/extensions/internacionalization.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../Widgets/comuntitle.dart';
// import '../../appstaticdata/staticdata.dart';
// import '../../provider/proviercolors.dart';
// import '../appstaticdata/colorfile.dart';
// import '../common/commonWidget/common_widgets.dart';
// import '../constants/i18n_en.dart';
// import '../responsivePackage.dart';
// import '../theme/color.dart';
// import 'state_service.dart';
//
// class StateListPage extends StatefulWidget {
//   const StateListPage({Key? key}) : super(key: key);
//
//   @override
//   State<StateListPage> createState() => _StateListPageState();
// }
//
// class _StateListPageState extends State<StateListPage> {
//   int pageNo = 0;
//   int totalPages = 0;
//   int totalElements = 0;
//   StateListMaster? stateTotalDataFetched;
//   List<StateList> stateMasterList = [];
//   String searchText = '';
//   int rowsPerPage = 8;
//   int currentPage = 0;
//   bool showLoader = true;
//
//   @override
//   void initState() {
//     super.initState();
//     stateListData(rowsPerPage, currentPage, pageNo, searchText);
//     getPageName();
//   }
//
//   getPageName() async {
//     final SharedPreferences pref = await prefs;
//     pref.setInt('navigatedPage', 5);
//   }
//
//   void stateListData(int row, int currentPage, int pageNo, searchText) {
//     StateService.getStateListForModel(row, currentPage, searchText)
//         .then((state) {
//       stateTotalDataFetched = state;
//       stateMasterList = stateTotalDataFetched!.stateList;
//       totalPages = stateTotalDataFetched!.totalPages!;
//       totalElements = stateTotalDataFetched!.totalElements!;
//       showLoader = false;
//       setState(() {});
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ColorNotifire>(
//       builder: (context, value, child) => Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         color: notifire!.getbgcolor,
//         child: LayoutBuilder(
//           builder: (BuildContext context, BoxConstraints constraints) {
//             return SizedBox(
//               height: constraints.maxWidth < 600 ? 900 : 1000,
//               width: double.infinity,
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 child: Column(
//                   children: [
//                     ComunTitle(title: 'state'.tr, path: "master_screen".tr),
//                     // const SizedBox(
//                     //   height: 10.0,
//                     // ),
//
//                     _buildtable(width: constraints.maxWidth),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildtable({required double width}) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: const BorderRadius.all(Radius.circular(12)),
//           color: notifire!.getcontiner,
//           boxShadow: boxShadow,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.only(
//               left: 20.0, right: 10.0, bottom: 20.0, top: 5.0),
//           child: (kIsWeb && Responsive.isDesktop(context))
//               ? Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 5.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: Responsive.isMobile(context)
//                                 ? MediaQuery.of(context).size.width / 3
//                                 : MediaQuery.of(context).size.width / 5,
//
//                             padding:
//                                 const EdgeInsets.only(left: 10.0, right: 10.0),
//                             // color: Colors.green,
//                             height: 45.0,
//                             child: TextFormField(
//                               textAlign: TextAlign.left,
//                               style: const TextStyle(fontSize: 15.0),
//                               decoration: InputDecoration(
//                                 // contentPadding: EdgeInsets.only(top: 20),
//                                 filled: true,
//                                 fillColor: Colors.white,
//                                 hintText: "search".tr,
//                                 prefixIcon: const Padding(
//                                   padding: EdgeInsets.symmetric(vertical: 5.0),
//                                   // add padding to adjust icon
//                                   child: Icon(
//                                     Icons.search,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                                 counterText: "",
//                                 contentPadding: const EdgeInsets.symmetric(
//                                     vertical: 5.0, horizontal: 30.0),
//                                 enabledBorder: const OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color: Color.fromRGBO(128, 128, 128, 1),
//                                   ),
//                                   // borderRadius: BorderRadius.circular(30.0),
//                                 ),
//                                 focusedBorder: const OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Colors.lightBlueAccent,
//                                       width: 3.0),
//                                   // borderRadius: BorderRadius.circular(30.0),
//                                 ),
//                                 hintStyle: const TextStyle(
//                                     color: Color.fromRGBO(128, 128, 128, 1),
//                                     fontStyle: FontStyle.normal,
//                                     fontSize: 14.0),
//                                 errorBorder: const OutlineInputBorder(
//                                   // borderRadius: BorderRadius.circular(30.0),
//                                   borderSide:
//                                       BorderSide(width: 3, color: Colors.red),
//                                 ),
//                                 focusedErrorBorder: const OutlineInputBorder(
//                                   // borderRadius: BorderRadius.all(Radius.circular(30)),
//                                   borderSide: BorderSide(
//                                     width: 3,
//                                     color: Color.fromRGBO(255, 0, 0, 1),
//                                   ),
//                                 ),
//                               ),
//                               onChanged: (text) {
//                                 searchText = text;
//                                 currentPage = 0;
//                                 stateListData(rowsPerPage, currentPage, pageNo,
//                                     searchText);
//                                 // searchState(searchText);
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     Divider(color: Colors.grey.shade300, height: 20),
//                     // Container(
//                     //   height: 2, // Adjust the height of the divider as needed
//                     //   color: Colors.grey[300], // Set the color of the divider
//                     // ),
//                     // const SizedBox(height: 10),
//                     showLoader
//                         ? SizedBox(
//                             width: Responsive.isDesktop(context)
//                                 ? MediaQuery.of(context).size.width
//                                 : MediaQuery.of(context).size.width,
//                             height: MediaQuery.of(context).size.height / 1.5,
//                             child: Center(
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   circularProgress(),
//                                 ],
//                               ),
//                             ),
//                           )
//                         : stateMasterList.isEmpty
//                             ? Container(
//                                 // color: Colors.green,
//                                 width: Responsive.isDesktop(context)
//                                     ? MediaQuery.of(context).size.width
//                                     : MediaQuery.of(context).size.width,
//                                 height: Responsive.isMobile(context)
//                                     ? MediaQuery.of(context).size.height / 5
//                                     : MediaQuery.of(context).size.height / 2,
//                                 child: const Center(
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text("No Data"),
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             : Container(
//                       margin:
//                       EdgeInsets.only(right: 10.0, left: 10.0),
//                       decoration: BoxDecoration(
//
//                           border: Border.all( color: signUpTopFontcolor)),
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Table(
//                           defaultVerticalAlignment:
//                           TableCellVerticalAlignment.middle,
//                           columnWidths: {
//                             0: const FixedColumnWidth(80),
//                             // Adjust column widths as needed
//                             1: FixedColumnWidth(
//                                 Responsive.isMobile(context)
//                                     ? 120
//                                     : 200),
//                             2: FixedColumnWidth(
//                                 Responsive.isMobile(context)
//                                     ? 120
//                                     : 200),
//                           },
//                           children: [
//                             TableRow(
//                               decoration: BoxDecoration(
//                                 color: signUpTopFontcolor
//                                     .withOpacity(0.8),
//                                 border: Border(
//                                   right: BorderSide
//                                       .none, // Remove right border
//                                 ),
//                               ),
//                               children: [
//                                 TableCell(
//                                   child: SizedBox(
//                                     height: 40,
//                                     child: Center(
//                                       child: Text(
//                                         "s.no".tr,
//                                         style: mediumBlackTextStyle
//                                             .copyWith(
//                                             fontSize: 16,
//                                             fontWeight:
//                                             FontWeight.w700,
//                                             color:
//                                             signUpTopBarcolor),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//
//                                 TableCell(
//                                   child: SizedBox(
//                                     child: Text(commonEnglishName,
//                                         style: mediumBlackTextStyle
//                                             .copyWith(
//                                             fontSize: 16,
//                                             fontWeight:
//                                             FontWeight
//                                                 .w700,
//                                             color:
//                                             signUpTopBarcolor)),
//                                   ),
//                                 ),
//
//                                 TableCell(
//                                   child: SizedBox(
//                                     child: Text(commonTamilName,
//                                         style: mediumBlackTextStyle
//                                             .copyWith(
//                                             fontSize: 16,
//                                             fontWeight:
//                                             FontWeight
//                                                 .w700,
//                                             color:
//                                             signUpTopBarcolor)),
//                                   ),
//                                 ),
//
//                               ],
//                             ),
//                             for (int index = pageNo * 10;
//                             index < (pageNo + 1) * 10 &&
//                                 index < stateMasterList.length;
//                             index++)
//                               TableRow(
//                                 decoration: BoxDecoration(
//                                   color: index.isOdd
//                                       ? const Color.fromRGBO(
//                                       255, 255, 255, 1)
//                                       : const Color.fromRGBO(
//                                       235, 239, 245, 1),
//                                   border: Border(
//                                     top: BorderSide(
//                                       color: Color((math.Random()
//                                           .nextDouble() *
//                                           0xFFFFFF)
//                                           .toInt())
//                                           .withOpacity(1.0),
//                                       width: 1.0,
//                                     ),
//                                   ),
//                                 ),
//                                 children: [
//                                   TableCell(
//                                     child: SizedBox(
//                                       height: 50,
//                                       child: Center(
//                                         child: Text(
//                                           (currentPage *
//                                               rowsPerPage +
//                                               index +
//                                               1)
//                                               .toString(),
//                                           style: TextStyle(
//                                             color: notifire!
//                                                 .getMainText,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   TableCell(
//                                     child: Text(
//                                       stateMasterList[index]
//                                           .english,
//                                       style: TextStyle(
//                                         color:
//                                         notifire!.getMainText,
//                                       ),
//                                     ),
//                                   ),
//
//                                   TableCell(
//                                     child: Text(
//                                       stateMasterList[index]
//                                           .tamil,
//                                       style: TextStyle(
//                                         color:
//                                         notifire!.getMainText,
//                                       ),
//                                     ),
//                                   ),
//
//                                 ],
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 8.0),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 0),
//                             child: Text(
//                               ' ${(((currentPage) * (8)) + 1)}-${(currentPage + 1) * (8)} of $totalElements ',
//                               style: TextStyle(
//                                 color: notifire!.getMainText,
//                                 fontSize: 12,
//                               ),
//                               textAlign: TextAlign.end,
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Row(
//                             // mainAxisSize: MainAxisSize.e,
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               currentPage > 0
//                                   ? IconButton(
//                                       onPressed: () {
//                                         setState(() {
//                                           showLoader = true;
//                                           currentPage--;
//                                           stateListData(rowsPerPage,
//                                               currentPage, pageNo, searchText);
//                                         });
//                                       },
//                                       icon: Icon(Icons.chevron_left,
//                                           color: notifire!.getMainText),
//                                     )
//                                   : IconButton(
//                                       onPressed: () {},
//                                       icon: Icon(Icons.chevron_left,
//                                           color: darker.withOpacity(0.5)),
//                                     ),
//                               Text("page".tr),
//                               const SizedBox(width: 5.0),
//                               Text("${currentPage + 1}"),
//                               // Add some spacing between the arrows
//                               (currentPage < totalPages - 1 &&
//                                       stateMasterList.isNotEmpty)
//                                   ? // Show the right arrow only if the condition is met
//                                   IconButton(
//                                       onPressed: () {
//                                         setState(() {
//                                           showLoader = true;
//                                           currentPage++;
//                                           stateListData(rowsPerPage,
//                                               currentPage, pageNo, searchText);
//                                         });
//                                       },
//                                       icon: Icon(Icons.chevron_right,
//                                           color: notifire!.getMainText),
//                                     )
//                                   : IconButton(
//                                       onPressed: () {},
//                                       icon: Icon(Icons.chevron_right,
//                                           color: darker.withOpacity(0.5)),
//                                     ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 )
//               : (Responsive.screenOrientation(context) == Orientation.landscape)
//                   ? Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 5.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Container(
//                                 width: Responsive.isMobile(context)
//                                     ? MediaQuery.of(context).size.width / 3
//                                     : MediaQuery.of(context).size.width / 5,
//
//                                 padding: const EdgeInsets.only(
//                                     left: 10.0, right: 10.0),
//                                 // color: Colors.green,
//                                 height: 45.0,
//                                 child: TextFormField(
//                                   textAlign: TextAlign.left,
//                                   style: const TextStyle(fontSize: 15.0),
//                                   decoration: InputDecoration(
//                                     // contentPadding: EdgeInsets.only(top: 20),
//                                     filled: true,
//                                     fillColor: Colors.white,
//                                     hintText: "search".tr,
//                                     prefixIcon: const Padding(
//                                       padding:
//                                           EdgeInsets.symmetric(vertical: 5.0),
//                                       // add padding to adjust icon
//                                       child: Icon(
//                                         Icons.search,
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                     counterText: "",
//                                     contentPadding: const EdgeInsets.symmetric(
//                                         vertical: 5.0, horizontal: 30.0),
//                                     enabledBorder: const OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: Color.fromRGBO(128, 128, 128, 1),
//                                       ),
//                                       // borderRadius: BorderRadius.circular(30.0),
//                                     ),
//                                     focusedBorder: const OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: Colors.lightBlueAccent,
//                                           width: 3.0),
//                                       // borderRadius: BorderRadius.circular(30.0),
//                                     ),
//                                     hintStyle: const TextStyle(
//                                         color: Color.fromRGBO(128, 128, 128, 1),
//                                         fontStyle: FontStyle.normal,
//                                         fontSize: 14.0),
//                                     errorBorder: const OutlineInputBorder(
//                                       // borderRadius: BorderRadius.circular(30.0),
//                                       borderSide: BorderSide(
//                                           width: 3, color: Colors.red),
//                                     ),
//                                     focusedErrorBorder:
//                                         const OutlineInputBorder(
//                                       // borderRadius: BorderRadius.all(Radius.circular(30)),
//                                       borderSide: BorderSide(
//                                         width: 3,
//                                         color: Color.fromRGBO(255, 0, 0, 1),
//                                       ),
//                                     ),
//                                   ),
//                                   onChanged: (text) {
//                                     searchText = text;
//                                     currentPage = 0;
//                                     stateListData(rowsPerPage, currentPage,
//                                         pageNo, searchText);
//                                     // searchState(searchText);
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         Divider(color: Colors.grey.shade300, height: 20),
//                         // Container(
//                         //   height: 2, // Adjust the height of the divider as needed
//                         //   color: Colors.grey[300], // Set the color of the divider
//                         // ),
//                         // const SizedBox(height: 10),
//                         showLoader
//                             ? SizedBox(
//                                 width: Responsive.isDesktop(context)
//                                     ? MediaQuery.of(context).size.width / 2.6
//                                     : MediaQuery.of(context).size.width,
//                                 height: MediaQuery.of(context).size.height / 2,
//                                 child: Center(
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       circularProgress(),
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             : stateMasterList.isEmpty
//                                 ? Container(
//                                     // color: Colors.green,
//                                     width: Responsive.isDesktop(context)
//                                         ? MediaQuery.of(context).size.width /
//                                             2.6
//                                         : MediaQuery.of(context).size.width,
//                                     height: Responsive.isMobile(context)
//                                         ? MediaQuery.of(context).size.height / 5
//                                         : MediaQuery.of(context).size.height /
//                                             2,
//                                     child: const Center(
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text("No Data"),
//                                         ],
//                                       ),
//                                     ),
//                                   )
//                                 : Container(
//                                     margin: EdgeInsets.only(
//                                         right: 10.0, left: 10.0),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           // color: appMainColor.withOpacity(0.8),
//                                           // borderRadius: BorderRadius.circular(25),
//                                           border: Border.all(
//                                               color: signUpTopFontcolor)),
//                                       child: SingleChildScrollView(
//                                         scrollDirection: Axis.horizontal,
//                                         child: Table(
//                                           defaultVerticalAlignment:
//                                               TableCellVerticalAlignment.middle,
//                                           columnWidths: {
//                                             0: const FixedColumnWidth(80),
//                                             // Adjust column widths as needed
//                                             1: FixedColumnWidth(
//                                                 Responsive.isMobile(context)
//                                                     ? 120
//                                                     : 200),
//                                             2: FixedColumnWidth(
//                                                 Responsive.isMobile(context)
//                                                     ? 120
//                                                     : 200),
//                                           },
//                                           children: [
//                                             TableRow(
//                                               decoration: BoxDecoration(
//                                                 color: signUpTopFontcolor
//                                                     .withOpacity(0.8),
//                                                 border: Border(
//                                                   right: BorderSide
//                                                       .none, // Remove right border
//                                                 ),
//                                               ),
//                                               children: [
//                                                 TableCell(
//                                                   child: SizedBox(
//                                                     height: 40,
//                                                     child: Center(
//                                                       child: Text(
//                                                         "s.no".tr,
//                                                         style: mediumBlackTextStyle
//                                                             .copyWith(
//                                                                 fontSize: 16,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w700,
//                                                                 color:
//                                                                     signUpTopBarcolor),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 TableCell(
//                                                     child: SizedBox(
//                                                       child: Text(commonEnglishName,
//                                                           style: mediumBlackTextStyle
//                                                               .copyWith(
//                                                                   fontSize: 16,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w700,
//                                                                   color:
//                                                                       signUpTopBarcolor)),
//                                                     ),
//                                                   ),
//
//                                                  TableCell(
//                                                     child: SizedBox(
//                                                       child: Text(
//                                                           commonTamilName,
//                                                           style: mediumBlackTextStyle
//                                                               .copyWith(
//                                                                   fontSize: 16,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w700,
//                                                                   color:
//                                                                       signUpTopBarcolor)),
//                                                     ),
//                                                   ),
//
//                                               ],
//                                             ),
//                                             for (int index = pageNo * 10;
//                                                 index < (pageNo + 1) * 10 &&
//                                                     index <
//                                                         stateMasterList.length;
//                                                 index++)
//                                               TableRow(
//                                                 decoration: BoxDecoration(
//                                                   color: index.isOdd
//                                                       ? const Color.fromRGBO(
//                                                           255, 255, 255, 1)
//                                                       : const Color.fromRGBO(
//                                                           235, 239, 245, 1),
//                                                   border: Border(
//                                                     top: BorderSide(
//                                                       color: Color((math.Random()
//                                                                       .nextDouble() *
//                                                                   0xFFFFFF)
//                                                               .toInt())
//                                                           .withOpacity(1.0),
//                                                       width: 1.0,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 children: [
//                                                   TableCell(
//                                                     child: SizedBox(
//                                                       height: 50,
//                                                       child: Center(
//                                                         child: Text(
//                                                           (currentPage *
//                                                                       rowsPerPage +
//                                                                   index +
//                                                                   1)
//                                                               .toString(),
//                                                           style: TextStyle(
//                                                             color: notifire!
//                                                                 .getMainText,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                    TableCell(
//                                                       child: Text(
//                                                         stateMasterList[index]
//                                                             .english,
//                                                         style: TextStyle(
//                                                           color: notifire!
//                                                               .getMainText,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                    TableCell(
//                                                       child: Text(
//                                                         stateMasterList[index]
//                                                             .tamil,
//                                                         style: TextStyle(
//                                                           color: notifire!
//                                                               .getMainText,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                 ],
//                                               ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                         const SizedBox(height: 8.0),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Expanded(
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 0),
//                                 child: Text(
//                                   ' ${(((currentPage) * (8)) + 1)}-${(currentPage + 1) * (8)} of $totalElements ',
//                                   style: TextStyle(
//                                     color: notifire!.getMainText,
//                                     fontSize: 12,
//                                   ),
//                                   textAlign: TextAlign.end,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Row(
//                                 // mainAxisSize: MainAxisSize.e,
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   currentPage > 0
//                                       ? IconButton(
//                                           onPressed: () {
//                                             setState(() {
//                                               showLoader = true;
//                                               currentPage--;
//                                               stateListData(
//                                                   rowsPerPage,
//                                                   currentPage,
//                                                   pageNo,
//                                                   searchText);
//                                             });
//                                           },
//                                           icon: Icon(Icons.chevron_left,
//                                               color: notifire!.getMainText),
//                                         )
//                                       : IconButton(
//                                           onPressed: () {},
//                                           icon: Icon(Icons.chevron_left,
//                                               color: darker.withOpacity(0.5)),
//                                         ),
//                                   Text("page".tr),
//                                   const SizedBox(width: 5.0),
//                                   Text("${currentPage + 1}"),
//                                   // Add some spacing between the arrows
//                                   (currentPage < totalPages - 1 &&
//                                           stateMasterList.isNotEmpty)
//                                       ? // Show the right arrow only if the condition is met
//                                       IconButton(
//                                           onPressed: () {
//                                             setState(() {
//                                               showLoader = true;
//                                               currentPage++;
//                                               stateListData(
//                                                   rowsPerPage,
//                                                   currentPage,
//                                                   pageNo,
//                                                   searchText);
//                                             });
//                                           },
//                                           icon: Icon(Icons.chevron_right,
//                                               color: notifire!.getMainText),
//                                         )
//                                       : IconButton(
//                                           onPressed: () {},
//                                           icon: Icon(Icons.chevron_right,
//                                               color: darker.withOpacity(0.5)),
//                                         ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     )
//                   : Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 5.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Container(
//                                 width: Responsive.isMobile(context)
//                                     ? MediaQuery.of(context).size.width / 1.8
//                                     : MediaQuery.of(context).size.width / 5,
//
//                                 padding: const EdgeInsets.only(
//                                     left: 10.0, right: 10.0),
//                                 // color: Colors.green,
//                                 height: 45.0,
//                                 child: TextFormField(
//                                   textAlign: TextAlign.left,
//                                   style: const TextStyle(fontSize: 15.0),
//                                   decoration: InputDecoration(
//                                     // contentPadding: EdgeInsets.only(top: 20),
//                                     filled: true,
//                                     fillColor: Colors.white,
//                                     hintText: "search".tr,
//                                     prefixIcon: const Padding(
//                                       padding:
//                                           EdgeInsets.symmetric(vertical: 5.0),
//                                       // add padding to adjust icon
//                                       child: Icon(
//                                         Icons.search,
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                     counterText: "",
//                                     contentPadding: const EdgeInsets.symmetric(
//                                         vertical: 5.0, horizontal: 30.0),
//                                     enabledBorder: const OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: Color.fromRGBO(128, 128, 128, 1),
//                                       ),
//                                       // borderRadius: BorderRadius.circular(30.0),
//                                     ),
//                                     focusedBorder: const OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: Colors.lightBlueAccent,
//                                           width: 3.0),
//                                       // borderRadius: BorderRadius.circular(30.0),
//                                     ),
//                                     hintStyle: const TextStyle(
//                                         color: Color.fromRGBO(128, 128, 128, 1),
//                                         fontStyle: FontStyle.normal,
//                                         fontSize: 14.0),
//                                     errorBorder: const OutlineInputBorder(
//                                       // borderRadius: BorderRadius.circular(30.0),
//                                       borderSide: BorderSide(
//                                           width: 3, color: Colors.red),
//                                     ),
//                                     focusedErrorBorder:
//                                         const OutlineInputBorder(
//                                       // borderRadius: BorderRadius.all(Radius.circular(30)),
//                                       borderSide: BorderSide(
//                                         width: 3,
//                                         color: Color.fromRGBO(255, 0, 0, 1),
//                                       ),
//                                     ),
//                                   ),
//                                   onChanged: (text) {
//                                     searchText = text;
//                                     currentPage = 0;
//                                     stateListData(rowsPerPage, currentPage,
//                                         pageNo, searchText);
//                                     // searchState(searchText);
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         Divider(color: Colors.grey.shade300, height: 20),
//                         // Container(
//                         //   height: 2, // Adjust the height of the divider as needed
//                         //   color: Colors.grey[300], // Set the color of the divider
//                         // ),
//                         // const SizedBox(height: 10),
//                         showLoader
//                             ? SizedBox(
//                                 width: Responsive.isDesktop(context)
//                                     ? MediaQuery.of(context).size.width / 2.6
//                                     : MediaQuery.of(context).size.width,
//                                 height: MediaQuery.of(context).size.height / 2,
//                                 child: Center(
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       circularProgress(),
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             : stateMasterList.isEmpty
//                                 ? Container(
//                                     // color: Colors.green,
//                                     width: Responsive.isDesktop(context)
//                                         ? MediaQuery.of(context).size.width /
//                                             2.6
//                                         : MediaQuery.of(context).size.width,
//                                     height: Responsive.isMobile(context)
//                                         ? MediaQuery.of(context).size.height / 5
//                                         : MediaQuery.of(context).size.height /
//                                             2,
//                                     child: const Center(
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text("No Data"),
//                                         ],
//                                       ),
//                                     ),
//                                   )
//                                 : Container(
//                                     margin: EdgeInsets.only(
//                                         right: 10.0, left: 10.0),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           // color: appMainColor.withOpacity(0.8),
//                                           // borderRadius: BorderRadius.circular(25),
//                                           border: Border.all(
//                                               color: signUpTopFontcolor)),
//                                       child: SingleChildScrollView(
//                                         scrollDirection: Axis.horizontal,
//                                         child: Table(
//                                           defaultVerticalAlignment:
//                                               TableCellVerticalAlignment.middle,
//                                           columnWidths: {
//                                             0: const FixedColumnWidth(80),
//                                             // Adjust column widths as needed
//                                             1: FixedColumnWidth(
//                                                 Responsive.isMobile(context)
//                                                     ? 120
//                                                     : 200),
//                                             2: FixedColumnWidth(
//                                                 Responsive.isMobile(context)
//                                                     ? 120
//                                                     : 200),
//                                           },
//                                           children: [
//                                             TableRow(
//                                               decoration: BoxDecoration(
//                                                 color: signUpTopFontcolor
//                                                     .withOpacity(0.8),
//                                                 border: Border(
//                                                   right: BorderSide
//                                                       .none, // Remove right border
//                                                 ),
//                                               ),
//                                               children: [
//                                                 TableCell(
//                                                   child: SizedBox(
//                                                     height: 40,
//                                                     child: Center(
//                                                       child: Text(
//                                                         "s.no".tr,
//                                                         style: mediumBlackTextStyle
//                                                             .copyWith(
//                                                                 fontSize: 16,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w700,
//                                                                 color:
//                                                                     signUpTopBarcolor),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                  TableCell(
//                                                     child: SizedBox(
//                                                       child: Text(commonEnglishName,
//                                                           style: mediumBlackTextStyle
//                                                               .copyWith(
//                                                                   fontSize: 16,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w700,
//                                                                   color:
//                                                                       signUpTopBarcolor)),
//                                                     ),
//                                                   ),
//                                                TableCell(
//                                                     child: SizedBox(
//                                                       child: Text(
//                                                           commonTamilName,
//                                                           style: mediumBlackTextStyle
//                                                               .copyWith(
//                                                                   fontSize: 16,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w700,
//                                                                   color:
//                                                                       signUpTopBarcolor)),
//                                                     ),
//                                                   ),
//                                               ],
//                                             ),
//                                             for (int index = pageNo * 10;
//                                                 index < (pageNo + 1) * 10 &&
//                                                     index <
//                                                         stateMasterList.length;
//                                                 index++)
//                                               TableRow(
//                                                 decoration: BoxDecoration(
//                                                   color: index.isOdd
//                                                       ? const Color.fromRGBO(
//                                                           255, 255, 255, 1)
//                                                       : const Color.fromRGBO(
//                                                           235, 239, 245, 1),
//                                                   border: Border(
//                                                     top: BorderSide(
//                                                       color: Color((math.Random()
//                                                                       .nextDouble() *
//                                                                   0xFFFFFF)
//                                                               .toInt())
//                                                           .withOpacity(1.0),
//                                                       width: 1.0,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 children: [
//                                                   TableCell(
//                                                     child: SizedBox(
//                                                       height: 50,
//                                                       child: Center(
//                                                         child: Text(
//                                                           (currentPage *
//                                                                       rowsPerPage +
//                                                                   index +
//                                                                   1)
//                                                               .toString(),
//                                                           style: TextStyle(
//                                                             color: notifire!
//                                                                 .getMainText,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   TableCell(
//                                                       child: Text(
//                                                         stateMasterList[index]
//                                                             .english,
//                                                         style: TextStyle(
//                                                           color: notifire!
//                                                               .getMainText,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                    TableCell(
//                                                       child: Text(
//                                                         stateMasterList[index]
//                                                             .tamil,
//                                                         style: TextStyle(
//                                                           color: notifire!
//                                                               .getMainText,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                 ],
//                                               ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                         const SizedBox(height: 8.0),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Expanded(
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 0),
//                                 child: Text(
//                                   ' ${(((currentPage) * (8)) + 1)}-${(currentPage + 1) * (8)} of $totalElements ',
//                                   style: TextStyle(
//                                     color: notifire!.getMainText,
//                                     fontSize: 12,
//                                   ),
//                                   textAlign: TextAlign.end,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Row(
//                                 // mainAxisSize: MainAxisSize.e,
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   currentPage > 0
//                                       ? IconButton(
//                                           onPressed: () {
//                                             setState(() {
//                                               showLoader = true;
//                                               currentPage--;
//                                               stateListData(
//                                                   rowsPerPage,
//                                                   currentPage,
//                                                   pageNo,
//                                                   searchText);
//                                             });
//                                           },
//                                           icon: Icon(Icons.chevron_left,
//                                               color: notifire!.getMainText),
//                                         )
//                                       : IconButton(
//                                           onPressed: () {},
//                                           icon: Icon(Icons.chevron_left,
//                                               color: darker.withOpacity(0.5)),
//                                         ),
//                                   Text("page".tr),
//                                   const SizedBox(width: 5.0),
//                                   Text("${currentPage + 1}"),
//                                   // Add some spacing between the arrows
//                                   (currentPage < totalPages - 1 &&
//                                           stateMasterList.isNotEmpty)
//                                       ? // Show the right arrow only if the condition is met
//                                       IconButton(
//                                           onPressed: () {
//                                             setState(() {
//                                               showLoader = true;
//                                               currentPage++;
//                                               stateListData(
//                                                   rowsPerPage,
//                                                   currentPage,
//                                                   pageNo,
//                                                   searchText);
//                                             });
//                                           },
//                                           icon: Icon(Icons.chevron_right,
//                                               color: notifire!.getMainText),
//                                         )
//                                       : IconButton(
//                                           onPressed: () {},
//                                           icon: Icon(Icons.chevron_right,
//                                               color: darker.withOpacity(0.5)),
//                                         ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//         ),
//       ),
//     );
//   }
//
//   _getAlertFontSize(BuildContext context) {
//     var currentLocale = Get.locale;
//     if (currentLocale?.languageCode == 'ta') {
//       // Font size for Tamil
//       return 12;
//     } else {
//       // Font size for English
//       return 16;
//     }
//   }
// }
//
// // class StateListData extends DataTableSource {
// //   List<StateList> stateMasterList = [];
// //   BuildContext context;
// //
// //   StateListData(this.stateMasterList, this.context);
// //
// //   @override
// //   DataRow? getRow(int index) {
// //     final dataIndex = index;
// //     if (dataIndex < stateMasterList.length) {
// //       final state = stateMasterList[dataIndex];
// //       return DataRow(
// //           color: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
// //
// //             return notifire!.getcontiner;
// //           }),
// //           cells: [
// //             DataCell(Text(state.id.toString(),style: TextStyle(color: notifire!.getMainText),)),
// //             DataCell(Text(state.english,style: TextStyle(color: notifire!.getMainText))),
// //             DataCell(Text(state.tamil,style: TextStyle(color: notifire!.getMainText))),
// //           ]);
// //     }
// //     return null; // Return null if dataIndex exceeds the length of stateData
// //   }
// //
// //   @override
// //   int get rowCount => stateMasterList.length;
// //
// //   @override
// //   bool get isRowCountApproximate => false;
// //
// //   @override
// //   int get selectedRowCount => 0;
// // }
