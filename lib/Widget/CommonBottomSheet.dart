import 'dart:async';


import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Config/Utils/color.dart';
import '../Config/Utils/constantValue.dart';
import 'CustomButton.dart';

typedef void OnTap();


enum TotalButton { ONE, TWO }

BuildContext contextCommon = Get.context!;

// void BottomSheetDialog(
//     {required Widget child,
//     required String message,
//     Widget? text,
//     bool enableDrag = false,
//     bool isDismissible = true,
//     bool isHideAutoDialog = false,
//     bool isCloseMenuShow = false,
//     onWillPop,
//     double? maxHeight,
//     Color? backgroundColor,
//     Color? mainColor,
//     int? hideDuration}) {
//   Get.bottomSheet(
//       Container(
//         height: Get.height * 0.85,
//         width: Get.width,
//         // constraints: BoxConstraints(maxHeight: maxHeight ?? Get.height * 0.85, minHeight: 100),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SizedBox(
//                 width: Get.width,
//             ),
//             Expanded(
//               child: WillPopScope(
//                 onWillPop: onWillPop,
//                 child: Stack(
//                   children: [
//                     Column(
//                       children: [
//                         Container(
//                           width: Get.width,
//                           height: 60.w,
//                           clipBehavior: Clip.hardEdge,
//                           decoration: BoxDecoration(
//                               color: backgroundColor ?? AppColors.GREEN,
//                               borderRadius: const BorderRadius.only(
//                                   topRight: Radius.circular(20), topLeft: Radius.circular(20))),
//                           padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
//                           child: Align(
//                             alignment: Alignment.center,
//                             child: message != ""
//                                 ? Text(
//                                     message,
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                         color: AppColors.WHITE,
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: 16.sp),
//                                   )
//                                 : text,
//                           ),
//                         ),
//                         Expanded(
//                           child: Container(
//                               clipBehavior: Clip.hardEdge,
//                               decoration: BoxDecoration(
//                                   color: mainColor ?? AppColors.WHITE,
//                                   borderRadius: const BorderRadius.only(
//                                       topRight: Radius.circular(20), topLeft: Radius.circular(20))),
//                               child: SingleChildScrollView(
//                                 child: child,
//                               )),
//                         ),
//                       ],
//                     ),
//                     if (isCloseMenuShow) Positioned(bottom: 15, right: 15, child: PopMenuButton()),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       isScrollControlled: true,
//       isDismissible: isDismissible,
//       enableDrag: enableDrag,
//       shape: RoundedRectangleBorder(
//         borderRadius:
//             BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//       ),
//       backgroundColor: backgroundColor ?? AppColors.GREEN,
//       enterBottomSheetDuration: Duration(milliseconds: 500),
//       exitBottomSheetDuration: Duration(milliseconds: 500));
//
//   if (isHideAutoDialog) {
//     Future.delayed(Duration(seconds: hideDuration ?? 3), () {
//       // print('close * * * ');
//       Get.back();
//     });
//   }
// }

