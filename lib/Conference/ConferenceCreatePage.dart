import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../district/district_service.dart';
import '../main.dart';
// import '../provider/proviercolors.dart';
import '../provider/provide_colors.dart';
import '../responsivePackage.dart';
// import '../state/state_model.dart';
import '../district/district_list_model.dart' as dId;

import '../state/state_model.dart';
import '../state/state_service.dart';
import '../staticdata.dart';
import '../theme/color.dart';
import 'ConferenceService.dart';

class ConferenceCreatePage extends StatefulWidget {
  const ConferenceCreatePage({super.key});

  @override
  State<ConferenceCreatePage> createState() => _ConferenceCreatePageState();
}

class _ConferenceCreatePageState extends State<ConferenceCreatePage> {
  TextEditingController event_people_allowed_Controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _eventNameController = TextEditingController();

  final TextEditingController _eventTypeController = TextEditingController();

  final TextEditingController _venueAddress1Controller = TextEditingController();
  final TextEditingController _venueAddress2Controller = TextEditingController();

  final _searchStateController = TextEditingController();
  final _searchAlertStateController = TextEditingController();
  final _searchAlertDistrictController = TextEditingController();

  int _stateAlertId = 0;
  int _districtAlertId = 0;
  var currentLocale = Get.locale;

  final _searchVenueStateController = TextEditingController();
  final _searchVenueAlertStateController = TextEditingController();
  final _searchVenueAlertDistrictController = TextEditingController();

  int _stateVenueAlertId = 0;
  int _districtVenueAlertId = 0;

  bool showTextboxes = false;

  List<StateDatum> stateMasterList = [];
  List<dId.Datum> districtListData = [];
  late StateDatum singleState;
  late dId.Datum districtData;
  late StateDatum singleAlertState;
  late dId.Datum districtAlertData;

  String _approvalStatus = 'No';




    String _stateSelection = "state".tr;
  String _districtSelection = "district".tr;
  String _districtSelectionSearch = "selectDistrict";

  String? _type;
  String? _state;
  String? _district;
  String? _venueState;
  String? _venueDistrict;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  //

  // DateTime? _selectedDate;
  TimeOfDay? _selectedFromTime;
  TimeOfDay? _selectedToTime;

  final Map<String, dynamic> conferenceTypes = {
    "Open to All": 1,
    "Registration Required": 2,
  };

  // List<String> eventTypes = ['Open to All', 'Registration Required'];
  String selectedEventType = '';
  bool _isDropdownError = false;
  FToast fToast = FToast();
  // List<Sch.Datum>? schoolList = [];
  // File? _selectedImage;

