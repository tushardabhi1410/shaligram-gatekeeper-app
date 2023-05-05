import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Config/Helper/ApiResponse.dart';
import '../../Config/Utils/constantValue.dart';
import '../../Modal/PrivacyPageModel/PrivacyPageModel.dart';

class PrivacyPageController extends GetxController{
  //Global Key Declaration
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Rx Variable Declaration
  RxString isFaqsEmptyMsg = "".obs;

  //RxList declaration
  RxList<PrivacyPageModel> arrPrivacyList = RxList<PrivacyPageModel>();

  //future RxList declaration
  Rx<Future<List<PrivacyPageModel>>> futurePrivacyData = Future.value(<PrivacyPageModel>[]).obs;




  Future<List<PrivacyPageModel>> RetrievePrivacyDataNew() async {
    try{
      arrPrivacyList=RxList([]);
      Map<String, dynamic> data = {
        "action":"listprivacypolicy",
      };

      ApiResponse response = ApiResponse(
          requestType: RequestType.post,
          data: data,
          base_url: URL_PRIVACY_POLICY,
          apiHeaderType: ApiHeaderType.Content);

      Map<String, dynamic>? responseData = await response.getResponse();

      if (responseData!['status'].toString()=="1") {
        List result = responseData['data'];

        arrPrivacyList.value = List.from(result.map((e) => PrivacyPageModel.fromJson(e)));
        arrPrivacyList.refresh();
        futurePrivacyData.refresh();


      } else {
        isFaqsEmptyMsg.value = responseData['message'];
        print(responseData['message']);
      }

    }
    catch(e){
      print("im in error");
      print(e);
    }

    return arrPrivacyList;

  }


}