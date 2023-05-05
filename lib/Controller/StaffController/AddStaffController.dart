import 'dart:convert';
import 'dart:io';
import 'package:avinashgatekeeper/Config/Helper/ApiResponse.dart';
import 'package:avinashgatekeeper/Config/Helper/DeviceData.dart';
import 'package:avinashgatekeeper/Config/Helper/SessionData.dart';
import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Config/Utils/Style.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/Modal/BuilderStaff/TypesModal/TypesModal.dart';
import 'package:avinashgatekeeper/View/Tabbar.dart';
import 'package:avinashgatekeeper/Widget/AppLoader.dart';
import 'package:avinashgatekeeper/Widget/Snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Modal/DrawerProjectModal/DrawerProjectModal.dart';
import '../../Widget/select_dailog.dart';

class AddStaffController extends GetxController {

  TextEditingController txt_name = TextEditingController();
  TextEditingController txt_phone = TextEditingController();
  TextEditingController txt_email = TextEditingController();
  TextEditingController txt_password = TextEditingController();
  TextEditingController txt_building = TextEditingController();
  TextEditingController txt_project = TextEditingController();

  BuilderStaffTypesModal obj_builderstafftype = BuilderStaffTypesModal();
  BuildContext context = Get.context!;
  RxString tcLink = "".obs;
  RxString privatePolicy = "".obs;

  ImagePicker imagePicker = ImagePicker();

  // RxList<BuilderStaffTypesModal> arrstafftypeslist = RxList<BuilderStaffTypesModal>();
  RxList<BuilderStaffTypesModal> arrstafftypeslist = RxList([]);
  Rx<Future<List<BuilderStaffTypesModal>>> futurestafftypesData =
      Future.value(<BuilderStaffTypesModal>[]).obs;
  RxString isFaqsEmptyMsg = "".obs;


  DrawerProjectModal obj_building = DrawerProjectModal();
  RxList<DrawerProjectModal> arrbuildingsList = RxList<DrawerProjectModal>();
  Rx<Future<List<DrawerProjectModal>>> futurebuildingsList =
      Future.value(<DrawerProjectModal>[]).obs;

  RxList<DrawerProjectModal> arrSelectedbuildings = RxList([]);

