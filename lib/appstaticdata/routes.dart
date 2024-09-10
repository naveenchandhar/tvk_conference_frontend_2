// ignore_for_file: prefer_const_constructors




import 'package:get/get.dart';

import '../homepage.dart';
import '../login/signup.dart';
import '../login_signup/splash_screen.dart';
import '../main.dart';





class Routes {
  static String initial = "/";
  static String signup = "/signup";
  static String homepage = "/homePage";

}

final getPage = [
  GetPage(
    name: Routes.initial,
    page: () => SplashScreen(),
  ),
  GetPage(
    name: Routes.homepage,
    page: () => HomePage(pageNavigation: navigatedPage),   //HomePage
  ),
  GetPage(
    name: Routes.signup,
    page: () => SignUpPage(),
  ),
//   GetPage(
//     name: Routes.principle,
//     page: () => PrinciplesPage(),
//   ),
//   GetPage(
//     name: Routes.pledge,
//     page: () => PledgePage(),
//   ),
//   GetPage(
//     name: Routes.contact,
//     page: () => ContactPage(),
//   ),
//   GetPage(
//     name: Routes.newHome,
//     page: () => NewHomePage(),
// ),
// GetPage(
//     name: Routes.news,
//     page: () => NewsListPage(),
//   ),
//   GetPage(
//     name: Routes.singleNews,
//     page: () => NewsSinglePage(),
//   ),
];
//test