void   BottomSheetDialog(
    {required Widget child,
    // BuildContext? context,
    required String message,
    Widget? text,
    bool enableDrag = false,
    bool isDismissible = true,
    bool isHideAutoDialog = false,
    bool isCloseMenuShow = false,
    onWillPop,
    double? maxHeight,
    Color? backgroundColor,
    Color? mainColor,
    int? hideDuration}) {
  HideKeyboard().then((value) {
    Future.delayed(Duration(milliseconds: 300), () {
      print("BottomSheet");
      Get.bottomSheet(
          Container(
            constraints: BoxConstraints(maxHeight: maxHeight ?? Get.height * 0.85),
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(contextCommon).viewInsets.bottom),
              child: WillPopScope(
                onWillPop: onWillPop,
                child: Stack(
                  children: [
                    Container(
                        clipBehavior: Clip.hardEdge,
                        margin: EdgeInsets.only(top: 60.w),
                        decoration: BoxDecoration(
                            color: mainColor ?? AppColors.WHITE,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
                        child: SingleChildScrollView(
                          child: child,
                        )),
                    Container(
                      width: Get.width,
                      height: 60.w,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          color: backgroundColor ?? AppColors.GREEN,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
                      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                      child: Align(
                        alignment: Alignment.center,
                        child: message != ""
                            ? Text(
                                message.toString().toLowerCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.WHITE,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp),
                              )
                            : text,
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
          isScrollControlled: true,
          isDismissible: isDismissible,
          enableDrag: enableDrag,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          backgroundColor: backgroundColor ?? AppColors.GREEN,
          enterBottomSheetDuration: Duration(milliseconds: 500),
          exitBottomSheetDuration: Duration(milliseconds: 500));
      if (isHideAutoDialog) {
        Future.delayed(Duration(seconds: hideDuration ?? 3), () {
          // print('close * * * ');
          Get.back();
        });
      }
    });
  });

  // showModalBottomSheet(
  //   context: context!,
  //   constraints: BoxConstraints(maxHeight: maxHeight ?? Get.height * 0.85),
  //   isScrollControlled: true,
  //   builder: (_) {
  //     // contextBottomDialog = con;
  //     return Padding(
  //       padding: EdgeInsets.only(
  //           bottom: MediaQuery.of(context).viewInsets.bottom),
  //       child: WillPopScope(
  //         onWillPop: onWillPop,
  //         child: Stack(
  //           children: [
  //             Container(
  //                 margin: EdgeInsets.only(top: 60.w),
  //                 decoration: BoxDecoration(
  //                     color: mainColor ?? AppColors.WHITE,
  //                     borderRadius: BorderRadius.only(
  //                         topRight: Radius.circular(20),
  //                         topLeft: Radius.circular(20))),
  //                 child: SingleChildScrollView(
  //                   child: child,
  //                 )),
  //             Container(
  //               width: Get.width,
  //               height: 60.h,
  //               decoration: BoxDecoration(
  //                   color: backgroundColor ?? AppColors.GREEN,
  //                   borderRadius: BorderRadius.only(
  //                       topRight: Radius.circular(20),
  //                       topLeft: Radius.circular(20))),
  //               padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
  //               child: Align(
  //                 alignment: Alignment.center,
  //                 child: message != ""
  //                     ? Text(
  //                         message,
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(
  //                             color: AppColors.WHITE,
  //                             fontWeight: FontWeight.w400,
  //                             fontSize: 18.sp),
  //                       )
  //                     : text,
  //               ),
  //             ),
  //             if (isCloseMenuShow)
  //               Positioned(bottom: 15, right: 15, child: PopMenuButton()),
  //           ],
  //         ),
  //       ),
  //     );
  //   },
  //   enableDrag: enableDrag,
  //   isDismissible: isDismissible,
  //   backgroundColor: backgroundColor ?? AppColors.GREEN,
  //   shape: RoundedRectangleBorder(
  //     borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(20), topRight: Radius.circular(20)),
  //   ),
  // );

  // if (isHideAutoDialog) {
  //   Future.delayed(Duration(seconds: hideDuration ?? 3), () {
  //     // print('close * * * ');
  //     Get.back();
  //   });
  // }
}



Widget ShowMessage(String message) {
  return Container(
    // height: 100,
    padding: EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 40),
    child: Align(
      alignment: Alignment.topLeft,
      child: Text(
        message.toString().toLowerCase(),
        style: TextStyle(color: AppColors.BLACK, fontWeight: FontWeight.w400, fontSize: 16.sp),
      ),
    ),
  );
}

//Alert Dialog
Widget AlertDialogButton(
    String? message,
    TotalButton? totalButton,
    String? buttonName,
    String? button2Name,
    OnTap? onTap,
    OnTap? onTap2,
    Color? bgColor,
    Color? bgColor2,
    TextStyle? textStyle,
    TextStyle? textStyle2) {
  return Container(
      width: Get.width,
      padding: EdgeInsets.all(30),
      child: Center(
        child: Column(
          children: [
            Text(
              message?.toLowerCase().toString() ?? "",
              style:
                  TextStyle(color: AppColors.BLACK, fontWeight: FontWeight.w400, fontSize: 16.sp),
            ),
            SizedBox(
              height: 15.w,
            ),
            totalButton == TotalButton.ONE
                ? CustomButtons.WidgetButton(
                    onTap: () => Get.back(),
                    height: 45,
                    width: Get.width,
                    radius: 22,
                    boxShadow: false,
                    bgColor: bgColor ?? AppColors.WHITE,
                    child: Text(
                      buttonName ?? "",
                      style: textStyle,
                    ))
                : TwoButtonDesign(onTap, onTap2, bgColor, bgColor2, textStyle, textStyle2,
                    buttonName, button2Name)
          ],
        ),
      ));
}

Widget TwoButtonDesign(
  OnTap? onTap,
  OnTap? onTap2,
  Color? bgColor,
  Color? bgColor2,
  TextStyle? textStyle,
  TextStyle? textStyle2,
  String? buttonName,
  String? button2Name,
) {
  return Row(
    children: [
      Expanded(
        child: CustomButtons.WidgetButton(
          onTap: onTap,
          height: 45,
          width: Get.width,
          radius: 22,
          boxShadow: false,
          bgColor: bgColor ?? AppColors.WHITE,
          child: Text(
            buttonName ?? "",
            style: textStyle,
          ),
        ),
      ),
      Expanded(
        child: CustomButtons.WidgetButton(
          onTap: onTap2,
          height: 45,
          width: Get.width,
          radius: 22,
          boxShadow: false,
          bgColor: bgColor2 ?? AppColors.WHITE,
          child: Text(
            button2Name ?? "",
            style: textStyle2,
          ),
        ),
      ),
    ],
  );
}

Future<void> HideKeyboard() async {
  FocusManager.instance.primaryFocus?.unfocus();
}

ValidationMsg(String msg) {
  FocusManager.instance.primaryFocus?.unfocus();
  // Future.delayed(Duration(milliseconds: 300), () {
    BottomSheetDialog(
        isDismissible: false,
        onWillPop: () async {
          return false;
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShowMessage(msg),
          ],
        ),
        isHideAutoDialog: true,
        message: "error",
        hideDuration: HIDEDURATION,
        backgroundColor: AppColors.RED);
  // });
}

SuccessMsg(String msg, {String title = "success"}) {
  FocusManager.instance.primaryFocus?.unfocus();
  // Future.delayed(Duration(milliseconds: 300), () {
    BottomSheetDialog(
        isDismissible: false,
        onWillPop: () async {
          return false;
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShowMessage(msg),
          ],
        ),
        isHideAutoDialog: true,
        message: title,
        hideDuration: HIDEDURATION,
        backgroundColor: AppColors.GREEN);
  // });
}
PackageInfoMsg(Widget widget, {String title = "package summary"}) {
  FocusManager.instance.primaryFocus?.unfocus();
  // Future.delayed(Duration(milliseconds: 300), () {
  BottomSheetDialog(
      isDismissible: true,
      onWillPop: () async {
        return true;
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // height: 100,
            padding: EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 40),
            child: Align(
              alignment: Alignment.topLeft,
              child:widget),
          )
        ],
      ),
     // isHideAutoDialog: true,
      message: title,
     // hideDuration: HIDEDURATION,
      backgroundColor: Color(0xffeb9f0e));
  // });
}

Widget Show2Button(OnTap? onTap, OnTap? onTap2, String buttonName, String button2Name) {
  return Row(
    children: [
      Expanded(
        child: CustomButtons.WidgetButton(

          onTap: onTap,
          height: 45,
          radius: 22.h,
          boxShadow: false,
          bgColor: AppColors.ALERT_BUTTON_COLOR,
          child: Text(
            buttonName,
            style: TextStyle(color: AppColors.BLACK, fontWeight: FontWeight.w600, fontSize: 14.sp),
          ),
        ),
      ),
      Expanded(
        child: CustomButtons.WidgetButton(
          onTap: onTap2,
          height: 45,
          radius: 22.h,
          boxShadow: false,
          bgColor: AppColors.BLACK,
          child: Text(
            button2Name,
            style: TextStyle(color: AppColors.WHITE, fontWeight: FontWeight.w600, fontSize: 14.sp),
          ),
        ),
      ),
    ],
  );
}
