import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Config/Utils/Style.dart';
import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/Controller/VisitorRegistrationPageController/VisitorRegistrationPageController.dart';
import 'package:avinashgatekeeper/View/VisitorPage/VisitorPage.dart';
import 'package:avinashgatekeeper/View/VisitorRegistrationPage/FlatListPage.dart';
import 'package:avinashgatekeeper/Widget/CustomAppBar.dart';
import 'package:avinashgatekeeper/Widget/CustomButton.dart';
import 'package:avinashgatekeeper/Widget/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Config/Functions.dart';
import '../../Modal/FlatChoiceModal/FlatChoiceModal.dart';
import '../../Widget/CustomDecoration.dart';
import '../../Widget/TextEditField.dart';

class VisitorRegistrationPage extends StatefulWidget {
  @override
  _VisitorRegistrationState createState() => _VisitorRegistrationState();
}

class _VisitorRegistrationState extends State<VisitorRegistrationPage> {
  VisitorRegistrationPageController cnt_Visitor =
      Get.put(VisitorRegistrationPageController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        resizeToAvoidBottomInset: true,
        body: Stack(children: [
          VisitorRegistrationForm(),
          Positioned(
              top: 0,
              child: CustomAppBar(
                  title: "Visitor Registration",
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
        ])
        //),
        );
  }

  Widget SubmitButton() {
    return OnTapButton(
        onTap: () {
          if (cnt_Visitor.unitkey.currentState!.validate()) {
            Get.to(VisitorPage(
              title: "Visitor",
              unittypeid: cnt_Visitor.txt_unit_number.text ?? "",
              SelectedRetiriveList:
                  cnt_Visitor.arrselectedpropertylistretriver.value,
            ));
          }
        },
        height: 40,
        decoration: CustomDecorations()
            .backgroundlocal(APP_THEME_COLOR, cornarradius, 0, APP_THEME_COLOR),
        text: "Verify",
        style: TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600));
  }

  Widget VisitorRegistrationForm() {
    return Container(
        // width: Get.width,
        // height: Get.height,
        child: Scaffold(
      backgroundColor: AppColors.BACKGROUND_WHITE,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: AppColors.TRANSPARENT,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
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
                key: cnt_Visitor.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80.w,
                    ),
                    Form(
                      key: cnt_Visitor.unitkey,
                      child: CommonDropDownTextField(
                        labelText: "Unit Number*",
                        onTap: () {
                          Get.to(FlatListPage(
                            SelectedRetiriveList: cnt_Visitor
                                            .arrselectedpropertylistretriver
                                            .value !=
                                        null &&
                                    cnt_Visitor.arrselectedpropertylistretriver
                                            .value !=
                                        ""
                                ? cnt_Visitor
                                    .arrselectedpropertylistretriver.value
                                : null,
                          ))?.then((value) {
                            if (value != null) {
                              cnt_Visitor
                                  .arrselectedpropertylistretriver.value = [];
                              List<VillaAndPlotAndUnitListModel> resultlist =
                                  [];
                              resultlist = value;
                              cnt_Visitor.arrselectedpropertylistretriver
                                  .value = value;
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
                              cnt_Visitor.txt_unit_number.text = textvalue;
                            }
                          });
                        },
                        controller: cnt_Visitor.txt_unit_number,
                        hintText: "Select Unit Number",
                        validator: cnt_Visitor.Validation,
                      ),
                    ),

                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                            width: 30,
                            child: Divider(
                              color: Colors.black,
                            )),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              shape: BoxShape.circle,
                              // borderRadius: BorderRadius.circular(15)
                            ),
                            child: Text(
                              "or",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.BLACK,
                                  height: 1.0,
                                  fontFamily: fontFamily),
                            )),
                        Container(
                            width: 30, child: Divider(color: Colors.black)),
                      ],
                    ),

                    // Form(
                    //   key: cnt_Visitor.visitorcodekey,
                    //   child: CustomTextField(
                    //     labelText: "Visitor Code",
                    //     autoFocus: false,
                    //     keybordType: TextInputType.number,
                    //     controller: cnt_Visitor.txt_visitor_code,
                    //     validator: cnt_Visitor.Validation,
                    //   ),
                    // ),
                    SizedBox(
                      height: 10,
                    ),

                    Form(
                      key: cnt_Visitor.visitorcodekey,
                      child: SimpleTextFieldNewwithcustomization(
                        inputformat: [UpperCaseTextFormatter()],
                        hintText: "XYZ456789",
                        textCapitalization: TextCapitalization.sentences,
                        controller: cnt_Visitor.txt_visitor_code,
                        textInputType: TextInputType.name,
                        labelText: "Visitor Code*",
                        validator: (value) => cnt_Visitor.Validation(value),
                        maxLength: 8,
                      ),
                    ),

                    SizedBox(
                      height: 20.w,
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //
                    //
                    //     CustomButtons.WidgetButton(
                    //       width: Get.width/2.5,
                    //       height: 45.w,
                    //       radius: 8.w,
                    //       onTap: () {
                    //         cnt_Visitor.txt_unit_number.clear();
                    //         cnt_Visitor.arrselectedpropertylistretriver.value=[];
                    //       },
                    //       child: Text(
                    //         "Reset",
                    //         style: TextStyle(
                    //             color: AppColors.WHITE, fontSize: 14.sp),
                    //       ),
                    //       bgColor: Colors.grey,
                    //     ),
                    //     CustomButtons.WidgetButton(
                    //       width: Get.width/2.5,
                    //       height: 45.w,
                    //       radius: 8.w,
                    //       onTap: () {
                    //         if(cnt_Visitor.unitkey.currentState!.validate()){
                    //           Get.to(VisitorPage(title: "Visitor",unittypeid: cnt_Visitor.txt_unit_number.text??"",SelectedRetiriveList: cnt_Visitor.arrselectedpropertylistretriver.value,));
                    //         }
                    //
                    //         //cnt_Visitor.OnTapSubmit();
                    //       },
                    //       child: Text(
                    //         "Verify",
                    //         style: TextStyle(
                    //             color: AppColors.WHITE, fontSize: 14.sp),
                    //       ),
                    //       bgColor:AppColors.APP_THEME_COLOR,
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
}
