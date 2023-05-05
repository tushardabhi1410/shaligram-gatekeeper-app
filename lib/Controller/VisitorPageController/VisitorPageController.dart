import 'dart:convert';
import 'dart:io';
import 'package:avinashgatekeeper/Config/Helper/ApiResponse.dart';
import 'package:avinashgatekeeper/Config/Helper/DeviceData.dart';
import 'package:avinashgatekeeper/Config/Helper/SessionData.dart';
import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Config/Utils/Style.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/Modal/FlatChoiceModal/FlatChoiceModal.dart';
import 'package:avinashgatekeeper/View/Tabbar.dart';
import 'package:avinashgatekeeper/Widget/AppLoader.dart';
import 'package:avinashgatekeeper/Widget/CommonBottomSheet.dart';
import 'package:avinashgatekeeper/Widget/Snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:dio/dio.dart' as dio;

import 'package:shared_preferences/shared_preferences.dart';

import '../../Modal/CommonModal/CommonModal.dart';
import '../../Modal/CommonModal/PurposeModal.dart';
import '../../View/HomePage/HomePage.dart';
import '../../View/RequestViewForm/RequestViewForm.dart';
import '../../Widget/select_dailog.dart';

class VisitorPageController extends GetxController {
  Rxn<TextEditingController> txt_name = Rxn(TextEditingController());
  Rxn<TextEditingController> txt_phone = Rxn(TextEditingController());
  Rxn<TextEditingController> txt_vehicle = Rxn(TextEditingController());
  Rxn<TextEditingController> txt_note = Rxn(TextEditingController());
  TextEditingController txt_password = TextEditingController();
  TextEditingController txt_building = TextEditingController();
  TextEditingController txt_project = TextEditingController();
  TextEditingController txt_unit = TextEditingController();

  TextEditingController txt_vendorroles = TextEditingController();
  TextEditingController txt_purpose = TextEditingController();

  //Rx object declaration
  Rxn<dynamic> arrselectedpropertylistretriver = Rxn();

  //Rx variable declaration
  RxBool isSwitched = false.obs;
  RxString projectarr = ''.obs;

  BuildContext context = Get.context!;
  RxString tcLink = "".obs;
  RxString privatePolicy = "".obs;

  ImagePicker imagePicker = ImagePicker();
  RxString Image_Photo = "".obs;
  String ccode = "91";
  String isocode = "IN";

  RxList<String> arrBuildingList = RxList([
    'The Persuit of Happiness',
    'Shaligram Kinaro',
    'Shaligram Signature',
    'Sundaram Status',
    'Saffron Homes',
  ]);

  // RxList<String> arrProjectList = RxList([
  //   'The Persuit of Happiness',
  //   'Shaligram Kinaro',
  //   'Shaligram Signature',
  //   'Sundaram Status',
  //   'Saffron Homes',
  // ]);

  RxList<CommonModal> arrvendorrolesList = RxList<CommonModal>([]);
  Rx<Future<List<CommonModal>>> futurevendorlistData =
      Future.value(<CommonModal>[]).obs;

  RxList<CommonModal> arrProjectList = RxList<CommonModal>([]);
  Rx<Future<List<CommonModal>>> futureprojectslistData =
      Future.value(<CommonModal>[]).obs;
  RxList<CommonModal> arrselectedProjectList = RxList<CommonModal>([]);

  RxList<CommonPurposeModal> arrpurposeList = RxList<CommonPurposeModal>([]);
  Rx<Future<List<CommonPurposeModal>>> futurepurposelistData =
      Future.value(<CommonPurposeModal>[]).obs;

  RxString isFaqsEmptyMsg = "".obs;

  CommonModal obj_vendorrole = CommonModal();
  CommonModal obj_project = CommonModal();
  CommonPurposeModal obj_purpose = CommonPurposeModal();

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
      return "Please Enter Your Name";
      // } else if (value!.length > 72) {
      //   return "Name should be 72 charecters only";
    } else {
      return null;
    }
  }