  String ccode = "91";
  String isocode = "IN";

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
      return "Please Enter Name";
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
    getprojectlist();
  }

  getprojectlist() async {
    arrbuildingsList=RxList<DrawerProjectModal>([]);

    SharedPreferences sp = await SharedPreferences.getInstance();
    Map<String,dynamic> sessionData = jsonDecode(sp.getString(SESSION_ARRAY)!);
    for(int index=0;index<sessionData[SESSION_BUILDINGS].length;index++) {
      arrbuildingsList.add(DrawerProjectModal(
        id: sessionData[SESSION_BUILDINGS][index][SESSION_BUILDINGS_PROJECT][SESSION_BUILDINGS_PROJECT_NAME]
            .toString(),
        // name: sessionData[SESSION_BUILDINGS][index][SESSION_BUILDINGS_PROJECT][SESSION_BUILDINGS_PROJECT_NAME]
        //     .toString(),
        name: "${sessionData[SESSION_BUILDINGS][index][SESSION_BUILDINGS_PROJECT][SESSION_BUILDINGS_PROJECT_NAME]}(${sessionData[SESSION_BUILDINGS][index]
        [SESSION_BUILDINGS_PROJECT_NAME]})",
        call_number: sessionData[SESSION_BUILDINGS][index][SESSION_BUILDINGS_PROJECT][SESSION_BUILDINGS_PROJECT_NAME]
            .toString(),
        mobile_view: sessionData[SESSION_BUILDINGS][index][SESSION_BUILDINGS_PROJECT][SESSION_BUILDINGS_PROJECT_NAME]
            .toString(),
        status: sessionData[SESSION_BUILDINGS][index][SESSION_BUILDINGS_PROJECT][SESSION_BUILDINGS_PROJECT_NAME]
            .toString(),
        project_share: sessionData[SESSION_BUILDINGS][index][SESSION_BUILDINGS_PROJECT][SESSION_BUILDINGS_PROJECT_NAME]
            .toString(),
        website_url: sessionData[SESSION_BUILDINGS][index][SESSION_BUILDINGS_PROJECT][SESSION_BUILDINGS_PROJECT_NAME]
            .toString(),
        whatsapp_number: sessionData[SESSION_BUILDINGS][index][SESSION_BUILDINGS_PROJECT][SESSION_BUILDINGS_PROJECT_NAME]
            .toString(),
        whatsapp_share_text: sessionData[SESSION_BUILDINGS][index][SESSION_BUILDINGS_PROJECT][SESSION_BUILDINGS_PROJECT_NAME]
            .toString(),
        //website_url: ,: sessionData[SESSION_BUILDINGS][index][SESSION_BUILDINGS_PROJECT][SESSION_BUILDINGS_PROJECT_NAME].toString(),

      ));
    }
    arrProjectList.refresh();
    // futureProjectListDrawer.value=arrProjectDrawerItemList as Future<List<DrawerProjectModal>>;
    futurebuildingsList.refresh();
    print(arrProjectList.length);
    print("arrProjectList.length");

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

  OnTapSubmit() {
    if (formKey.currentState!.validate()) {
      LoginServices();
    }
  }

  SelectBuildingValue() {
    BuildingDialogBox((value) {
      obj_building=value;
      txt_building.text = value.name??"";
      //projectCode.value = value.projectcode!;
    });
  }

  SelectProjectValue() {
    print("open dialog");
    ProjectDialogBox((value) {
      print("inside dialog");
      obj_builderstafftype=value;
      txt_project.text = value.type??"";

      //projectCode.value = value.projectcode!;
    });
  }

  String? Building_Validation(String? value){
    if(value!.isEmpty){
      return "Please select a value";
    }
    else{
      return null;
    }
  }

  // Future<dynamic> BuildingDialogBox(ValueChanged<dynamic> onChange) {
  //   return SelectDialog.showModal(
  //     Get.context!,
  //     label: "Building From All Cities"  ,
  //     items: arrBuildingList,
  //     onChange: onChange,
  //     searchBoxDecoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: "Search"),
  //   );
  // }
  // Future<dynamic> BuildingDialogBox(ValueChanged<DrawerProjectModal> onChange) {
  //   return SelectDialog1.showModal<DrawerProjectModal>(
  //     Get.context!,
  //     label: "Building From All Cities"  ,
  //     items: arrbuildingsList,
  //     onChange: onChange,
  //     searchBoxDecoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: "Search"),
  //   );
  // }
  Future<dynamic> BuildingDialogBox(ValueChanged<DrawerProjectModal> onChange) {
    return SelectDialog1.showModal<DrawerProjectModal>(
        Get.context!,
        label: "Buildings From All Cities" ,
        items: arrbuildingsList,
        multipleSelectedValues: arrSelectedbuildings,
        onChange: onChange,
        itemBuilder: (context, item, isSelected) {
          return ListTile(
            dense: true,
            trailing: isSelected
                ? Icon(
              Icons.done,
              color: Colors.black,
            )
                : Container(
              width: 20.w,
            ),
            title: Text(item.name!),
            selected: isSelected,
          );
        }, okButtonBuilder: (context, onPressed) {
      return ChooseButton(onPressed);
    }, onMultipleItemsChange: (List<DrawerProjectModal> selected) {

      arrSelectedbuildings.value =
          selected.where((element) => element.id != "").toList();

      final ids = Set();
      arrSelectedbuildings.value.retainWhere((x) => ids.add(x.name));
      arrSelectedbuildings.refresh();
      txt_building.text =
          arrSelectedbuildings.map((element) => element.name).join(", ");

    }, searchBoxDecoration: const InputDecoration(hintText: 'Search Here')
      //searchBoxDecoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: "Search"),
    );
  }

  Future<dynamic> ProjectDialogBox(ValueChanged<BuilderStaffTypesModal> onChange) {
    return SelectDialog.showModal<BuilderStaffTypesModal>(
      Get.context!,
      label: "Project From All Cities",
      items: arrstafftypeslist.value,
      onChange: onChange,
      searchBoxDecoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: "Search"),
    );
  }

  Future<void> LoginServices() async {
    AppLoader(Get.context!);
    try {
      AppLoader(context);
      DeviceData device = DeviceData();
      Map<String, String> deviceData = await device.getDeviceData();
      Map<String, String> data = {
        'builder_id': BUILDER_ID,
        'mobile_no': txt_name.text.trim().toString(),
        'password': txt_password.text.trim().toString(),
      };
      data.addAll(deviceData);

      ApiResponse response = ApiResponse(requestType: RequestType.post,
          data: data, base_url: URL_ADD_STAFF, apiHeaderType: ApiHeaderType.Login);
      Map<String, dynamic>? responseData = await response.getResponse();
      print(responseData);
      if (responseData!['status']) {}
      else {
        showSnackBar(status: Status.Error, message: responseData['message']);
        RemoveAppLoader(context);
      }
    } catch (ex) {
      print(ex);
    }
  }

  Future<List<BuilderStaffTypesModal>> RetrieveBuilderStaffTypesData() async {
    arrstafftypeslist = RxList<BuilderStaffTypesModal>([]);
    Map<String, dynamic> data = {};

    print('data234');
    print(URL_BUILDERSTAFFTYPEDIALOG);

    ApiResponse response = ApiResponse(
        requestType: RequestType.get,
        data: data,
        // base_url: URL_BUILDER_STAFF + "?checkin_date=2023-01-02&staff_category=1",
        // base_url: URL_BUILDER_STAFF + "?checkin_date=2023-01-02",
        // base_url: URL_BUILDER_STAFF + "?checkin_date="+todaysdate,
        base_url: URL_BUILDERSTAFFTYPEDIALOG,
        apiHeaderType: ApiHeaderType.NONE);
    Map<String, dynamic>? responseData = await response.getResponse();
    print(responseData);
    if (responseData!['status']==true) {
      List result = responseData['data'];
      arrstafftypeslist.value = List.from(result.map((e) => BuilderStaffTypesModal.fromJson(e)));
      print("Staff List");
      // print( URL_BUILDER_STAFF + "?staff_category=1");
      print(arrstafftypeslist);
      arrstafftypeslist.refresh();
    } else {
      isFaqsEmptyMsg.value = responseData['msg'];
      print(responseData['msg']);
    }
    obj_builderstafftype = arrstafftypeslist[0];
    txt_project.text = obj_builderstafftype.type!;
    return arrstafftypeslist;
  }

  OnProfilePictureSelect(){
    showCupertinoModalPopup(context: Get.context!, builder: (context){
      return CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
          child: const Text("Close"),
          onPressed: (){
            Get.back();
          },
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: (){
              Get.back();
              // CheckCameraPermission();
              CameraSelect();

            },
            child: Text("Camera",style: TextStyles.textStyleDark15(),),
          ),
          CupertinoActionSheetAction(
            onPressed: (){
              Get.back();
              ChooseImage();
              // CheckStoargePermission();
            },
            child: Text("Choose Photo",style: TextStyles.textStyleDark15() ,),
          ),
        ],
      );
    });
  }

  void CameraSelect()async{
    AppLoader(context);
    Directory directory = await getApplicationDocumentsDirectory();
    try{
      var response = await imagePicker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 60,
      );
      if(response != null){
        File file = File(response.path);

        double sizeInMb = file.lengthSync() / (1024 * 1024);

        if(sizeInMb > 1){
          RemoveAppLoader(context);
          showSnackBar(status: Status.Error,message: "Image size is not more then 800 kb",title: "Error!");
        }else{
          _cropImage(file);
          // UploadImage(file);
        }

      }
      else{
        RemoveAppLoader(context);
        print("No image selected");
      }
    }
    catch(e){
      print("Error :--- \n $e");
    }

  }

  void ChooseImage() async{
    AppLoader(context);
    Directory directory = await getApplicationDocumentsDirectory();
    try{
      var response = await imagePicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50
      );
      if(response!=null){
        File file = File(response.path);
        double sizeInMb = file.lengthSync() / (1024 * 1024);

        if(sizeInMb > 1){
          RemoveAppLoader(context);
          showSnackBar(status: Status.Error,message: "Image size is not more then 800 kb",title: "Error!");
        }else{
          _cropImage(file);
        }
      }
      else{
        RemoveAppLoader(context);
        print("No Image Selected");
      }
    }
    catch(e){
      print("Error :--- \n $e");
    }
  }

  Future _cropImage(File file)async{

    CroppedFile? cropfile = await ImageCropper.platform.cropImage(sourcePath: file.path);

    if(cropfile != null){
      RemoveAppLoader(context);

      //UploadImage(cropfile.path);

    }else{
      RemoveAppLoader(context);
    }
  }
}