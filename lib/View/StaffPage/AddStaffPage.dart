import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Config/Utils/color.dart';
import '../../Config/Utils/constantValue.dart';
import '../../Controller/BuilderStaffController/AddBuilderStaffPageController.dart';
import '../../Controller/StaffController/AddStaffController.dart';
import '../../Widget/CustomAppBar.dart';
import '../../Widget/CustomButton.dart';
import '../../Widget/CustomTextField.dart';


class AddStaffPage extends StatefulWidget {
  const AddStaffPage({Key? key}) : super(key: key);

  @override
  State<AddStaffPage> createState() => _AddStaffPageState();
}

class _AddStaffPageState extends State<AddStaffPage> {
  AddStaffController cnt_addstaff = Get.put(AddStaffController());

  @override
  void initState() {
    super.initState();
    cnt_addstaff.RetrieveBuilderStaffTypesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          CustomerStaffForm(),
          Positioned(
              top: 0,
              child: CustomAppBar(
                  title: "Customer Staff",
                  bgColor: AppColors.WHITE,
                  backimgbgColor: AppColors.DARK_GREY,
                  onTapCallBack: () {
                    Get.back();
                  })),
        ])
      //),
    );
  }

  Widget CustomerStaffForm() {
    return Container(
        width: Get.width,
        height: Get.height,
        child:
        // Positioned(
        //   bottom: 0,
        //   left: 0,
        //   right: 0,
        //   child: Container(
        //       alignment: Alignment.center,
        //       child: Image.asset(
        //         SPLASH_BG,
        //         fit: BoxFit.fill,
        //         //color: AppColors.DARK_GREY,
        //       )),
        // ),
        Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            elevation: 0,
            backgroundColor: AppColors.TRANSPARENT,
          ),
          backgroundColor: AppColors.WHITE,
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Container(
              width: Get.width,
              height: Get.height,
              padding: EdgeInsets.only(
                  left: PADDING, right: PADDING, top: 0.w, bottom: 0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Center(
                  //     child: Image.asset(APP_LOGO,fit: BoxFit.fill,height: 150.w,)
                  // ),

                  //SizedBox(height: 20.w,),
                  Container(
                      child: Form(
                        key: cnt_addstaff.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 80.w,
                            ),
                            CustomTextField(
                              labelText: "Name",
                              autoFocus: false,
                              keybordType: TextInputType.name,
                              controller: cnt_addstaff.txt_name,
                              validator: cnt_addstaff.Validator,
                            ),
                            SizedBox(
                              height: 20.w,
                            ),
                            ContactNumberTextField(),
                            // SizedBox(
                            //   height: 20.w,
                            // ),
                            // CustomTextField(
                            //   labelText: "Contact Number",
                            //   autoFocus: false,
                            //   keybordType: TextInputType.number,
                            //   controller: cnt_Customer.txt_phone,
                            //   validator: cnt_Customer.Validation_Phone,
                            // ),
                            SizedBox(
                              height: 20.w,
                            ),
                            CustomTextField(
                              labelText: "Email",
                              autoFocus: false,
                              keybordType: TextInputType.emailAddress,
                              controller: cnt_addstaff.txt_email,
                              validator: cnt_addstaff.Validator_email,
                            ),
                            SizedBox(
                              height: 20.w,
                            ),
                            BuildingSelectionWidget(),
                            SizedBox(
                              height: 20.w,
                            ),
                            ProjectSelectionWidget(),
                            SizedBox(
                              height: 20.w,
                            ),
                            InkWell(
                                onTap: (){
                                  cnt_addstaff.OnProfilePictureSelect();
                                },
                                child:
                                Image.asset("assets/images/add_images.png",height: 80.w,)),
                            SizedBox(
                              height: 20.w,
                            ),
                            CustomButtons.WidgetButton(
                              width: Get.width,
                              height: 45.w,
                              radius: 8.w,
                              onTap: () {
                                cnt_addstaff.OnTapSubmit();
                              },
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                    color: AppColors.WHITE, fontSize: 14.sp),
                              ),
                              bgColor: AppColors.APP_THEME_COLOR,
                            ),
                            SizedBox(
                              height: 10.w,
                            ),
                            CustomButtons.WidgetButton(
                              width: Get.width,
                              height: 45.w,
                              radius: 8.w,
                              onTap: () {},
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: AppColors.WHITE, fontSize: 14.sp),
                              ),
                              bgColor: Colors.grey,
                            ),
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
                      )),
                ],
              ),
            ),
          ),
        ));
  }

  Widget ContactNumberTextField() {
    return TextFormField(
      maxLength: 10,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      controller: cnt_addstaff.txt_phone,
      validator: cnt_addstaff.Validation_Phone,
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
                            dialogTextStyle: TextStyle(color: AppColors.BLACK, fontSize: 13.sp),
                            searchStyle: TextStyle(color: AppColors.BLACK, fontSize: 13.sp),
                            textStyle: TextStyle(color: AppColors.BLACK, fontSize: 13.sp),
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
                            initialSelection: cnt_addstaff.isocode != null
                                ? cnt_addstaff.isocode.toString().toUpperCase()
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
                                cnt_addstaff.isocode = code.code!;
                                cnt_addstaff.ccode = code.dialCode!;
                              }); //get the URL of flag. flags/aq.png for Antarctica
                            },
                          )),
                      SizedBox(width: 10.w,child:  Icon(
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
        onTap: () => cnt_addstaff.SelectBuildingValue(),
        validator: cnt_addstaff.Building_Validation,
        suffix: Icon(
          Icons.arrow_drop_down,
          color: AppColors.BLACK,
        ),
        hintStyle: TextStyle(color: AppColors.BLACK, fontSize: 13.sp),
        readOnly: true,
        hintText: "Select Building",
        controller: cnt_addstaff.txt_building,
        borderColor: AppColors.SHADOW,
        cursorColor: AppColors.BLACK);
  }

  Widget ProjectSelectionWidget() {
    return OutlineTextField(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        onTap: () => cnt_addstaff.SelectProjectValue(),
        validator: cnt_addstaff.Building_Validation,
        suffix: Icon(
          Icons.arrow_drop_down,
          color: AppColors.BLACK,
        ),
        hintStyle: TextStyle(color: AppColors.BLACK, fontSize: 13.sp),
        readOnly: true,
        hintText: "Select",
        controller: cnt_addstaff.txt_project,
        borderColor: AppColors.SHADOW,
        cursorColor: AppColors.BLACK);
  }
}
