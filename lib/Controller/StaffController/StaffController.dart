import 'package:avinashgatekeeper/Config/Helper/ApiResponse.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/Modal/Staff/StaffModel.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StaffPageController extends GetxController {
  BuildContext? context;
  RxList<StaffModal> arrstafflist = RxList<StaffModal>();
  RxList<StaffModal> arrstaffinlist = RxList<StaffModal>();

  RxList<StaffModal> searcharrvisitorlist = RxList<StaffModal>();
  List<StaffModal> checkinglist=[];
  List<StaffModal> checkinglistIn=[];
  RxBool noDataFound=false.obs;
  RxInt selected=0.obs;

  RxString isFaqsEmptyMsg = "".obs;
  Rx<Future<List<StaffModal>>> futurestaffData =
      Future.value(<StaffModal>[]).obs;
  Rx<Future<List<StaffModal>>> futurestaffinData =
      Future.value(<StaffModal>[]).obs;

  Rxn<TextEditingController> editingController = Rxn(TextEditingController());
  FocusNode fcn_node=FocusNode();
  String todaysdate=DateFormat("yyyy-MM-dd").format(DateTime.now());

  LoadPage() {
    futurestaffData.value = RetrieveStaffData();
    futurestaffinData.value = RetrieveStaffInData();
    arrstafflist.refresh();
    arrstaffinlist.refresh();
    print(URL_BUILDERIN_STAFF + "?checkin_date="+todaysdate+"&staff_category=2");
  }

  Future<List<StaffModal>> RetrieveStaffData() async {
    arrstafflist = RxList<StaffModal>([]);
    Map<String, dynamic> data = {};

    print('data');

    ApiResponse response = ApiResponse(
        requestType: RequestType.get,
        data: data,
        base_url: URL_STAFF + "?project_id=1&staff_category=2",
        apiHeaderType: ApiHeaderType.Content);
    Map<String, dynamic>? responseData = await response.getResponse();
    print(responseData);
    if (responseData!['status']) {
      List result = responseData['data'];
      arrstafflist.value = List.from(result.map((e) => StaffModal.fromJson(e)));
      print("Staff List");
      print(arrstafflist);
      checkinglist=[];
      checkinglist=arrstafflist.value;
      arrstafflist.refresh();
    } else {
      isFaqsEmptyMsg.value = responseData['msg'];
      print(responseData['msg']);
    }
    return arrstafflist;
  }

  Future<List<StaffModal>> RetrieveStaffInData() async {
    arrstaffinlist = RxList<StaffModal>([]);
    Map<String, dynamic> data = {};

    print('data');

    ApiResponse response = ApiResponse(
        requestType: RequestType.get,
        data: data,
        base_url: URL_BUILDERIN_STAFF + "?checkin_date="+todaysdate+"&staff_category=2",
        apiHeaderType: ApiHeaderType.Content);
    Map<String, dynamic>? responseData = await response.getResponse();
    print(responseData);
    if (responseData!['status']) {
      List result = responseData['data'];
      arrstaffinlist.value = List.from(result.map((e) => StaffModal.fromJson(e)));
      print("Staff List");
      print(arrstaffinlist);
      arrstaffinlist.refresh();
      checkinglistIn=[];
      checkinglistIn=arrstaffinlist.value;
    } else {
      isFaqsEmptyMsg.value = responseData['msg'];
      print(responseData['msg']);
    }
    return arrstaffinlist;
  }

  Future<void> refreshData() async {
    fcn_node.unfocus();
    editingController.value!.text="";
    arrstafflist.clear();
    arrstaffinlist.clear();
    futurestaffData.value = RetrieveStaffData();
    futurestaffinData.value = RetrieveStaffInData();
    arrstafflist.refresh();
    arrstaffinlist.refresh();
  }


  onSearchTextChanged(String text) async {
    searcharrvisitorlist.clear();
    noDataFound.value=false;
    if (text.isEmpty) {

      if(selected.value==0){arrstafflist.value=checkinglist;}
      if(selected.value==1){arrstaffinlist.value=checkinglistIn;}
      return ;
    }
   if(selected.value==0){
     arrstafflist.value=checkinglist;
     arrstafflist.value.forEach((element) {
       if (element.name!.toLowerCase().contains(text.toLowerCase()))
       {
         searcharrvisitorlist.value.add(element);
       }
     });
     if(searcharrvisitorlist.isEmpty){
       print("NO DATA FOUND");
       noDataFound.value=true;
     }
     arrstafflist.value=searcharrvisitorlist.value;
     arrstafflist.refresh();
     print(searcharrvisitorlist.value.length);
   }

   if(selected.value==1){

     arrstaffinlist.value=checkinglistIn;
     arrstaffinlist.value.forEach((element) {
       if (element.name!.toLowerCase().contains(text.toLowerCase()))
       {
         searcharrvisitorlist.value.add(element);
       }
     });
     if(searcharrvisitorlist.isEmpty){
       print("NO DATA FOUND");
       noDataFound.value=true;
     }
     arrstaffinlist.value=searcharrvisitorlist.value;
     arrstaffinlist.refresh();
     print(searcharrvisitorlist.value.length);

   }
   if(selected.value==2){

   }


  }

}
