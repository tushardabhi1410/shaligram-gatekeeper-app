import 'package:avinashgatekeeper/Config/Helper/ApiResponse.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/Modal/BuilderStaff/BuilderStaffModel.dart';
import 'package:avinashgatekeeper/Widget/AppLoader.dart';
import 'package:avinashgatekeeper/Widget/CommonBottomSheet.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Modal/BuilderStaff/BuilderStaffCheckInOutData.dart';
import '../../Modal/Visitor/VisitorModel.dart';
import '../../Modal/VisitorLogModel/VisitorLogModel.dart';

class BuilderStaffPageController extends GetxController with SingleGetTickerProviderMixin {


  //new Rx list Declaration
  RxList<BuilderStaffModalNew> arrBuilderStaffList = RxList<BuilderStaffModalNew>();
  RxList<BuilderStaffCheckInOutData> arrBuilderStaffCheckInList = RxList<BuilderStaffCheckInOutData>();
  RxList<BuilderStaffCheckInOutData> arrBuilderStaffCheckOutList = RxList<BuilderStaffCheckInOutData>();

  // rx variable declaration
  RxInt _loadMore = 0.obs;
  RxInt _pageCount = 1.obs;

  //rx future value declaration
  Rx<Future<List<BuilderStaffModalNew>>> futurestaffDataNew = Future.value(<BuilderStaffModalNew>[]).obs;
  Rx<Future<List<BuilderStaffCheckInOutData>>> futurestaffCheckInDataNew = Future.value(<BuilderStaffCheckInOutData>[]).obs;
  Rx<Future<List<BuilderStaffCheckInOutData>>> futurestaffCheckOutDataNew = Future.value(<BuilderStaffCheckInOutData>[]).obs;
  
  
  Rx<Future<List<BuilderStaffModalNew>>> futureBuilderDataNew = Future.value(<BuilderStaffModalNew>[]).obs;
  
  
  RxList<BuilderStaffModal> arrstafflist = RxList<BuilderStaffModal>();
  RxList<BuilderStaffModal> arrbuilderstaffinlist = RxList<BuilderStaffModal>();
  RxString isFaqsEmptyMsg = "".obs;
  Rx<Future<List<BuilderStaffModal>>> futurestaffData =
      Future.value(<BuilderStaffModal>[]).obs;
  Rx<Future<List<BuilderStaffModal>>> futurestaffinData =
      Future.value(<BuilderStaffModal>[]).obs;

  List<BuilderStaffModal> checkinglistIn=[];
  
  String todaysdate=DateFormat("yyyy-MM-dd").format(DateTime.now());
  RxBool noDataFound=false.obs;
  RxBool IsScroll = false.obs;
  RxInt selected=0.obs;
  Rxn<TextEditingController> editingController = Rxn(TextEditingController());
  FocusNode fcn_node=FocusNode();
  VistorModel? obj_builder;

  filtrationupdatae()async{
    _pageCount.value=1;
    _loadMore.value=0;
    editingController.value!.text="";
    RetrieveBuilderStaffDataNew();

  }

  LoadPage() {
    futurestaffDataNew.value = RetrieveBuilderStaffDataNew();
    arrstafflist.refresh();
    arrbuilderstaffinlist.refresh();
  }

  clearvalue(){
    _loadMore.value=0;
    _pageCount.value=1;
    editingController.value?.clear();
  }

