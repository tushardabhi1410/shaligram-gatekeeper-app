import 'package:avinashgatekeeper/Config/Helper/ApiResponse.dart';
import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/Modal/Visitor/VisitorModel.dart';
import 'package:avinashgatekeeper/Widget/AppLoader.dart';
import 'package:avinashgatekeeper/Widget/CommonBottomSheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Config/Utils/Style.dart';
import '../../Config/Utils/color.dart';
import '../../Config/Utils/images.dart';
import '../../Modal/VisitorLogModel/VisitorLogModel.dart';
import '../../Widget/CustomButton.dart';

class HomePageController extends GetxController
    with SingleGetTickerProviderMixin {

  //RxList Declaration
  RxList<VisitorModelNew> arrvisitorlistNew = RxList<VisitorModelNew>();
  RxList<VisitorModelNew> arrvisitorcheckinlistNew = RxList<VisitorModelNew>();
  RxList<VisitorModelNew> arrvisitorcheckoutlistNew = RxList<VisitorModelNew>();
  RxList<String> timechangelist = RxList<String>([]);


  RxString isFaqsEmptyMsg = "".obs;
  RxBool noDataFound=false.obs;
  RxBool IsScroll = false.obs;
  Rx<Future<List<VisitorModal>>> futurevisitorData = Future.value(<VisitorModal>[]).obs;
  Rx<Future<List<VisitorModelNew>>> futurevisitorDataNew = Future.value(<VisitorModelNew>[]).obs;
  Rx<Future<List<VisitorModelNew>>> futurevisitorcheckinDataNew = Future.value(<VisitorModelNew>[]).obs;
  Rx<Future<List<VisitorModelNew>>> futurevisitorcheckoutDataNew = Future.value(<VisitorModelNew>[]).obs;
  Rxn<TextEditingController> editingController = Rxn(TextEditingController());
  String formattedDate = DateFormat('kk:mm a').format(DateTime.now());
  FocusNode fcn_node=FocusNode();
  VistorModel? obj_visitor;


  //stopwatch declaration
  final _isHours = true;
  final StopWatchTimer stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    onStopped: () {
      print('onStop');
    },
    onEnded: () {
      print('onEnded');
    },
  );

  // rx variable declaration
  RxInt _loadMore = 0.obs;
  RxInt _pageCount = 1.obs;
  RxInt selected=0.obs;

  @override
  void onInit() {
    super.onInit();

  }

  LoadPage() {
    futurevisitorDataNew.value = RetrieveVisitorsData();
    arrvisitorlistNew.refresh();
  }

  clearvalue(){
    _loadMore.value=0;
    _pageCount.value=1;
    editingController.value?.clear();
  }

  scrollUpdate(ScrollController scrollController) {
    var maxScroll = scrollController.position.maxScrollExtent;
    var currentPosition = scrollController.position.pixels;
    print(currentPosition);
    if (maxScroll == currentPosition) {
      if (_loadMore.value == 1) {
        print(_pageCount);
        _pageCount.value++;
       RetrieveVisitorsData();
      }
    }
  }

  filtrationupdatae()async{
    _pageCount.value=1;
    _loadMore.value=0;
    editingController.value!.text="";
    RetrieveVisitorsData();

  }

 int dateandtimechanger(String date){
    final DateTime myDate = DateTime.parse(date);
    Duration dur =  DateTime.now().difference(myDate);
    final int second = dur.inSeconds;
    return second*1000;
  }



  //<editor-fold desc = "Api Calls">
  Future<List<VisitorModelNew>> RetrieveVisitorsData( {String filter=''}) async {
    Map<String, dynamic> data = {
      "action":"listvisitors",
      "perpage":"10",
      "nextpage":_pageCount.value,
      "ordbycolumnname":"id",
      "ordby":"-1",
      if(filter!=null && filter!="")"filter":filter,
    };

    //filtration
    if(obj_visitor!=null && obj_visitor!=""){
      VistorModel obj=obj_visitor!;
    if(obj.StartDate!.isNotEmpty && obj.StartDate!=null)  data['startdate']= obj.StartDate.toString() ?? "";
      if(obj.EndDate!.isNotEmpty && obj.EndDate!=null) data['enddate']=obj.EndDate.toString() ?? "";
      if(obj.projectmodel!=null) data['fltprojectid']=obj.projectmodel!.id.toString() ?? "";
    }


    print(data.toString()+" this is my send data");

    ApiResponse response = ApiResponse(
        requestType: RequestType.post,
        data: data,
        base_url: URL_VISITOR,
        apiHeaderType: ApiHeaderType.Content);

      Map<String, dynamic>? responseData = await response.getResponse();

        if (_pageCount.value == 1) {
          arrvisitorlistNew.clear();
        }

    if (responseData!['status'].toString()=="1") {
      List result = responseData['data'];

      _loadMore.value = responseData['loadmore'];

      List<VisitorModelNew> arrTempList = [];
      arrTempList = List<VisitorModelNew>.from(result.map((e) => VisitorModelNew.fromJson(e)));
      arrvisitorlistNew.addAll(arrTempList);
      // arrvisitorlistNew.value = List.from(result.map((e) => VisitorModelNew.fromJson(e)));
      arrvisitorlistNew.refresh();
      if(arrvisitorlistNew.length>0){
        IsScroll.value = true;
      }
      else
        {
          IsScroll.value = false;
        }
    } else {
      isFaqsEmptyMsg.value = responseData['message'];
      print(responseData['message']);

    }
    futurevisitorDataNew.refresh();
    return arrvisitorlistNew;
  }

  Future<List<VisitorModelNew>> RetrieveVisitorsCheckInData( {String filter=''}) async {


    Map<String, dynamic> data = {
      "action":"listvisitors",
      "perpage":"10",
      "nextpage":_pageCount.value,
      "ordbycolumnname":"id",
      "ordby":"1",
      "fltcheckstatus":"in",
      if(filter!=null && filter!="")"filter":filter,
    };

    //filtration
    if(obj_visitor!=null && obj_visitor!=""){
      VistorModel obj=obj_visitor!;
      if(obj.StartDate!.isNotEmpty && obj.StartDate!=null)  data['startdate']= obj.StartDate.toString() ?? "";
      if(obj.EndDate!.isNotEmpty && obj.EndDate!=null) data['enddate']=obj.EndDate.toString() ?? "";
      if(obj.projectmodel!=null) data['fltprojectid']=obj.projectmodel!.id.toString() ?? "";
    }

    print(data.toString()+" this is data for checking");

    ApiResponse response = ApiResponse(
        requestType: RequestType.post,
        data: data,
        base_url: URL_VISITOR,
        apiHeaderType: ApiHeaderType.Content);

      Map<String, dynamic>? responseData = await response.getResponse();
    if (_pageCount.value == 1) {
      arrvisitorcheckinlistNew.clear();
    }

    if (responseData!['status'].toString()=="1") {
      List result = responseData['data'];

      _loadMore.value = responseData['loadmore'];

      List<VisitorModelNew> arrTempList = [];
      arrTempList = List<VisitorModelNew>.from(result.map((e) => VisitorModelNew.fromJson(e)));
      arrvisitorcheckinlistNew.addAll(arrTempList);
      // arrvisitorlistNew.value = List.from(result.map((e) => VisitorModelNew.fromJson(e)));
      arrvisitorcheckinlistNew.refresh();
      if(arrvisitorcheckinlistNew.length>0){
        IsScroll.value = true;
      }
      else
      {
        IsScroll.value = false;
      }

    } else {
      isFaqsEmptyMsg.value = responseData['message'];
      print(responseData['message']);
    }
    futurevisitorcheckinDataNew.refresh();
    return arrvisitorcheckinlistNew;
  }
  Future<List<VisitorModelNew>> RetrieveVisitorsCheckOutData( {String filter=''}) async {

    Map<String, dynamic> data = {
      "action":"listvisitors",
      "perpage":"10",
      "nextpage":_pageCount.value,
      "ordbycolumnname":"id",
      "ordby":"1",
      "fltcheckstatus":"out",
      if(filter!=null && filter!="")"filter":filter,
    };

    //filtration
    if(obj_visitor!=null && obj_visitor!=""){
      VistorModel obj=obj_visitor!;
      if(obj.StartDate!.isNotEmpty && obj.StartDate!=null)  data['startdate']= obj.StartDate.toString() ?? "";
      if(obj.EndDate!.isNotEmpty && obj.EndDate!=null) data['enddate']=obj.EndDate.toString() ?? "";
      if(obj.projectmodel!=null) data['fltprojectid']=obj.projectmodel!.id.toString() ?? "";
    }

    ApiResponse response = ApiResponse(
        requestType: RequestType.post,
        data: data,
        base_url: URL_VISITOR,
        apiHeaderType: ApiHeaderType.Content);

      Map<String, dynamic>? responseData = await response.getResponse();
    if (_pageCount.value == 1) {
      arrvisitorcheckoutlistNew.clear();
    }

    if (responseData!['status'].toString()=="1") {
      List result = responseData['data'];

      _loadMore.value = responseData['loadmore'];

      List<VisitorModelNew> arrTempList = [];
      arrTempList = List<VisitorModelNew>.from(result.map((e) => VisitorModelNew.fromJson(e)));
      arrvisitorcheckoutlistNew.addAll(arrTempList);
      // arrvisitorlistNew.value = List.from(result.map((e) => VisitorModelNew.fromJson(e)));
      arrvisitorcheckoutlistNew.refresh();
      if(arrvisitorcheckoutlistNew.length>0){
        IsScroll.value = true;
      }
      else
      {
        IsScroll.value = false;
      }
    } else {
      isFaqsEmptyMsg.value = responseData['message'];
      print(responseData['message']);
    }
    futurevisitorcheckoutDataNew.refresh();
    return arrvisitorcheckoutlistNew;
  }

  VisitorCHECKIN_CHECKOUT({String visitorid='',String type="in"}) async {
    try{
      AppLoader(contextCommon);
      Map<String, dynamic> data = {
        "action":"checkvisitor",
        "visitorid":visitorid ?? "",
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
        SuccessMsg(responseData['message'] ?? "Success Fully CheckedIn");
        RemoveAppLoader(contextCommon);
        if(type.toLowerCase()=="out"){
          _pageCount.value=1;
          RetrieveVisitorsCheckInData();
        }
      } else {
        RemoveAppLoader(contextCommon);
        isFaqsEmptyMsg.value = responseData['message'];
        ValidationMsg(responseData['message'] ?? "Success Fully CheckedIn");
      }

    }
    catch(e){
      RemoveAppLoader(contextCommon);
      ValidationMsg("Somthing Went Wrong");
    }

  }


  //</editor-fold>

  Future<void> refreshData() async {
    print("REFRESH DATA=================>");
    arrvisitorlistNew.clear();
    editingController.value!.text="";
    _pageCount.value = 1;
   RetrieveVisitorsData();
    arrvisitorlistNew.refresh();
  }

  DrawerOpen(GlobalKey<ScaffoldState> globalKey) {
    globalKey.currentState!.openEndDrawer();
  }


  onSearchTextChanged(String text) async {
    _pageCount.value = 1;

    if (text.isEmpty) {
      if(selected.value==0){
        RetrieveVisitorsData();
      }
      else if(selected.value==1){
        RetrieveVisitorsCheckInData();
      }
      else{
        RetrieveVisitorsCheckOutData();
      }
      return;
    }
    else{
      if(selected.value==0){
        RetrieveVisitorsData(filter: text);
      }
      else if(selected.value==1){
        RetrieveVisitorsCheckInData(filter: text);
      }
      else{
        RetrieveVisitorsCheckOutData(filter: text);
      }

    }


  }

  OnClickHandler(VisitorModelNew obj){
    Get.bottomSheet(BuilderStaffDetailsBottomsheet(obj),isScrollControlled: true);
  }

  Widget BuilderStaffDetailsBottomsheet(VisitorModelNew obj){
    return Container(
      height: Get.height*0.6,
      decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))
      ),
      child: Stack(
        children: [
          Container(
            height: Get.height*0.4,
            color: Colors.transparent,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
              ),
              height: (Get.height * 0.55),
              padding: EdgeInsets.only(left: 20,right: 20,),

              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(height: 20,),

                    obj.profile != null && obj.profile!=""
                        ? SizedBox(
                        height: 70.h,
                        width: 70.w,
                        child: Center(
                            child: CircleAvatar(
                              child: CachedNetworkImage(
                                imageUrl: obj.profile ?? "",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: AppColors.SHIMMER_BASE),
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                errorWidget: (context, url, error) {
                                  return CircleAvatar(
                                    backgroundImage: AssetImage(PERSON_IMAGE),
                                    radius: 100,
                                  );
                                },
                                placeholder: (context, url) {
                                  return CircleAvatar(
                                    backgroundImage: AssetImage(PERSON_IMAGE),
                                    radius: 100,
                                  );
                                },
                                fit: BoxFit.contain,
                              ),
                              // backgroundImage: NetworkImage(
                              //     obj.image?.url??""),
                              radius: 100,
                            )))
                        : SizedBox(
                        height: 70.h,
                        width: 70.w,
                        child: Center(
                            child: CircleAvatar(
                              backgroundImage: AssetImage(PERSON_ICON),
                              radius: 100,
                            ))),

                    SizedBox(height: 10,),
                    // SizedBox(
                    //   height: 15,
                    // ),
                    Text(
                      // obj.categoryname??"",
                      obj.personname ??"",
                      style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.w700),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          InkWell(
                              splashColor: AppColors.TRANSPARENT,
                              hoverColor: AppColors.TRANSPARENT,
                              focusColor: AppColors.TRANSPARENT,
                              onTap: () {
                                launchMobileNo("tel:"+obj.mobile.toString());
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  color: AppColors.DARK_GREY
                                      .withOpacity(0.5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 8,
                                      top: 5,
                                      bottom: 6),
                                  child: Center(
                                    child: Text(
                                      "${obj.mobile}",
                                      style: TextStyles
                                          .textStyleMedium14(
                                          AppColors.BLACK),
                                    ),
                                  ),
                                ),
                              ))
                        ]),
                    SizedBox(height: 10,),
                    Divider(color: AppColors.BLACK,thickness: 1,),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Visitor Role",
                          style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w600),
                        ),
                        Text(
                          // obj.categoryname??"",
                          obj.visitor_role ??"",
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 16,fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    if(obj.unitdetails!.isNotEmpty && obj.unitdetails!=null)   Divider(color: AppColors.BLACK,thickness: 1,),
                    if(obj.unitdetails!.isNotEmpty && obj.unitdetails!=null) SizedBox(height: 10,),
                   if(obj.unitdetails!.isNotEmpty && obj.unitdetails!=null) Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${obj.unitdetails.toString().substring(0,obj.unitdetails.toString().indexOf(":"))}" ??"",
                          style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w600),
                        ),
                        Text(
                          // obj.categoryname??"",
                           "${obj.unitdetails.toString().substring((obj.unitdetails.toString().indexOf(":"))+1)}" ??"",
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 16,fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    if(obj.unitdetails!.isNotEmpty && obj.unitdetails!=null)   SizedBox(height: 10,),
                  Divider(color: AppColors.BLACK,thickness: 1,),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // obj.categoryname??"",
                          "Check In",
                          style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w600),
                        ),
                        Text(DateFormat('hh:mm a').format(DateTime.now()).toString(),
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 16,fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    CustomButtons.WidgetButton(
                      width: Get.width,
                      height: 45.w,
                      radius: 8.w,
                      onTap: () {
                        Get.back();
                        VisitorCHECKIN_CHECKOUT(type: "in",visitorid: obj.id.toString());
                      },
                      child: Text(
                        "CHECK IN",
                        style: TextStyle(
                            color: AppColors.WHITE, fontSize: 14.sp),
                      ),
                      bgColor: Colors.green,
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 10,
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CloseButton(),
              ],
            ),),
        ],
      ),
    );
  }


  VisitorCheckOut(VisitorModelNew obj){
   
    Get.bottomSheet(VisitorCheckInBottomsheet(obj),isScrollControlled: true);
  }

  Widget VisitorCheckInBottomsheet(VisitorModelNew obj){
    stopWatchTimer.clearPresetTime();
    stopWatchTimer.onResetTimer();
    stopWatchTimer.setPresetTime(mSec: dateandtimechanger(obj.checkinDatetime.toString()  ?? DateTime.now().toString()));
    stopWatchTimer.onStartTimer();
    return Container(
      height: Get.height*0.6,
      decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))
      ),
      child: Stack(
        children: [
          Container(
            height: Get.height*0.6,
            color: Colors.transparent,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
              ),
              height: (Get.height * 0.6)/*-50*/,
              padding: EdgeInsets.only(left: 20,right: 20,),

              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(height: 20,),

                    obj.profile != null && obj.profile!=""
                        ? SizedBox(
                        height: 70.h,
                        width: 70.w,
                        child: Center(
                            child: CircleAvatar(
                              child: CachedNetworkImage(
                                imageUrl: obj.profile ?? "",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: AppColors.SHIMMER_BASE),
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                errorWidget: (context, url, error) {
                                  return CircleAvatar(
                                    backgroundImage: AssetImage(PERSON_IMAGE),
                                    radius: 100,
                                  );
                                },
                                placeholder: (context, url) {
                                  return CircleAvatar(
                                    backgroundImage: AssetImage(PERSON_IMAGE),
                                    radius: 100,
                                  );
                                },
                                fit: BoxFit.contain,
                              ),
                              radius: 100,
                            )))
                        : SizedBox(
                        height: 70.h,
                        width: 70.w,
                        child: Center(
                            child: CircleAvatar(
                              backgroundImage: AssetImage(PERSON_ICON),
                              radius: 100,
                            ))),

                    SizedBox(height: 10,),
                    // SizedBox(
                    //   height: 15,
                    // ),
                    Text(obj.personname ??"", style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.w700),),
                    SizedBox(height: 10,),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          InkWell(
                              splashColor: AppColors.TRANSPARENT,
                              hoverColor: AppColors.TRANSPARENT,
                              focusColor: AppColors.TRANSPARENT,
                              onTap: () {
                                launchMobileNo("tel:"+obj.mobile.toString());
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  color: AppColors.DARK_GREY
                                      .withOpacity(0.5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 8,
                                      top: 5,
                                      bottom: 6),
                                  child: Center(
                                    child: Text(
                                      "${obj.mobile}",
                                      style: TextStyles
                                          .textStyleMedium14(
                                          AppColors.BLACK),
                                    ),
                                  ),
                                ),
                              ))
                        ]),
                    StreamBuilder<int>(
                      stream: stopWatchTimer.rawTime,
                      initialData: stopWatchTimer.rawTime.value,
                      builder: (context, snap) {
                        final value = snap.data!;
                        final displayTime =
                        StopWatchTimer.getDisplayTime(value, hours: _isHours,milliSecond: false);
                        return Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                displayTime,
                                style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),

                          ],
                        );
                      },
                    ),

                    SizedBox(height: 10,),
                    Divider(color: AppColors.BLACK,thickness: 1,),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Visitor Role",
                          style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w600),
                        ),
                        Text(
                          // obj.categoryname??"",
                          obj.visitor_role ??"",
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 16,fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    if(obj.unitdetails!.isNotEmpty && obj.unitdetails!=null)      Divider(color: AppColors.BLACK,thickness: 1,),
                    if(obj.unitdetails!.isNotEmpty && obj.unitdetails!=null)     SizedBox(height: 10,),
               if(obj.unitdetails!.isNotEmpty && obj.unitdetails!=null)     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${obj.unitdetails.toString().substring(0,obj.unitdetails.toString().indexOf(":"))}" ??"",
                          style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w600),
                        ),
                        Text(
                          // obj.categoryname??"",
                          "${obj.unitdetails.toString().substring((obj.unitdetails.toString().indexOf(":"))+1)}" ??"",
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 16,fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    if(obj.unitdetails!.isNotEmpty && obj.unitdetails!=null)     SizedBox(height: 10,),
                    Divider(color: AppColors.BLACK,thickness: 1,),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Check In", style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w600),),
                        Text(obj.checkinTime ?? "", style: TextStyle(color: Colors.grey.shade600, fontSize: 16,fontWeight: FontWeight.w600),),
                      ],
                    ),
                    SizedBox(height: 30,),
                    CustomButtons.WidgetButton(
                      width: Get.width,
                      height: 45.w,
                      radius: 8.w,
                      onTap: () {
                        Get.back();
                        VisitorCHECKIN_CHECKOUT(type: "out",visitorid: obj.id.toString());
                      },
                      child: Text(
                        "CHECK OUT",
                        style: TextStyle(
                            color: AppColors.WHITE, fontSize: 14.sp),
                      ),
                      bgColor: Colors.red,
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CloseButton(),
              ],
            ),)

        ],
      ),
    );
  }

  Widget CloseButton() {
    return CustomButtons.RoundIconButton(
        image: CANCEL_ICON,
        imgSize: 15,
        onTap: () {
          Get.back();
          stopWatchTimer.clearPresetTime();
          stopWatchTimer.onResetTimer();

        },
        bgColor: AppColors.SHIMMER_BASE,
        radius: 15,
        height: 30,
        width: 30,
        boxShadow: false,
        imgColor: AppColors.BLACK);
  }


  void launchMobileNo(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw "Could not launch $url";
    }
  }


}
