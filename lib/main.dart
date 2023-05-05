import 'package:avinashgatekeeper/Config/Helper/ControllerBinding.dart';
import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:avinashgatekeeper/View/SplashScreenPage/SplashScreenPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Config/Helper/NotificationHandler.dart';
import 'View/RequestViewForm/RequestViewForm.dart';


Future<void> myBackgroundHandler(RemoteMessage message) async {
  print(
      "-----------------------------------onBackgroundMessage--------------------------------------");

  try {
    // SharedPreferences.setMockInitialValues({});
    SharedPreferences sp = await SharedPreferences.getInstance();

    // sp.reload();
    // sp.setInt(NOTIFICATION_COUNT, 2);
    // sp.reload();
    // var count = sp.getInt(NOTIFICATION_COUNT);
    // print(count);
    print(message.data);
  } catch (e,s) {
    print(s);
  }

  // setNotificationCount(count!+1);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  NotificationHandler notificationHandler = NotificationHandler();
  FirebaseMessaging.onBackgroundMessage(myBackgroundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen(notificationHandler.onMessageOpenApp);
  FirebaseMessaging.onMessage.listen(notificationHandler.onMessage);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp(title: "Shaligram"));
}

class MyApp extends StatefulWidget {
  String? title;
  MyApp({required this.title, Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // this.initDynamicLinks();
  }

  // void initDynamicLinks() async {
  //   FirebaseDynamicLinks.instance.onLink.listen((event) {
  //     Uri deepLink = event.link;
  //     print(event);
  //     print(deepLink);
  //     if (deepLink != null) {
  //       Get.to(HomePage());
  //     }
  //   }).onError((error) {
  //     print(error);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: widget.title ?? "Shaligram",
      initialBinding: ControllerBinding(),
      defaultGlobalState: true,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
          fontFamily: 'ProductSans',
          primaryColor: AppColors.WHITE,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          accentColor: AppColors.BLACK,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: AppColors.TRANSPARENT,
          )),
      home: SplashScreen(),
      //home: CustomerRegisterPage(),
      onGenerateRoute: (setting) {
        print(setting.name);
      },
      builder: (context, child) {
        // ScreenUtil.init(BoxConstraints(maxWidth: Get.width , maxHeight: Get.height),context: context,minTextAdapt: true);
        final mediaQueryData = MediaQuery.of(context);
        final scale = mediaQueryData.textScaleFactor.clamp(0.95, 0.95);
        return MediaQuery(
          child: child!,
          data: mediaQueryData.copyWith(textScaleFactor: scale),
        );
      },
    );
  }
}