  Future<List<BuilderStaffModalNew>> RetrieveBuilderStaffDataNew({String filter=''}) async {
    try{
      Map<String, dynamic> data = {
        "action":"listbuilderstatff",
        "perpage":"10",
        "nextpage":_pageCount.value,
        "ordbycolumnname":"id",
        if(filter!=null && filter!="")"filter":filter,
        "ordby":"-1"
      };
      print("DATA++++++++++++?"+data.toString());

      ApiResponse response = ApiResponse(
          requestType: RequestType.post,
          data: data,
          base_url: URL_BUILDER_STAFF,
          apiHeaderType: ApiHeaderType.Content);

      Map<String, dynamic>? responseData = await response.getResponse();

      print("RES===============>"+responseData.toString());
      if (_pageCount.value == 1) {
        arrBuilderStaffList.clear();
      }

      if (responseData!['status'].toString()=="1") {

        _loadMore.value = responseData['loadmore'];

        List result = responseData['data'];

        List<BuilderStaffModalNew> arrTempList = [];
        arrTempList = List<BuilderStaffModalNew>.from(result.map((e) => BuilderStaffModalNew.fromJson(e)));
        arrBuilderStaffList.addAll(arrTempList);
        // arrBuilderStaffList.value = List.from(result.map((e) => BuilderStaffModalNew.fromJson(e)));

        arrBuilderStaffList.refresh();
        if(arrbuilderstaffinlist.length>0)
          {
            IsScroll.value = true;
          }
        else{
          IsScroll.value = false;
        }

      } else {
        isFaqsEmptyMsg.value = responseData['message'];
        futurestaffDataNew.refresh();
      }
    }
    catch(e){
      print(e);
    }
    futurestaffDataNew.refresh();
    return arrBuilderStaffList;
  }

  Future<List<BuilderStaffCheckInOutData>> RetrieveBuilderStaffCheckInDataNew({String filter=''}) async {
    try{
      Map<String, dynamic> data = {
        "action":"listbuilderstatff_checkin",
        "perpage":"10",
        "nextpage":_pageCount.value,
        "ordbycolumnname":"id",
        "ordby":"1",
        "type":"in",
        if(filter!=null && filter!="")"filter":filter,
      };
      // print(data.toString()+" ythiiiii");

      ApiResponse response = ApiResponse(
          requestType: RequestType.post,
          data: data,
          base_url: URL_BUILDER_STAFF,
          apiHeaderType: ApiHeaderType.Content);

      Map<String, dynamic>? responseData = await response.getResponse();
      if (_pageCount.value == 1) {
        arrBuilderStaffCheckInList.clear();
      }

      if (responseData!['status'].toString()=="1") {
        _loadMore.value = responseData['loadmore'] ?? 0;
        List result = responseData['data'];
        List<BuilderStaffCheckInOutData> arrTempList = [];
        arrTempList = List<BuilderStaffCheckInOutData>.from(result.map((e) => BuilderStaffCheckInOutData.fromJson(e)));
        arrBuilderStaffCheckInList.addAll(arrTempList);
        // arrBuilderStaffList.value = List.from(result.map((e) => BuilderStaffModalNew.fromJson(e)));

        arrBuilderStaffCheckInList.refresh();

        if(arrBuilderStaffCheckInList.length>0)
        {
          IsScroll.value = true;
        }
        else{
          IsScroll.value = false;
        }
      } else {
        isFaqsEmptyMsg.value = responseData['message'];
        futurestaffDataNew.refresh();
        print("responseData['msg']");
        print(arrBuilderStaffCheckInList.length);
      }
    }
    catch(e){
      // ValidationMsg("somthing went wrong");
      print(e);
    }
    futurestaffCheckInDataNew.refresh();
    return arrBuilderStaffCheckInList;
  }

