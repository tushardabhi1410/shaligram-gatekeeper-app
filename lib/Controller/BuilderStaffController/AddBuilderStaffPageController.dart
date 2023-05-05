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
import 'package:dio/dio.dart' as dio;
import '../../Modal/DrawerProjectModal/DrawerProjectModal.dart';
import '../../Widget/CommonBottomSheet.dart';
import '../../Widget/select_dailog.dart';

class AddBuilderStaffPageController extends GetxController {

  // TextEditingController txt_name = TextEditingController();
  Rxn<TextEditingController> txt_name = Rxn(TextEditingController());
  Rxn<TextEditingController> txt_phone = Rxn(TextEditingController());
  Rxn<TextEditingController> txt_email = Rxn(TextEditingController());
  TextEditingController txt_password = TextEditingController();
  TextEditingController txt_building = TextEditingController();
  TextEditingController txt_project = TextEditingController();

  DrawerProjectModal obj_builderstafftype = DrawerProjectModal();
  BuildContext context = Get.context!;
  RxString tcLink = "".obs;
  RxString privatePolicy = "".obs;
  RxBool isSwitched = false.obs;
  RxString  Image_Photo="".obs;

  ImagePicker imagePicker = ImagePicker();

  // RxList<BuilderStaffTypesModal> arrstafftypeslist = RxList<BuilderStaffTypesModal>();
  RxList<BuilderStaffTypesModal> arrstafftypeslist = RxList([]);
  RxList<DrawerProjectModal> arrstafftypeslistNew = RxList([]);
  Rx<Future<List<BuilderStaffTypesModal>>> futurestafftypesData = Future.value(<BuilderStaffTypesModal>[]).obs;
  Rx<Future<List<DrawerProjectModal>>> futurestafftypesDataNew = Future.value(<DrawerProjectModal>[]).obs;
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
    futurebuildingsList.value= GetProjectList() ;
    futurestafftypesDataNew.value= GetDesignation() ;
  }

  Future<List<DrawerProjectModal>> GetProjectList() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    arrbuildingsList.value=[];



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
        arrbuildingsList.value =
            List.from(result.map((e) => DrawerProjectModal.fromJson(e)));
        arrbuildingsList.refresh();
      }
      else {
        print("somthing went wrong in drawercontroller");
      }
    }catch(e){
      print(e);
    }



    return arrbuildingsList;
  }

  Future<List<DrawerProjectModal>> GetDesignation() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    arrstafftypeslistNew.value=[];
    try {
      var data = {
        'action': "fillbuilderstaff"
      };

      ApiResponse response = ApiResponse(
        data: data,
        base_url: URL_PROJECT_ASSIGNED,
        apiHeaderType: ApiHeaderType.Content,
        requestType: RequestType.post,
      );

      Map<String, dynamic>? responseData = await response.getResponse();

      print(responseData.toString()+" this is my responceeeeee");

      if (responseData!['status'].toString() == "1") {
        List result = responseData['result'];
        arrstafftypeslistNew.value =
            List.from(result.map((e) => DrawerProjectModal.fromJson(e)));
        arrstafftypeslistNew.refresh();
      }
      else {

      }
    }catch(e){
      print(e);
    }
    return arrstafftypeslistNew;
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
    } else if (value.length < 10 || value.length > 10) {
      return "     Please Enter your valid phone number";
    } else {
      return null;
    }
  }


  Add_BuilderStaff() async {
    AppLoader(context);
    try{

      List<DrawerProjectModal> testlist=arrSelectedbuildings.value;
      var unitjson = jsonEncode(testlist.map((e) => e.toJson()).toList());
      Map<String, dynamic> data = {};

      data['formevent'] = "addright";
      data['action'] = "insertbuilderstatff";
      data['personname'] = txt_name.value?.text.trim();
      data['mobile'] = txt_phone.value?.text.trim();
      data['iswhatsApp'] = isSwitched.isTrue?1:0;
      data['countrycode'] = ccode;
      data['email'] = txt_email.value?.text.trim();
      data['project'] = unitjson;
      data['countrycodestr'] = "in";
      data['designation'] = jsonEncode([obj_builderstafftype.toJson()]);

      if(Image_Photo.value.isNotEmpty){
        data['profile'] = await dio.MultipartFile.fromFile(Image_Photo.value);}
      print("IMAGE MOVE ==================>"+Image_Photo.toString());
      print(data.toString()+" this is my data");

      ApiResponse response = ApiResponse(
          data: data,
          requestType: RequestType.post,
          base_url: URL_ADD_BUILDER_STAFF,
          apiHeaderType: ApiHeaderType.Content);

      Map<String, dynamic>? responseData = await response.getResponse();
      if (responseData!['status'].toString() == "1") {
        SuccessMsg(responseData['message']);
        RemoveAppLoader(context);
        Get.back();
      } else {
        RemoveAppLoader(context);
        ValidationMsg(responseData['message'] ?? "Somthing Went Wrong");
        print(responseData['data']);
      }


    }catch(e){
      ValidationMsg("Somthing Went Wrong");
      print(e.toString());

      RemoveAppLoader(context);
    }

  }



  OnTapSubmit() {
    if (formKey.currentState!.validate()) {
      Add_BuilderStaff();
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
      txt_project.text = value.name??"";

      //projectCode.value = value.projectcode!;
    });
  }

  String? Building_Validation(String? value){
    print("im in validator 123");
    if(value!.isEmpty){
      return "Please select a building ";
    }
    else{
      return null;
    }
  }
  String? Designation_Validation(String? value){
    print("im in validator");
    if(value!.trim().isEmpty){
      return "Please select a Designation ";
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

  Future<dynamic> ProjectDialogBox(ValueChanged<DrawerProjectModal> onChange) {
    print("designation"+arrstafftypeslistNew.length.toString());
    return SelectDialog.showModal<DrawerProjectModal>(
      Get.context!,
      label: "Designation",
      items: arrstafftypeslistNew.value,
      onChange: onChange,
      searchBoxDecoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: "Search"),
    );
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
      Image_Photo.value=cropfile.path;
      Image_Photo.refresh();
      print("IMAGESELECTED+++++++++++++++++++>"+Image_Photo.toString());
      RemoveAppLoader(context);

      //UploadImage(cropfile.path);

    }else{
      RemoveAppLoader(context);
    }
  }
}
