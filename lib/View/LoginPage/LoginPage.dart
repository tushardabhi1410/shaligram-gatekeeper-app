import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/Config/Utils/images.dart';
import 'package:avinashgatekeeper/Controller/LoginController/LoginController.dart';
import 'package:avinashgatekeeper/View/HomePage/HomePage.dart';
import 'package:avinashgatekeeper/Widget/CommonButton.dart';
import 'package:avinashgatekeeper/Widget/CustomButton.dart';
import 'package:avinashgatekeeper/Widget/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Config/Functions.dart';
import '../../Widget/CustomDecoration.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  LoginController cnt_Login = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      resizeToAvoidBottomInset: false,
      body: WillPopScope(onWillPop: ()async{
        Get.offAll(LoginPage());
        return true;
      },child: customerForm()),
    );
  }

  Widget customerForm(){
    return Container(
      width: Get.width,
      height: Get.height,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                alignment: Alignment.center,
                child: Image.asset(
                  SPLASH_BG,
                  fit: BoxFit.fill,
                  //color: AppColors.DARK_GREY,
                )),
          ),
          Scaffold(
            backgroundColor: AppColors.TRANSPARENT,
            resizeToAvoidBottomInset: true,
            body: Container(
              padding: EdgeInsets.only(left: PADDING, right: PADDING, top: 0.w, bottom: 0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Image.asset(APP_LOGO_NEW,fit: BoxFit.contain,height: 150.w,width: 250.w,)
                  ),

                  //SizedBox(height: 20.w,),
                  Container(
                      child: Form(
                        key: cnt_Login.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              labelText: "Username",
                              autoFocus: true,
                              keybordType: TextInputType.emailAddress,
                              controller: cnt_Login.txt_username,
                              validator: cnt_Login.Validator,
                            ),
                            SizedBox(
                              height: 20.w,
                            ),
                            CustomTextField(
                              autoFocus: false,
                              labelText: "Password",
                              controller: cnt_Login.txt_password,
                              validator: cnt_Login.Validator_Password,
                            ),
                            SizedBox(
                              height: 20.w,
                            ),
                            SubmitButton(),


                          ],
                        ),
                      )),


                  SizedBox(height: 100.h,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


  Widget SubmitButton() {
    return OnTapButton(
        onTap: () {
          cnt_Login.OnTapLogin();
        },
        height: 45.w,
        decoration: CustomDecorations()
            .backgroundlocal(APP_THEME_COLOR, cornarradius, 0, APP_THEME_COLOR),
        text: "Sign In",
        style:
        TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600));
  }

}
