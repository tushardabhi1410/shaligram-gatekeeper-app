import 'package:avinashgatekeeper/Config/Helper/ApiResponse.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/Modal/Directory/DirectoryModel.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class DirectoryPageController extends GetxController with SingleGetTickerProviderMixin {


  //RxList declaration
  RxList<DirectoryModalNew> arrDirectoryList = RxList<DirectoryModalNew>();

  //future RxList declaration
  Rx<Future<List<DirectoryModalNew>>> futuredirectoryData = Future.value(<DirectoryModalNew>[]).obs;




  // Rx Variable Declaration
  RxInt _loadMore = 0.obs;
  RxInt _pageCount = 1.obs;
  RxString isFaqsEmptyMsg = "".obs;


  Rxn<TextEditingController> editingController = Rxn(TextEditingController());
  FocusNode fcn_node=FocusNode();
  RxBool noDataFound=false.obs;
  RxList<DirectoryModal> searchDirctorylist = RxList<DirectoryModal>();
  List<DirectoryModal> checkinglist=[];

  LoadPage() {
    futuredirectoryData.value = RetrieveDirectoryDataNew();
    arrDirectoryList.refresh();
  }



  Future<List<DirectoryModalNew>> RetrieveDirectoryDataNew({String filter=''}) async {
    try{

      Map<String, dynamic> data = {
        "action":"listdirectory",
        "ordbycolumnname":"id",
        "ordby":"1",
        "perpage":"10",
        "nextpage":_pageCount.value,
        if(filter!=null && filter!="") "filter":filter
      };



      ApiResponse response = ApiResponse(
          requestType: RequestType.post,
          data: data,
          base_url: URL_DIRECTORY,
          apiHeaderType: ApiHeaderType.Content);

      Map<String, dynamic>? responseData = await response.getResponse();

      if (_pageCount.value == 1) {
        arrDirectoryList.clear();
      }


      if (responseData!['status'].toString()=="1") {
        List result = responseData['data'];

        List<DirectoryModalNew> arrTempList = [];
        arrTempList = List<DirectoryModalNew>.from(result.map((e) => DirectoryModalNew.fromJson(e)));
        arrDirectoryList.addAll(arrTempList);
        // arrDirectoryList.value = List.from(result.map((e) => DirectoryModal.fromJson(e)));


        arrDirectoryList.refresh();
        futuredirectoryData.refresh();

      } else {
        isFaqsEmptyMsg.value = responseData['message'];
        print(responseData['message']);
      }

    }
    catch(e){
      print("im in error");
      print(e);
    }

    return arrDirectoryList;
  }
  Future<void> refreshData()async{
    fcn_node.unfocus();
    editingController.value!.text="";
    arrDirectoryList.clear();
    _pageCount.value=1;
    futuredirectoryData.value = RetrieveDirectoryDataNew();
    arrDirectoryList.refresh();

  }


  onSearchTextChanged(String text) async {
    _pageCount.value=1;
    noDataFound.value=false;

    if (text.isEmpty) {
      RetrieveDirectoryDataNew(filter: "");
      return;
    }
    else{
    RetrieveDirectoryDataNew(filter: text);
    }
  }
}
