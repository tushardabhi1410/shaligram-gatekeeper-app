import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/Config/Utils/images.dart';
import 'package:avinashgatekeeper/Widget/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef void OnTapCallBack();

class CustomAppBar extends StatefulWidget {
  Color? bgColor = AppColors.WHITE;
  String? title = "";
  Color iconBgColor;
  Color iconColor;
  Color backimgColor;
  Color backimgbgColor;
  OnTapCallBack? onTapCallBack;
  bool onlyBackButton;
  TextStyle? textStyle;
  bool boxshadow;

  CustomAppBar({this.bgColor,
    this.title,
    this.iconBgColor = Colors.white,
    this.iconColor = Colors.black,
    this.backimgbgColor = Colors.white,
    this.backimgColor = Colors.black,
    this.textStyle,
    this.onTapCallBack,this.onlyBackButton = false,
    this.boxshadow = false
  });

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {

  bool dotShow = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNotificationRead();
  }

  _getNotificationRead()async{

    // int count = await getNotificationRead();
    // print("Custom Bar $count");
    // if(count == 0){
    //   setState(() {
    //     dotShow = false;
    //   });
    // }else{
    //   setState(() {
    //     dotShow = true;
    //   });
    // }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.bgColor,
        boxShadow: [
          widget.boxshadow ? BoxShadow(
            color: Colors.black12,
            blurRadius: 1,
            offset: Offset(0,1),
            spreadRadius: 1
          ) : BoxShadow(
            color: AppColors.TRANSPARENT
          )
        ]
      ),
      padding: EdgeInsets.all(10),
      height: APP_BAR_HEIGHT.w,
      width: Get.width,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              child: Row(
                children: [
                  CustomButtons.RoundIconButton(
                      bgColor: widget.backimgbgColor,
                      height: 40.w,
                      width: 40.w,
                      onTap: widget.onTapCallBack,
                      image: BACK_ICON,
                      radius: 40.w / 2,
                      boxShadow: false,
                      imgColor: widget.backimgColor
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      widget.title!,
                      style: widget.textStyle ?? TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
            ),
          ),
          !widget.onlyBackButton ?Container(
            child: Row(
              children: [
                //SearchButton(bgcolor: widget.iconBgColor, iconColor: widget.iconColor),
                SizedBox(
                  width: 10,
                ),
                //NotificationButton(bgcolor: widget.iconBgColor, iconColor: widget.iconColor,dotShow: dotShow)
              ],
            ),
          ):Container()
        ],
      ),
    );
  }
}
