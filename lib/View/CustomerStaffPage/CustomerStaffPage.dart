import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/Controller/CustomerStaffPageController/CustomerStaffPageController.dart';
import 'package:avinashgatekeeper/Widget/CustomAppBar.dart';
import 'package:avinashgatekeeper/Widget/CustomButton.dart';
import 'package:avinashgatekeeper/Widget/CustomTextField.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomerStaffPage extends StatefulWidget {
  @override
  _CustomerStaffState createState() => _CustomerStaffState();
}

class _CustomerStaffState extends State<CustomerStaffPage> {
  CustomerStaffPageController cnt_Customer = Get.put(CustomerStaffPageController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        resizeToAvoidBottomInset: false,
        body: /*WillPopScope(onWillPop: ()async{
        Get.offAll(LoginPage());
        return true;
      },child:*/
            Stack(children: [
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
                    key: cnt_Customer.formKey,
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
                          controller: cnt_Customer.txt_name,
                          validator: cnt_Customer.Validator,
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
                          controller: cnt_Customer.txt_email,
                          validator: cnt_Customer.Validator_email,
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
                              cnt_Customer.OnProfilePictureSelect();
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
                            cnt_Customer.OnTapSubmit();
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                color: AppColors.WHITE, fontSize: 14.sp),
                          ),
                          bgColor: Colors.blueGrey,
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
                          bgColor: AppColors.BLACK,
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
      controller: cnt_Customer.txt_phone,
      validator: cnt_Customer.Validation_Phone,
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
                width: 135.w,
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
                            initialSelection: cnt_Customer.isocode != null
                                ? cnt_Customer.isocode.toString().toUpperCase()
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
                                cnt_Customer.isocode = code.code!;
                                cnt_Customer.ccode = code.dialCode!;
                              }); //get the URL of flag. flags/aq.png for Antarctica
                            },
                          )),
                      SizedBox(width: 20.w,child:  Icon(
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
        onTap: () => cnt_Customer.SelectBuildingValue(),
        validator: cnt_Customer.Building_Validation,
        suffix: Icon(
          Icons.arrow_drop_down,
          color: AppColors.BLACK,
        ),
        hintStyle: TextStyle(color: AppColors.BLACK, fontSize: 13.sp),
        readOnly: true,
        hintText: "Select Building",
        controller: cnt_Customer.txt_building,
        borderColor: AppColors.SHADOW,
        cursorColor: AppColors.BLACK);
  }

  Widget ProjectSelectionWidget() {
    return OutlineTextField(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        onTap: () => cnt_Customer.SelectProjectValue(),
        validator: cnt_Customer.Building_Validation,
        suffix: Icon(
          Icons.arrow_drop_down,
          color: AppColors.BLACK,
        ),
        hintStyle: TextStyle(color: AppColors.BLACK, fontSize: 13.sp),
        readOnly: true,
        hintText: "Select",
        controller: cnt_Customer.txt_project,
        borderColor: AppColors.SHADOW,
        cursorColor: AppColors.BLACK);
  }
}
