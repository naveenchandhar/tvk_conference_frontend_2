// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:math';


import 'package:auto_size_text/auto_size_text.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart' hide Trans;
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:io' as io;
import 'dart:io' show File, Platform;

import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



import '../Toast_message/toast_message.dart';
import '../appstaticdata/colorfile.dart';
import '../appstaticdata/routes.dart';
import '../appstaticdata/staticdata.dart';
import '../common/commonWidget/common_widgets.dart';

import '../controller.dart';
import '../controllers/languages.dart';

import '../drawer_signIn.dart';
import '../homepage.dart';
import '../main.dart';
import '../provider/provide_colors.dart';
import '../responsivePackage.dart';

import '../staticdata.dart';
import '../theme/color.dart';

// import'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

import '../widgets/signIn_titleBar.dart';
import 'singnup_service.dart';
import 'user_data_received_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
  final _phoneNoController = TextEditingController();
  final _passwordController = TextEditingController();
  FToast fToast = FToast();
  final _formKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final _alertFormKey = GlobalKey<FormState>();
  final _mobileFormKey = GlobalKey<FormState>();
  final _voterIdController = TextEditingController();
  final FocusNode focusNodeVoterId = FocusNode();
  final _mobNoController = TextEditingController();
  final FocusNode focusNodeMobNo = FocusNode();
  final _nameController = TextEditingController();
  final FocusNode focusNodeName = FocusNode();
  final _fatherNameController = TextEditingController();
  final FocusNode focusNodeFatherName = FocusNode();
  final _dobController = TextEditingController();
  final _dobController2 = TextEditingController();
  final FocusNode focusNodeDob = FocusNode();
  final _districtController = TextEditingController();
  final FocusNode focusNodeDistrict = FocusNode();
  final _constituencyController = TextEditingController();
  final FocusNode focusNodeConstituency = FocusNode();
  final _parliamentConstituencyController = TextEditingController();
  final FocusNode focusNodeParliamentConstituency = FocusNode();
  final _userPhoneNoController = TextEditingController();
  final FocusNode focusNodePhoneNo = FocusNode();
  final _password1Controller = TextEditingController();
  final FocusNode focusPassword1 = FocusNode();
  final _occupationController = TextEditingController();
  final FocusNode focusOccupation = FocusNode();
  final _addressController = TextEditingController();
  final FocusNode focusAddress = FocusNode();
  final _mailIdController = TextEditingController();
  final FocusNode focusNodeMailId = FocusNode();
  final _otpController = TextEditingController();
  final FocusNode focusNodeOtp = FocusNode();
  final _userPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final FocusNode focusNodePassword = FocusNode();
  bool showOtp = false;
  bool otpReceived = true;
  FilePickerResult? result;
  FilePickerResult? result1;
  FilePickerResult? result2;
  String profileImg = "";
  String aadharfrontImg = "";
  String aadharbackImg = "";

  bool imgChngFlg1 = false;
  bool imgChngFlg2 = false;
  bool imgChngFlg3 = false;
  bool _profileCameraClicked = false;
  CroppedFile? _croppedFile;
  dynamic _pickImageError;
  List<XFile>? _imageFileList;
  late io.File file;
  final ImagePicker _picker = ImagePicker();
  String fileName = "";

  bool _imageSelected = false;
  bool _image2Selected = false;
  bool _image3Selected = false;
  bool correctEpicNo = false;
  bool showOtpButton = false;
  bool showUserData = false;
  bool submitClicked = false;
  bool submitButtonClicked = false;
  bool optSent = false;
  // VoterModel voterData = VoterModel();
  // ErrorModel errorModelData = ErrorModel();
  int voterMasterId = 0;
  String gender='';
  int partNo=0;
  int districtId = 0;
  int assemblyConstituencyId = 0;
  int parlimentaryConstituencyId = 0;
  int stateId = 0;
  int occupationId = 0;
  // List<OccupationModel> _totalOccupationData = [];
  // late OccupationModel occupationData;
  String _occupationSelection = "Occupation";
  // late OtpReceivedModel otpReceivedData;
  // late OtpReceivedModel newUserOtpReceived;
  // int memberId = 0;
  int backendOtp = 0;
  int backendNewUserOtp = 0;
  bool _obscureTextPassword = true;
  bool _signInObscureTextPassword = true;
  DateTime? date;
  DateTime birthDate = DateTime.now();
  DateTime now = DateTime.now();
  bool isSwitched = false;
  ColorNotifire notifire = ColorNotifire();
  bool _checkBoxClicked = true;
  late TabController _tabController;
  int signInFirstWidget = 1;
  final FocusNode signInPhoneNo = FocusNode();
  final _alertPasswordFormKey = GlobalKey<FormState>();
  final _signInPasswordController = TextEditingController();
  final _signInPassword2Controller = TextEditingController();
  final FocusNode focusNodeSignInPassword = FocusNode();
  final FocusNode focusNodeSignInConfirmPassword = FocusNode();
  bool _obscureSignInTextPassword = true;
  bool _obscureSignInConfirmTextPassword = true;
  final _signInOtpController = TextEditingController();
  final FocusNode signInPhoneNoNode = FocusNode();
  final FocusNode signInRawPhoneNoNode = FocusNode();
  final _alertIdcardFormKey = GlobalKey<FormState>();
  final FocusNode signInAlertRawPhoneNoNode = FocusNode();
  // late FaceDetector faceDetector;
  // List<Face> faces=[];
  String? deviceId;
  bool forgotPasswordClicked=false;
  String? url="";
  String imageName="";
  bool showInCorrectButton = false;
  Timer? _timer;
  int _start = 10;
  bool showTimeRow=true;
  final StreamController<StreamData> _events = StreamController<StreamData>.broadcast();
  Stream<StreamData> get events => _events.stream;
  bool showResentOtp=false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
    _tabController.addListener(_resetTextFields);
    // if(Get.locale!.languageCode == 'ta')
    //   isSwitched=true;
    // getOccupationList();
    fToast.init(context);
    //To hide android default buttons
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    // final options = FaceDetectorOptions(performanceMode: FaceDetectorMode.accurate);
    // faceDetector = FaceDetector(options: options);
    // ServicesBinding.instance.keyboard.addHandler(_onKey);
    if(!kIsWeb){
      _checkFirstInstall();
    }
    // _events = new StreamController<int>();
    // _events.add(10);
    getPageRouter();
  }

  getPageRouter() async {
    final SharedPreferences pref = await prefs;
    pref.setString('currentRoute', Routes.signup);
  }

  // void startTimer() {
  //   const oneSec = Duration(seconds: 1);
  //   _timer = Timer.periodic(
  //     oneSec,
  //         (timer) {
  //       if (_start < 1) {
  //         showTimeRow=false;
  //         showResentOtp=true;
  //         setState(() {
  //           timer.cancel();
  //         });
  //         final newData = StreamData(_start, showTimeRow,showResentOtp);
  //         addEventToStream(newData);
  //       } else {
  //         setState(() {
  //           showResentOtp=false;
  //           _start--;
  //         });
  //         if(_start==0){
  //           showTimeRow=false;
  //           showResentOtp=true;
  //         }
  //         final newData = StreamData(_start, showTimeRow,showResentOtp);
  //         addEventToStream(newData);
  //         // addEventToStream(_start);
  //       }
  //     },
  //   );
  // }

  Future<String?> _getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
    }
    return deviceId;
  }

  Future<void> _checkFirstInstall() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstInstall = prefs.getBool('first_install') ?? true;

    if (isFirstInstall) {
      String? deviceId1 = await _getDeviceId();
      bool deviceExists = prefs.containsKey(deviceId1!);
      if (!deviceExists) {
        // if(isPledgeView!=true)
        //   await showMobileDialog();
        prefs.setBool(deviceId1, true);
      }
      prefs.setBool('first_install', false);
    }
  }

  // bool _onKey(KeyEvent event) {
  //   final key = event.logicalKey.keyLabel;
  //   if (event is KeyDownEvent) {
  //     if (signInFirstWidget == 1) {
  //       if (key == "Tab") {
  //         if (_phoneNoController.text == "") {
  //           showFailureToast("Please, Enter Phone Number", fToast);
  //         } else {
  //           findAdminCreatedUser(_phoneNoController.text);
  //           setState(() {});
  //         }
  //       }
  //     }
  //     setState(() {});
  //   }
  //
  //   return false;
  // }

  void _resetTextFields() {
    _phoneNoController.clear();
    _passwordController.clear();
    _voterIdController.clear();
    setState(() {
      showUserData = false;
      correctEpicNo = false;
      showOtpButton = false;
      showInCorrectButton=false;
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_resetTextFields);
    _tabController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(LocaleCont());
    return SafeArea(
      child: WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: Scaffold(
          drawer: LayoutBuilder(
            builder: (context, constraints) {
              if ((Responsive.isTab(context) || Responsive.screenOrientation(context) == Orientation.landscape) || kIsWeb) {
                return const Drawer(width: 260, child: DarwerSignInCode());
              } else {
                return Container();
              }
            },
          ),

          body: Consumer<ColorNotifire>(
            builder: (context, value, child) => Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.red,
                  child: DefaultTabController(
                    length: 2,
                    initialIndex: 0,
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        if (constraints.maxWidth < 600) {
                          // Mobile layout
                          return Container(
                            // color:   Colors.green,                     //notifire?.getbgcolor,
                            //notifire?.getbgcolor,
                            // height: 600,
                            width: double.infinity,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SignInTitleBar(
                                    title: 'Checkout',
                                    path: "E-Commerce",
                                    tabController: _tabController,
                                  ),
                                  // const SignInTitleBar(title: 'Checkout', path: "E-Commerce"),
                                  _buildlogin(width: constraints.maxWidth)
                                ],
                              ),
                            ),
                          );
                        }
                      //  else if ((constraints.maxWidth < 1200 && kIsWeb)||(MediaQuery.of(context).orientation == Orientation.landscape)) {
                        else if (constraints.maxWidth < 1200 && kIsWeb) {
                          return Container(
                            // color: Colors.cyan,
                            // color: constraints.maxWidth < 860
                            //     ? notifire?.getbgcolor
                            //     : notifire?.getprimerycolor,
                            // height: 1100,
                            width: double.infinity,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SignInTitleBar(
                                    title: 'Checkout',
                                    path: "E-Commerce",
                                    tabController: _tabController,
                                  ),

                                  constraints.maxWidth < 860
                                      ?(MediaQuery.of(context).orientation == Orientation.landscape)? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0),
                                    child: _buildlogin(
                                        width: constraints.maxWidth),
                                  ):
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 80),
                                    child: _buildlogin(
                                        width: constraints.maxWidth),
                                  )
                                      : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 19, vertical: 80),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 782,
                                              decoration: BoxDecoration(
                                                color: notifire?.getbgcolor,
                                                borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(
                                                        37)),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: _buildlogin(
                                                        width: constraints
                                                            .maxWidth),
                                                  ),
                                                  Expanded(
                                                    child: buildqrcode(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                        else if (constraints.maxWidth < 1200) {
                          return Container(

                            // color: Colors.yellow,
                            // color: constraints.maxWidth < 860
                            //     ? notifire?.getbgcolor
                            //     : notifire?.getprimerycolor,
                            height: 1000,
                            width: double.infinity,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                               //   if ((constraints.maxWidth < 900))
                                  SignInTitleBar(
                                    title: 'Checkout',
                                    path: "E-Commerce",
                                    tabController: _tabController,
                                  ),
                                  constraints.maxWidth < 860
                                      ?(MediaQuery.of(context).orientation == Orientation.landscape)? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0),
                                    child: _buildlogin(
                                        width: constraints.maxWidth),
                                  ):
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 80),
                                    child: _buildlogin(
                                        width: constraints.maxWidth),
                                  )
                                      : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 19, vertical: 80),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 782,
                                              decoration: BoxDecoration(
                                                color: notifire?.getbgcolor,
                                                borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(
                                                        37)),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: _buildlogin(
                                                        width: constraints
                                                            .maxWidth),
                                                  ),
                                                  Expanded(
                                                    child: buildqrcode(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                        else {
                          // Website layout
                          return Container(
                            // color: Colors.pinkAccent,
                            height: double.infinity,
                            width: double.infinity,
                            // color: Colors.green,
                            child: Column(
                              children: [
                                SignInTitleBar(
                                  title: 'Checkout',
                                  path: "E-Commerce",
                                  tabController: _tabController,
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 800,
                                                  decoration: BoxDecoration(
                                                    color: bgcolor,
                                                    borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(37)),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: _buildlogin(
                                                            width:
                                                            constraints.maxWidth),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        children: [
                                                          buildqrcode(),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildlogin({required double width}) {
    return Padding(
        padding: width < 860 && (MediaQuery.of(context).orientation == Orientation.landscape)?
        EdgeInsets.symmetric(horizontal: 15, vertical: 10):EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Container(
          height: Responsive.isMobile(context)
              ? MediaQuery.of(context).size.height
              : 1500,
          decoration: const BoxDecoration(
            color:    light,
            // color: notifire?.getprimerycolor,
            borderRadius: BorderRadius.all(Radius.circular(37)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width < 600 ? 20 : 30.0,
              // vertical: width < 600 ? 40 : 50.0
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height:width < 860 && (MediaQuery.of(context).orientation == Orientation.landscape) ? 50: 110,
                  // color: Colors.lightBlueAccent,
                  child: TabBarView(controller: _tabController, children: [
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('welcome'.tr,
                            style: mainTextStyle.copyWith(
                                overflow: TextOverflow.ellipsis,
                                color: signUpTextFontcolor),
                            maxLines: 2),

                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'commonCreateYourAccount'.tr,
                          style: mainTextStyle.copyWith(
                              overflow: TextOverflow.ellipsis,
                              color: signUpTextFontcolor),
                          maxLines: 2,
                        ),

                      ],
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 21,
                ),
                (Responsive.screenWidth(context) < 900)
                    ?(Responsive.screenOrientation(context) ==
                    Orientation.landscape)? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      width: 220,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: signUpTopBarcolor, //signUpTopBarcolor
                          borderRadius: BorderRadius.circular(20)),
                      child: TabBar(
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: signUpTopFontcolor,
                          ),
                          dividerColor: Colors.transparent,
                          unselectedLabelColor: notifire.getMainText,
                          controller: _tabController,
                          tabs: [
                            Text('commonLoginTamilMobile'.tr,
                                style: TextStyle(
                                    color: textwhite,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14)),

                          ]),

                    ),
                   if((Responsive.screenWidth(context) < 768)||(Responsive.screenWidth(context) > 898))
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        //     if (isSwitched == true) {
                        //       Get.updateLocale(const Locale('ta', 'IN'));
                        //       // notifire.setLocale(true);
                        //     } else {
                        //       // notifire.setLocale(false);
                        //       //
                        //       Get.updateLocale(const Locale('en', 'US'));
                        //     }
                        //   },
                        // ),
                      ],
                    ),
                  ],
                ):
                ((Responsive.screenWidth(context) > 680)&& (Responsive.screenWidth(context) < 900))?
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      width: 220,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: signUpTopBarcolor, //signUpTopBarcolor
                          borderRadius: BorderRadius.circular(20)),
                      child: TabBar(
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: signUpTopFontcolor,
                          ),
                          dividerColor: Colors.transparent,
                          unselectedLabelColor: notifire.getMainText,
                          controller: _tabController,
                          tabs: [
                            Text('commonLoginTamilMobile'.tr,
                                style: TextStyle(
                                    color: textwhite,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14)),

                          ]),
                    ),

                  ],
                ):
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      width: 220,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: signUpTopBarcolor, //signUpTopBarcolor
                          borderRadius: BorderRadius.circular(20)),
                      child: TabBar(
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: signUpTopFontcolor,
                          ),
                          dividerColor: Colors.transparent,
                          unselectedLabelColor: notifire.getMainText,
                          controller: _tabController,
                          tabs: [
                            Text('commonLoginTamilMobile'.tr,
                                style: TextStyle(
                                    color: textwhite,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14)),

                          ]),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: <Widget>[
                    //     FlutterSwitch(
                    //       activeText: commonTamil,
                    //       inactiveText: commonEnglish,
                    //       value: isSwitched,
                    //       valueFontSize: 10.0,
                    //       width: 55,
                    //       borderRadius: 30.0,
                    //       activeColor: Colors.blue,
                    //       inactiveColor: Colors.blue,
                    //       showOnOff: true,
                    //       onToggle: (val) {
                    //         setState(() {
                    //           isSwitched = val;
                    //         });
                    //         if (isSwitched == true) {
                    //           Get.updateLocale(const Locale('ta', 'IN'));
                    //           // notifire.setLocale(true);
                    //         } else {
                    //           // notifire.setLocale(false);
                    //           //
                    //           Get.updateLocale(const Locale('en', 'US'));
                    //         }
                    //       },
                    //     ),
                    //   ],
                    // ),
                  ],
                ):
                (((Responsive.screenWidth(context) < 1200) &&
                    !(Responsive.screenOrientation(context) ==
                        Orientation.landscape)) &&
                    !kIsWeb)
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      width: 260,
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color:
                          signUpTopBarcolor, //signUpTopBarcolor
                          borderRadius: BorderRadius.circular(20)),
                      child: TabBar(
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: signUpTopFontcolor,
                          ),
                          dividerColor: Colors.transparent,
                          unselectedLabelColor: notifire.getMainText,
                          controller: _tabController,
                          tabs: [
                            Text('commonLoginTamilMobile'.tr,
                                style: TextStyle(
                                    color: textwhite,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14)),

                          ]),
                    ),
                    // Row(
                    //   mainAxisAlignment:
                    //   MainAxisAlignment.spaceBetween,
                    //   children: <Widget>[
                    //     FlutterSwitch(
                    //       activeText: commonTamil,
                    //       inactiveText: commonEnglish,
                    //       value: isSwitched,
                    //       valueFontSize: 10.0,
                    //       width: 55,
                    //       borderRadius: 30.0,
                    //       activeColor: Colors.blue,
                    //       inactiveColor: Colors.blue,
                    //       showOnOff: true,
                    //       onToggle: (val) {
                    //         setState(() {
                    //           isSwitched = val;
                    //         });
                    //         if (isSwitched == true) {
                    //           Get.updateLocale(
                    //               const Locale('ta', 'IN'));
                    //           // notifire.setLocale(true);
                    //         } else {
                    //           // notifire.setLocale(false);
                    //           //
                    //           Get.updateLocale(
                    //               const Locale('en', 'US'));
                    //         }
                    //       },
                    //     ),
                    //   ],
                    // ),
                    // if(((Responsive.screenWidth(context)< 1000)&&(Responsive.screenOrientation(context) ==
                    //     Orientation.landscape)) && !kIsWeb)
                    //   Container(
                    //     height: 50,
                    //     width: 260,
                    //     padding: const EdgeInsets.all(6),
                    //     decoration: BoxDecoration(
                    //         color: signUpTopBarcolor, //signUpTopBarcolor
                    //         borderRadius: BorderRadius.circular(20)),
                    //     child: TabBar(
                    //         indicator: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(14),
                    //           color: signUpTopFontcolor,
                    //         ),
                    //         dividerColor: Colors.transparent,
                    //         unselectedLabelColor: notifire.getMainText,
                    //         tabs: [
                    //           Text('commonLoginTamil'.tr,
                    //               style: TextStyle(
                    //                   color: textwhite,
                    //                   fontWeight: FontWeight.w400,
                    //                   fontSize: 14)),
                    //           Text('SignUp'.tr,
                    //               style: TextStyle(
                    //                   color: textwhite,
                    //                   fontWeight: FontWeight.w400,
                    //                   fontSize: 14)),
                    //         ]),
                    //   ),
                    //   Padding(
                    //     padding: const EdgeInsets.only(left: 25.0,right: 25.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: <Widget>[
                    //         FlutterSwitch(
                    //           activeText: commonTamil,
                    //           inactiveText: commonEnglish,
                    //           value: isSwitched,
                    //           valueFontSize: 10.0,
                    //           width: 55,
                    //           borderRadius: 30.0,
                    //           activeColor: Colors.blue,
                    //           inactiveColor:Colors.blue,
                    //           showOnOff: true,
                    //           onToggle: (val) {
                    //             setState(() {
                    //               isSwitched = val;
                    //             });
                    //             if (isSwitched == true) {
                    //               Get.updateLocale(const Locale('ta', 'IN'));
                    //               // notifire.setLocale(true);
                    //             } else {
                    //               // notifire.setLocale(false);
                    //               //
                    //               Get.updateLocale(const Locale('en', 'US'));
                    //             }
                    //           },
                    //         ),
                    //
                    //       ],
                    //     ),
                    //   ),
                  ],
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // if(((Responsive.screenWidth(context)< 1000)&&(Responsive.screenOrientation(context) ==
                    //     Orientation.landscape)) && !kIsWeb)
                    Container(
                      height: 50,
                      // width: 250,
                      width: MediaQuery.of(context).size.width * 0.2, // Adjust the factor as needed
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color:
                          signUpTopBarcolor, //signUpTopBarcolor
                          borderRadius: BorderRadius.circular(20)),
                      child: TabBar(
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: signUpTopFontcolor,
                          ),
                          dividerColor: Colors.transparent,
                          unselectedLabelColor: notifire.getMainText,
                          controller: _tabController,
                          tabs: [
                            (Responsive.screenWidth(context) > 900)&& (Responsive.screenWidth(context) <= 1265)?
                            Text('commonLoginTamilMobile'.tr,
                                style: TextStyle(
                                    color: textwhite,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14)):Text('commonLoginTamil'.tr,
                                style: TextStyle(
                                    color: textwhite,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14)),
                            Text('SignUp'.tr,
                                style: TextStyle(
                                    color: textwhite,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14)),
                          ]),
                    ),

                    if (Responsive.screenWidth(context) < 1200)
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 25.0, right: 5.0),
                        // child: Row(
                        //   mainAxisAlignment:
                        //   MainAxisAlignment.spaceEvenly,
                        //   children: <Widget>[
                        //     FlutterSwitch(
                        //       activeText: commonTamil,
                        //       inactiveText: commonEnglish,
                        //       value: isSwitched,
                        //       valueFontSize: 10.0,
                        //       width: 55,
                        //       borderRadius: 30.0,
                        //       activeColor: Colors.blue,
                        //       inactiveColor: Colors.blue,
                        //       showOnOff: true,
                        //       onToggle: (val) {
                        //         setState(() {
                        //           isSwitched = val;
                        //         });
                        //         if (isSwitched == true) {
                        //           Get.updateLocale(
                        //               const Locale('ta', 'IN'));
                        //           // notifire.setLocale(true);
                        //         } else {
                        //           // notifire.setLocale(false);
                        //           //
                        //           Get.updateLocale(
                        //               const Locale('en', 'US'));
                        //         }
                        //       },
                        //     ),
                        //   ],
                        // ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 26.8,
                ),
                // languageChooser(),
                Flexible(
                  child: TabBarView(controller: _tabController, children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35.0, right: 35.0),
                        child: Form(
                          key: _signInFormKey,
                          child: FocusTraversalGroup(
                            policy: OrderedTraversalPolicy(),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "phoneNo".tr,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: signUpTextFontcolor),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                RawKeyboardListener(
                                  focusNode: signInRawPhoneNoNode,
                                  onKey: (event) {
                                    if (event.isKeyPressed(LogicalKeyboardKey.tab)) {
                                      if (_phoneNoController.text == "") {
                                        showFailureToast("Please, Enter Phone Number", fToast);
                                                } else {

                                        // _showLoader(context);
                                        //           findAdminCreatedUser(_phoneNoController.text);
                                                  setState(() {});
                                                }
                                    }
                                  },

                                  child: TextFormField(
                                    // focusNode: signInPhoneNoNode,
                                    controller: _phoneNoController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      LengthLimitingTextInputFormatter(10),
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'phone No can\'t be empty';
                                      } else if (value.length < 10) {
                                        return 'Atleast 10 numbers needed';
                                      }

                                      return null;
                                    },
                                    onTap: () {
                                      signInFirstWidget = 1;
                                      setState(() {});
                                    },
                                    onFieldSubmitted: (value) async {
                                      if (value == "" || value == null) {
                                        showFailureToast(
                                            "Please, Enter Phone Number", fToast);
                                      } else {
                                        // _showLoader(context);
                                        // findAdminCreatedUser(
                                        //     _phoneNoController.text);
                                      }
                                      // loginUser(_phoneNoController.text,
                                      //     _passwordController.text, context);
                                      // setState(() {});
                                    },
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25),
                                          borderSide: const BorderSide(
                                            // color: notifire!.isDark
                                            //     ? notifire!.geticoncolor
                                            //     : Colors.grey.shade200
                                          )),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25),
                                          borderSide: const BorderSide(
                                            // color: notifire!.isDark
                                            //     ? notifire!.geticoncolor
                                            //     : Colors.grey.shade200
                                          )),
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 5.0, horizontal: 10.0),
                                      hintText: "phoneNo".tr,
                                      hintStyle: const TextStyle(
                                          fontFamily: 'WorkSansSemiBold',
                                          fontSize: 16.0),
                                      prefixIcon: SizedBox(
                                        height: 20,
                                        width: 50,
                                        child: Center(
                                            child: SvgPicture.asset(
                                              "assets/phone-number.svg",
                                              height: 18,
                                              width: 18,
                                              // color: notifire!.geticoncolor,
                                            )),
                                      ),
                                      suffixIcon: SizedBox(
                                        height: 20,
                                        width: 50,
                                        child: Center(
                                            child: SvgPicture.asset(
                                              "assets/octagon-check.svg",
                                              height: 18,
                                              width: 18,
                                              // color: notifire!.geticoncolor,
                                            )),
                                      ),
                                    ),
                                    // onSubmitted: (_) {
                                    //   _toggleSignInButton();
                                    // },
                                    textInputAction: TextInputAction.go,
                                  ),
                                ),

                                // buildTextFilde(
                                //     hinttext: "phoneNo".tr,
                                //     prefixicon: "assets/phone-number.svg",
                                //     suffixistrue: true,
                                //     suffix: 'assets/octagon-check.svg',
                                //     controller: _phoneNoController),
                                const SizedBox(
                                  height: 19.8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "password".tr,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: signUpTextFontcolor),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  // focusNode: focusNodePassword,
                                  controller: _passwordController,

                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Password can't be empty";
                                    } else if (value.length < 5) {
                                      return 'must be greater than 5';
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    signInFirstWidget = 2;
                                    setState(() {});
                                  },
                                  obscureText: _signInObscureTextPassword,
                                  // style: const TextStyle(
                                  //     fontFamily: 'WorkSansSemiBold',
                                  //     fontSize: 16.0,
                                  //     color: backGround),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: const BorderSide(
                                          // color: notifire!.isDark
                                          //     ? notifire!.geticoncolor
                                          //     : Colors.grey.shade200
                                        )),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: const BorderSide(
                                          // color: notifire!.isDark
                                          //     ? notifire!.geticoncolor
                                          //     : Colors.grey.shade200
                                        )),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 10.0),
                                    hintText: "password".tr,
                                    hintStyle: const TextStyle(
                                        fontFamily: 'WorkSansSemiBold',
                                        fontSize: 16.0),
                                    prefixIcon: SizedBox(
                                      height: 20,
                                      width: 50,
                                      child: Center(
                                          child: SvgPicture.asset(
                                            "assets/keyboard-with-cable.svg",
                                            height: 18,
                                            width: 18,
                                            // color: notifire!.geticoncolor,
                                          )),
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: _toggleSignIn,
                                      child: Icon(
                                        _signInObscureTextPassword
                                            ? FontAwesomeIcons.eyeSlash
                                            : FontAwesomeIcons.eye,
                                        size: 15.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  // onSubmitted: (_) {
                                  //   _toggleSignInButton();
                                  // },
                                  textInputAction: TextInputAction.go,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                kIsWeb
                                    ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0,
                                      bottom: 10.0,
                                      left: 5.0,
                                      right: 0.0),
                                  child: Row(
                                    children: <Widget>[
                                      const SizedBox(
                                        width: 10,
                                      ), //SizedBox

                                      Checkbox(
                                          value: _checkBoxClicked,
                                          onChanged:
                                          _afternoonOutdoorChanged),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            showMobileDialog();
                                          },
                                          child: Text(
                                            "common_agree_to_terms".tr,
                                            style: TextStyle(
                                                fontSize:
                                                Responsive.isDesktop(
                                                    context)
                                                    ? 14
                                                    : 16,
                                                color:
                                                signUpTextFontcolor,
                                                overflow: TextOverflow
                                                    .ellipsis),
                                            overflow:
                                            TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ), //Checkbox
                                    ], //<Widget>[]
                                  ),
                                )
                                    : Row(
                                  children: <Widget>[
                                    Checkbox(
                                        value: _checkBoxClicked,
                                        onChanged:
                                        _afternoonOutdoorChanged),

                                    Container(
                                      width: Responsive.isDesktop(context)? 300: Responsive.isMobile(context) ?MediaQuery.sizeOf(context).width>650 ?300: 170 :200,
                                      // color: Colors.green,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                showMobileDialog();
                                              },
                                              child: Text(
                                                "common_agree_to_terms"
                                                    .tr,
                                                style: TextStyle(
                                                    fontSize: Responsive
                                                        .isDesktop(
                                                        context)
                                                        ? 14
                                                        : 16,
                                                    color:
                                                    signUpTextFontcolor,
                                                    overflow: TextOverflow
                                                        .ellipsis),
                                                overflow:
                                                TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ), //Checkbox
                                  ], //<Widget>[]
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      if (_checkBoxClicked == false) {
                                        showFailureToast(
                                            "common_click_terms".tr, fToast);
                                        return;
                                      }
                                      if (_signInFormKey.currentState!
                                          .validate()) {
                                        loginUser(_phoneNoController.text,
                                            _passwordController.text, context);
                                        setState(() {});
                                        // Get.to(const CompleteVerification());
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(24)),
                                        backgroundColor: signUpButtoncolor,
                                        elevation: 0,
                                        fixedSize: const Size.fromHeight(60)),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                            child: SizedBox(
                                              width: 10,
                                            )),
                                        Text("SignIn".tr,
                                            style: mediumBlackTextStyle
                                                .copyWith(color: Colors.white)),
                                        const Expanded(
                                            child: SizedBox(
                                              width: 10,
                                            )),
                                        Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                              color:
                                              Colors.white.withOpacity(0.2),
                                              borderRadius:
                                              BorderRadius.circular(12)),
                                          child: Center(
                                              child: SvgPicture.asset(
                                                "assets/arrow-right-small.svg",
                                                width: 12,
                                                height: 12,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ],
                                    )),
                                const SizedBox(
                                  height: 27.3,
                                ),
                                // InkWell(
                                //   onTap: () async {
                                //
                                //     // if (_phoneNoController.text == "") {
                                //     //   showResentOtp=false;
                                //     //   _phoneNoController.clear();
                                //     //   _signInOtpController.clear();
                                //     //   _signInPasswordController.clear();
                                //     //   _signInPassword2Controller.clear();
                                //     //   _otpController.clear();
                                //     //   showTimeRow=false;
                                //     //   _start=1000;
                                //     //   startTimer();
                                //     //   enterPassword(context,_phoneNoController.text);
                                //     //   await Future.delayed(const Duration(seconds: 2));
                                //     //   _timer?.cancel();
                                //     // }
                                //     // else {
                                //     //   showResentOtp=false;
                                //     //   _signInOtpController.clear();
                                //     //   _signInPasswordController.clear();
                                //     //   _signInPassword2Controller.clear();
                                //     //   _otpController.clear();
                                //     //   forgotPasswordClicked=true;
                                //     //   setState(() {});
                                //     //   _showLoader(context);
                                //     //   findAdminCreatedUser(_phoneNoController.text);
                                //     //   setState(() {});
                                //     // }
                                //
                                //   },
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     children: [
                                //       Text(
                                //         'ForgotPassword'.tr,
                                //         style: mediumBlackTextStyle.copyWith(
                                //             fontSize: Get.locale?.languageCode=='ta'?MediaQuery.sizeOf(context).width<400? 9.5:MediaQuery.sizeOf(context).width>650? 10:12:14, color: Colors.blue),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                const SizedBox(
                                  height: 17.5,
                                ),
                                // (showTimeRow==true)?
                                // Padding(
                                //   padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.end,
                                //     children: [
                                //       AutoSizeText(
                                //         "otpExpiry".tr,
                                //         style: const TextStyle(
                                //           color: mainColor,
                                //           fontWeight: FontWeight.w400,
                                //           fontStyle: FontStyle.normal,
                                //           fontSize: 15.0,
                                //         ),
                                //       ),
                                //       Text("$_start", style: const TextStyle(
                                //         color: actionColor,
                                //         fontWeight: FontWeight.w400,
                                //         fontStyle: FontStyle.normal,
                                //         fontSize: 18.0,
                                //       ),),
                                //       AutoSizeText(
                                //         "commonSeconds".tr,
                                //         style: const TextStyle(
                                //           color: mainColor,
                                //           fontWeight: FontWeight.w400,
                                //           fontStyle: FontStyle.normal,
                                //           fontSize: 18.0,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // )
                                //     :Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  ]),
                )
              ],
            ),
          ),
        ));
  }

  double _getTermsFontSize(BuildContext context2) {
    var currentLocale = Get.locale;
    // Define font sizes for English and Tamil
    if (currentLocale?.languageCode == 'ta') {
      // Font size for Tamil
      if (kIsWeb){
        return 13.0;
      }else{
        return 0.0;
      }
    } else {
      // Font size for English
      return 16.0;
    }
  }

  // checkEpicNo(String epicNo) async {
  //   await SIgnUpService.getUserData(epicNo).then((receivedData) async {
  //     if (receivedData.status == "success") {
  //       voterData = receivedData;
  //       partNo = voterData.data!.partNo!;
  //       gender=voterData.data!.sex!;
  //       voterMasterId = voterData.data!.id!;
  //       _nameController.text = voterData.data!.nameFirstEn!;
  //       _fatherNameController.text = voterData.data!.rNameFirst!;
  //       _dobController.text = voterData.data!.dob == null
  //           ? ""
  //           : DateFormat("dd-MM-yyyy").format(voterData.data!.dob!);
  //       _dobController2.text = voterData.data!.dob == null
  //           ? ""
  //           : DateFormat("yyyy-MM-dd").format(voterData.data!.dob!);
  //       _districtController.text = voterData.data!.mstDistrict == null
  //           ? ""
  //           : voterData.data!.mstDistrict!.dstctEnglish!;
  //       if (voterData.data!.mstDistrict != null) {
  //         districtId = voterData.data!.mstDistrict!.id!;
  //       }
  //       _constituencyController.text =
  //       voterData.data!.assembleyConstituency == null
  //           ? ""
  //           : voterData.data!.assembleyConstituency!.English == null
  //           ? ""
  //           : voterData.data!.assembleyConstituency!.English!;
  //       if (voterData.data!.assembleyConstituency != null) {
  //         assemblyConstituencyId = voterData.data!.assembleyConstituency!.id!;
  //       }
  //       _parliamentConstituencyController.text =
  //       voterData.data!.parlimentaryConstituency == null
  //           ? ""
  //           : voterData.data!.parlimentaryConstituency!.English == null
  //           ? ""
  //           : voterData.data!.parlimentaryConstituency!.English!;
  //       if (voterData.data!.parlimentaryConstituency != null) {
  //         parlimentaryConstituencyId =
  //         voterData.data!.parlimentaryConstituency!.id!;
  //       }
  //       if (voterData.data!.mstState != null) {
  //         stateId = voterData.data!.mstState!.id!;
  //         stateId = voterData.data!.mstState!.id!;
  //       }
  //       _phoneNoController.text = voterData.data!.contactNo ?? '';
  //       correctEpicNo = true;
  //       showUserData = true;
  //       showOtpButton = true;
  //       showInCorrectButton=voterData.data!.showIncorrect!;
  //     } else {
  //       showFailureToast(receivedData.message, fToast);
  //     }
  //
  //     // _nameController.text=
  //     setState(() {});
  //   });
  //   ;
  // }
  //
  // reCheckEpicNo(String epicNo) async {
  //   await SIgnUpService.recheckGetUserData(epicNo).then((receivedData) async {
  //     if (receivedData.status == "success") {
  //       voterData = receivedData;
  //       partNo = voterData.data!.partNo!;
  //       gender=voterData.data!.sex!;
  //       voterMasterId = voterData.data!.id!;
  //       _nameController.text = voterData.data!.nameFirstEn!;
  //       _fatherNameController.text = voterData.data!.rNameFirst!;
  //       _dobController.text = voterData.data!.dob == null
  //           ? ""
  //           : DateFormat("dd-MM-yyyy").format(voterData.data!.dob!);
  //       _dobController2.text = voterData.data!.dob == null
  //           ? ""
  //           : DateFormat("yyyy-MM-dd").format(voterData.data!.dob!);
  //       _districtController.text = voterData.data!.mstDistrict == null
  //           ? ""
  //           : voterData.data!.mstDistrict!.dstctEnglish!;
  //       if (voterData.data!.mstDistrict != null) {
  //         districtId = voterData.data!.mstDistrict!.id!;
  //       }
  //       _constituencyController.text =
  //       voterData.data!.assembleyConstituency == null
  //           ? ""
  //           : voterData.data!.assembleyConstituency!.English == null
  //           ? ""
  //           : voterData.data!.assembleyConstituency!.English!;
  //       if (voterData.data!.assembleyConstituency != null) {
  //         assemblyConstituencyId = voterData.data!.assembleyConstituency!.id!;
  //       }
  //       _parliamentConstituencyController.text =
  //       voterData.data!.parlimentaryConstituency == null
  //           ? ""
  //           : voterData.data!.parlimentaryConstituency!.English == null
  //           ? ""
  //           : voterData.data!.parlimentaryConstituency!.English!;
  //       if (voterData.data!.parlimentaryConstituency != null) {
  //         parlimentaryConstituencyId =
  //         voterData.data!.parlimentaryConstituency!.id!;
  //       }
  //       if (voterData.data!.mstState != null) {
  //         stateId = voterData.data!.mstState!.id!;
  //         stateId = voterData.data!.mstState!.id!;
  //       }
  //       _phoneNoController.text = voterData.data!.contactNo ?? '';
  //       correctEpicNo = true;
  //       showUserData = true;
  //       showOtpButton = true;
  //       showInCorrectButton=voterData.data!.showIncorrect!;
  //     } else {
  //       showFailureToast(receivedData.message, fToast);
  //     }
  //
  //     // _nameController.text=
  //     setState(() {});
  //   });
  //   ;
  // }
  //
  // sendOtp(
  //     String phoneNo,
  //     String epicNo,
  //     String Name_First_en,
  //     String RName_First,
  //     String DOB,
  //     int voterMasterId,
  //     int districtId,
  //     int assemblyConstituencyId,
  //     int parlimentaryConstituencyId,
  //     int stateId,
  //     StateSetter setState,
  //     ) async {
  //   try {
  //     var body = jsonEncode({
  //       "mobileNo": phoneNo,
  //       "IDCardNo": epicNo,
  //       "Name_First_en": Name_First_en,
  //       "RName_First": RName_First,
  //       "DOB": DOB,
  //       "votersMasterId": voterMasterId,
  //       "districtId": districtId,
  //       "assembleyConstituencyId": assemblyConstituencyId,
  //       "parlimentaryConstituencyId": parlimentaryConstituencyId,
  //       "stateId": stateId
  //     });
  //
  //     await SIgnUpService.sendOtpToMobile(body, fToast)
  //         .then((receivedData) async {
  //       if (receivedData.status == "success") {
  //         otpReceivedData = receivedData;
  //         backendOtp =  otpReceivedData.otp!.otp - 2026;
  //         // memberId = otpReceivedData.otp!.memberId;
  //         optSent = true;
  //         // showOtpButton = false;
  //         submitClicked = false;
  //       }
  //       //
  //       //   // _nameController.text=
  //       setState(() {});
  //     });
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  void loginUser(String phoneNo, String password, BuildContext context) async {
    try {
      var body = jsonEncode({
        'phoneNo': phoneNo,
        'password': password,
      });

      var user = await SIgnUpService.loginService(body, fToast);


      if (user.token != null) {
        _phoneNoController.clear();
        _passwordController.clear();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage(pageNavigation: 2)), // Change the value to 1 for the second tab
        );
      }else{
        _showLoader(context);
        // findAdminCreatedUser(_phoneNoController.text);
        _passwordController.clear();
      }
    } catch (e) {
      // Handle errors
    }
  }

  // static getFCMToken() async {
  //   return await FirebaseMessaging.instance.getToken();
  // }
  //
  // void findAdminCreatedUser(String phoneNo) async {
  //   try {
  //     var body = jsonEncode({
  //       'phoneNo': phoneNo,
  //     });
  //
  //     // UserDataTokenModel userTokenData =
  //     await SIgnUpService.findNewUser(
  //       body,
  //       fToast,
  //     ).then((user) async {
  //       Navigator.of(context).pop();
  //       setState(() {});
  //       if (user == "No Password") {
  //         showTimeRow=true;
  //         _start=60;
  //         startTimer();
  //         await sendOtpToNewUser(_phoneNoController.text);
  //         enterUserPasswordAlert(context,_phoneNoController.text);
  //         signInFirstWidget = 2;
  //       }else if(forgotPasswordClicked==true&&user !="User Not found. Please register!"){
  //         await sendOtpToNewUser(_phoneNoController.text);
  //         showTimeRow=true;
  //         _start=60;
  //         startTimer();
  //         enterUserPasswordAlert(context,_phoneNoController.text);
  //         signInFirstWidget = 2;
  //       }
  //       forgotPasswordClicked=false;
  //
  //       setState(() {});
  //     });
  //   } catch (e) {
  //     return;
  //   }
  // }
  //
  // sendOtpToNewUser(
  //     String phoneNo,
  //     ) async {
  //   try {
  //     var body = jsonEncode({
  //       "mobileNo": phoneNo,
  //     });
  //     await SIgnUpService.sendOtpToMobile(body, fToast)
  //
  //         .then((receivedData) async {
  //       if (receivedData.status == "success") {
  //         otpReceivedData = receivedData;
  //         backendOtp =  otpReceivedData.otp!.otp - 2026;
  //         // memberId = otpReceivedData.otp!.memberId;
  //         optSent = true;
  //         // showOtpButton = false;
  //         submitClicked = false;
  //       }
  //       //
  //       //   // _nameController.text=
  //       setState(() {});
  //     });
  //
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  updateUserFcm(
      String? fcmToken,
      int id,
      ) async {
    String? platformName = '';
    try {
      if (kIsWeb) {
        platformName = "Web";
      } else {
        if (Platform.isIOS) {
          platformName = "IOS";
        } else if (Platform.isAndroid) {
          platformName = "Android";
        }
      }
      var body = jsonEncode({
        'fcmToken': fcmToken,
        'memberId': id,
        'platform': platformName,
      });
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString('fcm_token', fcmToken);
      box.write('fcmToken', fcmToken);
      box.write('memberId', id);
      // await SIgnUpService.userFcmToken(body, fToast);
    } catch (e) {
      throw Exception(e);
    }
  }

  // void saveUser(
  //     int memberId,
  //     String otp,
  //     String password,
  //     String occupation,
  //     String address,
  //     BuildContext context,
  //     PlatformFile profileImage,
  //     // PlatformFile aadharFrontPage,
  //     // PlatformFile aadharBacKPage,
  //     int voterId,
  //     int occupationId,
  //     String phoneNo,
  //     String epicNo,
  //     String Name_First_en,
  //     String RName_First,
  //     String DOB,
  //     int voterMasterId,
  //     int districtId,
  //     int assemblyConstituencyId,
  //     int parlimentaryConstituencyId,
  //     int stateId,
  //     String gender,
  //     int partNo, BuildContext context2
  //     ) async {
  //   try {
  //     Map<String, String> data = <String, String>{};
  //     data = {
  //       // "memberId": memberId.toString(),
  //       // "otp": otp,
  //       "password": password,
  //       "occupationName": occupation,
  //       "address": address,
  //       "votersMasterId": voterId.toString(),
  //       // "occupationId": occupationId.toString(),
  //       "mobileNo": phoneNo,
  //       "IDCardNo": epicNo,
  //       "Name_First_en": Name_First_en,
  //       "RName_First": RName_First,
  //       "DOB": DOB,
  //       "districtId": districtId.toString(),
  //       "assembleyConstituencyId": assemblyConstituencyId.toString(),
  //       "parlimentaryConstituencyId": parlimentaryConstituencyId.toString(),
  //       "stateId": stateId.toString(),
  //       "Sex": gender.toString(),
  //       "part_no": partNo.toString()
  //     };
  //     await SIgnUpService.saveUser(
  //         data, profileImage, fToast
  //         // aadharFrontPage, aadharBacKPage
  //     )
  //         .then((userId) async {
  //       Navigator.of(context2).pop();
  //       await IdentityCardService.getIdentityCardForMember(
  //           fToast, userId, context)
  //           .then((idReturnData) {
  //         Navigator.of(context).pop();
  //         setState(() {});
  //
  //         if(!kIsWeb){
  //           String base64String = idReturnData.data.idPath;
  //           url= base64String.replaceAll(
  //               'data:image/png;base64,', '');
  //         }else{
  //           url = idReturnData.data.idPath;
  //         }
  //         imageName=idReturnData.data.fileName;
  //         // showLoader=false;
  //
  //         setState(() {});
  //       });
  //       showIdCardAlertDialog(context,url!);
  //       // if (kIsWeb) {
  //       //   await WebImageDownloader.downloadImageFromWeb(
  //       //     url,
  //       //     name: url.split("/").last,
  //       //     imageType: ImageType.png,
  //       //   );
  //       // }
  //       // else {
  //       //   var random = Random();
  //       //   _saveImage(context, url, random);
  //       // }
  //       // setState(() {});
  //       // _tabController.animateTo(0);
  //       // _userPhoneNoController.clear();
  //       // _otpController.clear();
  //       // result = null;
  //       // result1 = null;
  //       // result2 = null;
  //       // _imageSelected = false;
  //       // _image2Selected = false;
  //       // _image3Selected = false;
  //       // _password1Controller.clear();
  //       // optSent = false;
  //       // Navigator.of(context).pop();
  //       // setState(() {});
  //       // showSuccessToast("Please, proceed to Login", fToast);
  //       // Get.to(const SingUpPage());
  //       // }
  //     });
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  void saveNewUserPassword(String phoneNo, String password, ) async {
    try {
      var body = jsonEncode({
        "mobileNo": phoneNo,
        "password": password,
      });
      // await SIgnUpService.saveNewUserPassword1(
      //   body, fToast,)
      //     .then((userId) async {
      //   // if (userMobNoPresent == true) {
      //   // String url = await IdentityCardService.getIdentityCardForMember(
      //   //     fToast, userId, context); //userId
      //   // if (kIsWeb) {
      //   //   await WebImageDownloader.downloadImageFromWeb(
      //   //     url,
      //   //     name: url.split("/").last,
      //   //     imageType: ImageType.png,
      //   //   );
      //   // } else {
      //   //   var random = Random();
      //   //   _saveImage(context, url, random);
      //   // }
      //   setState(() {});
      //   _phoneNoController.clear();
      //   _tabController.animateTo(0);
      //   _userPhoneNoController.clear();
      //   signInPhoneNoNode.requestFocus();
      //   _otpController.clear();
      //   result = null;
      //   result1 = null;
      //   result2 = null;
      //   _imageSelected = false;
      //   _image2Selected = false;
      //   _image3Selected = false;
      //   _password1Controller.clear();
      //   optSent = false;
      //   Navigator.of(context).pop();
      //   setState(() {});
      //   showSuccessToast("Please, proceed to Login", fToast);
      //   // Get.to(const SingUpPage());
      //   // }
      // });
    } catch (e) {
      throw Exception(e);
    }
  }

  // void saveUserAndroid(
  //     int memberId,
  //     String otp,
  //     String password,
  //     String occupation,
  //     String address,
  //     BuildContext context,
  //     String profileImage,
  //     // String aadharFrontPage,
  //     // String aadharBacKPage,
  //     int voterId,
  //     int occupationId,
  //     String phoneNo,
  //     String epicNo,
  //     String Name_First_en,
  //     String RName_First,
  //     String DOB,
  //     int voterMasterId,
  //     int districtId,
  //     int assemblyConstituencyId,
  //     int parlimentaryConstituencyId,
  //     int stateId,
  //     String gender,
  //     int partNo, BuildContext context2,
  //     ) async {
  //   try {
  //     Map<String, String> data = <String, String>{};
  //     data = {
  //       // "memberId": memberId.toString(),
  //       // "otp": otp,
  //       "password": password,
  //       "occupationName": occupation,
  //       "address": address,
  //       "votersMasterId": voterId.toString().toUpperCase(),
  //       // "occupationId": occupationId.toString(),
  //       "mobileNo": phoneNo,
  //       "IDCardNo": epicNo,
  //       "Name_First_en": Name_First_en,
  //       "RName_First": RName_First,
  //       "DOB": DOB,
  //       "districtId": districtId.toString(),
  //       "assembleyConstituencyId": assemblyConstituencyId.toString(),
  //       "parlimentaryConstituencyId": parlimentaryConstituencyId.toString(),
  //       "stateId": stateId.toString(),
  //       "Sex": gender.toString(),
  //       "part_no": partNo.toString()
  //     };
  //     await SIgnUpService.saveUserAndroid(
  //         data, profileImage, fToast
  //         // , aadharFrontPage, aadharBacKPage
  //     )
  //         .then((userId) async {
  //       Navigator.of(context2).pop();
  //       await IdentityCardService.getIdentityCardForMember(
  //           fToast, userId, context)
  //           .then((idReturnData) {
  //         Navigator.of(context).pop();
  //         setState(() {});
  //
  //         if(!kIsWeb){
  //           String base64String = idReturnData.data.idPath;
  //           url= base64String.replaceAll(
  //               'data:image/png;base64,', '');
  //         }else{
  //           url = idReturnData.data.idPath;
  //         }
  //         imageName=idReturnData.data.fileName;
  //         // showLoader=false;
  //
  //         setState(() {});
  //       });
  //       showIdCardAlertDialog(context,url!);
  //       // if (kIsWeb) {
  //       //   await WebImageDownloader.downloadImageFromWeb(
  //       //     url,
  //       //     name: url.split("/").last,
  //       //     imageType: ImageType.png,
  //       //   );
  //       // }
  //       // else {
  //       //   var random = Random();
  //       //   _saveImage(context, url, random);
  //       // }
  //       // setState(() {});
  //       // _tabController.animateTo(0);
  //       // _userPhoneNoController.clear();
  //       // _otpController.clear();
  //       // result = null;
  //       // result1 = null;
  //       // result2 = null;
  //       // _imageSelected = false;
  //       // _image2Selected = false;
  //       // _image3Selected = false;
  //       // _password1Controller.clear();
  //       // optSent = false;
  //       // Navigator.of(context).pop();
  //       // setState(() {});
  //       // showSuccessToast("Please, proceed to Login", fToast);
  //       // Get.to(const SingUpPage());
  //       // }
  //     });
  //   } catch (e) {      throw Exception(e);
  //   }
  // }

