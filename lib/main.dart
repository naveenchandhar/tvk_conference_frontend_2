
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvk_maanadu/provider/provide_colors.dart';

import 'appstaticdata/routes.dart';
import 'controller.dart';
import 'controllers/translation.dart';
import 'login_signup/splash_screen.dart';


// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final box = GetStorage();
final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
// GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//
// int adminFlag = 11;
//
// int navigatedPage = 0;
// int memberId = 0;
// bool isPledgeView = false;
// String fcmToken = "";
// String loginMemberName = '';
//
// int? user_Id=0;
//
// String currentRoute = Routes.signup;

String profileGlobol = '';

bool loggedIn = false;
bool currentLanguage = false;
String token = '';
int mobileNo = 0;
String fullName = "";
String password = "";
int mPin = 0;
bool enableAuth = false;
bool showLoginPage = true;
int student_id=0;
int class_id=0;
int section_id=0;
bool firstLogin=false;
int _currentIndex = 0;
int tabPage=0;
bool individualEvent = false;
ValueNotifier<int> notificationCount = ValueNotifier<int>(0);
int _bottombarindex = -2;
int drawerIndex=0;
bool isLoaded=false;
int adminFlag = 11;
int navigatedPage = 0;
int memberId = 0;
bool isPledgeView = false;
String fcmToken = "";
String loginMemberName = '';
ValueNotifier<String> globolProfile = ValueNotifier<String>('');
int? user_Id=0;
String currentRoute = Routes.signup;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message");
  // await Firebase.initializeApp();
}
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//   runApp(MyApp());
// }

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
}

// void handleMessage(BuildContext context, RemoteMessage message) {
//   if (message.data['type'] == 'msg') {
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => const ChatsHome()));
//   }
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(!kIsWeb) {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }
  try {
    await GetStorage.init();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loggedIn = prefs.getBool("isLoggedIn") ?? false;
    mobileNo = prefs.getInt('mobileNo') ?? 0;
    fullName = prefs.getString('fullName') ?? "";
    password = prefs.getString('password') ?? "";
    mPin = prefs.getInt('mPin') ?? 0;
    enableAuth = prefs.getBool('enableAuth') ?? false;
    showLoginPage = prefs.getBool('showLoginPage') ?? true;
    firstLogin = prefs.getBool('firstLogin') ?? false;

    if(kIsWeb){
      await Firebase.initializeApp(
        //name: "little-indian",
          options: const FirebaseOptions(
              apiKey: "AIzaSyBOqF8r_lTE4ZE_Cd3ctVRtoj4C6r60h0o",
              authDomain: "little-indian-cbe.firebaseapp.com",
              databaseURL:
              "https://little-indian-cbe-default-rtdb.firebaseio.com",
              projectId: "little-indian-cbe",
              storageBucket: "little-indian-cbe.appspot.com",
              messagingSenderId: "963446834527",
              appId: "1:963446834527:web:8fae3c5709d8340b40e2ea",
              measurementId: "G-HG0Z1R5Z98"));}else{
      await Firebase.initializeApp(
        // name: "little-indian",
          options: const FirebaseOptions(
              apiKey: "AIzaSyBOqF8r_lTE4ZE_Cd3ctVRtoj4C6r60h0o",
              authDomain: "little-indian-cbe.firebaseapp.com",
              databaseURL:
              "https://little-indian-cbe-default-rtdb.firebaseio.com",
              projectId: "little-indian-cbe",
              storageBucket: "little-indian-cbe.appspot.com",
              messagingSenderId: "963446834527",
              appId: "1:963446834527:web:8fae3c5709d8340b40e2ea",
              measurementId: "G-HG0Z1R5Z98"));
    }
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );


    Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
      // await Firebase.initializeApp();
    }
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  } catch (e) {
    print(e.toString());
  }





  Get.put(LocaleCont());
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ColorNotifire(),
        ),
      ],
      child: Builder(builder: (context) {
        return GetMaterialApp(
          locale: const Locale('en', 'ta'),
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('ta'),
          ],
          // localizationsDelegates: const [
          //   // AppLocalizations.delegate,
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate
          // ],
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (locale.languageCode == deviceLocale!.languageCode &&
                  locale.countryCode == deviceLocale.countryCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
          translations: MyLocalization(),
          scrollBehavior: MyCustomScrollBehavior(),
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.initial,
          //loggedIn == false? Routes.signup:Routes.homepage,
          getPages: getPage,
          title: 'Tvk Conference',
          theme: ThemeData(
              useMaterial3: false,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              fontFamily: "Gilroy",
              dividerColor: Colors.transparent,
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: const Color(0xFF0059E7),
              )),
          // home: const MyHomePage(),
          home: const Scaffold(
            body: MyHomePage(), // Call DropdownWidget here
          ),
        );
      }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocaleCont>(
      builder: (cont) => MaterialApp(
        // key: navigatorKey2,
        locale: cont.locale,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.lightBlueAccent,
        ),
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale!.languageCode &&
                locale.countryCode == deviceLocale.countryCode) {
              return deviceLocale;
            }
          }
          return supportedLocales.first;
        },
        // localizationsDelegates: const [
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        //   AppLocalization.delegate,
        //   // AppLocalizations.delegate,
        // ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ta', 'IN'),
        ],

        title: 'LITTLE_INDIAN',

        home: const SplashScreen(),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'enter_mail': 'Enter your email',
    },
    'ur_PK': {
      'enter_mail': 'اپنا ای میل درج کریں۔',
    }
  };
}
