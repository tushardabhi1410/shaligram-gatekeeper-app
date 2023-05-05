import 'dart:io';

import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/Controller/VisitorPageController/VisitorPageController.dart';
import 'package:avinashgatekeeper/Widget/CustomAppBar.dart';
import 'package:avinashgatekeeper/Widget/CustomButton.dart';
import 'package:avinashgatekeeper/Widget/CustomTextField.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Config/Functions.dart';
import '../../Modal/FlatChoiceModal/FlatChoiceModal.dart';
import '../../Widget/CustomDecoration.dart';
import '../../Widget/TextEditField.dart';
import '../VisitorRegistrationPage/FlatListPage.dart';

class VisitorPage extends StatefulWidget {
  String? title = "";
  String unittypeid = "";
  dynamic SelectedRetiriveList;

  VisitorPage({
    Key? key,
    required this.title,
    required this.unittypeid,
    this.SelectedRetiriveList,
  }) : super(key: key);
  @override
  _VisitorState createState() => _VisitorState();
}

class _VisitorState extends State<VisitorPage> {
  VisitorPageController cnt_Visitor = Get.put(VisitorPageController());

  @override
  void initState() {
    cnt_Visitor.txt_unit.text = widget.unittypeid.toString();
    cnt_Visitor.arrselectedpropertylistretriver.value =
        widget.SelectedRetiriveList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        resizeToAvoidBottomInset: true,
        body: Stack(children: [
          VisitorForm(),
          Positioned(
              top: 0,
              child: CustomAppBar(
                  title: widget.title ?? "",
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
              child: SubmitButton(),
            ),
          ),
        ]));
  }

  Widget SubmitButton() {
    return OnTapButton(
        onTap: () {
          if (widget.title == "Visitor") {
            if (cnt_Visitor.formKey.currentState!.validate()) {
              cnt_Visitor.Add_Visitor();
            }
          } else {
            if (cnt_Visitor.formKey.currentState!.validate()) {
              cnt_Visitor.Add_Vendor();
            }
          }
        },
        height: 40,
        decoration: CustomDecorations()
            .backgroundlocal(APP_THEME_COLOR, cornarradius, 0, APP_THEME_COLOR),
        text: "Check In",
        style: TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600));
  }

  Widget VisitorForm() {
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
          body: Container(
            width: Get.width,
            height: Get.height,
            // padding: EdgeInsets.only(left: PADDING, right: PADDING, top: 0.w, bottom: 0.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      child: Form(
                    key: cnt_Visitor.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 80.w,
                        ),

                        GestureDetector(
                            onTap: () {
                              cnt_Visitor.OnProfilePictureSelect();
                            },
                            child: Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Obx(() => Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.black45, width: 2)),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: cnt_Visitor
                                                  .Image_Photo.value.isNotEmpty
                                              ? Image.file(
                                                  File(cnt_Visitor
                                                      .Image_Photo.value),
                                                  height: 80,
                                                )
                                              : Image.asset(
                                                  "assets/images/add_images.png",
                                                  height: 80.w,
                                                )))),
                                  Positioned(
                                      bottom: 5,
                                      right: 0,
                                      child: Container(
                                          padding: EdgeInsets.all(3),
                                          //width: 20,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.black45,
                                                  width: 1)),
                                          child: Icon(
                                            Icons.camera_alt,
                                            size: 15,
                                          )))
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 20.w,
                        ),
                        // CustomTextField(
                        //   labelText: "Name",
                        //   autoFocus: false,
                        //   keybordType: TextInputType.name,
                        //   controller: cnt_Visitor.txt_name,
                        //   validator: cnt_Visitor.Validator,
                        // ),

                        SimpleTextFieldNewwithcustomization(
                          inputformat: [UpperCaseTextFormatter()],
                          hintText: "John",
                          maxLength: 72,
                          textCapitalization: TextCapitalization.sentences,
                          controller: cnt_Visitor.txt_name,
                          textInputType: TextInputType.name,
                          labelText: "Name*",
                          validator: (value) => cnt_Visitor.Validator(value),
                        ),
                        // SizedBox(
                        //   height: 20.w,
                        // ),
                        // ContactNumberTextField(),
                        PhoneNumberTextField(cnt_Visitor.txt_phone),
                        // SizedBox(
                        //   height: 20.w,
                        // ),
                        // widget.title=="Vendor"? ProjectSelectionWidget():UnitIdSelectionWidget(),
                        widget.title == "Vendor"
                            ? CommonDropDownTextField(
                                labelText: "Project*",
                                onTap: () {
                                  cnt_Visitor.SelectProjectValue();
                                },
                                controller: cnt_Visitor.txt_project,
                                hintText: "Select Project",
                                validator: cnt_Visitor.Project_Validation,
                              )
                            : CommonDropDownTextField(
                                labelText: "Unit Number*",
                                onTap: () {
                                  Get.to(FlatListPage(
                                    SelectedRetiriveList: cnt_Visitor
                                                    .arrselectedpropertylistretriver
                                                    .value !=
                                                null &&
                                            cnt_Visitor
                                                    .arrselectedpropertylistretriver
                                                    .value !=
                                                ""
                                        ? cnt_Visitor
                                            .arrselectedpropertylistretriver
                                            .value
                                        : null,
                                  ))?.then((value) {
                                    if (value != null) {
                                      cnt_Visitor
                                          .arrselectedpropertylistretriver
                                          .value = [];
                                      List<VillaAndPlotAndUnitListModel>
                                          resultlist = [];
                                      resultlist = value;
                                      cnt_Visitor
                                          .arrselectedpropertylistretriver
                                          .value = value;
                                      String textvalue = '';
                                      resultlist.map((e) {
                                        if (textvalue == "") {
                                          textvalue = textvalue +
                                              "${e.plot_name ?? ""}" +
                                              "${e.vila_name ?? ""}" +
                                              "${e.name ?? ""}";
                                        } else {
                                          if (textvalue
                                              .toString()
                                              .contains(" , ")) {
                                            textvalue = textvalue +
                                                " , " +
                                                "${e.plot_name ?? e.vila_name ?? e.name}";
                                          } else {
                                            textvalue = textvalue +
                                                " , " +
                                                "${e.plot_name ?? e.vila_name ?? e.name}";
                                          }
                                        }
                                      }).toList();
                                      cnt_Visitor.txt_unit.text = textvalue;
                                    }
                                  });
                                },
                                controller: cnt_Visitor.txt_unit,
                                hintText: "Select Unit Number",
                                validator: cnt_Visitor.Building_Validation,
                              ),

                        // :UnitIdSelectionWidget(),

                        // SizedBox(
                        //   height: 20.w,
                        // ),
                        // VendorRoleSelectionWidget(),
                        CommonDropDownTextField(
                          labelText: "Vendor Role*",
                          onTap: () {
                            cnt_Visitor.SelectVendorRoleValue();
                          },
                          controller: cnt_Visitor.txt_vendorroles,
                          hintText: "Select Vendor Role",
                          validator: cnt_Visitor.Vendor_Validation,
                        ),
                        // SizedBox(
                        //   height: 20.w,
                        // ),
                        // PurposeSelectionWidget(),
                        if (widget.title == "Visitor")
                          CommonDropDownTextField(
                            labelText: "Purpose*",
                            onTap: () {
                              cnt_Visitor.SelectPurposeValue();
                            },
                            validator: cnt_Visitor.Purpose_Validation,
                            controller: cnt_Visitor.txt_purpose,
                            hintText: "Select Purpose",
                          ),
                        // SizedBox(
                        //   height: 20.w,
                        // ),
                        // CustomTextField(
                        //   labelText: "Vehicle Number",
                        //   autoFocus: false,
                        //   keybordType: TextInputType.number,
                        //   controller: cnt_Visitor.txt_vehicle,
                        //   validator: cnt_Visitor.validationvehical,
                        // ),
                        SimpleTextFieldNewwithcustomization(
                          inputformat: [UpperCaseTextFormatter()],
                          hintText: "9658",
                          textCapitalization: TextCapitalization.sentences,
                          controller: cnt_Visitor.txt_vehicle,
                          textInputType: TextInputType.name,
                          labelText: "Vehicle Number",
                          maxLength: 15,
                          // validator: cnt_Visitor.Vehical_Validator,
                        ),
                        // SizedBox(
                        //   height: 20.w,
                        // ),
                        // CustomTextField(
                        //   labelText: "Notes",
                        //   autoFocus: false,
                        //   keybordType: TextInputType.number,
                        //   controller: cnt_Visitor.txt_note,
                        //
                        // ),
                        SimpleTextFieldNewwithcustomization(
                          inputformat: [UpperCaseTextFormatter()],
                          hintText: "notes",
                          textCapitalization: TextCapitalization.sentences,
                          controller: cnt_Visitor.txt_note,
                          textInputType: TextInputType.name,
                          labelText: "Notes",
                          maxLength: 255,
                        ),

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
                                  activeColor: Colors.blueGrey,
                                  // color of the round icon, which moves from right to left
                                  thumbColor: AppColors.WHITE,
                                  // when the switch is off
                                  trackColor: Colors.grey,
                                  // boolean variable value
                                  value: cnt_Visitor.isSwitched.value,
                                  // changes the state of the switch
                                  onChanged: (value) => setState(() =>
                                      cnt_Visitor.isSwitched.value = value),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  "Regular Visitor",
                                  style: TextStyle(
                                      color: AppColors.BLACK,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ]),
                        ),

                        //Image.asset("assets/images/add_images.png",height: 80.w,),
                        SizedBox(
                          height: 100.w,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //     CustomButtons.WidgetButton(
                        //       width: Get.width/2.5,
                        //       height: 45.w,
                        //       radius: 8.w,
                        //       onTap: () {
                        //         if(widget.title=="Visitor"){
                        //           if(cnt_Visitor.formKey.currentState!.validate()){
                        //             cnt_Visitor.Add_Visitor();
                        //           }
                        //
                        //         }
                        //         else{
                        //           if(cnt_Visitor.formKey.currentState!.validate()){
                        //             cnt_Visitor.Add_Vendor();
                        //           }
                        //
                        //         }
                        //
                        //       },
                        //       child: Text(
                        //         "Check In",
                        //         style: TextStyle(
                        //             color: AppColors.WHITE, fontSize: 14.sp),
                        //       ),
                        //       bgColor: AppColors.APP_THEME_COLOR,
                        //     ),
                        //     SizedBox(
                        //       width: 10.w,
                        //     ),
                        //     CustomButtons.WidgetButton(
                        //       width: Get.width/2.5,
                        //       height: 45.w,
                        //       radius: 8.w,
                        //       onTap: () {},
                        //       child: Text(
                        //         "Cancel",
                        //         style: TextStyle(
                        //             color: AppColors.WHITE, fontSize: 14.sp),
                        //       ),
                        //       bgColor: Colors.grey,
                        //     ),
                        //   ],
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
      controller: cnt_Visitor.txt_phone.value,
      validator: cnt_Visitor.Validation_Phone,
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
                          child: CountryCodePicker(
                            dialogTextStyle: TextStyle(
                                color: AppColors.BLACK, fontSize: 13.sp),
                            searchStyle: TextStyle(
                                color: AppColors.BLACK, fontSize: 13.sp),
                            textStyle: TextStyle(
                                color: AppColors.BLACK, fontSize: 13.sp),
                            showDropDownButton: false,
                            padding: EdgeInsets.only(right: 0),
                            initialSelection: cnt_Visitor.isocode != null
                                ? cnt_Visitor.isocode.toString().toUpperCase()
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
                                cnt_Visitor.isocode = code.code!;
                                cnt_Visitor.ccode = code.dialCode!;
                              }); //get the URL of flag. flags/aq.png for Antarctica
                            },
                          )),
                      SizedBox(
                          width: 20.w,
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: AppColors.BLACK,
                          )),
                    ]))),
      ),
    );
  }

  Widget ProjectSelectionWidget() {
    return OutlineTextField(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        onTap: () {
          cnt_Visitor.SelectProjectValue();
        },
        validator: cnt_Visitor.Project_Validation,
        suffix: Icon(
          Icons.arrow_drop_down,
          color: AppColors.BLACK,
        ),
        hintStyle: TextStyle(color: AppColors.BLACK, fontSize: 13.sp),
        readOnly: true,
        hintText: "Select Project",
        controller: cnt_Visitor.txt_project,
        borderColor: AppColors.SHADOW,
        cursorColor: AppColors.BLACK);
  }

  Widget UnitIdSelectionWidget() {
    return OutlineTextField(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        onTap: () {
          Get.to(FlatListPage(
            SelectedRetiriveList:
                cnt_Visitor.arrselectedpropertylistretriver.value != null &&
                        cnt_Visitor.arrselectedpropertylistretriver.value != ""
                    ? cnt_Visitor.arrselectedpropertylistretriver.value
                    : null,
          ))?.then((value) {
            if (value != null) {
              cnt_Visitor.arrselectedpropertylistretriver.value = [];
              List<VillaAndPlotAndUnitListModel> resultlist = [];
              resultlist = value;
              cnt_Visitor.arrselectedpropertylistretriver.value = value;
              String textvalue = '';
              resultlist.map((e) {
                if (textvalue == "") {
                  textvalue = textvalue +
                      "${e.plot_name ?? ""}" +
                      "${e.vila_name ?? ""}" +
                      "${e.name ?? ""}";
                } else {
                  if (textvalue.toString().contains(" , ")) {
                    textvalue = textvalue +
                        " , " +
                        "${e.plot_name ?? e.vila_name ?? e.name}";
                  } else {
                    textvalue = textvalue +
                        " , " +
                        "${e.plot_name ?? e.vila_name ?? e.name}";
                  }
                }
              }).toList();
              cnt_Visitor.txt_unit.text = textvalue;
            }
          });
        },
        validator: cnt_Visitor.Building_Validation,
        suffix: Icon(
          Icons.arrow_drop_down,
          color: AppColors.BLACK,
        ),
        hintStyle: TextStyle(color: AppColors.BLACK, fontSize: 13.sp),
        readOnly: true,
        hintText: "Select Unit",
        controller: cnt_Visitor.txt_unit,
        borderColor: AppColors.SHADOW,
        cursorColor: AppColors.BLACK);
  }

  Widget VendorRoleSelectionWidget() {
    return OutlineTextField(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        onTap: () => cnt_Visitor.SelectVendorRoleValue(),
        validator: cnt_Visitor.Vendor_Validation,
        suffix: Icon(
          Icons.arrow_drop_down,
          color: AppColors.BLACK,
        ),
        hintStyle: TextStyle(color: AppColors.BLACK, fontSize: 13.sp),
        readOnly: true,
        hintText: "Select Vendor Role",
        controller: cnt_Visitor.txt_vendorroles,
        borderColor: AppColors.SHADOW,
        cursorColor: AppColors.BLACK);
  }

  Widget PurposeSelectionWidget() {
    return OutlineTextField(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        onTap: () => cnt_Visitor.SelectPurposeValue(),
        validator: cnt_Visitor.Purpose_Validation,
        suffix: Icon(
          Icons.arrow_drop_down,
          color: AppColors.BLACK,
        ),
        hintStyle: TextStyle(color: AppColors.BLACK, fontSize: 13.sp),
        readOnly: true,
        hintText: "Select purpose",
        controller: cnt_Visitor.txt_purpose,
        borderColor: AppColors.SHADOW,
        cursorColor: AppColors.BLACK);
  }
}
