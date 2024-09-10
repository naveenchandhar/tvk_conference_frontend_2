import 'dart:async';
import 'dart:convert';
// import 'package:TamilgaVetriKalagam/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
// import 'package:TamilgaVetriKalagam/constants/i18n_en.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../appstaticdata/colorfile.dart';
import '../common/commonWidget/common_widgets.dart';
import '../main.dart';
import '../provider/provide_colors.dart';
import '../responsivePackage.dart';
import '../state/state_model.dart';
import '../state/state_service.dart';
import '../theme/color.dart';
import './district_list_master_model.dart';
import '../state/state_list_master_model.dart';
// import '../../Widgets/comuntitle.dart';
// import '../../Widgets/sizebox.dart';
import '../../appstaticdata/staticdata.dart';
// import '../../provider/proviercolors.dart';
import 'dart:math' as math;
import 'district_master_model.dart' as dMM;
import 'district_service.dart';
import 'district_validator.dart';

class DistrictPage extends StatefulWidget {
  const DistrictPage({Key? key}) : super(key: key);

  @override
  State<DistrictPage> createState() => _StateListPageState();
}

class _StateListPageState extends State<DistrictPage> {
  int pageNo = 0;
  int rowsPerPage = 8;
  int totalPages = 0;
  int totalElements = 0;
  int _stateId = 0;
  int _alertstateId = 0;
  FToast fToast = FToast();
  DistrictListMasterModel? districtDataFetched;
  StateListMaster? stateTotalDataFetched;
  List<DistrictList> districtMasterList = [];
  final _searchStateController = TextEditingController();
  final _searchAlertStateController = TextEditingController();
  final textController1 = TextEditingController();
  final textController2 = TextEditingController();
  dMM.Data singleDistrict = dMM.Data(id: 0);
  List<StateList> stateMasterList = [];
  final _formKey = GlobalKey<FormState>();
  final _deleteFormKey = GlobalKey<FormState>();
  String searchText = '';
  late StateDatum singleState;
  late StateDatum singleAlertState;
  String _stateSelection = "state".tr;
  String deleteText = "Are you sure you want to delete this district?".tr;
  String yes = "Yes".tr;
  String no = "No".tr;
  bool isDeleted = true;
  String englishName = "English".tr;
  String tamilName = "Tamil".tr;
  int currentPage = 0;
bool showLoader=true;
  var singleStateMaster;
  List<StateDatum> stateListBackendData = [];

  @override
  void initState() {
    super.initState();
    fToast.init(context);
    stateListData();
    districtListData(rowsPerPage, currentPage, searchText, _stateId.toString());
    getPageName();
  }

  getPageName() async {
    final SharedPreferences pref = await prefs;
    pref.setInt('navigatedPage', 6);
  }

  void districtListData(
      int rowsPerPage, int currentPage, searchText, String stateId) async {
    if (stateId == "0") {
      stateId = "";
    }
    await DistrictService.getDistrictListForModel(
            rowsPerPage, currentPage, stateId, searchText)
        .then((districtDataList) {
      districtDataFetched = districtDataList;
      districtMasterList = districtDataFetched!.districtList;
      totalPages = districtDataFetched!.totalPages!;
      totalElements = districtDataFetched!.totalElements!;
      showLoader=false;
      setState(() {});
    });
  }

  Future<void> stateListData() async {
    await StateService.getStateListFromBackEnd().then((returnValue) {
      stateListBackendData = returnValue;
      setState(() {
        // stateListBackendData;
        //districtListForState;
      });
    });
  }

  Future<void> deleteIssueType(BuildContext context3, int id) async {
    if (await DistrictService.districtDeleteService(id, fToast)) {
      String stateId = "";
      if (_stateId == 0) {
        stateId = "";
      } else {
        stateId = _stateId.toString();
      }
      await DistrictService.getDistrictListForModel(
              rowsPerPage, currentPage, stateId, searchText)
          .then((districtDataList) {
        districtDataFetched = districtDataList;
        districtMasterList = districtDataFetched!.districtList;
        totalPages = districtDataFetched!.totalPages!;
        totalElements = districtDataFetched!.totalElements!;
      });

      districtListData(rowsPerPage, currentPage,searchText,_stateId.toString());
      setState(() {});
    }
  }

