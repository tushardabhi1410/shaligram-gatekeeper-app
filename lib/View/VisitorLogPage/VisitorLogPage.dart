import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/Controller/VisitorLogPageController/VisitorLogPageController.dart';
import 'package:avinashgatekeeper/Widget/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Config/Functions.dart';
import '../../Modal/VisitorLogModel/VisitorLogModel.dart';
import '../../Widget/CustomDecoration.dart';
import '../../Widget/TextEditField.dart';

class VisitorLogPage extends StatefulWidget {
  String? title;
  VistorModel? vistorModel;

  VisitorLogPage({Key? key, this.vistorModel, this.title}) : super(key: key);

  @override
  _VisitorLogState createState() => _VisitorLogState();
}

class _VisitorLogState extends State<VisitorLogPage> {
  VisitorLogPageController cnt_Visitor = Get.put(VisitorLogPageController());

  @override
  void initState() {
    super.initState();

    cnt_Visitor.futurearrProjectList.value =
        cnt_Visitor.GetProjectList().then((value) {
      if (widget.vistorModel != null) {
        value.map((element) {
          print(element.id.toString() + " this isssssss");
          if (element.id.toString() == widget.vistorModel!.projectmodel?.id) {
            cnt_Visitor.obj_project = element;
          }
        }).toList();

        var inputFormat = DateFormat('dd MMM yyyy');
        var date1 = inputFormat.parse(widget.vistorModel!.StartDate.toString());

        print(date1.toString() + " thissss is value");

        cnt_Visitor.txt_project.text =
            widget.vistorModel?.projectmodel?.name ?? "";
        cnt_Visitor.currentData =
            inputFormat.parse(widget.vistorModel!.StartDate.toString()) ??
                DateTime.now();
        cnt_Visitor.endData =
            inputFormat.parse(widget.vistorModel!.EndDate.toString()) ??
                DateTime.now();

        var dateFormat = DateFormat("dd/MM/yyyy");
        cnt_Visitor.txt_start_date.text =
            dateFormat.format(cnt_Visitor.currentData);
        cnt_Visitor.txt_end_date.text = dateFormat.format(cnt_Visitor.endData);

        cnt_Visitor.EndDate.value = widget.vistorModel!.EndDate.toString();
        cnt_Visitor.StartDate.value = widget.vistorModel!.StartDate.toString();
      }

      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          VisitorLogForm(),
          Positioned(
              top: 0,
              child: CustomAppBar(
                  title: widget.title ?? "Visitor Log",
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
          cnt_Visitor.OnTapSubmit();
        },
        height: 40,
        decoration: CustomDecorations()
            .backgroundlocal(APP_THEME_COLOR, cornarradius, 0, APP_THEME_COLOR),
        text: "Get Log",
        style: TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600));
  }

  Widget VisitorLogForm() {
    return Container(
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
          padding: EdgeInsets.only(
              left: PADDING, right: PADDING, top: 0.w, bottom: 0.w),
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
                      height: 50.w,
                    ),
                    // ProjectSelectionWidget(),
                    SizedBox(
                      height: 20.w,
                    ),
                    CommonDropDownTextField(
                      labelText: "Project*",
                      onTap: () {
                        cnt_Visitor.SelectProjectValue();
                      },
                      controller: cnt_Visitor.txt_project,
                      hintText: "Select Project",
                      validator: cnt_Visitor.Building_Validation,
                    ),
                    CommonDropDownTextField(
                      labelText: "Start Date*",
                      onTap: () {
                        cnt_Visitor.OpenDatePickerDialog();
                      },
                      controller: cnt_Visitor.txt_start_date,
                      hintText: "Select Start Date",
                      validator: cnt_Visitor.Building_Validation,
                    ),
                    CommonDropDownTextField(
                      labelText: "End Date*",
                      onTap: () {
                        cnt_Visitor.OpenEndDatePickerDialog();
                      },
                      controller: cnt_Visitor.txt_end_date,
                      hintText: "Select End Date",
                      validator: cnt_Visitor.Building_Validation,
                    ),
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
