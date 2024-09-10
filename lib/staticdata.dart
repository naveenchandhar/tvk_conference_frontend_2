// import 'package:buzz/calender.dart';
// import 'package:buzz/demo/toastification.dart';
// import 'package:buzz/forms_table/data_table.dart';
// import 'package:buzz/newpages/file_manager_page.dart';
// import 'package:buzz/newpages/maps_page.dart';
// import 'package:buzz/newpages/tabs_pills.dart';
// import 'package:buzz/projectlistpage.dart';
// import 'package:get/get.dart';
//
// import 'Buttons/default_style.dart';
// import 'Buttons/edge_style.dart';
// import 'Buttons/flat_style.dart';
// import 'Buttons/raised_style.dart';
// import 'FAQ/faq.dart';
// import 'Ui_kits/avatars.dart';
// import 'Ui_kits/modal.dart';
// import 'Users/users_cards.dart';
// import 'Users/users_edit.dart';
// import 'chartpage.dart';
// import 'chat/chatscreenpages/messages.dart';
// import 'ecommerce_pages/cart1.dart';
// import 'ecommerce_pages/checkout.dart';
// import 'ecommerce_pages/invoice.dart';
// import 'ecommerce_pages/pricing.dart';
// import 'ecommerce_pages/product_detils_page.dart';
// import 'ecommerce_pages/product_page.dart';
// import 'ecommercepage.dart';
// import 'forms_table/basic_tables.dart';
// import 'forms_table/datepicker.dart';
// import 'forms_table/validation_form.dart';
// import 'generalpage.dart';
// import 'login_signup/complete_verificaton_process.dart';
// import 'login_signup/email_verification.dart';
// import 'login_signup/forgot_password.dart';
// import 'login_signup/singup.dart';
// import 'newpages/newaddtoproject.dart';
// import 'newpages/newcheckboxpage.dart';
// import 'newpages/newdefault_page.dart';
// import 'newpages/newuserprofile.dart';


import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'Conference/ConferenceCreatePage.dart';
import 'Conference/ConferenceListPage.dart';
import 'Conference/ConferenceQrScan.dart';
import 'manual _entry/Manual_entry_page.dart';


class AppConst extends GetxController  {      //implements GetxService
  bool showDrawer = true;
  dynamic argumentForPage;

  updateshowDrawer() {
    showDrawer = !showDrawer;
    update();
  }

  RxInt pageselecter = 0.obs;

  RxInt selectColor = 0.obs;
  RxInt selectedTile = 0.obs;

  RxInt gridcounter = 4.obs;

  RxInt newGridCounter = 4.obs;

  RxDouble size = 550.0.obs;

  RxDouble size2 = 350.0.obs;

  int selectCategory = 0;

  int gridecoumter1 = 4;
  int grideCount = 4;

  grideupdate(int value) {
    gridecoumter1 = value;
  }

  grideupdate1(int value) {
    gridecoumter1 = value;
    update();
  }

  changeCurrentIndex({int? index}) {
    selectCategory = index ?? 0;
    update();
  }

  void changePage1(int pageNumber, {dynamic argument}) {
    // Your navigation logic here
    // switch (pageNumber) {
    //   case 10:
    // Navigate to a specific page using GetX navigation
    argumentForPage = argument;
    pageselecter.value = pageNumber;
    // Handle other page numbers as needed
    //   case 13:
    //   // Navigate to a specific page using GetX navigation
    //     pageselecter.value = pageNumber;
    //   default:
    //     break;

    // }
  }

  //Switch
  RxBool switchistrue = false.obs;

  var page = [
    const ConferenceCreatePage(),//0
    const ConferenceQrScan(),//1
    const ConferenceListPage(),//2
    const ManualEntryPage(),//3
    // const UserTotalDataPage(), //0
    // // const NewDefaultPage(), // 0
    // const BasicTablesPage(), //1
    // const MemberTablePage(), // 2
    // // const JoinGroupCall(), // 3
    // const CreateGroupCall(), // 4
    // const CreateGroupCall(), // 4
    // const StateListPage(), // 5
    // const DistrictPage(), // 6
    // const RegionListPage(), // 7
    // const ParlimentaryConstituencyPage(), // 8
    // const AssemblyTablePage(), // 9
    // const CreateLocalIssue(), // 10
    // const TweedlePage(), // 11
    // const ListLocalIssue(), //12
    // const CreateTweedlePage(), //13
    // const VolunteerTablePage(), // 14
    // const CreateMemberPage(), //15
    // const JointFamilyMemberPage(), //16
    // const CreateJoinFamilyMember(), //17
    // const Gender_Count_Report(), //18
    // const Gender_Count_Parliment_Report(), //19
    // const IdDownLoadPage(), //20
    // const CreateSurvey(), //21
    // const SurvayScreen(), //22
    // const AccountPageScreen(),//23
    // const TN_HelpLinePage(),//24
    // const UserCreateMemberListPage(),//25
    // const CreateEvents(),//26
    // const CreateNewsPage(),//27
  ].obs;

  void changePage(int newIndex) {
    pageselecter.value = newIndex;
  }
}
