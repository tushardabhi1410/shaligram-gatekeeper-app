import 'dart:io';
import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/Widget/CustomAppBar.dart';
import 'package:avinashgatekeeper/Widget/CustomTextField.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Config/Functions.dart';
import '../../../Config/Utils/images.dart';
import '../../../Controller/BuilderStaffController/AddBuilderStaffPageController.dart';
import '../../../Widget/CustomDecoration.dart';
import '../../../Widget/TextEditField.dart';

class AddBuilderStaffPage extends StatefulWidget {
  @override
  _AddBuilderStaffState createState() => _AddBuilderStaffState();
}

class _AddBuilderStaffState extends State<AddBuilderStaffPage> {
  AddBuilderStaffPageController cnt_addbuilder =
      Get.put(AddBuilderStaffPageController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        resizeToAvoidBottomInset: true,
        body: /*WillPopScope(onWillPop: ()async{
        Get.offAll(LoginPage());
        return true;
      },child:*/
            Stack(children: [
          CustomerStaffForm(),
          Positioned(
              top: 0,
              child: CustomAppBar(
                  title: "Builder Staff",
                  bgColor: AppColors.WHITE,
                  backimgbgColor: AppColors.DARK_GREY,
                  onTapCallBack: () {
                    Get.back();
                  })),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.BACKGROUND_WHITE,
                boxShadow: [
                  BoxShadow(
                      color: hex("266CB5").withOpacity(0.1),
                      offset: Offset(1, 1),
                      blurRadius: 5,
                      spreadRadius: 3),
                ],
              ),
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 20),
              child: SubmitButton_4(),
            ),
          ),
        ])
        //),
        );
  }

  Widget CustomerStaffForm() {
    return Container(
        width: Get.width,
        height: Get.height,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            elevation: 0,
            backgroundColor: AppColors.TRANSPARENT,
          ),
          backgroundColor: AppColors.BACKGROUND_WHITE,
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Container(
              // padding: EdgeInsets.only(left: PADDING, right: PADDING, top: 0.w, bottom: 0.w),
              child: Form(
                key: cnt_addbuilder.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100.w,
                    ),
                    // CustomTextField(
                    //   labelText: "Name",
                    //   autoFocus: false,
                    //   keybordType: TextInputType.name,
                    //   controller: cnt_addbuilder.txt_name,
                    //   validator: cnt_addbuilder.Validator,
                    // ),

                    Center(
                      child: GestureDetector(
                          onTap: () {
                            cnt_addbuilder.OnProfilePictureSelect();
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Obx(() => Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.black45, width: 2)),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                      child: cnt_addbuilder
                                              .Image_Photo.value.isNotEmpty
                                          ? Image.file(
                                              File(cnt_addbuilder
                                                  .Image_Photo.value),
                                              height: 90.w,
                                            )
                                          : Image.asset(
                                              "assets/images/add_images.png",
                                              height: 80.w,
                                            )))),
                              Positioned(
                                  bottom: 8,
                                  right: 0,
                                  child: Container(
                                      padding: EdgeInsets.all(3),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.black45, width: 1)),
                                      child: Icon(
                                        Icons.camera_alt,
                                        size: 15,
                                      )))
                            ],
                          )),
                    ),

                    SimpleTextFieldNewwithcustomization(
                      inputformat: [UpperCaseTextFormatter()],
                      hintText: "John",
                      imageIcon: METER_ICON,
                      textCapitalization: TextCapitalization.sentences,
                      controller: cnt_addbuilder.txt_name,
                      textInputType: TextInputType.name,
                      labelText: "Name*",
                      maxLength: 72,
                      validator: (value) =>
                          validation(value, "Please Enter Name"),
                    ),

                    PhoneNumberTextField(cnt_addbuilder.txt_phone),
                    // SizedBox(
                    //   height: 20.w,
                    // ),
                    // ContactNumberTextField(),
                    SizedBox(
                      height: 20.w,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CupertinoSwitch(
                              // overrides the default green color of the track
                              activeColor: Colors.green,
                              // color of the round icon, which moves from right to left
                              thumbColor: AppColors.WHITE,
                              // when the switch is off
                              trackColor: Colors.grey,
                              // boolean variable value
                              value: cnt_addbuilder.isSwitched.value,
                              // changes the state of the switch
                              onChanged: (value) => setState(() =>
                                  cnt_addbuilder.isSwitched.value = value),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              "IswhatsApp",
                              style: TextStyle(
                                  color: AppColors.BLACK,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ]),
                    ),
                    // SizedBox(
                    //   height: 10.w,
                    // ),
                    // CustomTextField(
                    //   labelText: "Email",
                    //   autoFocus: false,
                    //   keybordType: TextInputType.emailAddress,
                    //   controller: cnt_addbuilder.txt_email,
                    //   validator: cnt_addbuilder.Validator_email,
                    // ),
                    SimpleTextFieldNewwithcustomization(
                        hintText: "johndoe123@example.com",
                        controller: cnt_addbuilder.txt_email,
                        // inputformat: [UpperCaseTextFormatter()],
                        textInputType: TextInputType.emailAddress,
                        labelText: "Email*",
                        noautovalidation: true,
                        validator: (value) => emailvalidation(value)),
                    // SizedBox(
                    //   height: 20.w,
                    // ),
                    // BuildingSelectionWidget(),
                    // SizedBox(
                    //   height: 20.w,
                    // ),
                    CommonDropDownTextField(
                        labelText: "Building*",
                        onTap: () {
                          cnt_addbuilder.SelectBuildingValue();
                        },
                        controller: cnt_addbuilder.txt_building,
                        hintText: "Select Building",
                        validator: cnt_addbuilder.Building_Validation),
                    CommonDropDownTextField(
                      labelText: "Designation*",
                      onTap: () {
                        cnt_addbuilder.SelectProjectValue();
                      },
                      controller: cnt_addbuilder.txt_project,
                      hintText: "Select Designation",
                      validator: cnt_addbuilder.Designation_Validation,
                    ),
                    // ProjectSelectionWidget(),
                    SizedBox(
                      height: 20.w,
                    ),
                    // InkWell(
                    //     onTap: (){
                    //       cnt_addbuilder.OnProfilePictureSelect();
                    //     },
                    //     child:
                    //     Image.asset("assets/images/add_images.png",height: 80.w,)),

                    // SizedBox(
                    //   height: 20.w,
                    // ),
                    // CustomButtons.WidgetButton(
                    //   width: Get.width,
                    //   height: 45.w,
                    //   radius: 8.w,
                    //   onTap: () {
                    //     cnt_addbuilder.OnTapSubmit();
                    //   },
                    //   child: Text(
                    //     "Submit",
                    //     style: TextStyle(
                    //         color: AppColors.WHITE, fontSize: 14.sp),
                    //   ),
                    //   bgColor: AppColors.APP_THEME_COLOR,
                    // ),
                    SizedBox(
                      height: 100.w,
                    ),
                    // CustomButtons.WidgetButton(
                    //   width: Get.width,
                    //   height: 45.w,
                    //   radius: 8.w,
                    //   onTap: () {},
                    //   child: Text(
                    //     "Cancel",
                    //     style: TextStyle(
                    //         color: AppColors.WHITE, fontSize: 14.sp),
                    //   ),
                    //   bgColor: Colors.grey,
                    // ),
                    // CustomButtons.WidgetButton(
                    //   width: Get.width,
                    //   height: 45.w,
                    //   radius: 8.w,
                    //   onTap: (){
                    //   cnt_Customer.OnTapLogin();
                    // },
                    // child: Text(
                    //   "Sign In",
                    //   style: TextStyle(color: AppColors.WHITE, fontSize: 14.sp),
                    // ),
                    //   bgColor: AppColors.BLACK,
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget SubmitButton_4() {
    return OnTapButton(
        onTap: () {
          cnt_addbuilder.OnTapSubmit();
        },
        height: 40,
        decoration: CustomDecorations()
            .backgroundlocal(APP_THEME_COLOR, cornarradius, 0, APP_THEME_COLOR),
        text: "Submit",
        style: TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600));
  }

  Widget ContactNumberTextField() {
    return TextFormField(
      maxLength: 10,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      controller: cnt_addbuilder.txt_phone.value,
      validator: cnt_addbuilder.Validation_Phone,
      cursorColor: AppColors.BLACK,
      decoration: InputDecoration(
        counterText: "",
        contentPadding: EdgeInsets.zero,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black38,
        )),
        alignLabelWithHint: true,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: AppColors.BLACK,
        )),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: AppColors.RED,
        )),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: AppColors.RED,
        )),
        //labelText: "Contact Number",
        hintText: "Contact Number",
        hintStyle: TextStyle(color: AppColors.BLACK, fontSize: 13.sp),
        labelStyle: TextStyle(color: AppColors.BLACK, fontSize: 13.sp),

        prefixIcon: Padding(
            padding: EdgeInsets.only(left: 6.w),
            child: SizedBox(
                width: 100.w,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 0),
                          //padding: EdgeInsets.only(bottom: 2),
                          //   decoration: BoxDecoration(
                          //     border: Border(
                          //       //top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
                          //       bottom: BorderSide(width: 1.0, color: lbl_hint_clr),
                          //     ),
                          //   ),
                          child: CountryCodePicker(
                            dialogTextStyle: TextStyle(
                                color: AppColors.BLACK, fontSize: 13.sp),
                            searchStyle: TextStyle(
                                color: AppColors.BLACK, fontSize: 13.sp),
                            textStyle: TextStyle(
                                color: AppColors.BLACK, fontSize: 13.sp),
                            showDropDownButton: false,
                            //showOnlyCountryWhenClosed: false,
                            //showFlag: false,
                            //enabled: false,
                            //showFlagMain: false,
                            //hideMainText: false,
                            padding: EdgeInsets.only(right: 0),
                            // flagWidth: 30,
                            // flagDecoration: BoxDecoration(
                            //
                            // ),
                            // initialSelection: isocode.toUpperCase(),
                            initialSelection: cnt_addbuilder.isocode != null
                                ? cnt_addbuilder.isocode
                                    .toString()
                                    .toUpperCase()
                                : "IN",
                            onChanged: (CountryCode code) {
                              print(code
                                  .name); //get the country name eg: Antarctica
                              print(code
                                  .code); //get the country code like AQ for Antarctica
                              print(code
                                  .dialCode); //get the country dial code +672 for Antarctica
                              print(code.flagUri);
                              setState(() {
                                cnt_addbuilder.isocode = code.code!;
                                cnt_addbuilder.ccode = code.dialCode!;
                              }); //get the URL of flag. flags/aq.png for Antarctica
                            },
                          )),
                      SizedBox(
                          width: 10.w,
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.BLACK,
                          )),
                    ]))),
      ),
    );
  }

  Widget BuildingSelectionWidget() {
    return OutlineTextField(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        onTap: () => cnt_addbuilder.SelectBuildingValue(),
        validator: cnt_addbuilder.Building_Validation,
        suffix: Icon(
          Icons.arrow_drop_down,
          color: AppColors.BLACK,
        ),
        hintStyle: TextStyle(color: AppColors.BLACK, fontSize: 13.sp),
        readOnly: true,
        hintText: "Select Building",
        controller: cnt_addbuilder.txt_building,
        borderColor: AppColors.SHADOW,
        cursorColor: AppColors.BLACK);
  }

  Widget ProjectSelectionWidget() {
    return OutlineTextField(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        onTap: () => cnt_addbuilder.SelectProjectValue(),
        validator: cnt_addbuilder.Designation_Validation,
        suffix: Icon(
          Icons.arrow_drop_down,
          color: AppColors.BLACK,
        ),
        hintStyle: TextStyle(color: AppColors.BLACK, fontSize: 13.sp),
        readOnly: true,
        hintText: "Select Designation",
        controller: cnt_addbuilder.txt_project,
        borderColor: AppColors.SHADOW,
        cursorColor: AppColors.BLACK);
  }
}
