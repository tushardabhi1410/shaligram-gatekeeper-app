import 'package:avinashgatekeeper/Config/Helper/ApiResponse.dart';
import 'package:avinashgatekeeper/Config/Helper/DeviceData.dart';
import 'package:avinashgatekeeper/Config/Helper/SessionData.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/View/HomePage/HomePage.dart';
import 'package:avinashgatekeeper/View/Tabbar.dart';
import 'package:avinashgatekeeper/Widget/AppLoader.dart';
import 'package:avinashgatekeeper/Widget/Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class VisitorRegistrationPageController extends GetxController {

  TextEditingController txt_unit_number = TextEditingController();
  // TextEditingController txt_visitor_code = TextEditingController();
  Rxn<TextEditingController> txt_visitor_code = Rxn(TextEditingController());
  BuildContext context = Get.context!;
  RxString tcLink = "".obs;
  RxString privatePolicy = "".obs;
  Rxn<dynamic> arrselectedpropertylistretriver=Rxn();

  RxList<String> arrBuildingList = RxList([
    'The Persuit of Happiness',
    'Shaligram Kinaro',
    'Shaligram Signature',
    'Sundaram Status',
    'Saffron Homes',
  ]);

  RxList<String> arrProjectList = RxList([
    'The Persuit of Happiness',
    'Shaligram Kinaro',
    'Shaligram Signature',
    'Sundaram Status',
    'Saffron Homes',
  ]);

  int? mincntLng;
  int? maxcntLng;

  String helpImgUrl = "";

  FocusNode focusNode = FocusNode();

  RxString employeename = "".obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> unitkey = GlobalKey<FormState>();
  GlobalKey<FormState> visitorcodekey = GlobalKey<FormState>();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  String? Validation(String? value){
    if(value!.isEmpty){
      return "Please select a value";
    }
    else{
      return null;
    }
  }

  OnTapSubmit() {
    if ((txt_unit_number.text.isNotEmpty && txt_unit_number.text!="") ||
        (txt_visitor_code.value!.text.trim().isNotEmpty && txt_visitor_code.value!.text.trim()!="" )) {
      LoginServices();
    }
  }

  Future<void> LoginServices() async {
    AppLoader(Get.context!);
    try {
      AppLoader(context);
      DeviceData device = DeviceData();
      Map<String, String> deviceData = await device.getDeviceData();
      Map<String, String> data = {
        'builder_id': BUILDER_ID,
        'mobile_no': "",
        'password': "",
      };
      data.addAll(deviceData);
      print(data);
      ApiResponse response = ApiResponse(requestType: RequestType.post,
          data: data, base_url: URL_INSERT_VISITOR, apiHeaderType: ApiHeaderType.Login);
      Map<String, dynamic>? responseData = await response.getResponse();
      print(responseData);
      //showSnackBar(status: Status.Successful, message: "");
      if (responseData!['status']) {
        // debugger();
        RemoveAppLoader(context);
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setBool(SESSION_IS_LOGIN, true);
        showSnackBar(status: Status.Successful, message: 'success');
        if (responseData['data'] != null) {
          storeSessionArray(responseData['data']).then((value) {
            //Get.offAll(HomePage());
            Get.offAll(TabbarScreen());
          });
        }
      } else {
        showSnackBar(status: Status.Error, message: responseData['message']);
        RemoveAppLoader(context);
      }
    } catch (ex) {
      print(ex);
    }
  }
}
