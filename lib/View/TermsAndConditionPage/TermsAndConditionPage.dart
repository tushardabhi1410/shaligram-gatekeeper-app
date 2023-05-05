import 'package:avinashgatekeeper/Controller/TermsAndConditionController/TermsAndConditionController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Config/Utils/color.dart';
import '../../Widget/CustomAppBar.dart';


class TermsAndConditionPage extends StatefulWidget {
  const TermsAndConditionPage({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionPage> createState() => _TermsAndConditionPageState();
}

class _TermsAndConditionPageState extends State<TermsAndConditionPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  TermsAndConditionController cnt_tnc=Get.put(TermsAndConditionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(children: [

            Positioned(
                top: 0,
                child: CustomAppBar(
                    title: "Terms And Condition",
                    bgColor: AppColors.WHITE,
                    backimgbgColor: AppColors.DARK_GREY,
                    onTapCallBack: () {
                      Get.back();
                    })),
          ]),
        )
      //),
    );
  }
}
