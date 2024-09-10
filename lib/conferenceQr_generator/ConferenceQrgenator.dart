import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
import 'package:tvk_maanadu/Conference/ConferenceService.dart';
import "package:universal_html/html.dart"as html;


import '../Toast_message/toast_message.dart';
import '../assembly/assembly_constituency_list_model.dart';
import '../assembly/assembly_constituency_service.dart';
import '../district/district_service.dart';
import '../main.dart';
import '../provider/provide_colors.dart';
import '../responsivePackage.dart';
import '../state/state_model.dart';
import '../state/state_service.dart';
import '../district/district_list_model.dart' as dId;
import '../theme/color.dart';
import "package:http/http.dart" as http;

class Conferenceqrgenator extends StatefulWidget {
  final int id; // Define a final field for the ID

  const Conferenceqrgenator( this.id,{super.key});

  @override
  State<Conferenceqrgenator> createState() => _ConferenceqrgenatorState();
}

class _ConferenceqrgenatorState extends State<Conferenceqrgenator> {

  final _searchAlertStateController = TextEditingController();
  final _searchAlertDistrictController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _venueAddress1Controller = TextEditingController();
  final TextEditingController _venueAddress2Controller = TextEditingController();
  TextEditingController male_count_Controller = TextEditingController();
  TextEditingController female_count_Controller = TextEditingController();
  TextEditingController _CreaterNameController = TextEditingController();
  TextEditingController _MobileNOController = TextEditingController();

  int _stateAlertId = 0;
  int _districtAlertId = 0;
  int _assemblyAlertId = 0;
  var currentLocale = Get.locale;

  final _searchVenueStateController = TextEditingController();
  final _searchVenueAlertStateController = TextEditingController();
  final _searchVenueAlertDistrictController = TextEditingController();
  final _searchVenueAlertAssemblyController = TextEditingController();

  int _stateVenueAlertId = 0;
  int _districtVenueAlertId = 0;
  int _assemblyVenueAlertId = 0;

  bool showTextboxes = false;

  List<StateDatum> stateMasterList = [];
  List<dId.Datum> districtListData = [];
  late StateDatum singleState;
  late dId.Datum districtData;
  late StateDatum singleAlertState;
  late dId.Datum districtAlertData;
  late CAssemblyDatum singleAssemblyListData;
  List<CAssemblyDatum> assemblyList = [];

  String _stateSelection = "state".tr;
  String _districtSelection = "district".tr;
  String _districtSelectionSearch = "selectDistrict";
  String _assemblySelection = "Select Assembly";
  FToast fToast = FToast();
  @override
  void initState() {
    super.initState();
    fToast.init(context);
    // regionListData(
    //     row, pageNo, _stateId.toString(), _districtId.toString(), searchText);
    stateListData();
  }


  Future<void> stateListData() async {
    await StateService.getStateListFromBackEnd_tweedle().then((returnValue) {
      stateMasterList = returnValue;
      setState(() {

      });
    });
  }
  Future<List<dId.Datum>> getDistrict(int stateId) async {
    // districtListData=
    await DistrictService.getDistrictList(stateId).then((backendData) {
      districtListData = backendData;
    });
    return districtListData;
  }

  fetchAssemblyList(district) async {
    assemblyList =
    await AssemblyService.getAssemblyTotalListByDistrict(district);
    return assemblyList;
  }

