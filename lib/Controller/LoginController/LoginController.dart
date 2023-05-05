import 'package:avinashgatekeeper/Config/Helper/ApiResponse.dart';
import 'package:avinashgatekeeper/Config/Helper/DeviceData.dart';
import 'package:avinashgatekeeper/Config/Helper/SessionData.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/View/HomePage/HomePage.dart';
import 'package:avinashgatekeeper/View/Tabbar.dart';
import 'package:avinashgatekeeper/Widget/AppLoader.dart';
import 'package:avinashgatekeeper/Widget/Snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController txt_phone = TextEditingController();
  TextEditingController txt_password = TextEditingController();
  TextEditingController txt_username = TextEditingController();
  BuildContext context = Get.context!;
  RxString tcLink = "".obs;
  RxString privatePolicy = "".obs;

  int? mincntLng;
  int? maxcntLng;

  String helpImgUrl = "";
  FocusNode focusNode = FocusNode();

  RxString employeename = "".obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? Validator_email(String? value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value!);
    if (value.isEmpty) {
      return "Please Enter your Email";
    } else if (!emailValid) {
      return "Please Enter your valid Email";
    } else {
      return null;
    }
  }

  String? Validator(String? value) {
    if (value!.isEmpty) {
      return "Please Enter Username";
    } else {
      return null;
    }
  }

  String? Validator_Password(String? value) {
    if (value!.isEmpty) {
      return "Please enter password";
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      //  return "Password should contain atleast 1 special character";
      return "Password should be like Avinash@123";
    }
    // if (!RegExp(r'[A-Z]').hasMatch(value)) {
    //   //  return "Password should contain atleast 1 upper case";
    //   return "Password should be like Avinash@123";
    // }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      //  return "Password should contain atleast 1 digit";
      return "Password should be like Avinash@123";
    }
    if (value.length < 8) {
      //  return "Password should atleast contain 8 characters";
      return "Password should be like Avinash@123";
    }
    if (value.length > 20) {
      //  return "Password length is more than 20 characters";
      return "Password should be like Avinash@123";
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  String getOtp(String sms) {
    String? otp;
    RegExp regExp = RegExp(r"\d{4}");
    if (sms != "") {
      Iterable<RegExpMatch> match = regExp.allMatches(sms);
      otp = match.first.group(0);
      print(otp);
    }
    return otp!;
  }

  String? Validation_Phone(String? value) {
    if (value!.isEmpty) {
      return "Please Enter your number";
    } else if (value.length < mincntLng! || value.length > maxcntLng!) {
      return "Please Enter your valid phone number";
    } else {
      return null;
    }
  }

  OnTapLogin() {
    if (formKey.currentState!.validate()) {
      LoginServices();
    }
  }

  Future<dynamic> LoginServices() async {

    try {
      AppLoader(context);
      DeviceData device = DeviceData();
      Map<String, String> deviceData = await device.getDeviceData();
      Map<String, String> data = {
        'action': "login",
        'username': txt_username.text.trim().toString(),
        'password': txt_password.text.trim().toString(),
      };
      print(data.toString()+" this is responceee");
      data.addAll(deviceData);
      ApiResponse response = ApiResponse(requestType: RequestType.post,
          data: data, base_url: URL_LOGIN, apiHeaderType: ApiHeaderType.Login);
      Map<String, dynamic>? responseData = await response.getResponse();
      print(responseData.toString()+" this is responceee");
      if (responseData!['status'].toString()=="1") {
       RemoveAppLoader(context);
        showSnackBar(status: Status.Successful, message: 'success');
        if (responseData != null) {
          StoreLoginSessionData(responseData).then((value) {
            Get.offAll(TabbarScreen());
          });
        }
      } else {
        showSnackBar(status: Status.Error, message: responseData['msg']);
        RemoveAppLoader(context);
      }
    } catch (ex) {
      print(ex.toString());
      showSnackBar(status: Status.Error, message: 'something went wrong!!');
      RemoveAppLoader(context);
    }
  }
}
