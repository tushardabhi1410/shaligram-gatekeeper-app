import 'dart:convert';
import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Config/Utils/Style.dart';
import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/Config/Utils/images.dart';
import 'package:avinashgatekeeper/Controller/VisitorRegistrationPageController/FlatListPageController.dart';
import 'package:avinashgatekeeper/Modal/FlatChoiceModal/FlatChoiceModal.dart';
import 'package:avinashgatekeeper/Widget/CustomAppBar.dart';
import 'package:avinashgatekeeper/Widget/CustomDrawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Config/Functions.dart';
import '../../Widget/CustomDecoration.dart';
import '../../Widget/ShimmerWidget.dart';

class FlatListPage extends StatefulWidget {
   dynamic SelectedRetiriveList;
   FlatListPage({Key? key,this.SelectedRetiriveList}) : super(key: key);

  @override
  _FlatListState createState() => _FlatListState();
}

class Flat_Choice {
  const Flat_Choice({required this.title,});
  final String title;

}

class _FlatListState extends State<FlatListPage> with WidgetsBindingObserver {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  FlatListPageController cnt_Flat = Get.put(FlatListPageController());

  int _current_index = 0;



  @override
  void initState() {
    // TODO: implement initState
    if(widget.SelectedRetiriveList!=null){
      cnt_Flat.arrselectedpropertylistretriver.value=widget.SelectedRetiriveList;
    }
    cnt_Flat.LoadPage();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(toolbarHeight: 0, elevation: 0),
        resizeToAvoidBottomInset: true,
        key: scaffoldKey,
        //endDrawer: CustomDrawer(),
        drawer: CustomDrawer(),
        backgroundColor: AppColors.WHITE,
        bottomNavigationBar:  Container(
          decoration: BoxDecoration(color: AppColors.BACKGROUND_WHITE,
            boxShadow:
            [
              BoxShadow(color:
              hex("266CB5").withOpacity(0.1),offset: Offset(1,1),blurRadius: 5,spreadRadius: 3),],
          ),

          padding: const EdgeInsets.only(left: 20, right: 20,top: 20,bottom: 20),
          child: SubmitButton(),
        ),
        body: StatefulBuilder(builder: (BuildContext context,
            StateSetter setState /*You can rename this!*/) {
          return NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    toolbarHeight: 70,
                    automaticallyImplyLeading: false,
                    actions: [],
                    backgroundColor: AppColors.WHITE,
                    //expandedHeight: 60,
                    floating: false,
                    elevation: 0,
                    flexibleSpace: CustomAppBar(
                        title: "Flat List",
                        bgColor: AppColors.WHITE,
                        backimgbgColor: AppColors.DARK_GREY,
                        onTapCallBack: () {
                          Get.back();
                        }),
                  ),
                  SliverAppBar(
                      //expandedHeight: 100,
                      toolbarHeight: 65.w,
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.white,
                      flexibleSpace: Container(
                        //height: 50.w,
                        //padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: AppColors.WHITE,
                          // borderRadius: BorderRadius.only(
                          // bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.only(
                                    left: 13.w,
                                    right: 13.w,
                                    top: 10.w,
                                    bottom: 10.w),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [

                                      TextFormField(
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.done,
                                        cursorColor: AppColors.BLACK,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 12.w, horizontal: 12.w),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: Colors.black38,
                                          )),
                                          alignLabelWithHint: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: AppColors.BLACK,
                                          )),
                                          errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                            color: AppColors.RED,
                                          )),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                  borderSide: BorderSide(
                                            color: AppColors.RED,
                                          )),
                                          //labelText: "Search",
                                          hintText: "Search here",
                                          labelStyle: TextStyle(
                                              color: AppColors.BLACK,
                                              fontSize: 13.sp),
                                          suffixIcon: IconButton(
                                            icon: Icon(Icons.search, size: 30),
                                            onPressed: () {},
                                          ),
                                        ),
                                      )
                                    ]))
                          ],
                        ),
                      ),
                      pinned: true,
                      actions: [])
                ];
              },
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child:  Column(
                  children: [
                   Obx(() =>  FlatsView()),
                    PlotList(),
                    VillaList(),
                  ],
                ),
              ),

              );
        }));
  }

  Widget SubmitButton() {
    return OnTapButton(
        onTap: () { Get.back(result: cnt_Flat.arrselectedproprtylistnew.value);},
        height: 40,
        decoration: CustomDecorations()
            .backgroundlocal(APP_THEME_COLOR, cornarradius, 0, APP_THEME_COLOR),
        text: "Select",
        style:
        TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600));
  }

  Widget FlatListViewNew1() {
    return cnt_Flat.arrunitlistnew.length>0? Container(
        child: GridView.builder(
          itemCount: cnt_Flat.arrunitlistnew.length,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          primary: true,
          padding: EdgeInsets.only(top: 10, left: 15, right: 15,bottom: 25),
          gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 30.0,
            mainAxisSpacing: 5.0,
            childAspectRatio:2.6/1.8,
          ),
          itemBuilder: (BuildContext context, int ind) {
            return Obx(() =>  wd_flatListchildview(ind));
          },
        ),


    ):Container();
  }
  Widget PlotListView() {

    return Container(

        child: GridView.builder(
          itemCount: cnt_Flat.arrplotlistnew.length,
          shrinkWrap: true,
          // physics: BouncingScrollPhysics(),
          physics: BouncingScrollPhysics(),
          primary: true,
          padding: EdgeInsets.only(top: 10, left: 15, right: 15,bottom: 25),
          gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 30.0,
            mainAxisSpacing: 5.0,
            childAspectRatio:2.6/1.8,
          ),
          itemBuilder: (BuildContext context, int ind) {
            return wd_plotListchildview(ind);
          },
        ),


    );
  }
  Widget VillaListView() {

    return Container(

        child: GridView.builder(
          itemCount: cnt_Flat.arrvillalistnew.length,
          shrinkWrap: true,
          // physics: BouncingScrollPhysics(),
          physics: BouncingScrollPhysics(),
          primary: true,
          padding: EdgeInsets.only(top: 10, left: 15, right: 15,bottom: 25),
          gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 30.0,
            mainAxisSpacing: 5.0,
            childAspectRatio:2.6/1.8,
          ),
          itemBuilder: (BuildContext context, int ind) {
            return wd_villaListchildview(ind);
          },
        ),


    );
  }

  Widget PlotList() {

    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cnt_Flat.IsShimmerLoad.isTrue?cnt_Flat.arrplotlistnew.length>0?   Padding(
            padding: EdgeInsets.only(top: 10, left: 15, right: 15,bottom: 10),
            child: Text("Plots",style: TextStyles.textStyleDark16(),),
          ):Container():Container(),
          Container(
            child: cnt_Flat.IsShimmerLoad.isTrue?PlotListView():FlatShimmerEffect(),
          ),
        ],
      );
    });
  }
  Widget VillaList() {

    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cnt_Flat.IsShimmerLoad.isTrue?cnt_Flat.arrunitlistnew.length>0?  Padding(
            padding: EdgeInsets.only(top: 10, left: 15, right: 15,bottom: 10),
            child: Text("Villas",style: TextStyles.textStyleDark16(),),
          ):Container():Container(),
          Container(
            child: cnt_Flat.IsShimmerLoad.isTrue?VillaListView():FlatShimmerEffect(),
          ),
        ],
      );
    });
  }
  Widget FlatsView() {


      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cnt_Flat.IsShimmerLoad.isTrue?cnt_Flat.arrunitlistnew.length>0?  Padding(
            padding: EdgeInsets.only(top: 10, left: 15, right: 15,bottom: 10),
            child: Text("Flats",style: TextStyles.textStyleDark16(),),
          ):Container():Container(),
          Container(
            child: cnt_Flat.IsShimmerLoad.isTrue?FlatListViewNew1():FlatShimmerEffect(),
          ),
        ],
      );

  }


  Widget wd_flatListchildview(index) {
    VillaAndPlotAndUnitListModel obj1=cnt_Flat.arrunitlistnew[index];

    return Padding(
      padding: EdgeInsets.only(bottom: PADDING),
      child: GestureDetector(
        //onTap: () => cnt_Properties.GotoDetailpage(obj),
        onTap: () {
          if(cnt_Flat.arrselectedproprtylistnew.value.contains(obj1)){
            cnt_Flat.arrselectedproprtylistnew.value.remove(obj1);
          }else{
            cnt_Flat.arrselectedproprtylistnew.value.add(obj1);
          }

          setState((){});
        },
        child: Container(
          height: 60,
          width: double.infinity,
          //alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          decoration:
          cnt_Flat.arrselectedproprtylistnew.value.contains(obj1)?
          BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 1, //
                color: Colors.blue//                <--- border width here
            ),
          )
              :BoxDecoration(
            color: AppColors.WHITE,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 1, //                   <--- border width here
                color: Colors.blue
            ),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "${obj1.name}"??"",
                  style:
                  // index==_current_index?
                  TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color:cnt_Flat.arrselectedproprtylistnew.value.contains(obj1)?AppColors.WHITE: Colors.blue,
                      fontFamily: fontFamily),textAlign: TextAlign.center,

              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget wd_plotListchildview(index) {
    VillaAndPlotAndUnitListModel obj1=cnt_Flat.arrplotlistnew[index];

    return Padding(
      padding: EdgeInsets.only(bottom: PADDING),
      child: GestureDetector(
        onTap: () {
          if(cnt_Flat.arrselectedproprtylistnew.value.contains(obj1)){
              cnt_Flat.arrselectedproprtylistnew.value.remove(obj1);
          }else{
            cnt_Flat.arrselectedproprtylistnew.value.add(obj1);
          }

          setState((){});
        },
        child: Container(
          height: 60,
          width: double.infinity,
          //alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          decoration:   cnt_Flat.arrselectedproprtylistnew.value.contains(obj1)?
          BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 1, //
                color: Colors.blue//                <--- border width here
            ),
          )
              :BoxDecoration(
            color: AppColors.WHITE,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 1, //                   <--- border width here
              color: Colors.blue
            ),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "${obj1.plot_name} "??"",
                  style:
                  // index==_current_index?
                  TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color:    cnt_Flat.arrselectedproprtylistnew.value.contains(obj1)?AppColors.WHITE:Colors.blue,
                      fontFamily: fontFamily),textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget wd_villaListchildview(index) {
    VillaAndPlotAndUnitListModel obj1=cnt_Flat.arrvillalistnew[index];

    return Padding(
      padding: EdgeInsets.only(bottom: PADDING),
      child: GestureDetector(

        onTap: () {
          if(cnt_Flat.arrselectedproprtylistnew.value.contains(obj1)){
            cnt_Flat.arrselectedproprtylistnew.value.remove(obj1);
          }else{
            cnt_Flat.arrselectedproprtylistnew.value.add(obj1);
          }

          setState((){});
        },
        child: Container(
          height: 60,
          width: double.infinity,
          //alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          decoration:
          cnt_Flat.arrselectedproprtylistnew.value.contains(obj1)?
          BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 1, //
                color: Colors.blue//                <--- border width here
            ),
          )
              :BoxDecoration(
            color: AppColors.WHITE,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 1, //                   <--- border width here
              color: Colors.blue,
            ),
          ),
          clipBehavior: Clip.hardEdge,
          child: Center(
            child: Text(
                "${obj1.vila_name} "??"",
                style:
                // index==_current_index?
                TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: cnt_Flat.arrselectedproprtylistnew.value.contains(obj1)? AppColors.WHITE:Colors.blue,
                    fontFamily: fontFamily),textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget FlatShimmerEffect(){
    return  Container(
        child: ShimmerEffect(
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return Container(
                height: 40,
                width: double.infinity,
                //alignment: Alignment.center,
                padding: EdgeInsets.all(10),
               // width: Get.width,
               //  padding:
                // EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 8.w),
                child: shimmerWidget(
                    height: 100.w, radius: 10.w),
              );
            },
            itemCount: 30,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 5.0,
              childAspectRatio: 2.6 / 2,
            ),
          ),
        ));
  }
}