  Future<void> saveDistrict(int stateId, String dstctEnglish, String dstctTamil,
      BuildContext context2) async {
    var body = jsonEncode({
      "stateId": stateId,
      "dstctEnglish": dstctEnglish,
      "dstctTamil": dstctTamil
    });
    if (await DistrictService.districtSaveService(body, fToast)) {
      setState(() {});
      Navigator.of(context).pop();
      navigateCallback();
    }
  }

  void navigateCallback() {
   // showLoader=false;
    Navigator.of(context).pop();
    // Assuming context is accessible in the calling context
  }

  Future<void> updateRegion(int stateId, String dstctEnglish, String dstctTamil,
      int id, BuildContext context, BuildContext context2) async {
    var body = jsonEncode({
      "stateId": stateId,
      "dstctEnglish": dstctEnglish,
      "id": id,
      "dstctTamil": dstctTamil
    });
    if (await DistrictService.districtUpdateService(body, fToast, id)) {
      Navigator.of(context).pop();
      setState(() {});
      navigateCallback();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorNotifire>(
      builder: (context, value, child) => Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: notifire!.getbgcolor,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SizedBox(
              height: constraints.maxWidth < 600 ? 900 : 1000,
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    // ComunTitle(
                    //     title: 'district_List'.tr, path: "master_screen".tr),
                    Padding(
                      padding:  const EdgeInsets.only(left: 15,right: 15),
                      child:  Container(
                        // color: Colors.blue,
                        height: 40,
                        child: Center(
                          child: Row(
                            mainAxisAlignment:Responsive.isMobile(context)? MainAxisAlignment.end: MainAxisAlignment.spaceBetween,
                            children: [
                              if(!Responsive.isMobile(context))
                              Flexible(
                                child: Wrap(
                                  runSpacing: 5,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {

                                      },
                                      child: SvgPicture.asset("assets/home.svg",height: constraints.maxWidth < 600 ? 14:16,width: constraints.maxWidth < 600 ? 14:16,color: notifire?.getMainText ),),
                                    Text('   /   ${"master_screen".tr}   /   ',style: mediumBlackTextStyle.copyWith(color: notifire?.getMainText,fontSize: constraints.maxWidth < 600 ? 12:14),overflow: TextOverflow.ellipsis),
                                    Text('district'.tr,style: mediumGreyTextStyle.copyWith(color: appMainColor,fontSize: constraints.maxWidth < 600 ? 12:14),overflow: TextOverflow.ellipsis),
                                  ],
                                ),
                              ),

                              Container(
                                // width: 100.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                 // color: signUpButtoncolor,
                                ),
                                child: ElevatedButton.icon(
                                  label: textWithLightShadow("create".tr),
                                  icon:  Icon(
                                    Icons.edit,
                                    color: signUpTopBarcolor,
                                    size: 20.0,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: signUpButtoncolor,
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
                                    _showCreatePopup(context, stateMasterList, 0);
                                  },
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),

                    _buildtable(width: constraints.maxWidth, context: context),
                    // _buildtable2(width: constraints.maxWidth),
                    const SizedBox(),
                    const SizedBox(height: 8.0),

                    // const ComunBottomBar(),
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
    double stateWidth;

    if (MediaQuery.of(context).size.width >= 630 &&
        MediaQuery.of(context).size.width <= 767) {
      stateWidth = MediaQuery.of(context).size.width / 3;
    } else if (MediaQuery.of(context).size.width < 350) {
      stateWidth = MediaQuery.of(context).size.width;
    } else {
      stateWidth = MediaQuery.of(context).size.width / 2;
    }
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              color: notifire!.getcontiner,
              boxShadow: boxShadow,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: padding, right: padding, bottom: padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Responsive.isMobile(context) && (MediaQuery.of(context).orientation==Orientation.portrait)
                      ? Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left:10.0,right:10.0,top:8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: Responsive.isDesktop(context)
                                ? MediaQuery.of(context).size.width / 3.8
                                : stateWidth,
                            //MediaQuery.of(context).size.width/8
                            height: 40.0,

                            child: SearchField(
                              suggestionState: Suggestion.expand,
                              suggestionAction: SuggestionAction.unfocus,
                              searchInputDecoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 30.0),
                                prefixIcon: const Icon(
                                    Icons.account_balance
                                ),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    _stateId = 0;
                                    _searchStateController.clear();
                                    currentPage = 0;
                                    districtListData(
                                        rowsPerPage,
                                        currentPage,
                                        searchText,
                                        _stateId.toString());
                                    setState(() {});
                                  },
                                  child: const Icon(
                                    Icons.clear,
                                  ),
                                ),
                              ),
                              suggestions: stateListBackendData
                                  .map((singleStateData) => SearchFieldListItem(
                                singleStateData.english,
                                item: singleStateData,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          singleStateData.english,
                                          overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                                  .toList(),
                              // textInputAction: TextInputAction.next,
                              controller: _searchStateController,
                              hint: "state".tr,
                              // initialValue: SearchFieldListItem(_suggestions[2], SizedBox()),
                              maxSuggestionsInViewPort: 6,
                              itemHeight: 45,
                              onSuggestionTap: (x) async {
                                singleState = x.item!;
                                _stateSelection = singleState.english;
                                _stateId = singleState.id;
                                districtListData(rowsPerPage, currentPage,
                                    searchText, _stateId.toString());
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
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
                                districtListData(rowsPerPage, currentPage,
                                    searchText, _stateId.toString());
                              },
                            ),
                          ),


                        ],
                      ),
                    ),
                  )
                      : Row(
                    children: [
                      SizedBox(
                        width: Responsive.isMobile(context)
                            ? MediaQuery.of(context).size.width / 3.6
                            :MediaQuery.of(context).size.width<800? MediaQuery.of(context).size.width /3:MediaQuery.of(context).size.width<1100?MediaQuery.of(context).size.width /3.5:MediaQuery.of(context).size.width /4.3, //MediaQuery.of(context).size.width/8
                        height: 55.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left:10.0,right:10.0,top:10.0),
                          child: SearchField(
                            suggestionState: Suggestion.expand,
                            suggestionAction: SuggestionAction.unfocus,
                            searchInputDecoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.8),
                                ),
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 30.0),
                              prefixIcon: const Icon(
                                  Icons.account_balance
                              ),
                              suffixIcon: InkWell(
                                onTap: () {
                                  _stateId = 0;
                                  _searchStateController.clear();
                                  currentPage = 0;
                                  districtListData(rowsPerPage, currentPage,
                                      searchText, _stateId.toString());
                                  setState(() {});
                                },
                                child: const Icon(
                                  Icons.clear,
                                ),
                              ),
                            ),
                            suggestions: stateListBackendData
                                .map((singleStateData) => SearchFieldListItem(
                              singleStateData.english,
                              item: singleStateData,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        singleStateData.english,
                                        overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                                .toList(),
                            // textInputAction: TextInputAction.next,
                            controller: _searchStateController,
                            hint: "state".tr,
                            // initialValue: SearchFieldListItem(_suggestions[2], SizedBox()),
                            maxSuggestionsInViewPort: 6,
                            itemHeight: 45,
                            onSuggestionTap: (x) async {
                              singleState = x.item!;
                              _stateSelection = singleState.english;
                              _stateId = singleState.id;
                              currentPage = 0;
                              districtListData(rowsPerPage, currentPage,
                                  searchText, _stateId.toString());
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                        width: Responsive.isMobile(context)
                            ? MediaQuery.of(context).size.width / 3.6
                            :MediaQuery.of(context).size.width<800? MediaQuery.of(context).size.width /3:MediaQuery.of(context).size.width<1100?MediaQuery.of(context).size.width /3.5:MediaQuery.of(context).size.width /4.3,
                        height: 55.0,
                        padding: const EdgeInsets.only(left:10.0,right:10.0,top:10.0),
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
                            // contentPadding: const EdgeInsets.symmetric(
                            //     vertical: 5.0, horizontal: 30.0),
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
                              borderSide:
                              BorderSide(width: 3, color: Colors.red),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 3,
                                color: Color.fromRGBO(255, 0, 0, 1),
                              ),
                            ),
                          ),
                          onChanged: (text) {
                            searchText = text;
                            currentPage = 0;
                            districtListData(rowsPerPage, currentPage,
                                searchText, _stateId.toString());
                          },
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey.shade300, height: 20),
                  showLoader?  SizedBox(
                    width: Responsive.isDesktop(context)
                        ? MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.width ,
                    height:MediaQuery.of(context).size.height / 2,
                    child: Center(
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          circularProgress(),

                        ],
                      ),
                    ),
                  ):
                  districtMasterList.isEmpty?  SizedBox(
                    // color: Colors.green,
                    width: Responsive.isDesktop(context)
                        ? MediaQuery.of(context).size.width
                        : MediaQuery.of(context).size.width ,
                    height:Responsive.isMobile(context)?MediaQuery.of(context).size.height / 5:MediaQuery.of(context).size.height / 2,
                    child: const Center(
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Text("No Data"),

                        ],
                      ),
                    ),
                  ): Container(
                          decoration: BoxDecoration(
                            //  color: appMainColor.withOpacity(0.8),
                              // borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: signUpTopFontcolor)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child:

                            Table(
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              // border: TableBorder.all(),
                              columnWidths: {
                                0: const FixedColumnWidth(80),
                                1: FixedColumnWidth(
                                    Responsive.isMobile(context) ? 130 : 200),
                                2: FixedColumnWidth(
                                    Responsive.isMobile(context) ? 170 : 200),
                                3: FixedColumnWidth(
                                    Responsive.isMobile(context) ? 130 : 200),
                                4: const FixedColumnWidth(100),
                              },
                              children: [
                                TableRow(
                                  decoration: BoxDecoration(
                                    color: signUpTopFontcolor.withOpacity(0.8),
                                    border: Border(
                                      right:
                                      BorderSide.none, // Remove right border
                                    ),
                                  ),
                                  children: [
                                    TableCell(
                                      child: SizedBox(
                                        height: 50,
                                        child: Center(
                                          child: Text(
                                            "s.no".tr,
                                            style:
                                                mediumBlackTextStyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: signUpTopBarcolor),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                        child: Text("Tamil Name",
                                            style:
                                                mediumBlackTextStyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: signUpTopBarcolor)),
                                      ),
                                    ),
                                    TableCell(
                                      child: SizedBox(
                                        child: Text("English Name",
                                            style:
                                                mediumBlackTextStyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: signUpTopBarcolor)),
                                      ),
                                    ),
                                    TableCell(
                                      child: Text('state'.tr,
                                          style: mediumBlackTextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: signUpTopBarcolor)),
                                    ),
                                    TableCell(
                                      child: Text('action'.tr,
                                          style: mediumBlackTextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: signUpTopBarcolor)),
                                    ),
                                  ],
                                ),
                                for (int index = 0;
                                    index < districtMasterList.length;
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
                                          child: Center(
                                            child: Text(
                                              (currentPage * rowsPerPage +
                                                      index +
                                                      1)
                                                  .toString(),
                                              style: TextStyle(
                                                color: notifire!.getMainText,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          districtMasterList[index]
                                              .dstctEnglish,
                                          style: TextStyle(
                                            color: notifire!.getMainText,
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          districtMasterList[index].dstctTamil,
                                          style: TextStyle(
                                            color: notifire!.getMainText,
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Text(
                                          districtMasterList[index]
                                              .mstState!
                                              .english
                                              .toString(),
                                          style: TextStyle(
                                            color: notifire!.getMainText,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.edit,
                                              color: appMainColor,
                                            ),
                                            onPressed: () {
                                              _showCreatePopup(
                                                  context,
                                                  stateMasterList,
                                                  districtMasterList[index].id);
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color:
                                                  actionColor.withOpacity(0.8),
                                            ),
                                            onPressed: () {
                                              deleteDataAlert(
                                                context,
                                                districtMasterList[index].id,
                                                deleteText,
                                                yes,
                                                "No".tr, // Provide the value for 'no' here
                                              );
                                            },
                                          ),
                                        ],
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
                            ' ${(((currentPage) * (8)) + 1)}-${(currentPage + 1) * (8)} of $totalElements ',
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
                          // mainAxisSize: MainAxisSize.e,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            currentPage > 0
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        currentPage--;
                                        districtListData(
                                            rowsPerPage,
                                            currentPage,
                                            searchText,
                                            _stateId.toString());
                                      });
                                    },
                                    icon: Icon(Icons.chevron_left,
                                        color: notifire!.getMainText),
                                  )
                                : IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.chevron_left,
                                        color: darker.withOpacity(0.5)),
                                  ),
                            Text("page".tr),
                            const SizedBox(width: 5.0),
                            Text('${currentPage + 1}'),
                            // Add some spacing between the arrows
                            (currentPage < totalPages - 1 &&
                                    districtMasterList.isNotEmpty)
                                ? // Show the right arrow only if the condition is met
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        currentPage++;
                                        districtListData(
                                            rowsPerPage,
                                            currentPage,
                                            searchText,
                                            _stateId.toString());
                                      });
                                    },
                                    icon: Icon(
                                      Icons.chevron_right,
                                      color: notifire!.getMainText,
                                    ),
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCreatePopup(
      BuildContext context, List<StateList> stateMasterList, int id) async {
    String state = "state".tr;
    String district = "District".tr;

    if (id > 0) {
      await DistrictService.districtDataByIdService(id)
          .then((singleDistrictData) async {
        singleDistrict = singleDistrictData;
        textController1.text = singleDistrict.dstctEnglish!;
        textController2.text = singleDistrict.dstctTamil!;
        _alertstateId = singleDistrict.stateId!;
        await StateService.stateDataByIdService(_alertstateId)
            .then((singleStateData) {
          singleStateMaster = singleStateData;
          _stateSelection = singleStateMaster.english!;
          _searchAlertStateController.text = singleStateMaster.english!;
          // _priorityTypeController.text=priority.priorityType;
        });
      });

      showIssueTypeAlert(context, stateMasterList, "commonEnglishName",
          "commonTamilName", state, district, singleDistrict);
    } else {
      textController1.clear();
      textController2.clear();
      _alertstateId = 0;
      _searchAlertStateController.clear();
      _stateSelection = "state".tr;
      dMM.Data singleDistrict = dMM.Data(id: 0);
      showIssueTypeAlert(context, stateMasterList, "commonEnglishName",
          "commonTamilName", state, district, singleDistrict);
    }
  }

  void showIssueTypeAlert(
      BuildContext context,
      List<StateList> stateMasterList,
      String englishName,
      String tamilName,
      String state,
      String district,
      dMM.Data singleDistrict) {
    showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        notifire = Provider.of<ColorNotifire>(context, listen: true);
        return StatefulBuilder(
          builder: (BuildContext context2, setState) {
            return AlertDialog(
              backgroundColor: notifire!.getcontiner,
              content: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Positioned(
                    right: -40.0,
                    top: -40.0,
                    child: InkResponse(
                      onTap: () {
                        Navigator.of(context).pop();
                        textController1.clear();
                        textController2.clear();
                        setState(() {});
                      },
                      child: CircleAvatar(
                        radius: 15.0,
                        child: Icon(Icons.close,color: signUpTopBarcolor,),
                        backgroundColor: signUpButtoncolor,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Text(
                            'District'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: notifire!
                                  .getTextColor1, // Change this color to your desired color
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 1,
                          // Adjust the height of the line as needed
                          width: double.infinity,
                          // Makes the line span the entire width of its parent
                          color: Colors
                              .black, // Change the color of the line as needed
                        ),
                        const SizedBox(height: 16),
                        Form(
                          key: _formKey,
                          child: Column(
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Icon(Icons.account_balance),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    Center(
                                      child: Container(
                                        color: notifire!.getcontiner,
                                        width: Responsive.isDesktop(context)
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                        child: SearchField(
                                          suggestionState: Suggestion.expand,
                                          suggestionAction:
                                              SuggestionAction.unfocus,
                                          searchInputDecoration:
                                              InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.black
                                                    .withOpacity(0.8),
                                              ),
                                            ),
                                            border: const OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 5.0,
                                                    horizontal: 10.0),
                                            suffixIcon: InkWell(
                                              onTap: () {
                                                _alertstateId = 0;
                                                _searchAlertStateController
                                                    .clear();

                                                setState(() {});
                                              },
                                              child: const Icon(
                                                Icons.clear,
                                              ),
                                            ),
                                          ),
                                          suggestions: stateListBackendData
                                              .map((singleStateData) => SearchFieldListItem(
                                            singleStateData.english,
                                            item: singleStateData,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child:
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      singleStateData.english,
                                                      overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ))
                                              .toList(),
                                          // textInputAction: TextInputAction.next,
                                          controller:
                                              _searchAlertStateController,
                                          hint: "state".tr,
                                          validator: (value) {
                                            // if( widget.projectId!= 0) {
                                            //   value = IssueType(id: 0, name: '', description: '',);
                                            // }
                                            // value=_stateApprovedMember;
                                            if (value == "" ||
                                                value == null ||
                                                value == "state".tr) {
                                              return "Please_select_State".tr;
                                            }
                                            return null;
                                          },
                                          // initialValue: SearchFieldListItem(_suggestions[2], SizedBox()),
                                          maxSuggestionsInViewPort: 6,
                                          itemHeight: 45,
                                          onSuggestionTap: (x) async {
                                            singleAlertState =
                                                x.item!;
                                            _stateSelection =
                                                singleAlertState.english;
                                            _alertstateId = singleAlertState.id;
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ),
                                  ]),
                              const SizedBox(height: 20),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      'assets/En.svg',
                                      // Replace 'assets/En.svg' with your SVG file path
                                      width: 24,
                                      height: 24,
                                    ),
                                    // Icon(const IconData(0xe366, fontFamily: 'MaterialIcons'),size:20, color: notifire!.getMainText,),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    SizedBox(
                                      width: Responsive.isDesktop(context)
                                          ? MediaQuery.of(context).size.width /
                                              4
                                          : MediaQuery.of(context).size.width /
                                              2,
                                      child: TextFormField(
                                        onTap: () {},
                                        // controller: productResponse.id == null ?
                                        controller: textController1,
                                        // : productEditValue(productResponse.productName.toString()),
                                        validator: (value) => Validator
                                            .validateDistrictEnglishName(
                                                englishName: value!),
                                        decoration:
                                            inputDecorationWidget(englishName),
                                        style: TextStyle(
                                          color: notifire!
                                              .getMainText, // Use the color from the notifier directly
                                        ),
                                      ),
                                    ),
                                  ]),
                              const SizedBox(height: 20),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      'assets/Tamil_icon.svg',
                                      width: 24,
                                      height: 24,
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    SizedBox(
                                      width: Responsive.isDesktop(context)
                                          ? MediaQuery.of(context).size.width /
                                              4
                                          : MediaQuery.of(context).size.width /
                                              2,
                                      child: TextFormField(
                                        onTap: () {},
                                        // controller: productResponse.id == null ?
                                        controller: textController2,
                                        // : productEditValue(productResponse.productName.toString()),
                                        validator: (value) =>
                                            Validator.validateDistrictTamilName(
                                                tamilName: value!),
                                        decoration:
                                            inputDecorationWidget(tamilName),
                                        style: TextStyle(
                                          color: notifire!
                                              .getMainText, // Use the color from the notifier directly
                                        ),
                                      ),
                                    ),
                                  ]),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    // width: 100.0,
                                    height: 30.0,
                                    decoration: BoxDecoration(

                                    ),
                                    child: ElevatedButton(
                                      child: Text("Submit".tr, style: TextStyle(
                                        color: signUpTopBarcolor,
                                      )),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: signUpButtoncolor,
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
                                        if (_formKey.currentState!.validate()) {
                                          _showLoader(context2);
                                          if (singleDistrict.id == 0) {
                                            await saveDistrict(
                                                _alertstateId,
                                                textController1.text,
                                                textController2.text,
                                                context);
                                            _stateId = 0;
                                            districtListData(
                                                rowsPerPage,
                                                currentPage,
                                                searchText,
                                                _stateId.toString());
                                          } else {
                                            await updateRegion(
                                                _alertstateId,
                                                textController1.text,
                                                textController2.text,
                                                singleDistrict.id,
                                                context,
                                                context);
                                            _stateId = 0;
                                            districtListData(
                                                rowsPerPage,
                                                currentPage,
                                                searchText,
                                                _stateId.toString());
                                          }
                                        }
                                      },

                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void deleteDataAlert(
      BuildContext context, int id, String s, String t, String u) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: notifire!.getcontiner,
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      radius: 15.0,
                      child: Icon(Icons.close,color: signUpTopBarcolor,),
                      backgroundColor: signUpButtoncolor,
                    ),
                  ),
                ),
                Form(
                  key: _deleteFormKey,
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: 300,
                      height: 120,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Flexible(
                            child: Text(
                              "delete_district".tr,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: notifire!.getMainText,
                                fontSize: 15.0,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 35,
                                width: 100,
                                decoration: BoxDecoration(
                                    // color: Colors.yellowAccent,
                                    borderRadius: BorderRadius.circular(25)),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    deleteIssueType(context, id);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        signUpButtoncolor),
                                  ),
                                  child: Text(
                                    "yes".tr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: signUpTopBarcolor,
                                        fontSize: 14.0,
                                        fontStyle: FontStyle.normal),
                                  ),
                                ),
                              ),
                              Container(
                                height: 35,
                                width: 100,
                                decoration: BoxDecoration(
                                    // color: Colors.yellowAccent,
                                    borderRadius: BorderRadius.circular(25)),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        signUpButtoncolor),
                                  ),
                                  child: Text(
                                    'no'.tr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: signUpTopBarcolor,
                                        fontSize: 14.0,
                                        fontStyle: FontStyle.normal),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget textWithLightShadow(String title) {
    return Text(
      title,
      style:  TextStyle(
        fontWeight: FontWeight.w400,
        color: signUpTopBarcolor,
        fontSize: 10.0,
        fontStyle: FontStyle.normal,
        decoration: TextDecoration.none,
        shadows: const [
          Shadow(
            blurRadius: 1.0,
            color: shadowColor,
            offset: Offset(0.5, 0.5),
          ),
        ],
      ),
    );
  }

  _showLoader(BuildContext context) {
    // setState(() {
    //   showLoader = true;
    // });

    // Show the dialog
    showDialog(
      context: context,
      barrierDismissible: false, // prevents the user from dismissing the dialog
      builder: (BuildContext context) {
        // Close the dialog after 3 seconds
        // Future.delayed(Duration(seconds: 3), () {
        //   if (mounted) {
        //     // Ensure that the widget is still mounted before calling setState
        //     setState(() {
        //       showLoader = false;
        //     });
        //     Navigator.of(context).pop(); // Close the dialog
        //   }
        // });

        return AlertDialog(
          elevation: 0.0, // This makes the dialog fully transparent
          backgroundColor: Colors.transparent,
          content: Center(
            child:Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    // strokeWidth: 5.0, // Optional: Adjust the thickness of the progress indicator
                  ),
                ),
                // Adjust the size and position of the image widget as needed
                Positioned(
                  width: 60, // Adjust the width as needed
                  height: 60,
                  child: Image.asset("assets/img/tvk-logo-new.png",
                    fit: BoxFit.fill,), // Adjust the height as needed
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
