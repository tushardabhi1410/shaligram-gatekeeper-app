import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Config/Utils/Style.dart';
import '../../Config/Utils/color.dart';
import '../../Config/Utils/images.dart';
import '../../Widget/CustomAppBar.dart';
import '../HomePage/HomePage.dart';
import '../Tabbar.dart';



class RequestViewForm extends StatefulWidget {
  const RequestViewForm({Key? key}) : super(key: key);

  @override
  State<RequestViewForm> createState() => _RequestViewFormState();
}

class _RequestViewFormState extends State<RequestViewForm> {
  @override
  void initState() {
    FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;
      print(value.toString()+"         this is fcm token");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        resizeToAvoidBottomInset: false,

        body:WillPopScope(
            onWillPop: () async {
              Get.offAll(TabbarScreen());
              return false;
            },
            child: Stack(
                children: [
                  VerficationView(),
                  Positioned(
                      top: 0,
                      child: CustomAppBar(
                          title: "Verification Page",
                          bgColor: AppColors.WHITE,
                          backimgbgColor: AppColors.DARK_GREY,
                          onTapCallBack: () {
                            Get.offAll(TabbarScreen());
                          })),

                ])),


      //),
    );
  }
  Widget VerficationView(){
    return Container(
      margin: EdgeInsets.only(top: Get.height/2.8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset(IMG_VERFICATION_PENDING,height: 100,color: AppColors.APP_THEME_COLOR,)),
          SizedBox(height: 20.w,),
          Text("Waiting For Request Responce",style: TextStyles.textStyleDark18(AppColors.APP_THEME_COLOR),),
          SizedBox(height: 10.w,),
          GestureDetector(
              onTap: (){

              },
              child: Text("Resend Request",style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black
                  ,fontFamily: fontFamily,
                decoration: TextDecoration.underline,
              ),)),
        ],
      ),
    );
  }
}
