import 'dart:convert';
import 'dart:io';

import 'package:avinashgatekeeper/Config/Helper/SessionData.dart';
import 'package:avinashgatekeeper/Config/Utils/Style.dart';
import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/Modal/DrawerModal/DrawerModal.dart';
import 'package:avinashgatekeeper/View/LoginPage/LoginPage.dart';
import 'package:avinashgatekeeper/Widget/AlertDialogBox.dart';
import 'package:avinashgatekeeper/Widget/AppLoader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Config/Helper/ApiResponse.dart';
import '../../Modal/DrawerProjectModal/DrawerProjectModal.dart';

class CustomDrawerController extends GetxController {
  RxList<DrawerModal> arrDrawerItemList = RxList<DrawerModal>();
  Rx<Future<List<DrawerProjectModal>>> futureDrawer=Future.value(<DrawerProjectModal>[]).obs;

  RxList<DrawerProjectModal> arrProjectDrawerItemList = RxList<DrawerProjectModal>();
  // Future<List<DrawerProjectModal>>? futureProjectListDrawer;
  Rx<Future<List<DrawerProjectModal>>> futureProjectListDrawer =
      Future.value(<DrawerProjectModal>[]).obs;


  RxString fullname = "".obs;
  RxString profileimage = "".obs;
  RxString email = "".obs;
  RxString contactNo = "".obs;
  RxString  appVersion = "".obs;
  RxInt isBinaryImage = 0.obs;
  RxString profileImg = "".obs;

  RxString privacyLink = "".obs;
  RxString roleCode = "".obs;
  // String mobilenumber = "";
  // String sessionemail = "";
  // late BottomNavigationBarController cnt_bottom;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }



  Future<List<DrawerProjectModal>> GetProjectList() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    
    arrProjectDrawerItemList.value=[];



    try {
      var data = {
        'action': "fillproject"
      };

      ApiResponse response = ApiResponse(
        data: data,
        base_url: URL_PROJECT_ASSIGNED,
        apiHeaderType: ApiHeaderType.Content,
        requestType: RequestType.post,
      );

      Map<String, dynamic>? responseData = await response.getResponse();

      if (responseData!['status'].toString() == "1") {
        List result = responseData['result'];
        print(result.toString()+" result  dataaaaaa");
        arrProjectDrawerItemList.value =
            List.from(result.map((e) => DrawerProjectModal.fromJson(e)));
        arrProjectDrawerItemList.refresh();
      }
      else {
        print("somthing went wrong in drawercontroller");
      }
    }catch(e){
      print(e);
    }



    return arrProjectDrawerItemList;
  }

  Future getDrawerDetails() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    contactNo.value = sp.getString(SESSION_CONTACT)  ?? "";
    email.value = sp.getString(SESSION_USER_EMAIL) ?? "";
    fullname.value = sp.getString(SESSION_PERSONAL_DETAILS_USERDISPLAYNAME) ?? "";
    profileimage.value = sp.getString(SESSION_PROFILEPIC) ?? "";
  }

  OpenLogoutDialog() {
    Get.back();
    dialogCustom(
      message: "Do you really want to Logout?",
      onTap: () => Logout(Get.context!),
      textStyle: TextStyles.textStyleDark14(AppColors.WHITE),
      buttonName: "Logout",
      button2Name: "Cancel",
      bgColor: APP_THEME_COLOR,
      bgColor2: AppColors.WHITE,
      onTap2: ()=>Get.back(),
      textStyle2: TextStyles.textStyleLight14(AppColors.BLACK),
      totalButton: TotalButton.TWO,
    ).show();
  }


  Future<void> Logout(BuildContext context) async {
    updateDialogOpen = false;
    AppLoader(context);
    String macAddress = "";
    String os = "";
    clearSessionData().then((value){

      Get.deleteAll(force: true);
      Get.offAll(LoginPage());
    });

  }

  NavigationHandler(int index) {

    if(index == drawerIndex){
      Get.back();
    }
    drawerIndex = index;
    // CloseDrawer();
    // Get.back();
    DrawerModal obj = arrDrawerItemList[index];
    String title = obj.menuname!;
    switch (obj.uniquename) {
      case HOMEMENU:
        GotoProfilePage(title);
        break;

    }
  }

  GotoProfilePage(String title){

  }


}