//
// FetchData(){
//     txt_unit.text=
// }

  Add_Visitor() async {
    AppLoader(context);
    try {
      Map<String, dynamic> data = {};
      List<VillaAndPlotAndUnitListModel> testlist =
          arrselectedpropertylistretriver.value;
      var unitjson = jsonEncode(testlist.map((e) => e.toJson()).toList());

      data['formevent'] = "addright";
      data['action'] = "insertvisitor";
      data['personname'] = txt_name.value!.text.trim();
      data['mobile'] = txt_phone.value!.text.trim();
      if (obj_project != null) data['purpose'] = [obj_purpose.toJson()];
      data['regular_visitor'] = isSwitched.isTrue ? "1" : "0";
      data['comment'] = txt_note.value!.text.trim();
      data['unit'] = unitjson;
      data['countrycode'] = ccode;
      data['vehicleno'] = txt_vehicle.value!.text.trim();
      if (txt_note.value!.text.isNotEmpty)
        data['comment'] = txt_note.value!.text.trim();
      data['visitortypeid'] = [json.encode(obj_vendorrole.toJson())].toString();
      if (Image_Photo.value.isNotEmpty) {
        data['profile'] = await dio.MultipartFile.fromFile(Image_Photo.value);
      }

      print(data.toString() + " this is visitor datata");

      ApiResponse response = ApiResponse(
          data: data,
          requestType: RequestType.post,
          base_url: URL_ADDVISITOR,
          apiHeaderType: ApiHeaderType.Content);
      Map<String, dynamic>? responseData = await response.getResponse();
      if (responseData!['status'].toString() == "1") {
        SuccessMsg(responseData['message']);
        RemoveAppLoader(context);
        Get.offAll(RequestViewForm());
      } else {
        RemoveAppLoader(context);
        ValidationMsg(responseData['message'] ?? "Somthing Went Wrong");
        print(responseData['data']);
      }
    } catch (e) {
      ValidationMsg("Somthing Went Wrong");
      print(e.toString());

      RemoveAppLoader(context);
    }
  }

  Add_Vendor() async {
    AppLoader(context);
    try {
      Map<String, dynamic> data = {};
      data['action'] = "insertvendors";
      // data['formevent'] = "addright";
      data['personname'] = txt_name.value!.text.trim();
      data['regular_visitor'] = isSwitched.isTrue ? "1" : "0";
      data['mobile'] = txt_phone.value!.text.trim();
      data['countrycode'] = ccode;
      data['countrycodestr'] = "in";
      if (txt_vehicle.value!.text.trim().isNotEmpty)
        data['vehicleno'] = txt_vehicle.value!.text.trim();
      if (projectarr.value != "" && projectarr.value != null)
        data['projectid'] = projectarr.value.toString();
      if (txt_note.value!.text.isNotEmpty)
        data['comment'] = txt_note.value!.text.trim();
      data['vendorrole'] = [json.encode(obj_vendorrole.toJson())].toString();
      if (Image_Photo.value.isNotEmpty) {
        data['image'] = await dio.MultipartFile.fromFile(Image_Photo.value);
      }

      ApiResponse response = ApiResponse(
          data: data,
          requestType: RequestType.post,
          base_url: URL_ADDVENDOR,
          apiHeaderType: ApiHeaderType.Content);

      Map<String, dynamic>? responseData = await response.getResponse();
      if (responseData!['status'].toString() == "1") {
        SuccessMsg(responseData['message']);
        RemoveAppLoader(context);
        Get.offAll(TabbarScreen());
      } else {
        RemoveAppLoader(context);
        ValidationMsg(responseData['message'] ?? "Somthing Went Wrong");
        print(responseData['data']);
      }
    } catch (e) {
      ValidationMsg("Somthing Went Wrong");
      print(e.toString());

      RemoveAppLoader(context);
    }
  }

  // String? Vehical_Validator(String? value) {
  //   if (!RegExp(r'[A-Z][a-z]{2}\s[0-9|\s]{1,2}\s[A-Z|\s]{1,2}\s[0-9]{1,4}')
  //       .hasMatch(value!)) {
  //     //  return "Password should contain atleast 1 special character";
  //     return "Vehical should be like MH 15 JH 1234";
  //   }
  // }

  String? Validator_Password(String? value) {
    if (value!.isEmpty) {
      return "Please enter password";
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      //  return "Password should contain atleast 1 special character";
      return "Password should be like Avinash@123";
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      //  return "Password should contain atleast 1 upper case";
      return "Password should be like Avinash@123";
    }
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
    RetrieveVendorRolesData();
    RetrieveProjectData();
    RetrievePurposeData();
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
      return "     Please Enter your number";
    } else if (value.length < 10 || value.length > 11) {
      return "Please Enter your valid phone number";
    } else {
      return null;
    }
  }

  String? validationvehical(String? value) {
    if (value!.trim().isEmpty) {
      return "Please Enter your vehical number";
    } else {
      return null;
    }
  }

  Future<List<CommonModal>> RetrieveVendorRolesData() async {
    arrvendorrolesList = RxList<CommonModal>([]);
    Map<String, dynamic> data = {
      "action": "fillvendorroles",
    };

    print('data');
    print(URL_VENDORROLESLIST);

    ApiResponse response = ApiResponse(
        requestType: RequestType.post,
        data: data,
        // base_url: URL_BUILDER_STAFF + "?checkin_date=2023-01-02&staff_category=1",
        // base_url: URL_BUILDER_STAFF + "?checkin_date=2023-01-02",
        // base_url: URL_BUILDER_STAFF + "?checkin_date="+todaysdate,
        base_url: URL_VENDORROLESLIST,
        apiHeaderType: ApiHeaderType.Content);
    print(data);
    Map<String, dynamic>? responseData = await response.getResponse();
    print(responseData);
    if (responseData!['status'] == 1) {
      List result = responseData['result'];
      arrvendorrolesList.value =
          List.from(result.map((e) => CommonModal.fromJson(e)));
      print("VENDOR ROLES List");
      // print( URL_BUILDER_STAFF + "?staff_category=1");
      print(arrvendorrolesList);
      arrvendorrolesList.refresh();
    } else {
      isFaqsEmptyMsg.value = responseData['message'];
      print(responseData['message']);
    }
    return arrvendorrolesList;
  }

  Future<List<CommonModal>> RetrieveProjectData() async {
    arrProjectList = RxList<CommonModal>([]);
    Map<String, dynamic> data = {
      "action": "fillproject",
    };
    ApiResponse response = ApiResponse(
        requestType: RequestType.post,
        data: data,
        base_url: URL_VENDORROLESLIST,
        apiHeaderType: ApiHeaderType.Content);
    print(data);
    Map<String, dynamic>? responseData = await response.getResponse();
    print(responseData);
    if (responseData!['status'] == 1) {
      List result = responseData['result'];
      arrProjectList.value =
          List.from(result.map((e) => CommonModal.fromJson(e)));
      print("VENDOR ROLES List");
      // print( URL_BUILDER_STAFF + "?staff_category=1");
      print(arrvendorrolesList);
      arrProjectList.refresh();
    } else {
      isFaqsEmptyMsg.value = responseData['message'];
      print(responseData['message']);
    }
    return arrProjectList;
  }

  Future<List<CommonPurposeModal>> RetrievePurposeData() async {
    arrpurposeList = RxList<CommonPurposeModal>([]);
    Map<String, dynamic> data = {
      "action": "fillpurpose",
    };

    print('data');
    print(URL_VENDORROLESLIST);

    ApiResponse response = ApiResponse(
        requestType: RequestType.post,
        data: data,
        base_url: URL_VENDORROLESLIST,
        apiHeaderType: ApiHeaderType.Content);
    print(data);
    Map<String, dynamic>? responseData = await response.getResponse();
    print(responseData);
    print(" purposeeeeeeeeeeeeeeeeeeeeeee");
    if (responseData!['status'] == 1) {
      List result = responseData['data'];
      arrpurposeList.value =
          List.from(result.map((e) => CommonPurposeModal.fromJson(e)));
      arrpurposeList.refresh();
    } else {
      isFaqsEmptyMsg.value = responseData['message'];
      print(responseData['message']);
    }
    return arrpurposeList;
  }

  OnTapSubmit() {
    if (formKey.currentState!.validate()) {
      LoginServices();
    }
  }

  SelectBuildingValue() {
    BuildingDialogBox((value) {
      txt_building.text = value;
      //projectCode.value = value.projectcode!;
    });
  }

  SelectProjectValue() {
    ProjectDiaLougeOptions((value) {});
  }

  String? Building_Validation(String? value) {
    if (value!.isEmpty) {
      return "Please select a value";
    } else {
      return null;
    }
  }

  String? Purpose_Validation(String? value) {
    if (value!.trim().isEmpty) {
      return "Please select a purpose";
    } else {
      return null;
    }
  }

  String? Vendor_Validation(String? value) {
    if (value!.trim().isEmpty) {
      return "Please select a vendor";
    } else {
      return null;
    }
  }

  String? Project_Validation(String? value) {
    if (value!.isEmpty) {
      return "Please select a project";
    } else {
      return null;
    }
  }

  SelectVendorRoleValue() {
    VendorDialogBox((value) {
      obj_vendorrole = value;
      txt_vendorroles.text = obj_vendorrole.name ?? "";
      //projectCode.value = value.projectcode!;
    });
  }

  SelectPurposeValue() {
    PurposeDialogBox((value) {
      obj_purpose = CommonPurposeModal(id: value.id, purpose: value.purpose);
      txt_purpose.text = obj_purpose.purpose ?? "";
      //projectCode.value = value.projectcode!;
    });
  }

  Future<dynamic> BuildingDialogBox(ValueChanged<dynamic> onChange) {
    return SelectDialog.showModal(
      Get.context!,
      label: "Building From All Cities",
      items: arrBuildingList,
      onChange: onChange,
      searchBoxDecoration:
          InputDecoration(prefixIcon: Icon(Icons.search), hintText: "Search"),
    );
  }

  Future<dynamic> ProjectDialogBox(ValueChanged<dynamic> onChange) {
    return SelectDialog.showModal(
      Get.context!,
      multipleSelectedValues: arrselectedProjectList.value,
      label: "Project From All Cities",
      items: arrProjectList,
      // onChange: onChange,
      onMultipleItemsChange: onChange,

      searchBoxDecoration:
          InputDecoration(prefixIcon: Icon(Icons.search), hintText: "Search"),
    );
  }

  Future<dynamic> ProjectDiaLougeOptions(ValueChanged<dynamic> onChange) {
    return SelectDialog1.showModal<dynamic>(Get.context!,
        label: "Project From All Cities",
        items: arrProjectList,
        multipleSelectedValues: arrselectedProjectList.value,
        selectedValue: obj_project,
        onChange: onChange, itemBuilder: (context, item, isSelected) {
      return ListTile(
        dense: true,
        trailing: isSelected
            ? Icon(
                Icons.done,
                color: Colors.blue,
              )
            : Container(
                width: 20.w,
              ),
        title: Text(item.name!),
        selected: isSelected,
      );
    }, okButtonBuilder: (context, onPressed) {
      return ChooseButton(onPressed);
    }, onMultipleItemsChange: (List<dynamic> value) {
      print(value.toString());

      List<CommonModal>? triallist = [];
      if (value != null && value.length > 0) {
        projectarr.value = "";
        triallist = value.cast<CommonModal>();
        txt_project.text =
            triallist.map((e) => e.name.toString()).toList().join(" , ");
        projectarr.value =
            triallist.map((e) => e.id.toString()).toList().join(",");
        arrselectedProjectList.clear();
        arrselectedProjectList.value = triallist;
        arrselectedProjectList.refresh();
      } else {
        projectarr.value = "";
        txt_project.text = "";
        arrselectedProjectList.clear();
      }
    }, searchBoxDecoration: const InputDecoration(hintText: 'Search Here'));
  }

  Future<dynamic> VendorDialogBox(ValueChanged<dynamic> onChange) {
    return SelectDialog.showModal<CommonModal>(
      Get.context!,
      label: "Vendor Roles",
      items: arrvendorrolesList,
      onChange: onChange,
      searchBoxDecoration:
          InputDecoration(prefixIcon: Icon(Icons.search), hintText: "Search"),
    );
  }

  Future<dynamic> PurposeDialogBox(ValueChanged<CommonPurposeModal> onChange) {
    print(arrpurposeList[0].purpose.toString());
    return SelectDialog.showModal<CommonPurposeModal>(
      Get.context!,
      label: "Purpose",
      items: arrpurposeList,
      onChange: onChange,
      searchBoxDecoration:
          InputDecoration(prefixIcon: Icon(Icons.search), hintText: "Search"),
    );
  }

  OnProfilePictureSelect() {
    showCupertinoModalPopup(
        context: Get.context!,
        builder: (context) {
          return CupertinoActionSheet(
            cancelButton: CupertinoActionSheetAction(
              child: const Text("Close"),
              onPressed: () {
                Get.back();
              },
            ),
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  Get.back();
                  // CheckCameraPermission();
                  CameraSelect();
                },
                child: Text(
                  "Camera",
                  style: TextStyles.textStyleDark15(),
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Get.back();
                  ChooseImage();
                  // CheckStoargePermission();
                },
                child: Text(
                  "Choose Photo",
                  style: TextStyles.textStyleDark15(),
                ),
              ),
            ],
          );
        });
  }

  void CameraSelect() async {
    AppLoader(context);
    Directory directory = await getApplicationDocumentsDirectory();
    try {
      var response = await imagePicker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 60,
      );
      if (response != null) {
        File file = File(response.path);

        double sizeInMb = file.lengthSync() / (1024 * 1024);

        if (sizeInMb > 1) {
          RemoveAppLoader(context);
          showSnackBar(
              status: Status.Error,
              message: "Image size is not more then 800 kb",
              title: "Error!");
        } else {
          _cropImage(file);
          // UploadImage(file);
        }
      } else {
        RemoveAppLoader(context);
        print("No image selected");
      }
    } catch (e) {
      print("Error :--- \n $e");
    }
  }

  void ChooseImage() async {
    AppLoader(context);
    Directory directory = await getApplicationDocumentsDirectory();
    try {
      var response = await imagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);
      if (response != null) {
        File file = File(response.path);
        double sizeInMb = file.lengthSync() / (1024 * 1024);
        if (sizeInMb > 1) {
          RemoveAppLoader(context);
          showSnackBar(
              status: Status.Error,
              message: "Image size is not more then 800 kb",
              title: "Error!");
        } else {
          _cropImage(file);
        }
      } else {
        RemoveAppLoader(context);
        print("No Image Selected");
      }
    } catch (e) {
      print("Error :--- \n $e");
    }
  }

  Future _cropImage(File file) async {
    CroppedFile? cropfile = await ImageCropper.platform.cropImage(
        sourcePath: file.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));

    if (cropfile != null) {
      Image_Photo.value = cropfile.path;
      Image_Photo.refresh();
      RemoveAppLoader(context);

      //UploadImage(cropfile.path);
    } else {
      RemoveAppLoader(context);
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
        'mobile_no': txt_name.value!.text.trim().toString(),
        'password': txt_password.text.trim().toString(),
      };
      data.addAll(deviceData);
      print(data);
      ApiResponse response = ApiResponse(
          requestType: RequestType.post,
          data: data,
          base_url: URL_LOGIN,
          apiHeaderType: ApiHeaderType.Login);
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
