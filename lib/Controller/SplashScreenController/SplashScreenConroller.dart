import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/View/LoginPage/LoginPage.dart';
import 'package:avinashgatekeeper/View/SplashScreenPage/SplashScreenPage.dart';
import 'package:avinashgatekeeper/View/Tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
bool isLogin = false;
class SplashScreenController extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    this.SetTimerTOChangePage();
  }
  bool isLogin = false;
  SetTimerTOChangePage() {
    Future.delayed(Duration(seconds: 3), () {
      FindLoginStatus();
    });
  }
  Future getLoginDetails() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    isLogin = sp.getBool(SESSION_IS_LOGIN) ?? false;
  }
  FindLoginStatus() async {
    if(isLogin){
      Get.offAll(TabbarScreen(),
          duration: Duration(milliseconds: 2500),
          curve: Curves.decelerate,
          popGesture: true);
    }else{

      Get.offAll(LoginPage(),
          duration: Duration(milliseconds: 2500),
          curve: Curves.decelerate,
          popGesture: true);
    }

  }
}