  // void downloadExcel(bodyBytes, String fileName,BuildContext context, FToast fToast) async {
  //   // List<int> bytes = base64.decode(base64String);
  //   // await Permission.storage.request();
  //   String path = await ExternalPath.getExternalStoragePublicDirectory(
  //       ExternalPath.DIRECTORY_DOWNLOADS);
  //   // final dir= Directory(path);
  //   // final l = dir.listSync();
  //   // for( final d in l){
  //   //   try{
  //   //     final  str = await File("${d.path}/info.json").readAsString(); // 2. permission error here
  //   //   }catch(e){
  //   //   }
  //   // }
  //   String filePath = path + '/$fileName';
  //   File file = File(filePath);
  //   await OpenFilex.open(filePath);
  //   // showSuccessToast("${
  //   //     "File"
  //   // } as ${fileName}",fToast);
  //   await file.writeAsBytes(bodyBytes);
  //
  //   // snackBar(context,
  //   //     title: 'File downloaded successfully',
  //   //     backgroundColor: black,
  //   //     textColor: white);
  // }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Consumer<ColorNotifire>(
      builder: (context, value, child) => Container(
        height: screenHeight,
        width: screenWidth,
        color: value.getbgcolor,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SizedBox(
              // height: constraints.maxWidth < 600 ? 900 : 1000,
              // width: constraints.maxWidth < 600
              //     ? screenWidth / 2
              //     : double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: isMobile ? 15 : 15, right: 15),
                      child: Column(
                        children: [
                          // Container(
                          //   height: 40,
                          //   child: Center(
                          //     child: Row(
                          //       mainAxisAlignment: isMobile
                          //           ? MainAxisAlignment.end
                          //           : MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         if (!isMobile)
                          //           Flexible(
                          //             child: Wrap(
                          //               runSpacing: 5,
                          //               crossAxisAlignment: WrapCrossAlignment.center,
                          //               children: [
                          //                 InkWell(
                          //                   onTap: () {},
                          //                   child: SvgPicture.asset(
                          //                     "assets/home.svg",
                          //                     height: screenWidth < 600 ? 14 : 16,
                          //                     width: screenWidth < 600 ? 14 : 16,
                          //                     color: value.getMainText,
                          //                   ),
                          //                 ),
                          //                 Text(
                          //                   '   /   ',
                          //                   style: TextStyle(
                          //                     color: value.getMainText,
                          //                     fontSize: screenWidth < 600 ? 12 : 14,
                          //                   ),
                          //                   overflow: TextOverflow.ellipsis,
                          //                 ),
                          //                 Text(
                          //                   '${"Create_Conference".tr}',
                          //                   style: TextStyle(
                          //                     color: Colors.blue,
                          //                     fontSize: screenWidth < 600 ? 12 : 14,
                          //                   ),
                          //                   overflow: TextOverflow.ellipsis,
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         Container(
                          //           height: 30.0,
                          //           decoration: BoxDecoration(
                          //             color: Colors.red,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          SingleChildScrollView(
                            child: buildMainContainer(context,isMobile,isPortrait),
                          ),
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
  Container buildMainContainer(BuildContext context, bool isMobile, bool isPortrait) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blue, // Set border color here
          width: 1.0, // Set border width here
        ),
        borderRadius: BorderRadius.circular(10.0), // Set border radius here
      ),
      child: Column(
        children: [
          Container(
            width: !kIsWeb
                ? isPortrait
                ? MediaQuery.of(context).size.width * 0.9
                : MediaQuery.of(context).size.width * 0.45
                : MediaQuery.of(context).size.width * 0.25,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    _buildTextFieldWithIcon(
                      controller: _CreaterNameController,
                      labelText: 'Creater_Name'.tr,
                      icon: Icons.event,
                      errtext: "Creater_NameValidation".tr,
                    ),
                    const SizedBox(height: 12),
                    _buildMobNoTextFieldWithIcon(
                      controller: _MobileNOController,
                      labelText: 'Mobile_Number'.tr,
                      icon: Icons.phone,
                      errtext: "Mobile_Number_Validation".tr,
                    ),
                    const SizedBox(height: 12),
                    SearchField(
                      suggestionState: Suggestion.expand,
                      suggestionAction: SuggestionAction.unfocus,
                      searchInputDecoration: InputDecoration(
                        labelText: 'state'.tr,

                        hintText: "Please_select_State".tr,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: lightblue, width: 3.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.red, width: 3.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 16.0),
                        // Increased vertical padding
                        suffixIcon: InkWell(
                          onTap: () {
                            _stateAlertId = 0;
                            _districtAlertId = 0;
                            _searchAlertDistrictController.clear();
                            districtListData.clear();
                            _searchAlertStateController.clear();
                            assemblyList.clear();
                            _assemblyAlertId = 0;
                            _searchVenueAlertAssemblyController.clear();
                            setState(() {});
                          },
                          child: const Icon(Icons.clear),
                        ),
                        prefixIcon:
                        Icon(Icons.account_balance), // <-- Add prefix icon here
                      ),
                      suggestions: stateMasterList
                          .map((singleStateData) => SearchFieldListItem(
                        singleStateData.english,
                        item: singleStateData,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  singleStateData.english,
                                  overflow: TextOverflow
                                      .ellipsis, // Add ellipsis if text overflows
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                          .toList(),
                      controller: _searchAlertStateController,
                      hint: "state".tr,
                      validator: (value) {
                        if (value == "" || value == null || value == "state".tr) {
                          return "Please_select_State".tr;
                        }
                        return null;
                      },
                      maxSuggestionsInViewPort: 6,
                      itemHeight: 45,
                      // Adjusted height for suggestions
                      onSuggestionTap: (x) async {
                        singleAlertState = x.item!;
                        _stateSelection = singleAlertState.english;
                        _stateAlertId = singleAlertState.id;
                        _searchAlertDistrictController.clear();
                        districtListData.clear();
                        _districtSelectionSearch = "district".tr;
                        districtListData = await getDistrict(_stateAlertId);
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 12),
                    SearchField(
                      suggestionState: Suggestion.expand,
                      suggestionAction: SuggestionAction.unfocus,
                      searchInputDecoration: InputDecoration(
                        labelText: 'district'.tr,
                        hintText: "Please_select_District".tr,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: lightblue, width: 3.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.red, width: 3.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 16.0),  // Increased vertical padding
                        suffixIcon: InkWell(
                          onTap: () {
                            _districtAlertId = 0;
                            _searchAlertDistrictController.clear();
                            assemblyList.clear();
                            _assemblyAlertId = 0;
                            _searchVenueAlertAssemblyController.clear();
                            setState(() {});
                          },
                          child: const Icon(Icons.clear),
                        ),
                        prefixIcon: Icon(
                          Icons.castle,
                        ), // Prefix icon here
                      ),

                      // [Change: Making suggestions horizontally scrollable]
                      suggestions: districtListData
                          .map((singleDistrictData) => SearchFieldListItem(
                        singleDistrictData.dstctEnglish,
                        item: singleDistrictData,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                Text(singleDistrictData.dstctEnglish),
                              ],
                            ),
                          ),
                        ),
                      ))
                          .toList(),

                      controller: _searchAlertDistrictController,
                      hint: "district".tr,

                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Please_select_District".tr;
                        }
                        return null;
                      },

                      maxSuggestionsInViewPort: 6,  // Max number of suggestions visible at once
                      itemHeight: 45,  // Keeps the height of each suggestion item

                      onSuggestionTap: (x) async {
                        districtAlertData = x.item as dId.Datum;
                        _districtSelectionSearch = districtAlertData.dstctEnglish;
                        _districtAlertId = districtAlertData.id;
                        _searchVenueAlertAssemblyController.clear();
                        assemblyList.clear();
                        assemblyList = await fetchAssemblyList(_districtAlertId);
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      child: SearchField(
                        suggestionState: Suggestion.expand,
                        suggestionAction: SuggestionAction.unfocus,
                        searchInputDecoration: InputDecoration(
                          labelText: 'Assembly'.tr,
                          hintText: "Please_select_Assembly".tr,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(color: lightblue, width: 3.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide(color: Colors.red, width: 3.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 16.0), // Increased vertical padding
                          suffixIcon: InkWell(
                            onTap: () {
                              _assemblyAlertId = 0;
                              _searchVenueAlertAssemblyController.clear();
                              setState(() {});
                            },
                            child: const Icon(Icons.clear),
                          ),
                          prefixIcon: const Icon(Icons.castle), // Prefix icon here
                        ),
                        suggestions: assemblyList
                            .map((singleDistrictData) => SearchFieldListItem(
                          singleDistrictData.english!,
                          item: singleDistrictData,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,  // Enables horizontal scrolling
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Text(singleDistrictData.english!),
                                ],
                              ),
                            ),
                          ),
                        ))
                            .toList(),
                        controller: _searchVenueAlertAssemblyController,
                        hint: "Venue assembly".tr,
                        validator: (value) {
                          if (value == "" || value == null) {
                            return "Please_select_Assembly".tr;
                          }
                          return null;
                        },
                        maxSuggestionsInViewPort: 6,  // Limit the number of visible suggestions
                        itemHeight: 45,  // Set the item height
                        onSuggestionTap: (x) async {
                          singleAssemblyListData = x.item as CAssemblyDatum;
                          _assemblySelection = singleAssemblyListData.english!;
                          _assemblyAlertId = singleAssemblyListData.id!;

                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildNumTextFieldWithIcon(
                      controller: male_count_Controller,
                      labelText: 'malecount'.tr,
                      icon: Icons.people,
                      errtext: "malecountValidation".tr,
                    ),
                    const SizedBox(height: 12),
                    _buildNumTextFieldWithIcon(
                      controller: female_count_Controller,
                      labelText: 'femalecount'.tr,
                      icon: Icons.people,
                      errtext: "femalecountValidation".tr,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // const SizedBox(height: 10),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: SizedBox(
                  width: currentLocale?.languageCode == 'ta' ?180 :150, // Set the desired width
                  height: 45, // Set the desired height
                  child: buildSubmitElevatedButton(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  ElevatedButton buildSubmitElevatedButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          // Validate and submit form logic
          if (_formKey.currentState!.validate()) {
            Map<String, dynamic> jsonData = {
              'state_id': _stateAlertId!,
              'district_id': _districtAlertId!,
              'assembly_id': _assemblyAlertId!,
              'name': _CreaterNameController.text,
              'mobile_no': _MobileNOController.text!,
              'male_count': male_count_Controller.text!,
              'female_count': female_count_Controller.text!,
              "conference_id":widget.id
            };
            Map<String, dynamic> cardValue = {
              'state': _searchAlertStateController.text!,
              'district': _searchAlertDistrictController.text!,
              'assembly': _searchVenueAlertAssemblyController.text!
            };

            _showLoader(context);
            await ConferenceService().generateImage(jsonData, fToast,cardValue).then((_) {
              // showSuccessToast("Downloaded successfully", fToast);
            });
            Navigator.of(context).pop();
            setState(() {});
            // resetForm();
          }
        },
        child: Text('Submit'.tr, style: TextStyle(fontSize: 16)));
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
            child: Stack(
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
                  child: Image.asset(
                    "assets/img/tvk-logo-new.png",
                    fit: BoxFit.fill,
                  ), // Adjust the height as needed
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void resetForm() {
    // _eventNameController.clear();
    // _eventTypeController.clear();
    showTextboxes = false;
    // event_people_allowed_Controller.clear();
    // _selectedDate = null;
    // _selectedFromTime = null;
    _searchAlertStateController.clear();
    _searchAlertDistrictController.clear();
    _venueAddress1Controller.clear();
    _venueAddress2Controller.clear();
    _searchVenueAlertStateController.clear();
    _searchVenueAlertDistrictController.clear();
    setState(() {}); // Update the UI to reflect the changes
  }
  Widget _buildNumTextFieldWithIcon({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    int? maxLines,
    int? maxLength,
    bool? enabled,
    String? errtext,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      enabled: enabled ?? true,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errtext;
        }
        return null;
      },
    );
  }

  Widget _buildTextFieldWithIcon({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    int? maxLines,
    int? maxLength,
    bool? enabled,
    String? errtext,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      enabled: enabled ?? true,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errtext;
        }
        return null;
      },
    );
  }

  Widget _buildMobNoTextFieldWithIcon({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    int? maxLines,
    int? maxLength,
    bool? enabled,
    String? errtext,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      keyboardType: TextInputType.phone,  // Only accept phone numbers
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,  // Only allow digits
        LengthLimitingTextInputFormatter(10),    // Limit to 10 digits
      ],
      enabled: enabled ?? true,
      maxLines: maxLines ?? 1,
      maxLength: maxLength ?? 10,  // Ensure max length is 10
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errtext;
        }
        if (value.length != 10) {
          return 'Please enter a valid 10-digit mobile number';
        }
        return null;
      },
    );
  }

}