  @override
  void initState() {
    super.initState();
    fToast.init(context);
    // regionListData(
    //     row, pageNo, _stateId.toString(), _districtId.toString(), searchText);
    stateListData();
    getPageName();
  }
  getPageName() async {
    final SharedPreferences pref = await prefs;
    pref.setInt('navigatedPage', 30);
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      contentPadding: EdgeInsets.symmetric(
        vertical: 16.0, // Decrease the vertical padding
        horizontal: 10.0,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
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
  void _handleRadioValueChange(String? value) {
    setState(() {
      _approvalStatus = value!;
    });
  }


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
              height: constraints.maxWidth < 600 ? 900 : 1000,
              width: constraints.maxWidth < 600
                  ? screenWidth / 2
                  : double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: isMobile ? 15 : 15, right: 15),
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: isMobile
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.spaceBetween,
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
                    _buildTextFieldWithIcon(
                      controller: _eventNameController,
                      labelText: 'EnterName'.tr,
                      icon: Icons.event,
                      errtext: "nameValidation".tr,
                    ),
                    const SizedBox(height: 4),
                    _buildSearchableDropdown(
                      labelText: 'Event_type'.tr,
                      hintText: 'Event_type'.tr,
                      eventTypes: conferenceTypes,
                      // Ensure it's a list of strings
                      controller: _eventTypeController,
                      onChanged: (value) {
                        // Handle the selected event type
                        print('Selected event type: $value');
                      },
                      isError: false,
                      context: context,
                      errtext: "typeValidation".tr,
                    ),
                    if (showTextboxes) const SizedBox(height: 4),
                    if (showTextboxes)
                      _buildNumTextFieldWithIcon(
                        controller: event_people_allowed_Controller,
                        labelText: 'No_people_allowed'.tr,
                        icon: Icons.people,
                        errtext: "no_PeopleValidation".tr,
                      ),
                    if (showTextboxes) const SizedBox(height: 10),
                    if (showTextboxes)
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          'approvalRequired'.tr,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    if (showTextboxes) const SizedBox(height: 4),
                    if (showTextboxes)
                      Row(
                        children: [
                          Radio<String>(
                            value: 'yes'.tr,
                            groupValue: _approvalStatus,
                            onChanged: _handleRadioValueChange,
                          ),
                          Text('yes'.tr),
                          SizedBox(width: 20),
                          Radio<String>(
                            value: 'no'.tr,
                            groupValue: _approvalStatus,
                            onChanged: _handleRadioValueChange,
                          ),
                          Text('no'.tr),
                        ],
                      ),
                    _buildDateTimePickers(),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTimePicker(
                            labelText: 'time'.tr,
                            controller: TextEditingController(
                                text: _selectedFromTime?.format(context) ?? ''),
                            icon: Icons.access_time,
                            onTap: () => _selectFromTime(context),
                            errText: "time_Validation".tr,
                          ),
                        ),
                      ],
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
                            vertical: 20.0, horizontal: 16.0),
                        // Increased vertical padding
                        suffixIcon: InkWell(
                          onTap: () {
                            _districtAlertId = 0;

                            _searchAlertDistrictController.clear();

                            setState(() {});
                          },
                          child: const Icon(
                            Icons.clear,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.castle,
                        ), // <-- Add prefix icon here
                      ),
                      suggestions: districtListData
                          .map((singleDistrictData) => SearchFieldListItem(
                                singleDistrictData.dstctEnglish,
                                item: singleDistrictData,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(singleDistrictData.dstctEnglish),
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                      // textInputAction: TextInputAction.next,
                      controller: _searchAlertDistrictController,
                      hint: "district".tr,
                      //_districtSelectionSearch,
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Please_select_District".tr;
                        }
                        return null;
                      },
                      maxSuggestionsInViewPort: 6,
                      itemHeight: 45,
                      onSuggestionTap: (x) async {
                        districtAlertData = x.item as dId.Datum;
                        _districtSelectionSearch = districtAlertData.dstctEnglish;
                        _districtAlertId = districtAlertData.id;

                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildTextFieldWithIcon(
                      controller: _venueAddress1Controller,
                      labelText: 'venue_Address1'.tr,
                      icon: Icons.event,
                      errtext: 'venue_Add1Validation'.tr,
                    ),
                    const SizedBox(height: 12),
                    _buildTextFieldWithIcon(
                      controller: _venueAddress2Controller,
                      labelText: 'venue_Address2'.tr,
                      icon: Icons.event,
                      errtext: 'venue_Add2Validation'.tr,
                    ),
                    const SizedBox(height: 12),
                    SearchField(
                      suggestionState: Suggestion.expand,
                      suggestionAction: SuggestionAction.unfocus,
                      searchInputDecoration: InputDecoration(
                        labelText: 'Venue state'.tr,

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
                            _stateVenueAlertId = 0;
                            _districtVenueAlertId = 0;
                            _searchVenueAlertDistrictController.clear();
                            districtListData.clear();
                            _searchVenueAlertStateController.clear();
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
                      controller: _searchVenueAlertStateController,
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
                        _stateVenueAlertId = singleAlertState.id;
                        _searchVenueAlertDistrictController.clear();
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
                        labelText: 'Venue district'.tr,
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
                            vertical: 20.0, horizontal: 16.0),
                        // Increased vertical padding
                        suffixIcon: InkWell(
                          onTap: () {
                            _districtAlertId = 0;

                            _searchVenueAlertDistrictController.clear();

                            setState(() {});
                          },
                          child: const Icon(
                            Icons.clear,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.castle,
                        ), // <-- Add prefix icon here
                      ),
                      suggestions: districtListData
                          .map((singleDistrictData) => SearchFieldListItem(
                                singleDistrictData.dstctEnglish,
                                item: singleDistrictData,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(singleDistrictData.dstctEnglish),
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                      // textInputAction: TextInputAction.next,
                      controller: _searchVenueAlertDistrictController,
                      hint: "Venue district".tr,
                      //_districtSelectionSearch,
                      validator: (value) {
                        if (value == "" || value == null) {
                          return "Please_select_District".tr;
                        }
                        return null;
                      },
                      maxSuggestionsInViewPort: 6,
                      itemHeight: 45,
                      onSuggestionTap: (x) async {
                        districtAlertData = x.item as dId.Datum;
                        _districtSelectionSearch = districtAlertData.dstctEnglish;
                        _districtVenueAlertId = districtAlertData.id;

                        setState(() {});
                      },
                    ),

                  ],
                ),
              ),
            ),
          ),
          // const SizedBox(height: 10),
          kIsWeb ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: currentLocale?.languageCode == 'ta' ?180 :150, // Set the desired width
                  height: 40, // Set the desired height
                  child: buildSubmitElevatedButton(context),
                ),
              ),
              SizedBox(width: 10,),
              Center(
                child: SizedBox(
                  width: currentLocale?.languageCode == 'ta' ?180 :150, // Set the desired width
                  height: 40, // Set the desired height
                  child: buildViewElevatedButton(),
                ),
              ),
            ],
          ) : Column(
            children: [
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
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: SizedBox(
                      width: currentLocale?.languageCode == 'ta' ?180 :150, // Set the desired width
                      height: 45, // Set the desired height
                      child: buildViewElevatedButton(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  ElevatedButton buildViewElevatedButton() {
    return ElevatedButton(
      onPressed: () {
        Get.find<AppConst>().changePage(2);
      },
      child: Text('view'.tr, style: TextStyle(fontSize: 16)),
    );
  }

  ElevatedButton buildSubmitElevatedButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          // Validate and submit form logic
          if (_formKey.currentState!.validate()) {
            Map<String, dynamic> jsonData = {
              "name": _eventNameController.text,
              "type": _eventTypeController.text,
              "no_people_allowed": event_people_allowed_Controller.text,
              "approvel_required": _approvalStatus,
              "venue_address1": _venueAddress1Controller.text ?? '',
              "venue_address2": _venueAddress2Controller.text ?? '',
              "date": _selectedDate?.toString() ?? '',
              "start_time": _selectedFromTime?.format(context) ?? '',
              "state_id": _stateAlertId,
              "district_id": _districtAlertId,
              "venue_state_id": _stateVenueAlertId,
              "venue_district_id": _districtVenueAlertId,
            };
            ConferenceService().saveConference(jsonData, fToast);
            resetForm();
            setState(() {});
          }
        },
        child: Text('Submit'.tr, style: TextStyle(fontSize: 16)));
  }

  void resetForm() {
    _eventNameController.clear();
    _eventTypeController.clear();
    showTextboxes = false;
    event_people_allowed_Controller.clear();
    _selectedDate = null;
    _selectedFromTime = null;
    _searchAlertStateController.clear();
    _searchAlertDistrictController.clear();
    _venueAddress1Controller.clear();
    _venueAddress2Controller.clear();
    _searchVenueAlertStateController.clear();
    _searchVenueAlertDistrictController.clear();
    setState(() {}); // Update the UI to reflect the changes
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

  Widget _buildTimePicker({
    required String labelText,
    required TextEditingController controller,
    required IconData icon,
    required void Function() onTap,
    String? errText,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      onTap: () {
        onTap();
      },
      readOnly: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errText;
        }
        return null;
      },
    );
  }

  Widget _buildSearchableDropdown({
    required String labelText,
    required String hintText,
    required Map<String, dynamic> eventTypes,
    required TextEditingController controller,
    required ValueChanged<String?> onChanged,
    required bool isError,
    required BuildContext context,
    String? errtext,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SearchField<String>(
            controller: controller,
            suggestions: eventTypes.keys
                .map((type) => SearchFieldListItem<String>(
              type,
              item: type,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    // const SizedBox(width: 10),
                    // const Icon(Icons.event),
                    // const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        type,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ))
                .toList(),
            hint: hintText,
            searchInputDecoration: InputDecoration(
              labelText: labelText,
              hintText: hintText,
              suffixIcon: InkWell(
                onTap: () {
                  _eventTypeController.clear();
                  showTextboxes = false;
                  _approvalStatus = 'No';
                  setState(() {});
                },
                child: const Icon(Icons.clear),
              ),
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(
                  color: isError ? Colors.red : Colors.grey,
                ),
              ),
              errorText: isError ? errtext : null,
            ),
            maxSuggestionsInViewPort: 5,
            itemHeight: 45,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return errtext;
              }
              return null;
            },
            onSuggestionTap: (suggestion) {
              if (suggestion is SearchFieldListItem<String>) {
                onChanged(suggestion.item!);
              }
              if (suggestion.item! == "Registration Required") {
                showTextboxes = true;
              }else{
                showTextboxes = false;
                _approvalStatus = 'No';
                event_people_allowed_Controller.text=0.toString();
              }
              setState(() {});
              // Close the dropdown programmatically
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimePickers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: _buildTextFieldWithIcon(
                  controller: TextEditingController(
                    text: _selectedDate != null
                        ? "${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}"
                        : '', // Handle null case here
                  ),
                  labelText: 'conference_Date'.tr,
                  icon: Icons.calendar_today,
                  errtext: "con_Date_Validation".tr),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year, 6, 1),
      lastDate: DateTime(DateTime.now().year + 1, 5, 31),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectFromTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedFromTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedFromTime) {
      setState(() {
        _selectedFromTime = picked;
      });
    }
  }

  Future<void> _selectToTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedToTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedToTime) {
      setState(() {
        _selectedToTime = picked;
      });
    }
  }
}