//   Widget imagePickerWidget(BuildContext context2, StateSetter setState,
//       String fileName) {
//     return Responsive.isDesktop(context)
//         ? Row(
//       children: [
//         Container(
//           width: 150,
//           margin: const EdgeInsets.only(top: 2.0),
// // color: green,
//           child: Center(
//             child: Text('ProfileImage'.tr,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   color: signUpTextFontcolor,
//                   fontSize: Responsive.isDesktop(context) ? 16.0 : 12.0,
//                   fontStyle: FontStyle.normal,
//                 )),
//           ),
//         ),
//         _imageSelected == false
//             ? SizedBox(
//             width: 100.0,
//             child: IconButton(
//               onPressed: () async {
//                 {
//                   result = await FilePicker.platform.pickFiles(
//                     withData: true,
//                     allowMultiple: false,
//                     type: FileType.custom,
//                     allowedExtensions: [
//                       'jpeg',
//                       'jpg',
//                     ],
//                   );
//                   if (result == null) {
//                   } else {
//                     imgChngFlg1 = true;
//                     _imageSelected = true;
//
//                     setState(() {});
//                     result?.files.forEach((element) {
//                     });
//                   }
//                 }
//               },
//               icon: Icon(Icons.image),
//             ))
//             : SizedBox(
//           width: 90.0,
//           height: 90.0,
//           child: Stack(
//             children: [
//               Center(
//                 child: Container(
//                   width: 50.0,
//                   height: 50.0,
//                   decoration: BoxDecoration(
//                     //shape: BoxShape.rectangle,
//                     // color: const Color(0xff7c94b6),
//                     image: DecorationImage(
//                       image: MemoryImage(
//                           Uint8List.fromList(
//                               result!.files[0].bytes!)),
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 12,
//                 right: 10,
//                 child: InkResponse(
//                   onTap: () {
//                     setState(() {
//                       result = null;
//                       _imageSelected = false;
//                     });
//                   },
//                   child: CircleAvatar(
//                     radius: 10,
//                     child: Icon(Icons.close, size: 10, color: Colors.white,),
//                     backgroundColor: notifire.geticoncolor,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(width: 10.0),
//       ],
//     )
//         : Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           width: 110,
//           margin: const EdgeInsets.only(top: 2.0),
// // color: green,
//           child: Center(
//             child: Text(commonProfileImage,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   color: mainColor,
//                   fontSize: Responsive.isDesktop(context) ? 16.0 : 12.0,
//                   fontStyle: FontStyle.normal,
//                 )),
//           ),
//         ),
//         Row(
//           children: [
//             _imageSelected == false
//                 ?
//             SizedBox(
//               width: 100.0,
//               child: PopupMenuButton<String>(
//                 icon: Icon(Icons.image),
//                 itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//                   const PopupMenuItem(
//                     value: 'gallery',
//                     // row with 2 children
//                     child: Row(
//                       children: [
//                         Icon(Icons.image),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text('gallery')
//                       ],
//                     ),
//                   ),
//                   const PopupMenuItem(
//                     value: 'camera',
//                     // row with 2 children
//                     child: Row(
//                       children: [
//                         Icon(Icons.camera),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text('camera')
//                       ],
//                     ),
//                   ),
//                 ],
//                 onSelected: (String value) {
//                   // Handle selection here
//                   switch (value) {
//                     case 'gallery':
//                       _pickImageFromGallery(setState);
//                       break;
//                     case 'camera':
//                       _pickImageFromCamera(setState);
//                       break;
//                   }
//                 },
//
//               ),
//             ):
//             SizedBox(
//               width: 70.0,
//               height: 70.0,
//               child: Stack(
//                 children: [
//                   Container(
//                     width: 80.0,
//                     height: 80.0,
//                     child: profileImg.isNotEmpty
//                         ? Align(
//                       alignment: Alignment.topRight, // Align the image to the right
//                       child: Padding(
//                         padding: const EdgeInsets.only(top:5.0,left:5.0,bottom:10.0,right:10.0),
//                         child: kIsWeb
//                             ? Image.network(
//                           profileImg,
//                           fit: BoxFit.fill,
//                         )
//                             : Image.file(File(profileImg)),
//                       ),
//                     )
//                         : Container(),
//                   ),
//                   Positioned(
//                     top: 1,
//                     right: 0,
//                     child: InkResponse(
//                       onTap: () {
//                         setState(() {
//                           profileImg = '';
//                           _imageSelected = false;
//                         });
//                       },
//                       child: CircleAvatar(
//                         radius: 10,
//                         child: Icon(
//                           Icons.close, size: 10, color: Colors.white,),
//                         backgroundColor: notifire.geticoncolor,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(width: 5.0),
//           ],
//         ),
//       ],
//     );
//
//   }
//
//   Future<void> _onImageButtonPressed(ImageSource source,
//       {BuildContext? context}) async {
//     try {
//       final XFile? pickedFile = await _picker.pickImage(
//         source: source,
//       );
//       setState(() {
//         result == null;
//         imgChngFlg1 = true;
//         _profileCameraClicked = true;
//         _imageSelected = true;
//         _setImageFileListFromFile(pickedFile);
//       });
//       if (pickedFile != null) {
//         final croppedFile = await ImageCropper().cropImage(
//           sourcePath: pickedFile.path,
//           compressFormat: ImageCompressFormat.jpg,
//           compressQuality: 100,
//           uiSettings: [
//             AndroidUiSettings(
//                 toolbarTitle: 'Cropper',
//                 toolbarColor: Colors.deepOrange,
//                 toolbarWidgetColor: Colors.white,
//                 initAspectRatio: CropAspectRatioPreset.original,
//                 lockAspectRatio: false),
//             IOSUiSettings(
//               title: 'Cropper',
//             ),
//           ],
//         );
//         if (croppedFile != null) {
//           setState(() {
//             _croppedFile = croppedFile;
//             doFaceDetection();
//           });
//         }
//       }
//     } catch (e) {
//       setState(() {
//         _pickImageError = e;
//       });
//     }
//   }

  Future<void> _setImageFileListFromFile(XFile? value) async {
    _imageFileList = value == null ? null : <XFile>[value];
    file = io.File(_imageFileList![0].path);
  }

  // Widget aadharImagePickerWidget(
  //     BuildContext context2, StateSetter setState, String fileName) {
  //   return Column(
  //     children: [
  //       Responsive.isDesktop(context)
  //           ? Row(
  //         children: [
  //           Container(
  //             width: 110,
  //             margin: const EdgeInsets.only(top: 2.0),
  //             // color: green,
  //             child: Center(
  //               child: Text('AadharImage'.tr,
  //                   style: TextStyle(
  //                     fontWeight: FontWeight.w600,
  //                     color: mainColor,
  //                     fontSize:
  //                     Responsive.isDesktop(context) ? 16.0 : 12.0,
  //                     fontStyle: FontStyle.normal,
  //                   )),
  //             ),
  //           ),
  //           ElevatedButton(
  //             onPressed: () async {
  //               {
  //                 result1 = await FilePicker.platform.pickFiles(
  //                   withData: true,
  //                   allowMultiple: false,
  //                   type: FileType.custom,
  //                   allowedExtensions: [
  //                     'jpeg',
  //                     'jpg',
  //                   ],
  //                 );
  //                 if (result1 == null) {
  //                 } else {
  //                   _image2Selected = true;
  //                   imgChngFlg3 = false;
  //                   setState(() {});
  //                   result1?.files.forEach((element) {
  //                   });
  //                 }
  //               }
  //             },
  //             child: Text(
  //               'FrontPage'.tr,
  //             ),
  //           ),
  //           const SizedBox(width: 10.0),
  //           ElevatedButton(
  //             onPressed: () async {
  //               {
  //                 result2 = await FilePicker.platform.pickFiles(
  //                   withData: true,
  //                   allowMultiple: false,
  //                   type: FileType.custom,
  //                   allowedExtensions: [
  //                     'jpeg',
  //                     'jpg',
  //                   ],
  //                 );
  //                 if (result2 == null) {
  //                 } else {
  //                   // resultList.add(result!);
  //                   imgChngFlg3 = false;
  //                   _image3Selected = true;
  //                   // final files = result?.files; //EDIT: THIS PROBABLY CAUSED YOU AN ERROR
  //                   // String textt = result!.files.first.path.toString();
  //                   //  placeholder = FileImage(File(textt));
  //                   setState(() {});
  //                   result2?.files.forEach((element) {
  //                   });
  //                 }
  //               }
  //             },
  //             child: Text(
  //               'Backpage'.tr,
  //             ),
  //           ),
  //         ],
  //       )
  //           : Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Container(
  //             width: 110,
  //
  //             margin: const EdgeInsets.only(top: 2.0),
  //             // color: green,
  //             child: Center(
  //               child: Text('AadharImage'.tr,
  //                   style: TextStyle(
  //                     fontWeight: FontWeight.w600,
  //                     color: mainColor,
  //                     fontSize:
  //                     Responsive.isDesktop(context) ? 16.0 : 12.0,
  //                     fontStyle: FontStyle.normal,
  //                   )),
  //             ),
  //           ),
  //           Column(
  //             children: [
  //               Row(
  //                 children: [
  //                   SizedBox(
  //                     width: 105.0,
  //                     child: ElevatedButton(
  //                       onPressed: () async {
  //                         {
  //                           await _onImageButtonPressed(
  //                               ImageSource.gallery,
  //                               context: context);
  //                           aadharfrontImg = _croppedFile!.path ?? '';
  //                           // result1 = await FilePicker.platform.pickFiles(
  //                           //   withData: true,
  //                           //   allowMultiple: false,
  //                           //   type: FileType.custom,
  //                           //   allowedExtensions: [
  //                           //     'jpeg',
  //                           //     'jpg',
  //                           //   ],
  //                           // );
  //                           // if (result1 == null) {
  //                           // } else {
  //                           _image2Selected = true;
  //                           imgChngFlg3 = false;
  //                           setState(() {});
  //                           //   result1?.files.forEach((element) {
  //                           //   });
  //                           // }
  //                         }
  //                       },
  //                       child: Text(
  //                         'FrontPage'.tr,
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(width: 5.0),
  //                   SizedBox(
  //                     width: (Responsive.screenOrientation(context2) ==
  //                         Orientation.landscape)
  //                         ? MediaQuery.of(context2).size.width / 5
  //                         : MediaQuery.of(context2).size.width / 3,
  //                     // color: green,
  //                     child: _image2Selected == true
  //                         ? AutoSizeText(
  //                       _croppedFile!.path.split("/").last ?? '',
  //                     )
  //                         : imgChngFlg1 == true
  //                         ? const AutoSizeText(
  //                       commonUploadYourProfile,
  //                     )
  //                         : AutoSizeText(
  //                       'upload_your_photo'.tr,
  //                       style: TextStyle(
  //                         color: Colors.red,
  //                         fontWeight: FontWeight.w400,
  //                         fontStyle: FontStyle.normal,
  //                         fontSize: _getTermsFontSize(context2),
  //                         // overflow: TextOverflow.ellipsis,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 5.0),
  //               Row(
  //                 children: [
  //                   SizedBox(
  //                     width: 105.0,
  //                     child: ElevatedButton(
  //                       onPressed: () async {
  //                         {
  //                           await _onImageButtonPressed(
  //                               ImageSource.gallery,
  //                               context: context);
  //                           aadharbackImg = _croppedFile!.path ?? '';
  //                           // result2 = await FilePicker.platform.pickFiles(
  //                           //   withData: true,
  //                           //   allowMultiple: false,
  //                           //   type: FileType.custom,
  //                           //   allowedExtensions: [
  //                           //     'jpeg',
  //                           //     'jpg',
  //                           //   ],
  //                           // );
  //                           // if (result2 == null) {
  //                           // } else {
  //                           imgChngFlg3 = false;
  //                           _image3Selected = true;
  //                           //
  //                           setState(() {});
  //                           //   result2?.files.forEach((element) {
  //                           //   });
  //                           // }
  //                         }
  //                       },
  //                       child: Text(
  //                         'Backpage'.tr,
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(width: 5.0),
  //                   SizedBox(
  //                     width: (Responsive.screenOrientation(context2) ==
  //                         Orientation.landscape)
  //                         ? MediaQuery.of(context2).size.width / 5
  //                         : MediaQuery.of(context2).size.width / 3,
  //                     // color: green,
  //                     child: _image3Selected == true
  //                         ? AutoSizeText(
  //                       _croppedFile!.path.split("/").last ?? '',
  //                     )
  //                         : imgChngFlg1 == true
  //                         ? const AutoSizeText(
  //                       commonUploadYourProfile,
  //                     )
  //                         : AutoSizeText(
  //                       'upload_your_photo'.tr,
  //                       style: TextStyle(
  //                         color: Colors.red,
  //                         fontWeight: FontWeight.w400,
  //                         fontStyle: FontStyle.normal,
  //                         fontSize: _getTermsFontSize(context2),
  //                         // overflow: TextOverflow.ellipsis,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //       if (kIsWeb)
  //         (_image2Selected == true || _image3Selected == true)
  //             ? const SizedBox(
  //           height: 10.0,
  //         )
  //             : Container(),
  //       if (kIsWeb)
  //         ((_image2Selected == true || _image3Selected == true) ||
  //             (imgChngFlg2 == true || imgChngFlg3 == true))
  //             ? Row(
  //           children: [
  //             Container(
  //               width: 110,
  //               margin: const EdgeInsets.only(top: 2.0),
  //             ),
  //             SizedBox(
  //               width: MediaQuery.of(context2).size.width / 10,
  //               // color: green,
  //               child: _image2Selected == true
  //                   ? AutoSizeText(
  //                 result1!.files[0].name,
  //               )
  //                   : const AutoSizeText(
  //                 "",
  //                 style: TextStyle(
  //                   color: Colors.red,
  //                   fontWeight: FontWeight.w400,
  //                   fontStyle: FontStyle.normal,
  //                   fontSize: 13.0,
  //                   // overflow: TextOverflow.ellipsis,
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(width: 10.0),
  //             SizedBox(
  //               width: MediaQuery.of(context2).size.width / 10,
  //               // color: green,
  //               child: _image3Selected == true
  //                   ? AutoSizeText(
  //                 result2!.files[0].name,
  //               )
  //                   : const AutoSizeText(
  //                 "",
  //                 style: TextStyle(
  //                   color: Colors.red,
  //                   fontWeight: FontWeight.w400,
  //                   fontStyle: FontStyle.normal,
  //                   fontSize: 13.0,
  //                   // overflow: TextOverflow.ellipsis,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         )
  //        : Container(),
  //     ],
  //   );
  // }

  // Widget checkEpicNoButtonWidget() {
  //   return ElevatedButton(
  //       onPressed: () async {
  //         if (_formKey.currentState!.validate()) {
  //           FocusManager.instance.primaryFocus?.unfocus();
  //           await checkEpicNo(_voterIdController.text.toUpperCase());
  //         }
  //       },
  //       style: ElevatedButton.styleFrom(
  //           shape:
  //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
  //           backgroundColor: signUpButtoncolor,
  //           elevation: 0,
  //           fixedSize: const Size.fromHeight(60)),
  //       child: Row(
  //         children: [
  //           const Expanded(
  //               child: SizedBox(
  //                 width: 10,
  //               )),
  //           Text(
  //             // 'Check Epic No'.tr,
  //             kIsWeb
  //                 ? 'Check Epic No'.tr
  //                 : 'Check_Epic_No_mobile'.tr,
  //             style: mediumBlackTextStyle.copyWith(
  //                 color: Colors.white, fontSize:Get.locale?.languageCode=='ta'?MediaQuery.sizeOf(context).width>850||MediaQuery.sizeOf(context).width<450?MediaQuery.sizeOf(context).width<400?7.5:8.5:10:14),
  //           ),
  //           const Expanded(
  //               child: SizedBox(
  //                 width: 10,
  //               )),
  //           Container(
  //             height: 35,
  //             width: 35,
  //             decoration: BoxDecoration(
  //                 color: Colors.white.withOpacity(0.2),
  //                 borderRadius: BorderRadius.circular(12)),
  //             child: Center(
  //                 child: SvgPicture.asset(
  //                   "assets/arrow-right-small.svg",
  //                   width: 12,
  //                   height: 12,
  //                   color: Colors.white,
  //                 )),
  //           ),
  //         ],
  //       ));
  // }
  //
  // Widget submitButtonWidget(BuildContext context) {
  //   return  ElevatedButton(
  //         onPressed: () async {
  //           if (_formKey.currentState!.validate()) {
  //             submitClicked = true;
  //             submitButtonClicked = true;
  //             optSent = false;
  //             showTimeRow=false;
  //             _start=1000;
  //             startTimer();
  //
  //             // showOtpButton = false;
  //             showDistrictAlert(context);
  //             await Future.delayed(const Duration(seconds: 2));
  //             _timer?.cancel();
  //             setState(() {});
  //           }
  //           // await sendOtp(_userPhoneNoController.text);
  //         },
  //         style: ElevatedButton.styleFrom(
  //             shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
  //             backgroundColor: signUpSubmitButtonColor,
  //             elevation: 0,
  //             fixedSize: const Size.fromHeight(60)),
  //         child: Row(
  //           children: [
  //             const Expanded(
  //                 child: SizedBox(
  //                   width: 10,
  //                 )),
  //             Text(
  //               'Submit'.tr,
  //               style: mediumBlackTextStyle.copyWith(color: Colors.white),
  //             ),
  //             const Expanded(
  //                 child: SizedBox(
  //                   width: 10,
  //                 )),
  //             Container(
  //               height: 35,
  //               width: 35,
  //               decoration: BoxDecoration(
  //                   color: Colors.white.withOpacity(0.2),
  //                   borderRadius: BorderRadius.circular(12)),
  //               child: Center(
  //                   child: SvgPicture.asset(
  //                     "assets/arrow-right-small.svg",
  //                     width: 12,
  //                     height: 12,
  //                     color: Colors.white,
  //                   )),
  //             ),
  //           ],
  //         ),
  //   );
  // }
  //
  // Widget incorrectButtonWidget() {
  //   return ElevatedButton(
  //       onPressed: () async {
  //         // showOtp = false;
  //         // showOtpButton = false;
  //         // correctEpicNo = false;
  //         // showUserData = false;
  //         // _nameController.clear();
  //         // _fatherNameController.clear();
  //         // _dobController.clear();
  //         // _districtController.clear();
  //         // _constituencyController.clear();
  //         // _parliamentConstituencyController.clear();
  //         // setState(() {});
  //         // await sendOtp(_userPhoneNoController.text);
  //         if (_formKey.currentState!.validate()) {
  //           await reCheckEpicNo(_voterIdController.text.toUpperCase());
  //           // await checkEpicNo(_voterIdController.text.toUpperCase());
  //         }
  //       },
  //       style: ElevatedButton.styleFrom(
  //           shape:
  //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
  //           backgroundColor: signUpButtoncolor,
  //           elevation: 0,
  //           fixedSize: const Size.fromHeight(60)),
  //       child: Row(
  //         children: [
  //           const Expanded(
  //               child: SizedBox(
  //                 width: 10,
  //               )),
  //           Text(
  //             'InCorrect'.tr,
  //             style: mediumBlackTextStyle.copyWith(color: Colors.white),
  //           ),
  //           const Expanded(
  //               child: SizedBox(
  //                 width: 10,
  //               )),
  //           Container(
  //             height: 35,
  //             width: 35,
  //             decoration: BoxDecoration(
  //                 color: Colors.white.withOpacity(0.2),
  //                 borderRadius: BorderRadius.circular(12)),
  //             child: Center(
  //                 child: SvgPicture.asset(
  //                   "assets/arrow-right-small.svg",
  //                   width: 12,
  //                   height: 12,
  //                   color: Colors.white,
  //                 )),
  //           ),
  //         ],
  //       ));
  // }
  //
  // Widget sendOtpButtonWidget(StateSetter setState, BuildContext context2) {
  //   return Container(
  //     height:50,
  //      width: 200,
  //     child: ElevatedButton(
  //         onPressed: () async {
  //           if (_alertFormKey.currentState!.validate()) {
  //             showTimeRow=true;
  //             _start=60;
  //             startTimer();
  //             await sendOtp(
  //                 _userPhoneNoController.text,
  //                 _voterIdController.text.toUpperCase(),
  //                 _nameController.text,
  //                 _fatherNameController.text,
  //                 _dobController2.text,
  //                 voterMasterId,
  //                 districtId,
  //                 assemblyConstituencyId,
  //                 parlimentaryConstituencyId,
  //                 stateId,
  //                 setState);
  //           }
  //         },
  //         style: ElevatedButton.styleFrom(
  //             shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
  //             backgroundColor: signUpButtoncolor,
  //             elevation: 0,
  //             fixedSize: const Size.fromHeight(60)),
  //         child: Row(
  //           children: [
  //             const Expanded(
  //                 child: SizedBox(
  //                   width: 10,
  //                 )),
  //             Text(
  //               'sendOtp'.tr,
  //               style: mediumBlackTextStyle.copyWith(color: Colors.white),
  //             ),
  //             const Expanded(
  //                 child: SizedBox(
  //                   width: 10,
  //                 )),
  //             Container(
  //               height: 35,
  //               width: 35,
  //               decoration: BoxDecoration(
  //                   color: Colors.white.withOpacity(0.2),
  //                   borderRadius: BorderRadius.circular(12)),
  //               child: Center(
  //                   child: SvgPicture.asset(
  //                     "assets/arrow-right-small.svg",
  //                     width: 12,
  //                     height: 12,
  //                     color: Colors.white,
  //                   )),
  //             ),
  //           ],
  //         )),
  //   );
  // }

  Widget loginButtonWidget(StateSetter setState, BuildContext context2) {
    return Container(
      height:50,
      width:200,
      child: ElevatedButton(
          onPressed: () async {
          //   if (_imageSelected == false
          //       // ||
          //       // _image2Selected == false ||
          //       // _image3Selected == false
          //   ) {
          //     if (_imageSelected == false) {
          //       showFailureToast("commonUploadYourProfile", fToast);
          //       setState(() {});
          //     }
          //     // else if (_image2Selected == false) {
          //     //   // showFailureToast(commonUploadAadharFront, fToast);
          //     //   setState(() {});
          //     // } else if (_image3Selected == false) {
          //     //   // showFailureToast(commonUploadAadharBack, fToast);
          //     //   setState(() {});
          //     // }
          //     return;
          //   }
          //   if(!kIsWeb) {
          //     if (faces.length != 1) {
          //       showFailureToast(
          //           "please, upload a proper profile image", fToast);
          //       return;
          //     }
          //   }
          //   if (_alertFormKey.currentState!.validate()) {
          //     _showLoader(context);
          //     if (!kIsWeb) {
          //       saveUserAndroid(
          //         memberId,
          //         _otpController.text,
          //         _password1Controller.text,
          //         _occupationController.text,
          //         _addressController.text,
          //         context,
          //         profileImg,
          //         // aadharfrontImg,
          //         // aadharbackImg,
          //         voterData.data!.id!,
          //         occupationId,
          //         _userPhoneNoController.text,
          //         _voterIdController.text.toUpperCase(),
          //         _nameController.text,
          //         _fatherNameController.text,
          //         _dobController.text,
          //         voterMasterId,
          //         districtId,
          //         assemblyConstituencyId,
          //         parlimentaryConstituencyId,
          //         stateId,
          //         gender,
          //         partNo,context2
          //       );
          //     } else {
          //       saveUser(
          //         memberId,
          //         _otpController.text,
          //         _password1Controller.text,
          //         _occupationController.text,
          //         _addressController.text,
          //         context,
          //         result!.files![0],
          //         // result1!.files![0],
          //         // result2!.files![0],
          //         voterData.data!.id!,
          //         occupationId,
          //         _userPhoneNoController.text,
          //         _voterIdController.text.toUpperCase(),
          //         _nameController.text,
          //         _fatherNameController.text,
          //         _dobController.text,
          //         voterMasterId,
          //         districtId,
          //         assemblyConstituencyId,
          //         parlimentaryConstituencyId,
          //         stateId,
          //           gender,
          //           partNo,context2
          //       );
          //       showOtp = false;
          //       _otpController.clear();
          //       _password1Controller.clear();
          //       _userPhoneNoController.clear();
          //       profileImg='';
          //       _imageSelected=false;
          //       _croppedFile=null;
          //       setState((){
          //
          //       });
          //
          //     }
          //   }
          },
          style: ElevatedButton.styleFrom(
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              backgroundColor: signUpButtoncolor,
              elevation: 0,
              fixedSize: const Size.fromHeight(60)),
          child: Row(
            children: [
              const Expanded(
                  child: SizedBox(
                    width: 10,
                  )),
              Text(
                'SignUp'.tr,
                style: mediumBlackTextStyle.copyWith(color: Colors.white),
              ),
              const Expanded(
                  child: SizedBox(
                    width: 10,
                  )),
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: SvgPicture.asset(
                      "assets/arrow-right-small.svg",
                      width: 12,
                      height: 12,
                      color: Colors.white,
                    )),
              ),
            ],
          )),
    );
  }

  // Widget downloadButton(StateSetter setState, String url) {
  //   return  Container(
  //     // width: 100.0,
  //     height: 30.0,
  //     decoration: BoxDecoration(
  //       // color: signUpTopFontcolor,
  //     ),
  //     child: ElevatedButton.icon(
  //       label: textWithLightShadow("Download".tr),
  //       icon:  Icon(
  //         Icons.cloud_download_outlined,
  //         color: signUpTopBarcolor,
  //         size: 20.0,
  //       ),
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: signUpButtoncolor,
  //         padding: EdgeInsets.symmetric(
  //           horizontal: 14,
  //           vertical: !kIsWeb
  //               ? 0.0
  //               : Responsive.isMobile(context)
  //               ? 0.0
  //               : 11,
  //         ),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(4.0),
  //         ),
  //       ),
  //       onPressed: () async {
  //         // _showLoader(context);
  //         // if (kIsWeb) {
  //         //   await WebImageDownloader.downloadImageFromWeb(
  //         //     url,
  //         //     name: imageName,
  //         //     imageType: ImageType.png,
  //         //   );
  //         // }
  //         // else {
  //         //   var random = Random();
  //         //   fileName = '${imageName}${random.nextInt(100)}.png';
  //         //   downloadBase64String(
  //         //       url, fileName, context, fToast);
  //         //   // _saveImage(context, url, random);
  //         // }
  //         // setState(() {});
  //         // Navigator.of(context).pop();
  //         // _tabController.animateTo(0);
  //         // _userPhoneNoController.clear();
  //         // _otpController.clear();
  //         // result = null;
  //         // result1 = null;
  //         // result2 = null;
  //         // _imageSelected = false;
  //         // _image2Selected = false;
  //         // _image3Selected = false;
  //         // _password1Controller.clear();
  //         // optSent = false;
  //         // Navigator.of(context).pop();
  //         // setState(() {});
  //         // showSuccessToast("Please, proceed to Login", fToast);
  //       },
  //     ),
  //   );
  // }

  Widget passwordButtonWidget(StateSetter setState) {
    return Container(
      width:250,
      height:50,
      child: ElevatedButton(
          onPressed: () async {
            if(_signInPasswordController.text!=_signInPassword2Controller.text){
              showFailureToast("commonCorrectPassword", fToast);
              return;
            }
            // if(backendNewUserOtp!=_signInOtpController.text){
            //   showFailureToast(commonIncorrectOtp, fToast);
            //   return;
            // }
            if (_alertPasswordFormKey.currentState!.validate()) {
              saveNewUserPassword(
                  _phoneNoController.text,_signInPasswordController.text
              );
              _phoneNoController.clear();
              _signInOtpController.clear();
              _signInPasswordController.clear();
              _signInPassword2Controller.clear();
              _otpController.clear();

            }
          },
          style: ElevatedButton.styleFrom(
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              backgroundColor: signUpButtoncolor,
              elevation: 0,
              fixedSize: const Size.fromHeight(50)),
          child: Row(
            children: [
              const Expanded(
                  child: SizedBox(
                    width: 10,
                  )),
              Text(
                'common_confirm'.tr,
                style: mediumBlackTextStyle.copyWith(color: Colors.white),
              ),
              const Expanded(
                  child: SizedBox(
                    width: 10,
                  )),
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: SvgPicture.asset(
                      "assets/arrow-right-small.svg",
                      width: 12,
                      height: 12,
                      color: Colors.white,
                    )),
              ),
            ],
          )),
    );
  }

  // Future<void> getOccupationList() async {
  //   await OccupationService.getOccupationList().then((data) => {
  //     _totalOccupationData = data,
  //   });
  //   setState(() {});
  // }

  void _toggleLogin() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _toggleSignIn() {
    setState(() {
      _signInObscureTextPassword = !_signInObscureTextPassword;
    });
  }

  // Future<void> showDistrictAlert(BuildContext context) async {
  //   showIssueTypeAlert(context);
  // }
  //
  // void showIssueTypeAlert(
  //     BuildContext context,
  //     ) {
  //   var alert2=WillPopScope(
  //     onWillPop: () async => false,
  //     child: AlertDialog(
  //       contentPadding: EdgeInsets.zero,
  //       content:StreamBuilder<StreamData>(
  //           stream: _events.stream,
  //           builder: (BuildContext context, AsyncSnapshot<StreamData> snapshot) {
  //             if (!snapshot.hasData) {
  //               return SizedBox(
  //                 width: Responsive.isDesktop(context)
  //                     ? 420
  //                     : (Responsive.screenOrientation(context) ==
  //                     Orientation.landscape)
  //                     ? 330
  //                     : (MediaQuery.of(context).size.width>680)&&(MediaQuery.of(context).size.width<900)
  //                     ?MediaQuery.of(context).size.width/1.7:Responsive.isMobile(context) ?MediaQuery.of(context).size.width/1.03
  //                     :MediaQuery.of(context).size.width / 1.03,
  //                 height: MediaQuery.of(context).size.height>1000?500:400,
  //                 child: Center(
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       circularProgress(),
  //                     ],
  //                   ),
  //                 ),
  //               ); // or some loading indicator
  //             }
  //             final data = snapshot.data!;
  //             return Stack(
  //         clipBehavior: Clip.none,
  //         children: <Widget>[
  //           Form(
  //             key: _alertFormKey,
  //             child: StatefulBuilder(builder: (context2, setState) {
  //               return SizedBox(
  //                 width: Responsive.isDesktop(context)
  //                     ? 400
  //                     : (Responsive.screenOrientation(context2) ==
  //                     Orientation.landscape)
  //                     ? 330
  //                     : MediaQuery.of(context).size.width / 1.03,
  //                 height: 450,
  //                 child: SingleChildScrollView(
  //                   child: Padding(
  //                     padding: const EdgeInsets.only(
  //                         left: 10.0, right: 10.0, top: 15.0),
  //                     child: Column(
  //                       children: [
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             Text(
  //                               "commonSignUp",
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.w700,
  //                                 color: signUpTextFontcolor,
  //                                 fontSize: 17.0,
  //                                 fontStyle: FontStyle.normal,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         // Row(
  //                         //   mainAxisAlignment: MainAxisAlignment.end,
  //                         //   children: [
  //                         //     IconButton(
  //                         //       icon: Icon(
  //                         //         Icons.cancel,
  //                         //         color: notifire!.geticoncolor,
  //                         //       ),
  //                         //       onPressed: () {
  //                         //         Navigator.of(context).pop();
  //                         //         showOtp = false;
  //                         //         _userPhoneNoController.clear();
  //                         //         // showOtpButton = false;
  //                         //         // correctEpicNo = false;
  //                         //         // showUserData = false;
  //                         //         // _nameController.clear();
  //                         //         // _fatherNameController.clear();
  //                         //         // _dobController.clear();
  //                         //         // _districtController.clear();
  //                         //         // _constituencyController.clear();
  //                         //         // _parliamentConstituencyController.clear();
  //                         //         setState(() {});
  //                         //       },
  //                         //     ),
  //                         //   ],
  //                         // ),
  //                         const SizedBox(
  //                           height: 10,
  //                         ),
  //                         submitButtonClicked == true
  //                             ? Padding(
  //                           padding:
  //                           const EdgeInsets.only(left: 20.0),
  //                           child: Row(
  //                             mainAxisAlignment:
  //                             MainAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 'phoneNo'.tr,
  //                                 style: TextStyle(
  //                                     fontWeight: FontWeight.bold,
  //                                     color: signUpTextFontcolor),
  //                               ),
  //                             ],
  //                           ),
  //                         )
  //                             : Container(),
  //                         submitButtonClicked == true
  //                             ? const SizedBox(
  //                           height: 10,
  //                         )
  //                             : Container(),
  //                         submitButtonClicked == true
  //                             ? phoneNoBuildTextFilde(
  //                             hinttext: 'phoneNo'.tr,
  //                             prefixicon: "assets/phone-number.svg",
  //                             suffixistrue: false,
  //                             controller: _userPhoneNoController)
  //                             : Container(),
  //                         optSent == true
  //                             ? const SizedBox(
  //                           height: 19.8,
  //                         )
  //                             : Container(),
  //                         optSent == true
  //                             ? Padding(
  //                           padding:
  //                           const EdgeInsets.only(left: 20.0),
  //                           child: Row(
  //                             mainAxisAlignment:
  //                             MainAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 commonOtp,
  //                                 style: TextStyle(
  //                                     fontWeight: FontWeight.bold,
  //                                     color: signUpTextFontcolor),
  //                               ),
  //                             ],
  //                           ),
  //                         )
  //                             : Container(),
  //                         optSent == true
  //                             ? const SizedBox(
  //                           height: 10,
  //                         )
  //                             : Container(),
  //                         optSent == true
  //                             ? TextFormField(
  //
  //                           keyboardType: TextInputType.number,
  //                           inputFormatters: <TextInputFormatter>[
  //                             new LengthLimitingTextInputFormatter(4),
  //                             FilteringTextInputFormatter.digitsOnly
  //                           ],
  //                           focusNode: focusNodeOtp,
  //                           controller: _otpController,
  //                           validator: (value) {
  //                             if (value!.isEmpty) {
  //                               return "Otp can't be empty";
  //                             } else if (value.length < 4) {
  //                               return 'must be equal to 4';
  //                             } else if (value != backendOtp.toString()) {
  //                               return 'Otp Incorrect';
  //                             }
  //                             return null;
  //                           },
  //                           decoration: InputDecoration(
  //                             enabledBorder: OutlineInputBorder(
  //                                 borderRadius:
  //                                 BorderRadius.circular(25),
  //                                 borderSide: const BorderSide(
  //                                   // color: notifire!.isDark
  //                                   //     ? notifire!.geticoncolor
  //                                   //     : Colors.grey.shade200
  //                                 )),
  //                             border: OutlineInputBorder(
  //                                 borderRadius:
  //                                 BorderRadius.circular(25),
  //                                 borderSide: const BorderSide(
  //                                   // color: notifire!.isDark
  //                                   //     ? notifire!.geticoncolor
  //                                   //     : Colors.grey.shade200
  //                                 )),
  //                             contentPadding:
  //                             const EdgeInsets.symmetric(
  //                                 vertical: 5.0,
  //                                 horizontal: 10.0),
  //                             hintText: commonOtp,
  //                             hintStyle: const TextStyle(
  //                                 fontFamily: 'WorkSansSemiBold',
  //                                 fontSize: 16.0),
  //                             // prefixIcon: SizedBox(
  //                             //   height: 20,
  //                             //   width: 50,
  //                             //   child: Center(
  //                             //       child: SvgPicture.asset(
  //                             //         "assets/keyboard-with-cable.svg",
  //                             //         height: 18,
  //                             //         width: 18,
  //                             //         // color: notifire!.geticoncolor,
  //                             //       )),
  //                             // ),
  //                             // suffixIcon: InkWell(
  //                             //   onTap: () {
  //                             //     setState(() {
  //                             //       _obscureTextPassword =
  //                             //       !_obscureTextPassword;
  //                             //     });
  //                             //   },
  //                             //   child: Icon(
  //                             //     _obscureTextPassword
  //                             //         ? FontAwesomeIcons.eyeSlash
  //                             //         : FontAwesomeIcons.eye,
  //                             //     size: 15.0,
  //                             //     color: Colors.black,
  //                             //   ),
  //                             // ),
  //                           ),
  //                         )
  //                             : Container(),
  //                         optSent == true
  //                             ? const SizedBox(
  //                           height: 19.8,
  //                         )
  //                             : Container(),
  //                         ((optSent == true)&&(snapshot.data!.showTimeRow==true))?
  //                         Padding(
  //                           padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
  //                           child: Row(
  //                             mainAxisAlignment: MainAxisAlignment.end,
  //                             children: [
  //                               AutoSizeText(
  //                                 "otpExpiry".tr,
  //                                 style: const TextStyle(
  //                                   color: mainColor,
  //                                   fontWeight: FontWeight.w400,
  //                                   fontStyle: FontStyle.normal,
  //                                   fontSize: 15.0,
  //                                 ),
  //                               ),
  //                               Text("${snapshot.data!.timerValue.toString()}", style: const TextStyle(
  //                                 color: actionColor,
  //                                 fontWeight: FontWeight.w400,
  //                                 fontStyle: FontStyle.normal,
  //                                 fontSize: 18.0,
  //                               ),),
  //                               AutoSizeText(
  //                                 "commonSeconds".tr,
  //                                 style: const TextStyle(
  //                                   color: mainColor,
  //                                   fontWeight: FontWeight.w400,
  //                                   fontStyle: FontStyle.normal,
  //                                   fontSize: 18.0,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         )
  //                             :Container(),
  //                     ((optSent == true)&&(snapshot.data!.showResentOtp==true))?
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.end,
  //                           children: [
  //
  //                             TextButton(
  //                                 onPressed: () async {
  //                                   showTimeRow=true;
  //                                   _otpController.clear();
  //                                   _start=60;
  //                                   startTimer();
  //                                   await sendOtpToNewUser(_userPhoneNoController.text);
  //                                   setState(() {});
  //                                 },
  //                                 child: Text(
  //                                   "commonResendOTP".tr,
  //                                   style: const TextStyle(
  //                                       decoration: TextDecoration.underline,
  //                                       color: cyan,
  //                                       fontSize: 16.0,
  //                                       fontFamily: 'WorkSansMedium'),
  //                                 )),
  //                           ],
  //                         ):Container(),
  //                         optSent == true
  //                             ? Padding(
  //                           padding:
  //                           const EdgeInsets.only(left: 20.0),
  //                           child: Row(
  //                             mainAxisAlignment:
  //                             MainAxisAlignment.start,
  //                             children: [
  //                               Text(
  //                                 'password'.tr,
  //                                 style: TextStyle(
  //                                     fontWeight: FontWeight.bold,
  //                                     color: signUpTextFontcolor),
  //                               ),
  //                             ],
  //                           ),
  //                         )
  //                             : Container(),
  //                         optSent == true
  //                             ? const SizedBox(
  //                           height: 10,
  //                         )
  //                             : Container(),
  //                         optSent == true
  //                             ? TextFormField(
  //                           focusNode: focusNodePassword,
  //                           controller: _password1Controller,
  //
  //                           validator: (value) {
  //                             if (value!.isEmpty) {
  //                               return "Password can't be empty";
  //                             } else if (value.length < 5) {
  //                               return 'must be greater than 5';
  //                             }
  //                             return null;
  //                           },
  //                           obscureText: _obscureTextPassword,
  //                           // style: const TextStyle(
  //                           //     fontFamily: 'WorkSansSemiBold',
  //                           //     fontSize: 16.0,
  //                           //     color: backGround),
  //                           decoration: InputDecoration(
  //                             enabledBorder: OutlineInputBorder(
  //                                 borderRadius:
  //                                 BorderRadius.circular(25),
  //                                 borderSide: const BorderSide(
  //                                   // color: notifire!.isDark
  //                                   //     ? notifire!.geticoncolor
  //                                   //     : Colors.grey.shade200
  //                                 )),
  //                             border: OutlineInputBorder(
  //                                 borderRadius:
  //                                 BorderRadius.circular(25),
  //                                 borderSide: const BorderSide(
  //                                   // color: notifire!.isDark
  //                                   //     ? notifire!.geticoncolor
  //                                   //     : Colors.grey.shade200
  //                                 )),
  //                             contentPadding:
  //                             const EdgeInsets.symmetric(
  //                                 vertical: 5.0,
  //                                 horizontal: 10.0),
  //                             hintText: commonPassword,
  //                             hintStyle: const TextStyle(
  //                                 fontFamily: 'WorkSansSemiBold',
  //                                 fontSize: 16.0),
  //                             prefixIcon: SizedBox(
  //                               height: 20,
  //                               width: 50,
  //                               child: Center(
  //                                   child: SvgPicture.asset(
  //                                     "assets/keyboard-with-cable.svg",
  //                                     height: 18,
  //                                     width: 18,
  //                                     // color: notifire!.geticoncolor,
  //                                   )),
  //                             ),
  //                             suffixIcon: InkWell(
  //                               onTap: () {
  //                                 setState(() {
  //                                   _obscureTextPassword =
  //                                   !_obscureTextPassword;
  //                                 });
  //                               },
  //                               child: Icon(
  //                                 _obscureTextPassword
  //                                     ? FontAwesomeIcons.eyeSlash
  //                                     : FontAwesomeIcons.eye,
  //                                 size: 15.0,
  //                                 color: Colors.black,
  //                               ),
  //                             ),
  //                           ),
  //                           // onSubmitted: (_) {
  //                           //   _toggleSignInButton();
  //                           // },
  //                           textInputAction: TextInputAction.go,
  //                         )
  //                             : Container(),
  //                         optSent == true
  //                             ? const SizedBox(
  //                           height: 19.8,
  //                         )
  //                             : Container(),
  //                         optSent == true
  //                             ? const SizedBox(
  //                           height: 10.0,
  //                         )
  //                             : Container(),
  //                         optSent == true
  //                             ? imagePickerWidget(
  //                             context2, setState, fileName)
  //                             : Container(),
  //                         optSent == true
  //                             ? const SizedBox(
  //                           height: 0.0,
  //                         )
  //                             : Container(),
  //                         // optSent == true
  //                         //     ? aadharImagePickerWidget(
  //                         //     context2, setState, fileName)
  //                         //     : Container(),
  //                         submitClicked == true
  //                             ? const SizedBox(
  //                           height: 10.0,
  //                         )
  //                             : Container(),
  //                         submitClicked == true
  //                             ? sendOtpButtonWidget(setState, context2)
  //                             : Container(),
  //                         optSent == true
  //                             ? const SizedBox(
  //                           height: 10.0,
  //                         )
  //                             : Container(),
  //                         optSent == true
  //                             ? loginButtonWidget(setState,context2)
  //                             : Container(),
  //                         const SizedBox(
  //                           height: 10,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             }),
  //           ),
  //           Positioned(
  //             right: -10.0,
  //             top: -10.0,
  //             child: Material(
  //               color: Colors.transparent,
  //               child: InkWell(
  //
  //                 onTap: () {
  //                   Navigator.of(context).pop();
  //                   showOtp = false;
  //                   _otpController.clear();
  //                   _password1Controller.clear();
  //                   _userPhoneNoController.clear();
  //                   profileImg='';
  //                   _imageSelected=false;
  //                   _croppedFile=null;
  //                   // optSent=false;
  //                   // showOtpButton = false;
  //                   // correctEpicNo = false;
  //                   // showUserData = false;
  //                   // _nameController.clear();
  //                   // _fatherNameController.clear();
  //                   // _dobController.clear();
  //                   // _districtController.clear();
  //                   // _constituencyController.clear();
  //                   // _parliamentConstituencyController.clear();
  //                   setState(() {});
  //                 },
  //                 child: CircleAvatar(
  //                   child: Icon(Icons.close),
  //                   backgroundColor: notifire!.geticoncolor,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       );})
  //     ),
  //   );
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (BuildContext context2) {
  //         return alert2;
  //       });
  // }

  // Future<void> enterUserPasswordAlert(BuildContext context, String phone) async {
  //   enterPassword(context,phone);
  // }

  void addEventToStream(StreamData event) {
    _events.add(event);
  }

  // void enterPassword(BuildContext context, String phone) {
  //   var alert= WillPopScope(
  //     onWillPop: () async => false,
  //     child: AlertDialog(
  //         contentPadding: EdgeInsets.zero,
  //         content:StreamBuilder<StreamData>(
  //             stream: _events.stream,
  //             builder: (BuildContext context, AsyncSnapshot<StreamData> snapshot) {
  //               if (!snapshot.hasData) {
  //                 return SizedBox(
  //                   width: Responsive.isDesktop(context)
  //                       ? 420
  //                       : (Responsive.screenOrientation(context) ==
  //                       Orientation.landscape)
  //                       ? 330
  //                       : (MediaQuery.of(context).size.width>680)&&(MediaQuery.of(context).size.width<900)
  //                       ?MediaQuery.of(context).size.width/1.7:Responsive.isMobile(context) ?MediaQuery.of(context).size.width/1.03
  //                       :MediaQuery.of(context).size.width / 1.03,
  //                   height: MediaQuery.of(context).size.height>1000?500:400,
  //                   child: Center(
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         circularProgress(),
  //                       ],
  //                     ),
  //                   ),
  //                 ); // or some loading indicator
  //               }
  //               final data = snapshot.data!;
  //               return Stack(
  //                 clipBehavior: Clip.none,
  //                 children: <Widget>[
  //                   Form(
  //                     key: _alertPasswordFormKey,
  //                     child: StatefulBuilder(builder: (context2, setState) {
  //                       return SizedBox(
  //                         width: Responsive.isDesktop(context)
  //                             ? 420
  //                             : (Responsive.screenOrientation(context2) ==
  //                             Orientation.landscape)
  //                             ? 330
  //                             : (MediaQuery.of(context).size.width>680)&&(MediaQuery.of(context).size.width<900)
  //                             ?MediaQuery.of(context).size.width/1.7:Responsive.isMobile(context) ?MediaQuery.of(context).size.width/1.03
  //                             :MediaQuery.of(context).size.width / 1.03,
  //                         height: MediaQuery.of(context).size.height>1000?500:400,
  //                         child: SingleChildScrollView(
  //                           child: Padding(
  //                             padding: const EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
  //                             child: Column(
  //                               children: [
  //                                 // Row(
  //                                 //   mainAxisAlignment: MainAxisAlignment.end,
  //                                 //   children: [
  //                                 //     IconButton(
  //                                 //       icon: Icon(
  //                                 //         Icons.cancel,
  //                                 //         color: notifire!.geticoncolor,
  //                                 //       ),
  //                                 //       onPressed: () {
  //                                 //         Navigator.of(context).pop();
  //                                 //         _phoneNoController.clear();
  //                                 //         setState(() {});
  //                                 //       },
  //                                 //     ),
  //                                 //   ],
  //                                 // ),
  //                                 Row(
  //                                   mainAxisAlignment: MainAxisAlignment.center,
  //                                   children: [
  //                                     Text(
  //                                       "commonEnterPassword".tr,
  //                                       style: TextStyle(
  //                                         fontWeight: FontWeight.w700,
  //                                         color: signUpTextFontcolor,
  //                                         fontSize:Get.locale?.languageCode=='ta'?15:17,
  //                                         fontStyle: FontStyle.normal,
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //
  //                                 const SizedBox(
  //                                   height: 10,
  //                                 ),
  //                                 Padding(
  //                                   padding: const EdgeInsets.only(left: 20.0),
  //                                   child: Row(
  //                                     mainAxisAlignment: MainAxisAlignment.start,
  //                                     children: [
  //                                       Text(
  //                                         'phoneNo'.tr,
  //                                         style: TextStyle(
  //                                             fontWeight: FontWeight.bold,
  //                                             fontSize: _getTermsFontSize(context),
  //                                             color: signUpTextFontcolor),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 const SizedBox(
  //                                   height: 10,
  //                                 ),
  //                                 RawKeyboardListener(
  //                                   focusNode: signInAlertRawPhoneNoNode,
  //                                   onKey: (event) async {
  //                                     if (event.isKeyPressed(LogicalKeyboardKey.tab)) {
  //                                       if (_phoneNoController.text == "") {
  //                                         showFailureToast("Please, Enter Phone Number", fToast);
  //                                       } else {
  //                                         // _timer!.cancel();
  //                                         showTimeRow=true;
  //                                         _signInOtpController.clear();
  //                                         _start=60;
  //                                         startTimer();
  //                                         await sendOtpToNewUser(_phoneNoController.text);
  //                                         setState(() {});
  //                                       }
  //                                     }
  //                                   },
  //                                   child: TextFormField(
  //                                     keyboardType: TextInputType.number,
  //                                     inputFormatters: <TextInputFormatter>[
  //                                       new LengthLimitingTextInputFormatter(10),
  //                                       FilteringTextInputFormatter.digitsOnly
  //                                     ],
  //                                     // focusNode: focusNodeOtp,
  //                                     controller: _phoneNoController,
  //                                     readOnly: phone == "" ? false : true,
  //                                     onFieldSubmitted: (value) async {
  //                                       if (_phoneNoController.text == "") {
  //                                         showFailureToast("Please, Enter Phone Number", fToast);
  //                                       } else {
  //                                         // showTimeRow=true;
  //                                         // startTimer();
  //                                         await sendOtpToNewUser(_phoneNoController.text);
  //                                         setState(() {});
  //                                       }
  //                                       // loginUser(_phoneNoController.text,
  //                                       //     _passwordController.text, context);
  //                                       // setState(() {});
  //                                     },
  //                                     decoration: InputDecoration(
  //                                       enabledBorder: OutlineInputBorder(
  //                                           borderRadius: BorderRadius.circular(25),
  //                                           borderSide: const BorderSide(
  //                                             // color: notifire!.isDark
  //                                             //     ? notifire!.geticoncolor
  //                                             //     : Colors.grey.shade200
  //                                           )),
  //                                       border: OutlineInputBorder(
  //                                           borderRadius: BorderRadius.circular(25),
  //                                           borderSide: const BorderSide(
  //                                             // color: notifire!.isDark
  //                                             //     ? notifire!.geticoncolor
  //                                             //     : Colors.grey.shade200
  //                                           )),
  //                                       contentPadding: const EdgeInsets.symmetric(
  //                                           vertical: 5.0, horizontal: 10.0),
  //                                       prefixIcon: SizedBox(
  //                                         height: 20,
  //                                         width: 50,
  //                                         child: Center(
  //                                             child: SvgPicture.asset(
  //                                               "assets/phone-number.svg",
  //                                               height: 18,
  //                                               width: 18,
  //                                               // color: notifire!.geticoncolor,
  //                                             )),
  //                                       ),
  //                                       hintText: 'phoneNo'.tr,
  //                                       hintStyle:  TextStyle(
  //                                           fontFamily: 'WorkSansSemiBold',
  //                                           fontSize: _getTermsFontSize(context)),
  //
  //                                       // prefixIcon: SizedBox(
  //                                       //   height: 20,
  //                                       //   width: 50,
  //                                       //   child: Center(
  //                                       //       child: SvgPicture.asset(
  //                                       //         "assets/keyboard-with-cable.svg",
  //                                       //         height: 18,
  //                                       //         width: 18,
  //                                       //         // color: notifire!.geticoncolor,
  //                                       //       )),
  //                                       // ),
  //                                       // suffixIcon: InkWell(
  //                                       //   onTap: () {
  //                                       //     setState(() {
  //                                       //       _obscureTextPassword =
  //                                       //       !_obscureTextPassword;
  //                                       //     });
  //                                       //   },
  //                                       //   child: Icon(
  //                                       //     _obscureTextPassword
  //                                       //         ? FontAwesomeIcons.eyeSlash
  //                                       //         : FontAwesomeIcons.eye,
  //                                       //     size: 15.0,
  //                                       //     color: Colors.black,
  //                                       //   ),
  //                                       // ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 const SizedBox(
  //                                   height: 19.8,
  //                                 ),
  //                                 Padding(
  //                                   padding: const EdgeInsets.only(left: 20.0),
  //                                   child: Row(
  //                                     mainAxisAlignment: MainAxisAlignment.start,
  //                                     children: [
  //                                       Text(
  //                                         "commonOtp".tr,
  //                                         style: TextStyle(
  //                                             fontWeight: FontWeight.bold,
  //                                             fontSize: _getTermsFontSize(context),
  //                                             color: signUpTextFontcolor),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 const SizedBox(
  //                                   height: 10,
  //                                 ),
  //
  //                                 TextFormField(
  //                                   keyboardType: TextInputType.number,
  //                                   inputFormatters: <TextInputFormatter>[
  //                                     new LengthLimitingTextInputFormatter(4),
  //                                     FilteringTextInputFormatter.digitsOnly
  //                                   ],
  //                                   focusNode: focusNodeOtp,
  //                                   controller: _signInOtpController,
  //                                   onTap: () {
  //                                     signInFirstWidget = 2;
  //                                     setState(() {});
  //                                   },
  //                                   validator: (value) {
  //                                     if (value!.isEmpty) {
  //                                       return "Otp can't be empty";
  //                                     } else if (value.length < 4) {
  //                                       return 'must be equal to 4';
  //                                     } else if (value != backendOtp.toString()) {
  //                                       return 'Otp Incorrect';
  //                                     }
  //                                     return null;
  //                                   },
  //                                   decoration: InputDecoration(
  //                                     enabledBorder: OutlineInputBorder(
  //                                         borderRadius: BorderRadius.circular(25),
  //                                         borderSide: const BorderSide(
  //                                           // color: notifire!.isDark
  //                                           //     ? notifire!.geticoncolor
  //                                           //     : Colors.grey.shade200
  //                                         )),
  //                                     border: OutlineInputBorder(
  //                                         borderRadius: BorderRadius.circular(25),
  //                                         borderSide: const BorderSide(
  //                                           // color: notifire!.isDark
  //                                           //     ? notifire!.geticoncolor
  //                                           //     : Colors.grey.shade200
  //                                         )),
  //                                     contentPadding: const EdgeInsets.symmetric(
  //                                         vertical: 5.0, horizontal: 10.0),
  //                                     hintText: "commonOtp".tr,
  //                                     hintStyle: TextStyle(
  //                                       fontFamily: 'WorkSansSemiBold',
  //                                       fontSize: _getTermsFontSize(context),),
  //                                     // prefixIcon: SizedBox(
  //                                     //   height: 20,
  //                                     //   width: 50,
  //                                     //   child: Center(
  //                                     //       child: SvgPicture.asset(
  //                                     //         "assets/keyboard-with-cable.svg",
  //                                     //         height: 18,
  //                                     //         width: 18,
  //                                     //         // color: notifire!.geticoncolor,
  //                                     //       )),
  //                                     // ),
  //                                     // suffixIcon: InkWell(
  //                                     //   onTap: () {
  //                                     //     setState(() {
  //                                     //       _obscureTextPassword =
  //                                     //       !_obscureTextPassword;
  //                                     //     });
  //                                     //   },
  //                                     //   child: Icon(
  //                                     //     _obscureTextPassword
  //                                     //         ? FontAwesomeIcons.eyeSlash
  //                                     //         : FontAwesomeIcons.eye,
  //                                     //     size: 15.0,
  //                                     //     color: Colors.black,
  //                                     //   ),
  //                                     // ),
  //                                   ),
  //                                 ),
  //                                 const SizedBox(
  //                                   height: 10.0,
  //                                 ),
  //                                 (snapshot.data!.showTimeRow==true)?
  //                                 Padding(
  //                                   padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
  //                                   child: Row(
  //                                     mainAxisAlignment: MainAxisAlignment.end,
  //                                     children: [
  //                                       AutoSizeText(
  //                                         "otpExpiry".tr,
  //                                         style: const TextStyle(
  //                                           color: mainColor,
  //                                           fontWeight: FontWeight.w400,
  //                                           fontStyle: FontStyle.normal,
  //                                           fontSize: 15.0,
  //                                         ),
  //                                       ),
  //                                       Text("${snapshot.data!.timerValue.toString()}", style: const TextStyle(
  //                                         color: actionColor,
  //                                         fontWeight: FontWeight.w400,
  //                                         fontStyle: FontStyle.normal,
  //                                         fontSize: 18.0,
  //                                       ),),
  //                                       AutoSizeText(
  //                                         "commonSeconds".tr,
  //                                         style: const TextStyle(
  //                                           color: mainColor,
  //                                           fontWeight: FontWeight.w400,
  //                                           fontStyle: FontStyle.normal,
  //                                           fontSize: 18.0,
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 )
  //                                     :Container(),
  //                                 (snapshot.data!.showResentOtp==true)?
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.end,
  //                             children: [
  //
  //                               TextButton(
  //                                   onPressed: () async {
  //                                     showTimeRow=true;
  //                                     _signInOtpController.clear();
  //                                     _start=60;
  //                                     startTimer();
  //                                     await sendOtpToNewUser(_phoneNoController.text);
  //                                     setState(() {});
  //                                   },
  //                                   child: Text(
  //                                     "commonResendOTP".tr,
  //                                     style: TextStyle(
  //                                         decoration: TextDecoration.underline,
  //                                         color: cyan,
  //                                         fontSize: 16.0,
  //                                         fontFamily: 'WorkSansMedium'),
  //                                   )),
  //                             ],
  //                           ):Container(),
  //
  //                                 Padding(
  //                                   padding: const EdgeInsets.only(left: 20.0),
  //                                   child: Row(
  //                                     mainAxisAlignment: MainAxisAlignment.start,
  //                                     children: [
  //                                       Text(
  //                                         'password'.tr,
  //                                         style: TextStyle(
  //                                             fontWeight: FontWeight.bold,
  //                                             fontSize: _getTermsFontSize(context),
  //                                             color: signUpTextFontcolor),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 const SizedBox(
  //                                   height: 10,
  //                                 ),
  //                                 TextFormField(
  //                                   focusNode: focusNodeSignInPassword,
  //                                   controller: _signInPasswordController,
  //
  //                                   validator: (value) {
  //                                     if (value!.isEmpty) {
  //                                       return "Password can't be empty";
  //                                     } else if (value.length < 5) {
  //                                       return 'must be greater than 5';
  //                                     }
  //                                     return null;
  //                                   },
  //                                   obscureText: _obscureSignInTextPassword,
  //                                   // style: const TextStyle(
  //                                   //     fontFamily: 'WorkSansSemiBold',
  //                                   //     fontSize: 16.0,
  //                                   //     color: backGround),
  //                                   decoration: InputDecoration(
  //                                     enabledBorder: OutlineInputBorder(
  //                                         borderRadius: BorderRadius.circular(25),
  //                                         borderSide: const BorderSide(
  //                                           // color: notifire!.isDark
  //                                           //     ? notifire!.geticoncolor
  //                                           //     : Colors.grey.shade200
  //                                         )),
  //                                     border: OutlineInputBorder(
  //                                         borderRadius: BorderRadius.circular(25),
  //                                         borderSide: const BorderSide(
  //                                           // color: notifire!.isDark
  //                                           //     ? notifire!.geticoncolor
  //                                           //     : Colors.grey.shade200
  //                                         )),
  //                                     contentPadding: const EdgeInsets.symmetric(
  //                                         vertical: 5.0, horizontal: 10.0),
  //                                     hintText: 'password'.tr,
  //                                     hintStyle:  TextStyle(
  //                                       fontFamily: 'WorkSansSemiBold',
  //                                       fontSize: _getTermsFontSize(context),),
  //                                     prefixIcon: SizedBox(
  //                                       height: 20,
  //                                       width: 50,
  //                                       child: Center(
  //                                           child: SvgPicture.asset(
  //                                             "assets/keyboard-with-cable.svg",
  //                                             height: 18,
  //                                             width: 18,
  //                                             // color: notifire!.geticoncolor,
  //                                           )),
  //                                     ),
  //                                     suffixIcon: InkWell(
  //                                       onTap: () {
  //                                         setState(() {
  //                                           _obscureSignInTextPassword =
  //                                           !_obscureSignInTextPassword;
  //                                         });
  //                                       },
  //                                       child: Icon(
  //                                         _obscureSignInTextPassword
  //                                             ? FontAwesomeIcons.eyeSlash
  //                                             : FontAwesomeIcons.eye,
  //                                         size: 15.0,
  //                                         color: Colors.black,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   // onSubmitted: (_) {
  //                                   //   _toggleSignInButton();
  //                                   // },
  //                                   textInputAction: TextInputAction.go,
  //                                 ),
  //                                 const SizedBox(
  //                                   height: 19.8,
  //                                 ),
  //                                 Padding(
  //                                   padding: const EdgeInsets.only(left: 20.0),
  //                                   child: Row(
  //                                     mainAxisAlignment: MainAxisAlignment.start,
  //                                     children: [
  //                                       Text(
  //                                         'confirm_password'.tr,
  //                                         style: TextStyle(
  //                                             fontWeight: FontWeight.bold,
  //                                             fontSize: _getTermsFontSize(context),
  //                                             color: signUpTextFontcolor),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 const SizedBox(
  //                                   height: 10,
  //                                 ),
  //                                 TextFormField(
  //                                   focusNode: focusNodeSignInConfirmPassword,
  //                                   controller: _signInPassword2Controller,
  //
  //                                   validator: (value) {
  //                                     if (value!.isEmpty) {
  //                                       return "Password can't be empty";
  //                                     } else if (value.length < 5) {
  //                                       return 'must be greater than 5';
  //                                     }
  //                                     return null;
  //                                   },
  //                                   obscureText: _obscureSignInConfirmTextPassword,
  //                                   // style: const TextStyle(
  //                                   //     fontFamily: 'WorkSansSemiBold',
  //                                   //     fontSize: 16.0,
  //                                   //     color: backGround),
  //                                   decoration: InputDecoration(
  //                                     enabledBorder: OutlineInputBorder(
  //                                         borderRadius: BorderRadius.circular(25),
  //                                         borderSide: const BorderSide(
  //                                           // color: notifire!.isDark
  //                                           //     ? notifire!.geticoncolor
  //                                           //     : Colors.grey.shade200
  //                                         )),
  //                                     border: OutlineInputBorder(
  //                                         borderRadius: BorderRadius.circular(25),
  //                                         borderSide: const BorderSide(
  //                                           // color: notifire!.isDark
  //                                           //     ? notifire!.geticoncolor
  //                                           //     : Colors.grey.shade200
  //                                         )),
  //                                     contentPadding: const EdgeInsets.symmetric(
  //                                         vertical: 5.0, horizontal: 10.0),
  //                                     hintText: "password".tr,
  //                                     hintStyle:  TextStyle(
  //                                         fontFamily: 'WorkSansSemiBold',
  //                                         fontSize: _getTermsFontSize(context)),
  //                                     prefixIcon: SizedBox(
  //                                       height: 20,
  //                                       width: 50,
  //                                       child: Center(
  //                                           child: SvgPicture.asset(
  //                                             "assets/keyboard-with-cable.svg",
  //                                             height: 18,
  //                                             width: 18,
  //                                             // color: notifire!.geticoncolor,
  //                                           )),
  //                                     ),
  //                                     suffixIcon: InkWell(
  //                                       onTap: () {
  //                                         setState(() {
  //                                           _obscureSignInConfirmTextPassword =
  //                                           !_obscureSignInConfirmTextPassword;
  //                                         });
  //                                       },
  //                                       child: Icon(
  //                                         _obscureSignInConfirmTextPassword
  //                                             ? FontAwesomeIcons.eyeSlash
  //                                             : FontAwesomeIcons.eye,
  //                                         size: 15.0,
  //                                         color: Colors.black,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   // onSubmitted: (_) {
  //                                   //   _toggleSignInButton();
  //                                   // },
  //                                   textInputAction: TextInputAction.go,
  //                                 ),
  //                                 const SizedBox(
  //                                   height: 19.8,
  //                                 ),
  //                                 passwordButtonWidget(setState),
  //                                 const SizedBox(
  //                                   height: 10,
  //                                 )
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       );
  //                     }),
  //                   ),
  //                   Positioned(
  //                     right: -10.0,
  //                     top: -10.0,
  //                     child: Material(
  //                       color: Colors.transparent,
  //                       child: InkWell(
  //                         onTap: () {
  //                           // This onTap callback will be triggered when tapping the CircleAvatar.
  //                           // You can handle it to perform specific actions.
  //                           Navigator.of(context).pop();
  //                           showResentOtp=false;
  //                           _phoneNoController.clear();
  //                           _signInOtpController.clear();
  //                           _signInPasswordController.clear();
  //                           _signInPassword2Controller.clear();
  //                           _otpController.clear();
  //                           setState(() {});
  //                         },
  //                         child: CircleAvatar(
  //                           backgroundColor: notifire!.geticoncolor,
  //                           child: Icon(Icons.close),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               );
  //             })
  //     ),
  //   );
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context2) {
  //       return alert;
  //     },
  //   );
  //
  //
  // }


  // Future<void> showIdCardAlertDialog(BuildContext context, String url) async {
  //   showIdCard(context,url);
  // }

  // void showIdCard( BuildContext context, String url) {
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context2) {
  //       return WillPopScope(
  //         onWillPop: () async => false,
  //         child: AlertDialog(
  //           contentPadding: EdgeInsets.zero,
  //           content: Stack(
  //             clipBehavior: Clip.none,
  //             children: <Widget>[
  //               Form(
  //                 key: _alertIdcardFormKey,
  //                 child: StatefulBuilder(builder: (context2, setState) {
  //                   return SizedBox(
  //                     width: Responsive.isDesktop(context)
  //                         ? 500
  //                         : (Responsive.screenOrientation(context2) ==
  //                         Orientation.landscape)
  //                         ? 410
  //                         : 350,
  //                     height: Responsive.isDesktop(context)
  //                         ? 340
  //                         : (Responsive.screenOrientation(context2) ==
  //                         Orientation.landscape)
  //                         ? 286
  //                         : 250,
  //                     child: SingleChildScrollView(
  //                       child: Padding(
  //                         padding: const EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
  //                         child: Column(
  //                           children: [
  //                             const SizedBox(
  //                               height: 10,
  //                             ),
  //                             !kIsWeb?Image.memory(
  //                               base64Decode(url),
  //                               width: Responsive.isDesktop(context)
  //                                   ? 470
  //                                   : (Responsive.screenOrientation(context2) ==
  //                                   Orientation.landscape)
  //                                   ? 380
  //                                   : 320,
  //                               height: Responsive.isDesktop(context)
  //                                   ? 270
  //                                   : (Responsive.screenOrientation(context2) ==
  //                                   Orientation.landscape)
  //                                   ? 216
  //                                   : 180,
  //                               fit: BoxFit.fill,
  //                             ):Container(
  //                               width: Responsive.isDesktop(context)
  //                                   ? 470
  //                                   : (Responsive.screenOrientation(context2) ==
  //                                   Orientation.landscape)
  //                                   ? 380
  //                                   : 320,
  //                               height: Responsive.isDesktop(context)
  //                                   ? 270
  //                                   : (Responsive.screenOrientation(context2) ==
  //                                   Orientation.landscape)
  //                                   ? 216
  //                                   : 180,
  //                               decoration: BoxDecoration(
  //                                 // shape: BoxShape.circle,
  //                                 color: const Color(0xff7c94b6),
  //                                 image: DecorationImage(
  //                                   image: NetworkImage(url),
  //                                   fit: BoxFit.fill,
  //                                 ),
  //                                 // borderRadius: BorderRadius.all( Radius.circular(50.0)),
  //                                 border: Border.all(
  //                                   // color: Colors.red,
  //                                   width: 1.0,
  //                                 ),
  //                               ),
  //                             ),
  //                             const SizedBox(
  //                               height: 10,
  //                             ),
  //                             downloadButton(setState,url),
  //                             const SizedBox(
  //                               height: 10,
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   );
  //                 }),
  //               ),
  //               Positioned(
  //                 right: -10.0,
  //                 top: -10.0,
  //                 child: Material(
  //                   color: Colors.transparent,
  //                   child: InkWell(
  //                     onTap: () {
  //                       _tabController.animateTo(0);
  //                       _userPhoneNoController.clear();
  //                       _otpController.clear();
  //                       result = null;
  //                       result1 = null;
  //                       result2 = null;
  //                       _imageSelected = false;
  //                       _image2Selected = false;
  //                       _image3Selected = false;
  //                       _password1Controller.clear();
  //                       optSent = false;
  //                       Navigator.of(context).pop();
  //                       setState(() {});
  //                       showSuccessToast("Please, proceed to Login", fToast);
  //                     },
  //                     child: CircleAvatar(
  //                       backgroundColor: notifire!.geticoncolor,
  //                       child: Icon(Icons.close),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  //
  // }

  Future<void> showMobileDialog() async {
    await Future.delayed(const Duration(milliseconds: 50));
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              // contentPadding: EdgeInsets.only(top: 12, left: 24, bottom: 20),
              insetPadding: EdgeInsets.symmetric(horizontal: 15),
              content: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Form(
                    key: _mobileFormKey,
                    child: StatefulBuilder(builder: (context2, setState) {
                      return SizedBox(
                        width: Responsive.isDesktop(context)
                            ? 400
                            : (Responsive.screenOrientation(context2) ==
                            Orientation.landscape)
                            ? 330
                            : Responsive.isTab(context2)
                            ? 330
                            : MediaQuery.of(context).size.width / 1.15,
                        height: 500,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  'Privacy Policy',
                                  style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Text(
                                'Privacy Policy',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 20),
                              AutoSizeText(
                                'Tamilaga Vettri Kazhagam (“TVK“, “we”, “us”, “our”) are committed to respecting your online privacy and recognize the need for appropriate protection and management of any personally identifiable information you share with us. This Privacy Policy (“Policy”) describes how we collects, uses, discloses and transfers personal information of users through its websites and applications, including through https://thuli.tamilagavettrikazhagam.org, https://join.tamilagavettrikazhagam.org web portal and mobile applications (collectively, the “Platform”).',
                                minFontSize: 2,
                                maxFontSize: 14,
                                style: TextStyle(fontWeight: FontWeight.w500,height: 2),
                                maxLines: 30,
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              AutoSizeText(
                                'If you choose to use our Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that we collect is used for providing and improving the Service. we will not use or share your information with anyone except as described in this Privacy Policy.',
                                minFontSize: 2,
                                maxFontSize: 14,
                                style: TextStyle(fontWeight: FontWeight.w500,height: 2),
                                maxLines: 30,
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              AutoSizeText(
                                'The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at Tamilaga Vettri Kazhagam unless otherwise defined in this Privacy Policy.',
                                minFontSize: 2,
                                maxFontSize: 14,
                                style: TextStyle(fontWeight: FontWeight.w500,height: 2),
                                maxLines: 30,
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 30),
                              Text(
                                'Information Collection and Use',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 20),
                              AutoSizeText(
                                'For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to Name , Age , Contact number. The information that we request will be retained by us and used as described in this privacy policy.',
                                minFontSize: 2,
                                maxFontSize: 14,
                                style: TextStyle(fontWeight: FontWeight.w500,height: 2),
                                maxLines: 30,
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              AutoSizeText(
                                'The platform does use third party services that may collect information used to identify you.',
                                minFontSize: 2,
                                maxFontSize: 14,
                                style: TextStyle(fontWeight: FontWeight.w500,height: 2),
                                maxLines: 30,
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              AutoSizeText(
                                'Link to privacy policy of third party service providers used by the app',
                                minFontSize: 2,
                                maxFontSize: 14,
                                style: TextStyle(fontWeight: FontWeight.w500,height: 2),
                                maxLines: 30,
                                textAlign: TextAlign.justify,
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    height: 2,
                                  ),
                                  children: [
                                    WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Text('•', style: TextStyle(fontSize: 14)),
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Google Play Services\n',
                                    ),
                                    WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Text('•', style: TextStyle(fontSize: 14)),
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Google Analytics for Firebase\n',
                                    ),
                                  ],
                                ),
                              ),
                              //SizedBox(height: 20),
                              Text(
                                'Log Data',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 30),
                              AutoSizeText(
                                'We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.',
                                minFontSize: 2,
                                maxFontSize: 14,
                                style: TextStyle(fontWeight: FontWeight.w500,height: 2),
                                maxLines: 30,
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Log Data',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 20),
                              AutoSizeText(
                                'We want to inform you that whenever you use our Service, in a case of an error in the app we collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our Service, the time and date of your use of the Service, and other statistics.',
                                minFontSize: 2,
                                maxFontSize: 14,
                                style: TextStyle(fontWeight: FontWeight.w500,height: 2),
                                maxLines: 30,
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Cookies',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 20),
                              AutoSizeText(
                                'Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device’s internal memory.',
                                minFontSize: 2,
                                maxFontSize: 14,
                                style: TextStyle(fontWeight: FontWeight.w500,height: 2),
                                maxLines: 30,
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              AutoSizeText(
                                'This Service does not use these “cookies” explicitly. However, the app may use third party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.',
                                minFontSize: 2,
                                maxFontSize: 14,
                                style: TextStyle(fontWeight: FontWeight.w500,height: 2),
                                maxLines: 30,
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Service Providers',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 20),
                              AutoSizeText(
                                'We may employ third-party companies and individuals due to the following reasons:',
                                minFontSize: 2,
                                maxFontSize: 14,
                                style: TextStyle(fontWeight: FontWeight.w500,height: 2),
                                maxLines: 30,
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    height: 2,
                                  ),
                                  children: [
                                    WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Text('•', style: TextStyle(fontSize: 14)),
                                      ),
                                    ),

                                    TextSpan(
                                      text: 'To facilitate our Service;\n',
                                    ),
                                    WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Text('•', style: TextStyle(fontSize: 14)),
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'To provide the Service on our behalf;\n',
                                    ),
                                    WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Text('•', style: TextStyle(fontSize: 14)),
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'To perform Service-related services; or\n',
                                    ),
                                    WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Text('•', style: TextStyle(fontSize: 14)),
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'To assist us in analyzing how our Service is used.\n',
                                    ),
                                  ],
                                ),
                              ),
                              AutoSizeText(
                                'we want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.',
                                minFontSize: 2,
                                maxFontSize: 14,
                                style: TextStyle(fontWeight: FontWeight.w500,height: 2),
                                maxLines: 30,
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Security',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 20),
                              AutoSizeText(
                                'We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security.',
                                minFontSize: 2,
                                maxFontSize: 14,
                                style: TextStyle(fontWeight: FontWeight.w500,height: 2),
                                maxLines: 30,
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Links to Other Sites',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 20),
                              AutoSizeText(
                                'This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by us. Therefore, we strongly advise you to review the Privacy Policy of these websites. we have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.',
                                minFontSize: 2,
                                maxFontSize: 14,
                                style: TextStyle(fontWeight: FontWeight.w500,height: 2),
                                maxLines: 30,
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Children’s Privacy',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 20),
                              AutoSizeText(
                                'These Services do not address anyone under the age of 13. we do not knowingly collect personally identifiable information from children under 13. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to do necessary actions.',
                                minFontSize: 2,
                                maxFontSize: 14,
                                style: TextStyle(fontWeight: FontWeight.w500,height: 2),
                                maxLines: 30,
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Changes to This Privacy Policy',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 20),
                              AutoSizeText(
                                'We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. we will notify you of any changes by posting the new Privacy Policy on this page.',
                                minFontSize: 2,
                                maxFontSize: 14,
                                style: TextStyle(fontWeight: FontWeight.w500,height: 2),
                                maxLines: 30,
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              AutoSizeText(
                                'This policy is effective as of 2020-05-26',
                                minFontSize: 2,
                                maxFontSize: 14,
                                style: TextStyle(fontWeight: FontWeight.w500,height: 2),
                                maxLines: 30,
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Contact Us',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 20),
                              AutoSizeText(
                                'If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at itadmin@tamilagavettrikazhagam.org.',
                                minFontSize: 2,
                                maxFontSize: 14,
                                style: TextStyle(fontWeight: FontWeight.w500,height: 2),
                                maxLines: 30,
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(height: 20),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    {
                                      checkedTrue();
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: Text(
                                    'Agree'.tr,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                          // Column(
                          //   children: [
                          //     Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         Text(
                          //           'commonUserReference'.tr,
                          //           style: TextStyle(
                          //             fontWeight: FontWeight.w700,
                          //             color: signUpTextFontcolor,
                          //             fontSize: 17.0,
                          //             fontStyle: FontStyle.normal,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //     const SizedBox(
                          //       height: 30,
                          //     ),
                          //     Container(
                          //       height: Responsive.isDesktop(context)
                          //           ? 300
                          //           : (Responsive.screenOrientation(context2) ==
                          //           Orientation.landscape)
                          //           ? 200
                          //           : 350.0,
                          //       width: 500.0,
                          //
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(12),
                          //         // color: Colors.green
                          //       ),
                          //       child: SingleChildScrollView(
                          //         child: Padding(
                          //           padding: const EdgeInsets.all(10.0),
                          //           child: Center(
                          //             child: Column(
                          //               children: [
                          //                 Padding(
                          //                   padding: const EdgeInsets.all(5.0),
                          //                   child: Text(
                          //                     'tvk_Pledge'.tr,
                          //                     textAlign: TextAlign.center,
                          //                     style: TextStyle(
                          //                         fontSize: 16.0,
                          //                         // Adjust font size as needed
                          //                         fontWeight: FontWeight.w700,
                          //                         color:
                          //                         signUpTextFontcolor // Apply bold font weight
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 const SizedBox(height: 10),
                          //                 Padding(
                          //                   padding: const EdgeInsets.only(
                          //                       left: 10.0),
                          //                   child: Row(
                          //                     children: [
                          //                       Flexible(
                          //                         child: AutoSizeText(
                          //                               'pledge_line_1'.tr + ' ' + 'pledge_line_2'.tr+ ' ' + 'pledge_line_3'.tr + '\n'+'\n'+
                          //                               'pledge_line_4'.tr+ ' ' + 'pledge_line_5'.tr + '\n'+ '\n'+'pledge_line_6'.tr + ' ' + 'pledge_line_7'.tr+ ' ' + 'pledge_line_8'.tr + ' '+
                          //                               'pledge_line_9'.tr+ ' ' + 'pledge_line_10'.tr + ' '+ 'pledge_line_11'.tr + ' '+ '\n'+ '\n'+
                          //                               'pledge_line_12'.tr+ ' ' + 'pledge_line_13'.tr + ' '+ 'pledge_line_14'.tr + ' '+ 'pledge_line_15'.tr + ' ' + 'pledge_line_16'.tr,
                          //                           minFontSize: 2,
                          //                           maxFontSize: 10,
                          //                           style: TextStyle(
                          //                               // fontSize:
                          //                               // _getAlertFontSize(
                          //                               //     context2),
                          //                               // fontSize:14,
                          //                               fontWeight:
                          //                               FontWeight.w700),
                          //                           maxLines: 30,
                          //                           textAlign: TextAlign.justify, // Set text alignment to justify
                          //                           // Adjust font size as needed
                          //                           // textAlign:
                          //                           // TextAlign.justify,
                          //                           // Adjust text alignment as needed
                          //                         ),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ),
                          //                 // Padding(
                          //                 //   padding: const EdgeInsets.only(
                          //                 //       left: 10.0),
                          //                 //   child: Row(
                          //                 //     mainAxisAlignment:
                          //                 //     MainAxisAlignment.start,
                          //                 //     children: [
                          //                 //       Flexible(
                          //                 //         child: Text(
                          //                 //           'pledge_line_2'.tr,
                          //                 //           style: TextStyle(
                          //                 //               fontSize:
                          //                 //               _getAlertFontSize(
                          //                 //                   context),
                          //                 //               fontWeight:
                          //                 //               FontWeight.w700,
                          //                 //           ),
                          //                 //           // Adjust font size as needed
                          //                 //           // textAlign:
                          //                 //           // TextAlign.justify,
                          //                 //           // Adjust text alignment as needed
                          //                 //         ),
                          //                 //       ),
                          //                 //     ],
                          //                 //   ),
                          //                 // ),
                          //                 // Padding(
                          //                 //   padding: const EdgeInsets.only(
                          //                 //       left: 10.0),
                          //                 //   child: Row(
                          //                 //     mainAxisAlignment:
                          //                 //     MainAxisAlignment.start,
                          //                 //     children: [
                          //                 //       Flexible(
                          //                 //         child: Text(
                          //                 //           'pledge_line_3'.tr,
                          //                 //           style: TextStyle(
                          //                 //               fontSize:
                          //                 //               _getAlertFontSize(
                          //                 //                   context),
                          //                 //               fontWeight:
                          //                 //               FontWeight.w700),
                          //                 //           // Adjust font size as needed
                          //                 //           // textAlign:
                          //                 //           // TextAlign.justify,
                          //                 //           // Adjust text alignment as needed
                          //                 //         ),
                          //                 //       ),
                          //                 //     ],
                          //                 //   ),
                          //                 // ),
                          //                 // const SizedBox(height: 10),
                          //                 // Padding(
                          //                 //   padding: const EdgeInsets.only(
                          //                 //       left: 10.0),
                          //                 //   child: Row(
                          //                 //     mainAxisAlignment:
                          //                 //     MainAxisAlignment.start,
                          //                 //     children: [
                          //                 //       Flexible(
                          //                 //         child: Text(
                          //                 //           'pledge_line_4'.tr,
                          //                 //           style: TextStyle(
                          //                 //               fontSize:
                          //                 //               _getAlertFontSize(
                          //                 //                   context),
                          //                 //               fontWeight:
                          //                 //               FontWeight.w700),
                          //                 //           // Adjust font size as needed
                          //                 //           // textAlign:
                          //                 //           // TextAlign.justify,
                          //                 //           // Adjust text alignment as needed
                          //                 //         ),
                          //                 //       ),
                          //                 //     ],
                          //                 //   ),
                          //                 // ),
                          //                 // Padding(
                          //                 //   padding: const EdgeInsets.only(
                          //                 //       left: 10.0),
                          //                 //   child: Row(
                          //                 //     mainAxisAlignment:
                          //                 //     MainAxisAlignment.start,
                          //                 //     children: [
                          //                 //       Flexible(
                          //                 //         child: Text(
                          //                 //           'pledge_line_5'.tr,
                          //                 //           style: TextStyle(
                          //                 //               fontSize:
                          //                 //               _getAlertFontSize(
                          //                 //                   context),
                          //                 //               fontWeight:
                          //                 //               FontWeight.w700),
                          //                 //           // Adjust font size as needed
                          //                 //           // textAlign:
                          //                 //           // TextAlign.justify,
                          //                 //           // Adjust text alignment as needed
                          //                 //         ),
                          //                 //       ),
                          //                 //     ],
                          //                 //   ),
                          //                 // ),
                          //                 // const SizedBox(height: 10),
                          //                 // Padding(
                          //                 //   padding: const EdgeInsets.only(
                          //                 //       left: 10.0),
                          //                 //   child: Row(
                          //                 //     mainAxisAlignment:
                          //                 //     MainAxisAlignment.start,
                          //                 //     children: [
                          //                 //       Flexible(
                          //                 //         child: Text(
                          //                 //           'pledge_line_6'.tr,
                          //                 //           style: TextStyle(
                          //                 //               fontSize:
                          //                 //               _getAlertFontSize(
                          //                 //                   context),
                          //                 //               fontWeight:
                          //                 //               FontWeight.w700),
                          //                 //           // Adjust font size as needed
                          //                 //           // textAlign:
                          //                 //           // TextAlign.justify,
                          //                 //           // Adjust text alignment as needed
                          //                 //         ),
                          //                 //       ),
                          //                 //     ],
                          //                 //   ),
                          //                 // ),
                          //                 // Padding(
                          //                 //   padding: const EdgeInsets.only(
                          //                 //       left: 10.0),
                          //                 //   child: Row(
                          //                 //     mainAxisAlignment:
                          //                 //     MainAxisAlignment.start,
                          //                 //     children: [
                          //                 //       Flexible(
                          //                 //         child: Text(
                          //                 //           'pledge_line_7'.tr,
                          //                 //           style: TextStyle(
                          //                 //               fontSize:
                          //                 //               _getAlertFontSize(
                          //                 //                   context),
                          //                 //               fontWeight:
                          //                 //               FontWeight.w700),
                          //                 //           // Adjust font size as needed
                          //                 //           // textAlign:
                          //                 //           // TextAlign.justify,
                          //                 //           // Adjust text alignment as needed
                          //                 //         ),
                          //                 //       ),
                          //                 //     ],
                          //                 //   ),
                          //                 // ),
                          //                 // Padding(
                          //                 //   padding: const EdgeInsets.only(
                          //                 //       left: 10.0),
                          //                 //   child: Row(
                          //                 //     mainAxisAlignment:
                          //                 //     MainAxisAlignment.start,
                          //                 //     children: [
                          //                 //       Flexible(
                          //                 //         child: Text(
                          //                 //           'pledge_line_8'.tr,
                          //                 //           style: TextStyle(
                          //                 //               fontSize:
                          //                 //               _getAlertFontSize(
                          //                 //                   context),
                          //                 //               fontWeight:
                          //                 //               FontWeight.w700),
                          //                 //           // Adjust font size as needed
                          //                 //           // textAlign:
                          //                 //           // TextAlign.justify,
                          //                 //           // Adjust text alignment as needed
                          //                 //         ),
                          //                 //       ),
                          //                 //     ],
                          //                 //   ),
                          //                 // ),
                          //                 // Padding(
                          //                 //   padding: const EdgeInsets.only(
                          //                 //       left: 10.0),
                          //                 //   child: Row(
                          //                 //     mainAxisAlignment:
                          //                 //     MainAxisAlignment.start,
                          //                 //     children: [
                          //                 //       Flexible(
                          //                 //         child: Text(
                          //                 //           'pledge_line_9'.tr,
                          //                 //           style: TextStyle(
                          //                 //               fontSize:
                          //                 //               _getAlertFontSize(
                          //                 //                   context),
                          //                 //               fontWeight:
                          //                 //               FontWeight.w700),
                          //                 //           // Adjust font size as needed
                          //                 //           // textAlign:
                          //                 //           // TextAlign.justify,
                          //                 //           // Adjust text alignment as needed
                          //                 //         ),
                          //                 //       ),
                          //                 //     ],
                          //                 //   ),
                          //                 // ),
                          //                 // Padding(
                          //                 //   padding: const EdgeInsets.only(
                          //                 //       left: 10.0),
                          //                 //   child: Row(
                          //                 //     mainAxisAlignment:
                          //                 //     MainAxisAlignment.start,
                          //                 //     children: [
                          //                 //       Flexible(
                          //                 //         child: Text(
                          //                 //           'pledge_line_10'.tr,
                          //                 //           style: TextStyle(
                          //                 //               fontSize:
                          //                 //               _getAlertFontSize(
                          //                 //                   context),
                          //                 //               fontWeight:
                          //                 //               FontWeight.w700),
                          //                 //           // Adjust font size as needed
                          //                 //           // textAlign:
                          //                 //           // TextAlign.justify,
                          //                 //           // Adjust text alignment as needed
                          //                 //         ),
                          //                 //       ),
                          //                 //     ],
                          //                 //   ),
                          //                 // ),
                          //                 // Padding(
                          //                 //   padding: const EdgeInsets.only(
                          //                 //       left: 10.0),
                          //                 //   child: Row(
                          //                 //     mainAxisAlignment:
                          //                 //     MainAxisAlignment.start,
                          //                 //     children: [
                          //                 //       Flexible(
                          //                 //         child: Text(
                          //                 //           'pledge_line_11'.tr,
                          //                 //           style: TextStyle(
                          //                 //               fontSize:
                          //                 //               _getAlertFontSize(
                          //                 //                   context),
                          //                 //               fontWeight:
                          //                 //               FontWeight.w700),
                          //                 //           // Adjust font size as needed
                          //                 //           textAlign:
                          //                 //           TextAlign.justify,
                          //                 //           // Adjust text alignment as needed
                          //                 //         ),
                          //                 //       ),
                          //                 //     ],
                          //                 //   ),
                          //                 // ),
                          //                 // const SizedBox(height: 10),
                          //                 // Padding(
                          //                 //   padding: const EdgeInsets.only(
                          //                 //       left: 10.0),
                          //                 //   child: Row(
                          //                 //     mainAxisAlignment:
                          //                 //     MainAxisAlignment.start,
                          //                 //     children: [
                          //                 //       Flexible(
                          //                 //         child: Text(
                          //                 //           'pledge_line_12'.tr,
                          //                 //           style: TextStyle(
                          //                 //               fontSize:
                          //                 //               _getAlertFontSize(
                          //                 //                   context),
                          //                 //               fontWeight:
                          //                 //               FontWeight.w700),
                          //                 //           // Adjust font size as needed
                          //                 //           textAlign:
                          //                 //           TextAlign.justify,
                          //                 //           // Adjust text alignment as needed
                          //                 //         ),
                          //                 //       ),
                          //                 //     ],
                          //                 //   ),
                          //                 // ),
                          //                 // Padding(
                          //                 //   padding: const EdgeInsets.only(
                          //                 //       left: 10.0),
                          //                 //   child: Row(
                          //                 //     mainAxisAlignment:
                          //                 //     MainAxisAlignment.start,
                          //                 //     children: [
                          //                 //       Flexible(
                          //                 //         child: Text(
                          //                 //           'pledge_line_13'.tr,
                          //                 //           style: TextStyle(
                          //                 //               fontSize:
                          //                 //               _getAlertFontSize(
                          //                 //                   context),
                          //                 //               fontWeight:
                          //                 //               FontWeight.w700),
                          //                 //           // Adjust font size as needed
                          //                 //           textAlign:
                          //                 //           TextAlign.justify,
                          //                 //           // Adjust text alignment as needed
                          //                 //         ),
                          //                 //       ),
                          //                 //     ],
                          //                 //   ),
                          //                 // ),
                          //                 // Padding(
                          //                 //   padding: const EdgeInsets.only(
                          //                 //       left: 10.0),
                          //                 //   child: Row(
                          //                 //     mainAxisAlignment:
                          //                 //     MainAxisAlignment.start,
                          //                 //     children: [
                          //                 //       Flexible(
                          //                 //         child: Text(
                          //                 //           'pledge_line_14'.tr,
                          //                 //           style: TextStyle(
                          //                 //               fontSize:
                          //                 //               _getAlertFontSize(
                          //                 //                   context),
                          //                 //               fontWeight:
                          //                 //               FontWeight.w700),
                          //                 //           // Adjust font size as needed
                          //                 //           textAlign:
                          //                 //           TextAlign.justify,
                          //                 //           // Adjust text alignment as needed
                          //                 //         ),
                          //                 //       ),
                          //                 //     ],
                          //                 //   ),
                          //                 // ),
                          //                 // Padding(
                          //                 //   padding: const EdgeInsets.only(
                          //                 //       left: 10.0),
                          //                 //   child: Row(
                          //                 //     mainAxisAlignment:
                          //                 //     MainAxisAlignment.start,
                          //                 //     children: [
                          //                 //       Flexible(
                          //                 //         child: Text(
                          //                 //           'pledge_line_15'.tr,
                          //                 //           style: TextStyle(
                          //                 //               fontSize:
                          //                 //               _getAlertFontSize(
                          //                 //                   context),
                          //                 //               fontWeight:
                          //                 //               FontWeight.w700),
                          //                 //           // Adjust font size as needed
                          //                 //           textAlign:
                          //                 //           TextAlign.justify,
                          //                 //           // Adjust text alignment as needed
                          //                 //         ),
                          //                 //       ),
                          //                 //     ],
                          //                 //   ),
                          //                 // ),
                          //                 // Padding(
                          //                 //   padding: const EdgeInsets.only(
                          //                 //       left: 10.0),
                          //                 //   child: Row(
                          //                 //     mainAxisAlignment:
                          //                 //     MainAxisAlignment.start,
                          //                 //     children: [
                          //                 //       Flexible(
                          //                 //         child: Text(
                          //                 //           'pledge_line_16'.tr,
                          //                 //           style: TextStyle(
                          //                 //               fontSize:
                          //                 //               _getAlertFontSize(
                          //                 //                   context),
                          //                 //               fontWeight:
                          //                 //               FontWeight.w700),
                          //                 //           // Adjust font size as needed
                          //                 //           textAlign:
                          //                 //           TextAlign.justify,
                          //                 //           // Adjust text alignment as needed
                          //                 //         ),
                          //                 //       ),
                          //                 //     ],
                          //                 //   ),
                          //                 // ),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //       // child: Image.asset(
                          //       //   "assets/img/tvk-moto.jpg",
                          //       //   fit: BoxFit.fill,
                          //       //   height: 500.0,
                          //       //   width: 500.0,
                          //       // ),
                          //     ),
                          //     ElevatedButton(
                          //       onPressed: () async {
                          //         {
                          //           checkedTrue();
                          //           Navigator.of(context).pop();
                          //         }
                          //       },
                          //       child: Text(
                          //         'Agree'.tr,
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       height: 10,
                          //     )
                          //   ],
                          // ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _afternoonOutdoorChanged(bool? value) {
    _checkBoxClicked = value!;
    setState(() {});
  }

  // Future<void> _saveImage(
  //     BuildContext context, String url, Random random) async {
  //   final scaffoldMessenger = ScaffoldMessenger.of(context);
  //   late String message;
  //   final splitted = url.split("/");
  //   final splitted2 = splitted.last.split(".");
  //   try {
  //     // Download image
  //     final http.Response response = await http.get(Uri.parse(url));
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
  //       await OpenFilex.open(file.path);
  //     }
  //   } catch (e) {
  //     message = e.toString();
  //     scaffoldMessenger.showSnackBar(SnackBar(
  //       content: Text(
  //         message,
  //         style: const TextStyle(
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
  //       style: const TextStyle(
  //         fontSize: 12,
  //         color: Colors.white,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //     backgroundColor: const Color(0xFFe91e63),
  //   ));
  // }

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


  void checkedTrue() {
    setState(() {
      _checkBoxClicked = true;
    });
  }

  // void doFaceDetection() async{
  //   InputImage inputImage= InputImage.fromFile(file);
  //   faces = await faceDetector.processImage(inputImage);
  //   if(faces.length !=1){
  //     showFailureToast("please, upload a proper profile image", fToast);
  //   }
  //   // for (Face face in faces) {
  //   //
  //   // }
  // }

  // Future<void> _pickImageFromGallery(StateSetter setState) async {
  //   await _onImageButtonPressed(ImageSource.gallery,
  //       context: context);
  //   profileImg = _croppedFile!.path ?? '';
  //   setState(() {
  //   });
  // }
  //
  // Future<void> _pickImageFromCamera(StateSetter setState) async {
  //   await _onImageButtonPressed(ImageSource.camera,
  //       context: context);
  //   profileImg = _croppedFile!.path ?? '';
  //   setState(() {
  //   });
  // }

  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
    return exitResult ?? false;
  }
//
  Future<bool?> _showExitDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
  }
//
  AlertDialog _buildExitDialog(BuildContext context) {
    return AlertDialog(
      title: AutoSizeText(
        "appExit".tr,                 //"Do you really want to exit the app?",
        // style: Theme.of(context).textTheme.headline6,
      ),

      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: AutoSizeText('Cancel_app'.tr),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: AutoSizeText('EXIT'.tr),
        ),
      ],
    );
  }

}

Widget buildqrcode() {
  var currentLocale_ = Get.locale;
  return Consumer<ColorNotifire>(
    builder: (context, value, child) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 600,
        // color: Colors.green,
        // color: notifire?.getbgcolor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 500.0,
              width: 500.00,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'tvk_Pledge'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0, // Adjust font size as needed
                              fontWeight: FontWeight.w700,
                              color:
                              signUpTextFontcolor // Apply bold font weight
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                        child: AutoSizeText(
                          'pledge_line_1'.tr + ' ' + 'pledge_line_2'.tr+ ' ' + 'pledge_line_3'.tr + '\n'+'\n'+
                              'pledge_line_4'.tr+ ' ' + 'pledge_line_5'.tr + '\n'+ '\n'+'pledge_line_6'.tr + ' ' + 'pledge_line_7'.tr+ ' ' + 'pledge_line_8'.tr + ' '+
                              'pledge_line_9'.tr+ ' ' + 'pledge_line_10'.tr + ' '+ 'pledge_line_11'.tr + ' '+ '\n'+ '\n'+
                              'pledge_line_12'.tr+ ' ' + 'pledge_line_13'.tr + ' '+ 'pledge_line_14'.tr + ' '+ 'pledge_line_15'.tr + ' ' + 'pledge_line_16'.tr,
                          minFontSize: 2,
                            maxFontSize: currentLocale_?.languageCode == 'ta' ? 11 : 14,
                          style: TextStyle(
                            // fontSize:
                            // _getAlertFontSize(
                            //     context2),
                            // fontSize:14,
                              fontWeight:
                              FontWeight.w700),
                          maxLines: 30,
                          textAlign: TextAlign.justify, // Set text alignment to justify
                          // Adjust font size as needed
                          // textAlign:
                          // TextAlign.justify,
                          // Adjust text alignment as needed
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       AutoSizeText(
                      //         'pledge_line_2'.tr,
                      //         minFontSize: 5,
                      //         maxFontSize: _calculateMaxFontSize(MediaQuery.of(context).size.width),
                      //         style: TextStyle(
                      //             // fontSize: _getFontSize(context),
                      //             fontWeight: FontWeight.w700),
                      //         // Adjust font size as needed
                      //         textAlign: TextAlign.justify,
                      //         // Adjust text alignment as needed
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       AutoSizeText(
                      //         'pledge_line_3'.tr,
                      //         minFontSize: 5,
                      //         maxFontSize: _calculateMaxFontSize(MediaQuery.of(context).size.width),
                      //         style: TextStyle(
                      //             // fontSize: _getFontSize(context),
                      //             fontWeight: FontWeight.w700),
                      //         // Adjust font size as needed
                      //         textAlign: TextAlign.justify,
                      //         // Adjust text alignment as needed
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(height: 10),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       AutoSizeText(
                      //         'pledge_line_4'.tr,
                      //         minFontSize: 5,
                      //         maxFontSize: _calculateMaxFontSize(MediaQuery.of(context).size.width),
                      //         style: TextStyle(
                      //             // fontSize: _getFontSize(context),
                      //             fontWeight: FontWeight.w700),
                      //         // Adjust font size as needed
                      //         textAlign: TextAlign.justify,
                      //         // Adjust text alignment as needed
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       AutoSizeText(
                      //         'pledge_line_5'.tr,
                      //         minFontSize: 5,
                      //         maxFontSize: _calculateMaxFontSize(MediaQuery.of(context).size.width),
                      //         style: TextStyle(
                      //             // fontSize: _getFontSize(context),
                      //             fontWeight: FontWeight.w700),
                      //         // Adjust font size as needed
                      //         textAlign: TextAlign.justify,
                      //         // Adjust text alignment as needed
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(height: 10),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       AutoSizeText(
                      //         'pledge_line_6'.tr,
                      //         minFontSize: 5,
                      //         maxFontSize: _calculateMaxFontSize(MediaQuery.of(context).size.width),
                      //         style: TextStyle(
                      //             // fontSize: _getFontSize(context),
                      //             fontWeight: FontWeight.w700),
                      //         // Adjust font size as needed
                      //         textAlign: TextAlign.justify,
                      //         // Adjust text alignment as needed
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       AutoSizeText(
                      //         'pledge_line_7'.tr,
                      //         minFontSize: 5,
                      //         maxFontSize: _calculateMaxFontSize(MediaQuery.of(context).size.width),
                      //         style: TextStyle(
                      //             // fontSize: _getFontSize(context),
                      //             fontWeight: FontWeight.w700),
                      //         // Adjust font size as needed
                      //         textAlign: TextAlign.justify,
                      //         // Adjust text alignment as needed
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       AutoSizeText(
                      //         'pledge_line_8'.tr,
                      //         minFontSize: 5,
                      //         maxFontSize: _calculateMaxFontSize(MediaQuery.of(context).size.width),
                      //         style: TextStyle(
                      //             // fontSize: _getFontSize(context),
                      //             fontWeight: FontWeight.w700),
                      //         // Adjust font size as needed
                      //         textAlign: TextAlign.justify,
                      //         // Adjust text alignment as needed
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       AutoSizeText(
                      //         'pledge_line_9'.tr,
                      //         minFontSize: 5,
                      //         maxFontSize: _calculateMaxFontSize(MediaQuery.of(context).size.width),
                      //         style: TextStyle(
                      //             // fontSize: _getFontSize(context),
                      //             fontWeight: FontWeight.w700),
                      //         // Adjust font size as needed
                      //         textAlign: TextAlign.justify,
                      //         // Adjust text alignment as needed
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       AutoSizeText(
                      //         'pledge_line_10'.tr,
                      //         minFontSize: 5,
                      //         maxFontSize: _calculateMaxFontSize(MediaQuery.of(context).size.width),
                      //         style: TextStyle(
                      //             // fontSize: _getFontSize(context),
                      //             fontWeight: FontWeight.w700),
                      //         // Adjust font size as needed
                      //         textAlign: TextAlign.justify,
                      //         // Adjust text alignment as needed
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       AutoSizeText(
                      //         'pledge_line_11'.tr,
                      //         minFontSize: 5,
                      //         maxFontSize: _calculateMaxFontSize(MediaQuery.of(context).size.width),
                      //         style: TextStyle(
                      //             // fontSize: _getFontSize(context),
                      //             fontWeight: FontWeight.w700),
                      //         // Adjust font size as needed
                      //         textAlign: TextAlign.justify,
                      //         // Adjust text alignment as needed
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(height: 10),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       AutoSizeText(
                      //         'pledge_line_12'.tr,
                      //         minFontSize: 5,
                      //         maxFontSize: _calculateMaxFontSize(MediaQuery.of(context).size.width),
                      //         style: TextStyle(
                      //             // fontSize: _getFontSize(context),
                      //             fontWeight: FontWeight.w700),
                      //         // Adjust font size as needed
                      //         textAlign: TextAlign.justify,
                      //         // Adjust text alignment as needed
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       AutoSizeText(
                      //         'pledge_line_13'.tr,
                      //         minFontSize: 5,
                      //         maxFontSize: _calculateMaxFontSize(MediaQuery.of(context).size.width),
                      //         style: TextStyle(
                      //             // fontSize: _getFontSize(context),
                      //             fontWeight: FontWeight.w700),
                      //         // Adjust font size as needed
                      //         textAlign: TextAlign.justify,
                      //         // Adjust text alignment as needed
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       AutoSizeText(
                      //         'pledge_line_14'.tr,
                      //         minFontSize: 5,
                      //         maxFontSize: _calculateMaxFontSize(MediaQuery.of(context).size.width),
                      //         style: TextStyle(
                      //             // fontSize: _getFontSize(context),
                      //             fontWeight: FontWeight.w700),
                      //         // Adjust font size as needed
                      //         textAlign: TextAlign.justify,
                      //         // Adjust text alignment as needed
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       AutoSizeText(
                      //         'pledge_line_15'.tr,
                      //         minFontSize: 5,
                      //         maxFontSize: _calculateMaxFontSize(MediaQuery.of(context).size.width),
                      //         style: TextStyle(
                      //             // fontSize: _getFontSize(context),
                      //             fontWeight: FontWeight.w700),
                      //         // Adjust font size as needed
                      //         textAlign: TextAlign.justify,
                      //         // Adjust text alignment as needed
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       AutoSizeText(
                      //         'pledge_line_16'.tr,
                      //         minFontSize: 5,
                      //         maxFontSize: _calculateMaxFontSize(MediaQuery.of(context).size.width),
                      //         style: TextStyle(
                      //             // fontSize: _getFontSize(context),
                      //             fontWeight: FontWeight.w700),
                      //         // Adjust font size as needed
                      //         textAlign: TextAlign.justify,
                      //         // Adjust text alignment as needed
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              // child: Image.asset(
              //   "assets/img/tvk-moto.jpg",
              //   fit: BoxFit.fill,
              //   height: 500.0,
              //   width: 500.0,
              // ),
            ),
          ],
        ),
      ),
    ),
  );
}

double _getFontSize(BuildContext context) {
  // Get the current locale
  var currentLocale = Get.locale;
  if (((Responsive.isDesktop(context)))) {
    if (currentLocale?.languageCode == 'ta') {
      // Font size for Tamil
      return 9.0;
    } else {
      // Font size for English
      return 12;
    }
  }
  if (((Responsive.screenWidth(context) > 900) &&
      (Responsive.screenOrientation(context) == Orientation.landscape)) &&
      (!kIsWeb)) {
    if (currentLocale?.languageCode == 'ta') {
      // Font size for Tamil
      return 8.0;
    } else {
      // Font size for English
      return 11.5;
    }
  }
  else if((MediaQuery.sizeOf(context).width>600) &&(MediaQuery.sizeOf(context).width<700)&&(Responsive.screenOrientation(context) == Orientation.portrait)){
    if (currentLocale?.languageCode == 'ta') {
      // Font size for Tamil
      return 6.5;
    } else {
      // Font size for English
      return 9.5;
    }
  }
  else if (Responsive.isMobile(context)) {
    if (currentLocale?.languageCode == 'ta') {
      // Font size for Tamil
      return 5.5;
    } else {
      if((Responsive.screenWidth(context)<370)){
        return 8;
      }else {
        // Font size for English
        return 8.5;
      }
    }
  }
  else if (Responsive.isTab(context)) {
    if (currentLocale?.languageCode == 'ta') {
      if(MediaQuery.sizeOf(context).width>800 && MediaQuery.sizeOf(context).width<900){
        return 7.7;
      }else {
        // Font size for Tamil
        return 8.5;
      }
    } else {
      // Font size for English
      if(MediaQuery.sizeOf(context).width>800 && MediaQuery.sizeOf(context).width<900){
        return 10.0;
      }else {
        // Font size for Tamil
        return 11;
      }
    }
  } else {
    if ((Responsive.screenOrientation(context) == Orientation.landscape) &&
        (currentLocale?.languageCode == 'ta')) {
      return 6.5;
    } else if ((Responsive.screenOrientation(context) ==
        Orientation.landscape) &&
        (currentLocale?.languageCode == 'en')) {
      return 8.5;
    } else if (currentLocale?.languageCode == 'ta') {
      // Font size for Tamil
      return 5.5;
    } else {
      // Font size for English
      return 8.5;
    }
  }
  // Define font sizes for English and Tamil
}

double _getTermsFontSize(BuildContext context) {
  // Get the current locale
  var currentLocale = Get.locale;

  // Define font sizes for English and Tamil
  if (currentLocale?.languageCode == 'ta') {
    // Font size for Tamil
    return 11.0;
  } else {
    // Font size for English
    return 12.0;
  }
}

double _calculateMaxFontSize(double width) {
  var currentLocale = Get.locale;
  if (width < 890) {
    // return 11;
    if (currentLocale?.languageCode == 'ta') {
      // Font size for Tamil
      return 8.0;
    } else {
      // Font size for English
      return 11;
    }
  } else if (width < 1000) {
    // return 12;
    if (currentLocale?.languageCode == 'ta') {
      // Font size for Tamil
      return 8.0;
    } else {
      // Font size for English
       return 12;
    }
  } else {
    if (currentLocale?.languageCode == 'ta') {
      // Font size for Tamil
      return 10.0;
    } else {
      // Font size for English
      return 13;
    }
    // return 14;
  }
}



double _getAlertFontSize(BuildContext context) {
  // Get the current locale
  var currentLocale = Get.locale;
  if (((Responsive.isDesktop(context)))) {
    if (currentLocale?.languageCode == 'ta') {
      // Font size for Tamil
      return 8.0;
    } else {
      // Font size for English
      return 11.5;
    }
  }
  if (((Responsive.screenWidth(context) > 900) &&
      (Responsive.screenOrientation(context) == Orientation.landscape)) &&
      (!kIsWeb)) {
    if (currentLocale?.languageCode == 'ta') {
      // Font size for Tamil
      return 8.0;
    } else {
      // Font size for English
      return 11.5;
    }
  }
  else if((MediaQuery.sizeOf(context).width>600) &&(MediaQuery.sizeOf(context).width<700)&&(Responsive.screenOrientation(context) == Orientation.portrait)){
    if (currentLocale?.languageCode == 'ta') {
      // Font size for Tamil
      return 6.5;
    } else {
      // Font size for English
      return 9.5;
    }
  }
  else if (Responsive.isMobile(context)) {
    if (currentLocale?.languageCode == 'ta') {
      // Font size for Tamil
      return 5.5;
    } else {
      if((Responsive.screenWidth(context)<370)){
        return 8;
      }else {
        // Font size for English
        return 8.5;
      }
    }
  }
  else if (Responsive.isTab(context)) {
    if (currentLocale?.languageCode == 'ta') {
      // Font size for Tamil
      return 6.5;
    } else {
      // Font size for English
      return 9.5;
    }
  } else {
    if ((Responsive.screenOrientation(context) == Orientation.landscape) &&
        (currentLocale?.languageCode == 'ta')) {
      return 6.5;
    } else if ((Responsive.screenOrientation(context) ==
        Orientation.landscape) &&
        (currentLocale?.languageCode == 'en')) {
      return 8.5;
    } else if (currentLocale?.languageCode == 'ta') {
      // Font size for Tamil
      return 5.5;
    } else {
      // Font size for English
      return 8.5;
    }
  }
}

Widget epicBuildTextFilde(
    {required String hinttext,
      required String prefixicon,
      String? suffix,
      required bool suffixistrue,
      TextEditingController? controller}) {
  return TextFormField(
    style: const TextStyle(
      // color: notifire!.getMainText
    ),
    controller: controller,
    // inputFormatters: [
    //   UpperCaseTextFormatter(),
    // ],
    textCapitalization: TextCapitalization.characters,
    validator: (value) {
      var epic = value?.toUpperCase();
      RegExp pattern = RegExp(r'^[A-Z]{3}\d{7}$');
      if ((value!.length < 10) || !(pattern.hasMatch(epic!))) {
        return 'epic_Not_match'.tr;
      }
      return null;
    },
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            // color: notifire!.isDark
            //     ? notifire!.geticoncolor
            //     : Colors.grey.shade200
          )),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            // color: notifire!.isDark
            //     ? notifire!.geticoncolor
            //     : Colors.grey.shade200
          )),
      hintText: hinttext,
      hintStyle: mediumGreyTextStyle,
      prefixIcon: SizedBox(
        height: 20,
        width: 50,
        child: Center(
            child: SvgPicture.asset(
              prefixicon,
              height: 18,
              width: 18,
              // color: notifire!.geticoncolor,
            )),
      ),
      suffixIcon: suffixistrue
          ? SizedBox(
        height: 20,
        width: 50,
        child: Center(
            child: SvgPicture.asset(
              suffix!,
              height: 18,
              width: 18,
              color: notifire?.geticoncolor,
            )),
      )
          : const SizedBox(),
    ),
  );
}

Widget phoneNoBuildTextFilde(
    {required String hinttext,
      required String prefixicon,
      String? suffix,
      required bool suffixistrue,
      TextEditingController? controller}) {
  return TextFormField(
    keyboardType: TextInputType.number,
    inputFormatters: <TextInputFormatter>[
      LengthLimitingTextInputFormatter(10),
      FilteringTextInputFormatter.digitsOnly
    ],
    style: const TextStyle(
      // color: notifire!.getMainText
    ),
    controller: controller,
    validator: (value) {
      if (value!.isEmpty) {
        return 'MobileNo can\'t be empty';
      } else if (value.length < 10) {
        return 'Atleast 10 numbers needed';
      }
      return null;
    },
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            // color: notifire!.isDark
            //     ? notifire!.geticoncolor
            //     : Colors.grey.shade200
          )),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            // color: notifire!.isDark
            //     ? notifire!.geticoncolor
            //     : Colors.grey.shade200
          )),
      hintText: hinttext,
      hintStyle: mediumGreyTextStyle,
      prefixIcon: SizedBox(
        height: 20,
        width: 50,
        child: Center(
            child: SvgPicture.asset(
              prefixicon,
              height: 18,
              width: 18,
              // color: notifire!.geticoncolor,
            )),
      ),
      suffixIcon: suffixistrue
          ? SizedBox(
        height: 20,
        width: 50,
        child: Center(
            child: SvgPicture.asset(
              suffix!,
              height: 18,
              width: 18,
              color: notifire?.geticoncolor,
            )),
      )
          : const SizedBox(),
    ),
  );
}

// Widget occupationBuildTextFilde(
//     {required String hinttext,
//       required String prefixicon,
//       String? suffix,
//       required bool suffixistrue,
//       TextEditingController? controller}) {
//   return SearchField(
//     suggestionState: Suggestion.expand,
//     suggestionAction: SuggestionAction.unfocus,
//     searchInputDecoration: InputDecoration(
//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(
//           color: Colors.black.withOpacity(0.8),
//         ),
//       ),
//       border: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.red),
//       ),
//       contentPadding: const EdgeInsets.symmetric(
//           vertical: 5.0, horizontal: 10.0),
//
//     ),
//     suggestions: stateListData
//         .map((singleStateData) => SearchFieldListItem(
//       singleStateData.english,
//       item: singleStateData,
//     ))
//         .toList(),
//     // textInputAction: TextInputAction.next,
//     controller: _searchStateController,
//     readOnly: adminFlag==0?false:true,
//     focusNode: _focusState,
//     validator: (value) {
//       // if( widget.projectId!= 0) {
//       //   value = IssueType(id: 0, name: '', description: '',);
//       // }
//       // value=_stateApprovedMember;
//       if(value==""||value==null||value==selectState) {
//         _focusState.requestFocus();
//         return "Please select State";
//
//       }
//     },
//     hint: AppLocalization.of(context)
//         .getTranslatedValue("State")
//         .toString(),
//     // initialValue: SearchFieldListItem(_suggestions[2], SizedBox()),
//     maxSuggestionsInViewPort: 6,
//     itemHeight: 45,
//     onSuggestionTap: (x) {
//       stateData = x!.item as Datum;
//       _stateSelection = stateData.english;
//       _stateId = stateData.id;
//       _districtSelection = selectDistrict;
//       _districtId = 0;
//       districtListData.clear();
//       _regionId=0;
//       regionListData.clear();
//       _searchDistrictController.clear();
//       _searchRegionController.clear();
//       getDistrict(_stateId);
//       setState(() {});
//     },
//   );
// }

Widget buildTextFilde(
    {required String hinttext,
      required String prefixicon,
      String? suffix,
      required bool suffixistrue,
      TextEditingController? controller}) {
  return TextFormField(
    style: const TextStyle(
      // color: notifire!.getMainText
    ),
    controller: controller,
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            // color:  signUpTextFontcolor,
          )),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            // color:  signUpTextFontcolor,
            // color: notifire!.isDark
            //     ? notifire!.geticoncolor
            //     : Colors.grey.shade200
          )),
      hintText: hinttext,
      hintStyle: mediumGreyTextStyle,
      prefixIcon: SizedBox(
        height: 20,
        width: 50,
        child: Center(
            child: SvgPicture.asset(
              prefixicon,
              height: 18,
              width: 18,
              // color: notifire!.geticoncolor,
            )),
      ),
      suffixIcon: suffixistrue
          ? SizedBox(
        height: 20,
        width: 50,
        child: Center(
            child: SvgPicture.asset(
              suffix!,
              height: 18,
              width: 18,
              color: notifire?.geticoncolor,
            )),
      )
          : const SizedBox(),
    ),
  );
}

Widget buildTextFiledNonEditable(
    {required String hinttext,
      required String prefixicon,
      String? suffix,
      required bool suffixistrue,
      TextEditingController? controller}) {
  return TextField(
    style: const TextStyle(
      // color: notifire!.getMainText
    ),
    readOnly: true,
    controller: controller,
    decoration: InputDecoration(
      fillColor: darkiconcolor.withOpacity(0.5),
      filled: true,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            // color: Colors.lightBlueAccent
            // color: notifire!.isDark
            //     ? notifire!.geticoncolor
            //     : Colors.grey.shade200
          )),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            // color: Colors.lightBlueAccent
            // color: notifire!.isDark
            //     ? notifire!.geticoncolor
            //     : Colors.grey.shade200
          )),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.orange
            // color: notifire!.isDark
            //     ? notifire!.geticoncolor
            //     : Colors.grey.shade200
          )),
      hintText: hinttext,
      hintStyle: mediumGreyTextStyle,
      prefixIcon: SizedBox(
        height: 20,
        width: 50,
        child: Center(
            child: SvgPicture.asset(
              prefixicon,
              height: 18,
              width: 18,
              // color: notifire!.geticoncolor,
            )),
      ),
      suffixIcon: suffixistrue
          ? SizedBox(
        height: 20,
        width: 50,
        child: Center(
            child: SvgPicture.asset(
              suffix!,
              height: 18,
              width: 18,
              color: notifire?.geticoncolor,
            )),
      )
          : const SizedBox(),
    ),
  );
}

class StreamData {
   int? timerValue;
   bool? showTimeRow;
   bool? showResentOtp;

  StreamData(this.timerValue, this.showTimeRow,this.showResentOtp);
}