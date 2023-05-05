import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:avinashgatekeeper/Config/Utils/images.dart';
import 'package:avinashgatekeeper/View/LoginPage/LoginPage.dart';
import 'package:avinashgatekeeper/Widget/awsom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Config/Utils/Style.dart';
import 'CustomButton.dart';

typedef void OnTap();

double imageHeight = 55.w;
double btncloseHight = 45.w;

enum TotalButton { ONE, TWO }

enum Status { Successful, Error }

class AlertDialogBoxButton extends StatefulWidget {
  String? message;
  TotalButton? totalButton;
  String? buttonName;
  String? button2Name;
  OnTap? onTap;
  OnTap? onTap2;
  OnTap? oneButtonTap;
  Color? bgColor;
  Color? bgColor2;
  TextStyle? textStyle;
  TextStyle? textStyle2;
  double? height;
  Widget? child;

  AlertDialogBoxButton(
      {this.message,
      this.totalButton = TotalButton.ONE,
      this.oneButtonTap,
      this.buttonName = "",
      this.button2Name = "",
      this.onTap,
      this.onTap2,
      this.bgColor,
      this.bgColor2,
      this.textStyle,
      this.textStyle2,
      this.height,
      this.child});

  @override
  _AlertDialogBoxButtonState createState() => _AlertDialogBoxButtonState();
}

class _AlertDialogBoxButtonState extends State<AlertDialogBoxButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.TRANSPARENT,
      body: Container(
          width: Get.width,
          height: Get.height,
          color: AppColors.TRANSPARENT,
          padding: EdgeInsets.all(30),
          child: Center(
            child: Stack(
              children: [
                Container(
                  height: widget.height ?? 190.w,
                  width: Get.width,
                  color: AppColors.TRANSPARENT,
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: (widget.height ?? 190.w) - 50.w,
                    width: Get.width - 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.WHITE,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Spacer(
                          flex: 2,
                        ),
                        widget.child ??
                            Padding(
                              padding: EdgeInsets.only(left: 3.w, right: 3.w),
                              child: Text(
                                widget.message ?? "",
                                style: TextStyles.textStyleLight16(
                                    AppColors.BLACK),
                                textAlign: TextAlign.center,
                              ),
                            ),
                        Spacer(
                          flex: 1,
                        ),
                        // SizedBox(
                        //   height: 10.w,
                        // ),
                        widget.totalButton == TotalButton.ONE
                            ? CustomButtons.WidgetButton(
                                onTap: widget.onTap ?? () => Get.back(),
                                height: 40.w,
                                width: Get.width,
                                radius: 0,
                                bgColor:
                                    widget.bgColor ?? AppColors.BLACK,
                                child: Text(
                                  widget.buttonName ?? "",
                                  style: widget.textStyle,
                                ))
                            : TwoButtonDesign()
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      height: 90.w,
                      width: 90.w,
                      padding: EdgeInsets.all(15),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          color: AppColors.WHITE,
                          borderRadius: BorderRadius.circular(90.w / 2),
                          border: Border.all(
                              color: AppColors.BLACK, width: 1)),
                      child: Image.asset(APP_LOGO_ROUNDED),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget TwoButtonDesign() {
    return Row(
      children: [
        Expanded(
          child: CustomButtons.WidgetButton(
            onTap: widget.onTap2,
            height: 40.w,
            width: Get.width,
            radius: 0,
            bgColor: widget.bgColor2 ?? AppColors.BLACK,
            child: Text(
              widget.button2Name ?? "",
              style: widget.textStyle2,
            ),
          ),
        ),
        Expanded(
          child: CustomButtons.WidgetButton(
            onTap: widget.onTap,
            height: 40.w,
            width: Get.width,
            radius: 0,
            bgColor: widget.bgColor ?? AppColors.BLACK,
            child: Text(
              widget.buttonName ?? "",
              style: widget.textStyle,
            ),
          ),
        ),
      ],
    );
  }
}

AwesomeDialogCustom dialogCustom(
    {BuildContext? context,
    String? message,
    TotalButton? totalButton,
    String? buttonName,
    String? button2Name,
    OnTap? onTap,
    OnTap? onTap2,
    Color? bgColor,
    Color? bgColor2,
    TextStyle? textStyle,
    TextStyle? textStyle2,
    double? height,
    bool backbuttondismiss = true}) {
  return AwesomeDialogCustom(
    dialogButtonType: DialogButtonType.WITHOUT_BACK_BUTTON,
    context: context ?? Get.context!,
    btnCancel: totalButton == TotalButton.TWO ? CustomButtons.WidgetButton(
            onTap: onTap2,
            height: 40.w,
            width: Get.width,
            radius: 0,
            bgColor: bgColor2 ?? AppColors.BLACK,
            child: Text(
              button2Name ?? "",
              style: textStyle2,
            ),
          ) : null,
    btnOk: CustomButtons.WidgetButton(
      onTap: onTap,
      height: 40.w,
      width: Get.width,
      radius: 0,
      bgColor: bgColor ?? AppColors.BLACK,
      child: Text(
        buttonName ?? "",
        style: textStyle,
      ),
    ),
    headerheight: 70,
    headerwidth: 70,
    bodyHeaderDistance: 10.w,
    buttonPadding: EdgeInsets.only(top: 20.w),
    headerboderColor: AppColors.BLACK,
    customHeader: Padding(
      padding: EdgeInsets.all(10.w),
      child: Icon(Icons.logout,size: 50,color: AppColors.WHITE,),
    ),

    dismissOnTouchOutside: false,
    dismissOnBackKeyPress: backbuttondismiss,
    isDense: true,
    //animType: AnimType.SCALE,
    body: Padding(
      padding: EdgeInsets.only(left: 8.w, right: 8.w),
      child: Text(
        message ?? "",
        style: TextStyles.textStyleLight16(APP_THEME_COLOR),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
