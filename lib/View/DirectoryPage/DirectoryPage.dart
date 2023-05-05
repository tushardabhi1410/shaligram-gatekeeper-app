import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Config/Utils/Style.dart';
import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/Config/Utils/images.dart';
import 'package:avinashgatekeeper/Controller/DirectoryPageController/DirectoryPageController.dart';
import 'package:avinashgatekeeper/Widget/CustomDrawer.dart';
import 'package:avinashgatekeeper/Widget/RefreshIndicatorWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Modal/Directory/DirectoryModel.dart';
import '../../Widget/ShimmerWidget.dart';

class DirectoryPage extends StatefulWidget {
  // FilterModal? filterData = FilterModal.instance();
  // bool isFilterApply;
  // HomePage({this.filterData, this.isFilterApply = false});

  @override
  _DirectoryState createState() => _DirectoryState();
}

class _DirectoryState extends State<DirectoryPage> with WidgetsBindingObserver {

  DirectoryPageController cnt_Directory = Get.put(DirectoryPageController());
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  // var currentPage = 0.0;

  @override
  void initState() {
    cnt_Directory.LoadPage();
    // TODO: implement initState
    cnt_Directory.editingController.value?.clear();
    super.initState();
  }

  @override
  void dispose() {
    print("Dispose");
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
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        drawer: CustomDrawer(),
        //endDrawer: CustomDrawer(),
        //onEndDrawerChanged: (value) => cnt_Bottom.OnDrawerChange(value),
        backgroundColor: AppColors.WHITE,
        body: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
          return NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    //toolbarHeight: 50,
                    automaticallyImplyLeading: false,
                    actions: [],
                    backgroundColor: AppColors.WHITE,
                    //expandedHeight: 60,
                    floating: false,
                    elevation: 0,
                    flexibleSpace: Container(
                      height: 50.w,
                      padding: EdgeInsets.only(left: 5.w),
                      decoration: BoxDecoration(
                        color: AppColors.WHITE,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // IconButton(onPressed: (){
                          //
                          // }, icon: Image.asset("assets/images/deshbord_heder1.png",color: AppColors.BLACK,)),
                          //
                          Padding(
                            padding: EdgeInsets.all(0.w),
                            child: Image.asset(
                              APP_LOGO_NEW,
                              height: 80,
                              width: 150,
                              fit: BoxFit.contain,
                            ),
                          ),

                          IconButton(
                              onPressed: () {
                                scaffoldKey.currentState!.openDrawer();
                              },
                              icon: Icon(Icons.menu))
                        ],
                      ),
                    ),
                  ),
                  SliverAppBar(
                      // expandedHeight: 100,
                      toolbarHeight: 85.w,
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.white,
                      flexibleSpace: Container(
                        //height: 50.w,
                        //padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: AppColors.WHITE,
                          // borderRadius: BorderRadius.only(
                          //     bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: EdgeInsets.all(10.w),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Text("Directory List",
                                      //     style: TextStyles.textStyleDark16()),
                                      SizedBox(height: 10.w),
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
                                          hintText: "Search your Directory",
                                          labelStyle: TextStyle(
                                              color: AppColors.BLACK,
                                              fontSize: 13.sp),
                                          // suffixIcon: Image.asset(
                                          //   BARCODE_ICON,
                                          //   fit: BoxFit.cover,
                                          // ),
                                            suffixIcon:cnt_Directory.fcn_node.hasFocus? GestureDetector(
                                                onTap: (){
                                                  FocusScope.of(context).unfocus();
                                                  cnt_Directory.fcn_node.unfocus();
                                                  cnt_Directory.editingController.value!.text="";
                                                  cnt_Directory.onSearchTextChanged(cnt_Directory.editingController.value!.text);
                                                  setState(() {
                                                  });

                                                },
                                                child: Icon(Icons.cancel,color: Colors.black,)):
                                            GestureDetector(
                                                onTap: (){
                                                  FocusScope.of(context).requestFocus(cnt_Directory.fcn_node);
                                                  cnt_Directory.fcn_node.requestFocus();
                                                },
                                                child: Icon(Icons.search,color: Colors.black,))
                                        ),


                                        controller: cnt_Directory.editingController.value,
                                        focusNode: cnt_Directory.fcn_node,
                                        onChanged: (value) {
                                          cnt_Directory.onSearchTextChanged(cnt_Directory.editingController.value!.text);
                                          setState(() {
                                          });
                                        },
                                        onFieldSubmitted: (value) {
                                          setState(() {
                                            cnt_Directory.onSearchTextChanged(cnt_Directory.editingController.value!.text);
                                            // get_member_list(_textsearch.text);
                                          });
                                          FocusScope.of(context).unfocus();
                                        },
                                        onEditingComplete: (){
                                          setState(() {
                                            cnt_Directory.onSearchTextChanged(
                                                cnt_Directory.editingController.value!.text);
                                          });
                                          FocusScope.of(context).unfocus();
                                          // get_allProduct_list(_textsearch.text);
                                        },
                                        
                                      )
                                    ]))
                          ],
                        ),
                      ),
                      pinned: true,
                      actions: [])
                ];
              },
              body: SafeArea(
                  bottom: bottomSafeArea,
                  child: Stack(
                    children: [
                      RefreshIndicatorWidget(
                        onRefresh: cnt_Directory.refreshData,
                        child: Container(
                          width: Get.width,
                          height: Get.height,
                          child: NotificationListener<
                              OverscrollIndicatorNotification>(
                            onNotification: (overscroll) {
                              overscroll.disallowGlow();
                              return true;
                            },
                            child: SingleChildScrollView(
                              child: Column(
                                children: [DirectoryView()],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )));
          //margin: EdgeInsets.symmetric(horizontal: 20),
        }));
  }

  //<editor-fold desc = "AppBar">


  Widget DirectoryListView() {
    return Container(
      padding: EdgeInsets.only(left: PADDING, right: PADDING, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return wd_directoryListchildview(index);
            },
            itemCount: cnt_Directory.arrDirectoryList.length!=0?cnt_Directory.arrDirectoryList.length:0,
          ),
        ],
      ),
    );
  }

  Widget DirectoryView() {
    return Obx(() {
      return FutureBuilder(
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return snapshot.data.length != 0
                ? DirectoryListView()
                : Container(
              width: Get.width,
              height: 500,
              alignment: Alignment.center,
              child: Text(
                cnt_Directory.isFaqsEmptyMsg.value,
                style: TextStyle(
                    color: AppColors.BLACK,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
            );
          } else {
            return DirectoryShimmerEffect();
            // return Container();
          }
        },
        future: cnt_Directory.futuredirectoryData.value,
      );
    });
  }

  Widget DirectoryShimmerEffect() {
    return Container(
        child: ShimmerEffect(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return Container(
                    width: Get.width,
                    padding:
                    EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 8.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        shimmerWidget(
                            height: 100.w, width: Get.width, radius: 10.w),
                        SizedBox(
                          height: 8.w,
                        ),
                        shimmerWidget(
                            height: 100.w, width: Get.width, radius: 10.w),
                      ],
                    ),
                  );
                },
                itemCount: 5,
              ),
            ],
          ),
        ));
  }

  Widget wd_directoryListchildview(int index) {
    DirectoryModalNew obj=cnt_Directory.arrDirectoryList[index];
    return Padding(
      padding: EdgeInsets.only(bottom: PADDING),
      child: InkWell(
        //onTap: () => cnt_Properties.GotoDetailpage(obj),
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppColors.WHITE,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [boxShadow,boxShadowback]),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        obj.image != null && obj.image != ""
                            ? SizedBox(
                            height: 70.h,
                            width: 70.w,
                            child: Center(
                                child: CircleAvatar(
                                  child: CachedNetworkImage(
                                    imageUrl: obj.image ?? "",
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                          decoration: BoxDecoration(
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
                                  // backgroundImage: AssetImage(PERSON_ICON),
                                  backgroundImage: AssetImage(PERSON_IMAGE),
                                  radius: 100,
                                ))),
                        RichText(
                            text: TextSpan(
                                // text: "B-201",
                                text: obj.flatname.toString(),
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                    fontFamily: fontFamily),
                                children: [TextSpan(text: "")])),
                      ]),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            obj.personname ??"",
                            // obj.name?.capitalize??"",
                            style: TextStyles.textStyleDark16()),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5.w,
                              ),
                              // Row(
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     mainAxisAlignment:
                              //     MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       RichText(
                              //           text: TextSpan(
                              //               text: "Gym Trainer",
                              //               style: TextStyles.textStyleLight12(
                              //                   Colors.grey),
                              //               children: [TextSpan(text: "")])),
                              //     ]),
                              // SizedBox(
                              //   height: 5.w,
                              // ),
                              // RichText(
                              //     text: TextSpan(
                              //         text: "Flat No: ",
                              //         style: TextStyles.textStyleLight12(
                              //             Colors.grey),
                              //         children: [TextSpan(text: "123")])),
                              // SizedBox(
                              //   height: 5.w,
                              // ),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors.WHITE,
                                        border:
                                            Border.all(color: Colors.blueGrey),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            right: 20,
                                            top: 5,
                                            bottom: 5),
                                        child: Center(
                                          child: Text(
                                            // "Owner",
                                            obj.type ??"",
                                            // "",
                                            style: TextStyles.textStyleMedium14(
                                                AppColors.BLACK),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                              SizedBox(
                                height: 5.w,
                              ),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                        splashColor: AppColors.TRANSPARENT,
                                        hoverColor: AppColors.TRANSPARENT,
                                        focusColor: AppColors.TRANSPARENT,
                                        onTap: () {},
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

                                              "${obj.contact}"??"",
                                                style: TextStyles
                                                    .textStyleMedium14(
                                                        AppColors.BLACK),
                                              ),
                                            ),
                                          ),
                                        ))
                                  ])
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }



}
