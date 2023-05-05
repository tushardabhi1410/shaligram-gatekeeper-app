import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../Config/Helper/ApiResponse.dart';
import '../../Config/Utils/constantValue.dart';
import '../../Modal/FlatChoiceModal/FlatChoiceModal.dart';

class FlatListPageController extends GetxController with SingleGetTickerProviderMixin {
  BuildContext? context;

  RxList<FlatChoicesModal> arrflatchoicelist = RxList<FlatChoicesModal>();
  RxList<FlatChoicesModal> arrflatchoicelistnew = RxList<FlatChoicesModal>();

  //new list of rx list declaration
  RxList<VillaAndPlotAndUnitListModel> arrunitlistnew = RxList<VillaAndPlotAndUnitListModel>();
  RxList<VillaAndPlotAndUnitListModel> arrplotlistnew = RxList<VillaAndPlotAndUnitListModel>();
  RxList<VillaAndPlotAndUnitListModel> arrvillalistnew = RxList<VillaAndPlotAndUnitListModel>();
  RxList<VillaAndPlotAndUnitListModel> arrselectedproprtylistnew = RxList<VillaAndPlotAndUnitListModel>();
  Rxn<dynamic> arrselectedpropertylistretriver=Rxn();

  RxBool IsShimmerLoad=false.obs;

  Rx<Future<List<VillaAndPlotAndUnitListModel>>> futureunitplotvilla = Future.value(<VillaAndPlotAndUnitListModel>[]).obs;




  RxList<FlatChoicesModalWithCustomization> arrflatchoicelistnewstring = RxList<FlatChoicesModalWithCustomization>();
  RxList<Flats> arrflatchoicesublist = RxList<Flats>();
  RxString isFaqsEmptyMsg = "".obs;
  Rx<Future<List<FlatChoicesModal>>> futureflatchoicelistData = Future.value(<FlatChoicesModal>[]).obs;
  Rx<Future<List<FlatChoicesModal>>> futureflatchoicelistDataNew = Future.value(<FlatChoicesModal>[]).obs;
  Rx<Future<List<FlatChoicesModalWithCustomization>>> futureflatchoicelistDatastring = Future.value(<FlatChoicesModalWithCustomization>[]).obs;
  Rx<Future<List<Flats>>> futureflatchoicesublistData = Future.value(<Flats>[]).obs;


  LoadPage() {
    RetrieveFlatChoiceDataNew();
    futureflatchoicelistDataNew.refresh();
  }


  RetrieveFlatChoiceDataNew() async {
    IsShimmerLoad.value=false;
   arrunitlistnew = RxList<VillaAndPlotAndUnitListModel>([]);
   arrplotlistnew = RxList<VillaAndPlotAndUnitListModel>([]);
   arrvillalistnew = RxList<VillaAndPlotAndUnitListModel>([]);

    Map<String, dynamic> data = {
      "action":"listprojectdetails"
    };
    ApiResponse response = ApiResponse(
        requestType: RequestType.post,
        data: data,
        base_url: URL_FLATCHOICE,
        apiHeaderType: ApiHeaderType.Content);
    Map<String, dynamic>? responseData = await response.getResponse();

    try{
      if (responseData!['status'].toString()=="1") {
        List<VillaAndPlotAndUnitListModel> unittemplist=[],villatemplist=[],plottemplist=[];
        List<dynamic> unit=[],plot=[],villa=[];


        if(responseData['data']['unit']!=null)   unit =responseData['data']['unit'];
        if(responseData['data']['villa']!=null)  villa=responseData['data']['villa'];
        if(responseData['data']['plot']!=null)   plot=responseData['data']['plot'];

        if(unit.length>0)  unit.forEach((element) {unittemplist.add(VillaAndPlotAndUnitListModel.fromJson(element));});
        if(plot.length>0)  plot.forEach((element) {plottemplist.add(VillaAndPlotAndUnitListModel.fromJson(element));});
        if(villa.length>0) villa.forEach((element) {villatemplist.add(VillaAndPlotAndUnitListModel.fromJson(element));});

        arrunitlistnew.value=unittemplist;
        arrplotlistnew.value=plottemplist;
        arrvillalistnew.value=villatemplist;

        if(arrselectedpropertylistretriver.value!=null ){
          List<VillaAndPlotAndUnitListModel> testlist=arrselectedpropertylistretriver.value;

          testlist.forEach((element1) {
            unittemplist.forEach((element) {

                if(element1.plot_id.toString()==element.plot_id.toString() && element1.name.toString()==element1.name.toString() && element1.unit_id.toString()==element.unit_id.toString()){
                  arrselectedproprtylistnew.add(element);

                }


            });

            plottemplist.forEach((element) {

                if(element1.plot_id.toString()==element.plot_id.toString() && element1.name.toString()==element1.name.toString()){
                  arrselectedproprtylistnew.add(element);
                }

            });

            villatemplist.forEach((element) {

                if(element1.villa_id.toString()==element.villa_id.toString() && element1.vila_name.toString()==element1.vila_name.toString()){
                  arrselectedproprtylistnew.add(element);
                }

            });
          });


        }



        IsShimmerLoad.value=true;




      }
      else {
        isFaqsEmptyMsg.value = responseData['message'];
        print(responseData['msg']);
        IsShimmerLoad.value=true;
      }}catch(e){
      print(e);
      IsShimmerLoad.value=true;
    }




  }

  Future<void> refreshData()async{

  }

  DrawerOpen(GlobalKey<ScaffoldState> globalKey) {
    globalKey.currentState!.openEndDrawer();
  }
}