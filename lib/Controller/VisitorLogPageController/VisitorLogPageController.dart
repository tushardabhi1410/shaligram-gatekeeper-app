import 'dart:convert';

import 'package:avinashgatekeeper/Config/Helper/ApiResponse.dart';
import 'package:avinashgatekeeper/Config/Helper/DeviceData.dart';
import 'package:avinashgatekeeper/Config/Helper/SessionData.dart';
import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/View/HomePage/HomePage.dart';
import 'package:avinashgatekeeper/View/Tabbar.dart';
import 'package:avinashgatekeeper/Widget/AppLoader.dart';
import 'package:avinashgatekeeper/Widget/Snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:select_dialog/select_dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../Modal/DrawerProjectModal/DrawerProjectModal.dart';
import '../../Modal/VisitorLogModel/VisitorLogModel.dart';
import '../../Widget/CommonBottomSheet.dart';
import '../../Widget/select_dailog.dart';

class VisitorLogPageController extends GetxController {

  TextEditingController txt_project = TextEditingController();
  TextEditingController txt_start_date = TextEditingController();
  TextEditingController txt_end_date = TextEditingController();

  BuildContext context = Get.context!;
  RxString tcLink = "".obs;
  RxString privatePolicy = "".obs;
  RxString StartDate = "".obs;
  RxString EndDate = "".obs;
  RxBool isdata=false.obs;
  Rxn<VistorModel> obj_model= Rxn<VistorModel>();

  DrawerProjectModal obj_project = DrawerProjectModal();
  Rx<Future<List<DrawerProjectModal>>> futureProjectList =
      Future.value(<DrawerProjectModal>[]).obs;

  RxList<DrawerProjectModal> arrSelectedProjects = RxList([]);

  //future list declaration
  Rx<Future<List<DrawerProjectModal>>> futurearrProjectList=Future.value(<DrawerProjectModal>[]).obs;
  //rx list declaration
  RxList<DrawerProjectModal> arrProjectList = RxList<DrawerProjectModal>();

  final dateFormat = DateFormat('yyyy-MM-dd');


  int? mincntLng;
  int? maxcntLng;

  String helpImgUrl = "";

  FocusNode focusNode = FocusNode();

  RxString employeename = "".obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime currentData = DateTime.now();
  DateTime endData = DateTime.now();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
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

  OpenDatePickerDialog() async {
    DateTime? _datePicker = await showDatePicker(
        context: Get.context!,
        initialDate: currentData,
        firstDate: DateTime(2014),
        lastDate: DateTime.now(),);

    if(_datePicker!=null){
      currentData = _datePicker;
      var dateFormat = DateFormat("dd/MM/yyyy") ;
      StartDate.value = DateFormat("dd MMM yyyy").format(_datePicker);

      print(_datePicker);
      txt_start_date.text = dateFormat.format(_datePicker);
    }
  }


  OpenEndDatePickerDialog() async {
    DateTime? _datePicker = await showDatePicker(
        context: Get.context!,
        initialDate: endData,
        firstDate: DateTime(2014),
        lastDate: DateTime.now());

    if(_datePicker!=null){
      currentData = _datePicker;
      var dateFormat = DateFormat("dd/MM/yyyy");
      EndDate.value = DateFormat("dd MMM yyyy").format(_datePicker);

      print(_datePicker);
      txt_end_date.text = dateFormat.format(_datePicker);
    }
  }


  OnTapSubmit() {
    if (formKey.currentState!.validate()) {
      obj_model.value=VistorModel(EndDate:EndDate.value ,projectmodel:obj_project ,StartDate:StartDate.value);
      if(obj_model.value!=null){
        Get.back(result:obj_model.value);
      }
      else{
        ValidationMsg("Somthing Went Wrong");
      }

      // Get.back();
    }
  }

  SelectProjectValue() {
    ProjectDiaLougeOptions((value) {
      obj_project=value;
      txt_project.text = value.name??"";
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

  String? Validation(String? value){
    if(value!.isEmpty){
      return "Please enter a value";
    }
    else{
      return null;
    }
  }

  Future<dynamic> ProjectDiaLougeOptions(ValueChanged<DrawerProjectModal> onChange) {
    return SelectDialog1.showModal<DrawerProjectModal>(
        Get.context!,
        label: "Project From All Cities" ,
        items: arrProjectList,
        selectedValue: obj_project,
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
        },
        okButtonBuilder: (context, onPressed) {
      return ChooseButton(onPressed);
    },
      searchBoxDecoration: const InputDecoration(hintText: 'Search Here')
    );
  }



  Future<List<DrawerProjectModal>> GetProjectList() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    arrProjectList.value=[];

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
        arrProjectList.value =
            List.from(result.map((e) => DrawerProjectModal.fromJson(e)));
        arrProjectList.refresh();
      }
      else {
        print("somthing went wrong in drawercontroller");
      }
    }catch(e){
      print(e);
    }



    return arrProjectList;
  }


  Future<void> LoginServices() async {
    AppLoader(Get.context!);
    try {
      AppLoader(context);
      DeviceData device = DeviceData();
      Map<String, String> deviceData = await device.getDeviceData();
      Map<String, String> data = {
        'builder_id': BUILDER_ID,
        'mobile_no': '',
        'password': '',
      };
      data.addAll(deviceData);
      print(data);
      ApiResponse response = ApiResponse(requestType: RequestType.post,
          data: data, base_url: URL_LOGIN, apiHeaderType: ApiHeaderType.Login);
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



  String dateFormate(d){
    var inputFormat = DateFormat('dd/MM/yyyy');
    var inputDate = inputFormat.parse(d);
    var outputFormat = DateFormat('yyyy-MM-dd');
    return outputFormat.format(inputDate);
  }
}
