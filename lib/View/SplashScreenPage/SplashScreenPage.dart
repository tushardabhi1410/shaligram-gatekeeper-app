import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/Config/Utils/images.dart';
import 'package:avinashgatekeeper/Controller/SplashScreenController/SplashScreenConroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashScreenController cnt_Splash = Get.put(SplashScreenController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cnt_Splash.getLoginDetails();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {

    });
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]);
  }

  // Future getSessionData()async{
  //   MySharedPreferences sp = MySharedPreferences.instance;
  //   String value = await sp.getStringValue("Background_Notification");
  //   if(value =="3"){
  //     Get.to(OffersPage());
  //   }
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cnt_Splash.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashWidget(),
    );
  }

  Widget SplashWidget(){
    return Stack(
      children: [
        Container(
          height: Get.height,
          width: Get.width,
          color: AppColors.WHITE,
        ),
        Container(
          alignment: Alignment.bottomCenter,
         // height: Get.height * 0.55,
          width: Get.width,
          child: Image.asset(SPLASH_BG,fit: BoxFit.fill,),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          left: 0,
          child: Center(
            child: Image.asset(APP_LOGO_NEW,fit: BoxFit.fill,width: Get.width / 1.5,)
          )
        ),
      ],
    );
  }
}

