import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:avinashgatekeeper/Config/Utils/images.dart';
import 'package:avinashgatekeeper/Widget/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Search button

typedef void onTap();

Widget SearchButton({Color bgcolor = Colors.white , Color iconColor = Colors.black ,onTap? ontap }) {
  return CustomButtons.RoundIconButton(
    onTap: ontap ?? ()=>{

    },
      boxShadow: false,
      width: 40.w,
      radius: 40.w/2,
      height: 40.w,
      imgColor: iconColor,
      bgColor: bgcolor,
      image: "");
}

// Notifcation Button

Widget NotificationButton({Color bgcolor = Colors.white,Color iconColor = Colors.black,bool dotShow = false}) {
  return Stack(
    children: [
      CustomButtons.RoundIconButton(
        onTap: (){

        },
          boxShadow: false,
          width: 40.w,
          radius: 40.w / 2,
          height: 40.w,
          imgColor: iconColor,
          bgColor: bgcolor,
          image: ""),
     if(dotShow) Positioned(
          left: 20.w,
          top: 10.w,
          child: Icon(
            Icons.circle,
            size: 10,
            color: AppColors.BARRIERCOLOR,
          ))
    ],
  );
}

// Back Button



typedef void OnTapBack();
GoToBack(){
  Get.back();
}

Widget BackScreenButton({OnTapBack? onTap,Color bgcolor = Colors.white,Color iconColor = Colors.black}){
  return CustomButtons.RoundIconButton(
    bgColor: bgcolor,
    height: 45.w,
    width: 45.w,
    onTap: onTap??GoToBack(),
    image: CANCEL_ICON,
    radius: 50,
    boxShadow: false,
    imgColor: iconColor
  );
}