  Future<List<BuilderStaffCheckInOutData>> RetrieveBuilderStaffCheckOutDataNew({String filter=''}) async {
    try{
      Map<String, dynamic> data = {
        "action":"listbuilderstatff_checkin",
        "perpage":"10",
        "nextpage":_pageCount.value,
        "ordbycolumnname":"id",
        "ordby":"1",
        "type":"out",
        if(filter!=null && filter!="")"filter":filter,
      };

      ApiResponse response = ApiResponse(
          requestType: RequestType.post,
          data: data,
          base_url: URL_BUILDER_STAFF,
          apiHeaderType: ApiHeaderType.Content);

      Map<String, dynamic>? responseData = await response.getResponse();
      if (_pageCount.value == 1) {
        arrBuilderStaffCheckOutList.clear();
      }

      if (responseData!['status'].toString()=="1") {
        _loadMore.value = responseData['loadmore'] ?? 0;
        List result = responseData['data'];
        List<BuilderStaffCheckInOutData> arrTempList = [];
        arrTempList = List<BuilderStaffCheckInOutData>.from(result.map((e) => BuilderStaffCheckInOutData.fromJson(e)));
        arrBuilderStaffCheckOutList.addAll(arrTempList);
        // arrBuilderStaffList.value = List.from(result.map((e) => BuilderStaffModalNew.fromJson(e)));

        arrBuilderStaffCheckOutList.refresh();

        if(arrBuilderStaffCheckOutList.length>0)
        {
          IsScroll.value = true;
        }
        else{
          IsScroll.value = false;
        }
      } else {
        isFaqsEmptyMsg.value = responseData['message'];
        futurestaffDataNew.refresh();
        print("responseData['msg']");
        print(arrBuilderStaffCheckOutList.length);
      }
    }
    catch(e){
      // ValidationMsg("somthing went wrong");
      print(e);
    }
    futurestaffCheckOutDataNew.refresh();
    return arrBuilderStaffCheckOutList;
  }

  BUILDER_CHECKIN_CHECKOUT({String visitorid='',String type="in"}) async {
    try{
      AppLoader(contextCommon);
      Map<String, dynamic> data = {
        "action":"checkbuilderstatff",
        "builderstatffid":visitorid ?? "",
        "type": type,
        "time": DateFormat('hh:mm a').format(DateTime.now()).toString()
      };

      ApiResponse response = ApiResponse(
          requestType: RequestType.post,
          data: data,
          base_url: URL_CHECKIN_VISITOR,
          apiHeaderType: ApiHeaderType.Content);

      Map<String, dynamic>? responseData = await response.getResponse();

      if (responseData!['status'].toString()=="1") {
        if(type=="out"){
          SuccessMsg("Successfully Check-Out");
          _pageCount.value=1;
          RetrieveBuilderStaffCheckInDataNew();
        }
        if(type=="in"){
          SuccessMsg("Successfully Check-in");
        }

        RetrieveBuilderStaffDataNew();
        RemoveAppLoader(contextCommon);
      } else {
        isFaqsEmptyMsg.value = responseData['message'];
        print(responseData['message']);
        ValidationMsg(responseData['message'] ?? "Success Fully CheckedIn");
        RemoveAppLoader(contextCommon);
      }

    }
    catch(e){
      RemoveAppLoader(contextCommon);
      ValidationMsg("Somthing Went Wrong");
    }

  }

  int dateandtimechanger(String date){
    final DateTime myDate = DateTime.parse(date);
    Duration dur =  DateTime.now().difference(myDate);
    final int second = dur.inSeconds;
    return second*1000;
  }


  Future<void> refreshData()async{
    arrstafflist.clear();
    fcn_node.unfocus();
    editingController.value!.text="";
    _pageCount.value=1;
    futurestaffDataNew.value = RetrieveBuilderStaffDataNew();
    arrstafflist.refresh();
  }

  scrollUpdate(ScrollController scrollController) {
    var maxScroll = scrollController.position.maxScrollExtent;
    var currentPosition = scrollController.position.pixels;
    print(currentPosition);
    if (maxScroll == currentPosition) {
      if (_loadMore.value == 1) {
        print(_pageCount);
        _pageCount.value++;
        RetrieveBuilderStaffDataNew();
      }
    }
  }


  onSearchTextChanged(String text) async {
    noDataFound.value=false;
    _pageCount.value=1;


    if (text.isEmpty) {
      if(selected.value==0){
        RetrieveBuilderStaffDataNew();
      }
      else if(selected.value==1){
        RetrieveBuilderStaffCheckInDataNew();
      }
      else{
        RetrieveBuilderStaffCheckOutDataNew();
      }

      return;
    }
   else{
     if(selected.value==0){
       RetrieveBuilderStaffDataNew(filter: text);
     }
     else if(selected.value==1){
       RetrieveBuilderStaffCheckInDataNew(filter: text);
     }
     else{
       RetrieveBuilderStaffCheckOutDataNew(filter: text);
     }

    }


  }

}
