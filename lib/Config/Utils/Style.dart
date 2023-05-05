import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var fontFamily = "ProductSans";

class TextStyles{
  static TextStyle textStyleLight16([Color color = Colors.black]) => TextStyle(
      color: color,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400
      ,fontFamily: fontFamily
  );

  static TextStyle textStyleLight10 = TextStyle(
    fontSize: 10.sp,
      fontWeight: FontWeight.w400
      ,fontFamily: fontFamily
  );

  static TextStyle textStyleDark16([Color color = Colors.black]) => TextStyle(
      fontSize: 16.sp,
      color: color,
      fontWeight: FontWeight.w500
      ,fontFamily: fontFamily
  );
  static TextStyle semiboldtextstyle([Color color = Colors.black]) => TextStyle(
      fontSize: 16.sp,
      color: color,
      fontWeight: FontWeight.w500
      ,fontFamily: fontFamily
  );



  static TextStyle textStyleLight14([Color color = Colors.black]) => TextStyle(
    fontSize: 14.sp,
    color: color,
       fontWeight: FontWeight.normal,
    fontFamily: fontFamily
  );

  static TextStyle textStyleMedium14([Color color = Colors.black]) => TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w400,
      color: color
      ,fontFamily: fontFamily
  );

  static TextStyle textStyleDark14([Color color = Colors.black]) => TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: color
      ,fontFamily: fontFamily
  );

  static TextStyle textStyleLight15([Color color = Colors.black]) => TextStyle(
      fontSize: 15.sp,
      color: color,
      fontWeight: FontWeight.w400
      ,fontFamily: fontFamily
  );
  static TextStyle textStyleMedium15([Color color = Colors.black]) => TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w400,
      color: color
      ,fontFamily: fontFamily
  );
  static TextStyle textStyleDark15([Color color = Colors.black]) => TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w500,
      color: color
      ,fontFamily: fontFamily
  );

  static TextStyle textStyleDark12([Color color = Colors.black]) => TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: color
      ,fontFamily: fontFamily
  );

  static TextStyle textStyleLight12([Color color = Colors.black]) => TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: color
      ,fontFamily: fontFamily
  );

  static TextStyle textStyleDark22([Color? color]) => TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w500,
    color: color??AppColors.BLACK,fontFamily: fontFamily
  );
  static TextStyle textStyleDark24([Color? color]) => TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w500,
      color: color??AppColors.BLACK,fontFamily: fontFamily
  );
  static TextStyle textStyleDark18([Color? color]) => TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
      color: color??AppColors.BLACK,fontFamily: fontFamily
  );

  static TextStyle textStyleLight18([Color? color]) => TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w400,
      color: color??AppColors.BLACK,fontFamily: fontFamily
  );

  static TextStyle textStyleDark25([Color? color]) => TextStyle(
      fontSize: 25.sp,
      fontWeight: FontWeight.w500,
      color: color??AppColors.BLACK,fontFamily: fontFamily
  );
  static TextStyle textStyleDark20([Color? color]) => TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
      color: color??AppColors.BLACK,fontFamily: fontFamily
  );
  static TextStyle textStyleLight20([Color? color]) => TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
      color: color??AppColors.BLACK,fontFamily: fontFamily
  );
}

BoxShadow shadow = BoxShadow(
    color: Colors.black12.withOpacity(0.06),
    blurRadius: 15,
    spreadRadius: 0,
    offset: Offset(0, 2));

BoxShadow fullcontainerboxShadow=
BoxShadow(
    color: hex("266CB5").withOpacity(0.03),
    blurRadius: 4,
    offset: Offset(0,0),
    spreadRadius: 4
);

BoxShadow smallcontainerboxShadow=
BoxShadow(
    color: Colors.black.withOpacity(0.03),
    blurRadius: 4,
    offset: Offset(0,6),
    spreadRadius: 2
);