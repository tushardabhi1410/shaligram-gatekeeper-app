import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Config/Utils/Style.dart';
import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/Config/Utils/images.dart';
import 'package:avinashgatekeeper/Controller/StaffController/StaffController.dart';
import 'package:avinashgatekeeper/Modal/Staff/StaffModel.dart';
import 'package:avinashgatekeeper/View/BuilderStaffPage/AddBuilderStaffPage/AddBuilderStaffPage.dart';
import 'package:avinashgatekeeper/View/VisitorLogPage/VisitorLogPage.dart';
import 'package:avinashgatekeeper/View/VisitorPage/VisitorPage.dart';
import 'package:avinashgatekeeper/Widget/CustomDrawer.dart';
import 'package:avinashgatekeeper/Widget/RefreshIndicatorWidget.dart';
import 'package:avinashgatekeeper/Widget/ShimmerWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Widget/CustomButton.dart';
import 'AddStaffPage.dart';

class StaffPage extends StatefulWidget {
  // FilterModal? filterData = FilterModal.instance();
  // bool isFilterApply;
  // HomePage({this.filterData, this.isFilterApply = false});

  @override
  _StaffPageState createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> with WidgetsBindingObserver {
  StaffPageController cnt_staff = Get.put(StaffPageController());
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String formattedDate = DateFormat('kk:mm a').format(DateTime.now());

  var renderOverlay = true;
  var visible = true;
  var switchLabelPosition = false;
  var extend = false;
  var rmicons = false;
  var customDialRoot = false;
  var closeManually = false;
  var useRAnimation = true;
  var isDialOpen = ValueNotifier<bool>(false);
  var speedDialDirection = SpeedDialDirection.up;
  var buttonSize = const Size(56.0, 56.0);
  var childrenButtonSize = const Size(65.0, 65.0);
  var selectedfABLocation = FloatingActionButtonLocation.endDocked;

  // var currentPage = 0.0;

  @override
  void initState() {
    cnt_staff.LoadPage();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    print("Dispose");
    super.dispose();
  }

  void launchMobileNo(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state);
  }

  @override
  Widget build(BuildContext context) {

    cnt_staff.context = context;
    // cnt_Home.cnt_ProjectList.addListener(() {
    //   setState(() {
    //     currentPage = cnt_Home.cnt_ProjectList.page!;
    //   });
    // });
    return Scaffold(
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          spacing: 3,
          openCloseDial: isDialOpen,
          childPadding: const EdgeInsets.all(5),
          spaceBetweenChildren: 4,
          buttonSize:
          buttonSize, // it's the SpeedDial size which defaults to 56 itself
          label: extend
              ? const Text("Open")
              : null, // The label of the main button.
          activeLabel: extend ? const Text("Close") : null,
          childrenButtonSize: childrenButtonSize,
          visible: visible,
          direction: speedDialDirection,
          switchLabelPosition: switchLabelPosition,
          closeManually: closeManually,
          renderOverlay: false,
          onOpen: () => debugPrint('OPENING DIAL'),
          onClose: () => debugPrint('DIAL CLOSED'),
          useRotationAnimation: useRAnimation,
          tooltip: 'Open Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          // foregroundColor: Colors.black,
          // backgroundColor: Colors.white,
          // activeForegroundColor: Colors.red,
          // activeBackgroundColor: Colors.blue,
          elevation: 0.0,
          animationCurve: Curves.elasticInOut,
          isOpenOnStart: false,
          backgroundColor:AppColors.APP_THEME_COLOR,
          animationDuration: const Duration(milliseconds: 500),
          shape: customDialRoot
              ? const RoundedRectangleBorder()
              : const StadiumBorder(),
          // childMargin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          children: [

            SpeedDialChild(
              labelStyle: TextStyle(color: AppColors.BLACK.withOpacity(0.4), fontWeight: FontWeight.bold),
              labelBackgroundColor: AppColors.WHITE,
              child: Padding(padding: EdgeInsets.all(15),child: Image.asset("assets/images/fab_icon.png",fit: BoxFit.cover)),
              backgroundColor: AppColors.YELLOW,
              foregroundColor: Colors.white,
              label: 'Visitor Log',
              onTap: () {
                Get.to(VisitorLogPage());
              },
            ),

            SpeedDialChild(
              labelStyle: TextStyle(color: AppColors.BLACK.withOpacity(0.4), fontWeight: FontWeight.bold),
              labelBackgroundColor: AppColors.WHITE,
              child: Padding(padding: EdgeInsets.all(15),child: Image.asset("assets/images/fab_icon.png",fit: BoxFit.cover)),
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              label: 'Add New Staff',
              onTap: () {
                Get.to(AddStaffPage());
              },
            ),
          ],
        ),
        appBar: AppBar(toolbarHeight: 0, elevation: 0),
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        //endDrawer: CustomDrawer(),
        drawer: CustomDrawer(),
        backgroundColor: AppColors.WHITE,
        body: StatefulBuilder(builder: (BuildContext context,
            StateSetter setState /*You can rename this!*/) {
          return NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
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
                      child:  Row(
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
                              APP_LOGO,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),

                          IconButton(onPressed: (){
                            scaffoldKey.currentState!.openDrawer();
                          }, icon: Icon(Icons.menu))
                        ],
                      )
                    ),
                  ),
                  SliverAppBar(
                    // expandedHeight: 100,
                      toolbarHeight: 140.w,
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
                            Row(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Expanded(child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          cnt_staff.selected.value = 0;
                                          print(cnt_staff.selected.value);
                                          cnt_staff.fcn_node.unfocus();
                                          cnt_staff.editingController.value!.text="";
                                        });
                                      },
                                      child:Container(
                                        padding: EdgeInsets.all(10.w),
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                          color: cnt_staff.selected.value==0?AppColors.YELLOW:AppColors.SHIMMER_BASE,
                                          // borderRadius: BorderRadius.only(
                                          //     bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
                                        ),
                                        child: Image.asset(
                                          METER_ICON,
                                          height: 20.h,
                                          width: 20.w,
                                        ),))),
                                  Expanded(child: InkWell(
                                      onTap: (){
                                        setState((){
                                          cnt_staff.selected.value=1;
                                          print(cnt_staff.selected.value);
                                          print("Check In");
                                          cnt_staff.fcn_node.unfocus();
                                          cnt_staff.editingController.value!.text="";
                                          cnt_staff.RetrieveStaffInData();
                                        });
                                        print("Check In");
                                      },
                                      child:Container(
                                        padding: EdgeInsets.all(10.w),
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                          color: cnt_staff.selected.value==1?AppColors.YELLOW:AppColors.SHIMMER_BASE,
                                          // borderRadius: BorderRadius.only(
                                          //     bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
                                        ),
                                        alignment: Alignment.center,
                                        child:Text("IN",
                                            style: TextStyles.textStyleLight14()),))),
                                  Expanded(child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          cnt_staff.selected.value =2;
                                          print(cnt_staff.selected.value);
                                          cnt_staff.fcn_node.unfocus();
                                          cnt_staff.editingController.value!.text="";
                                          print("checkout");
                                        });
                                      },
                                      child:Container(
                                          height: 40.h,
                                          padding: EdgeInsets.all(10.w),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: cnt_staff.selected.value==2?AppColors.YELLOW:AppColors.SHIMMER_BASE,
                                            // borderRadius: BorderRadius.only(
                                            //     bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
                                          ),
                                          child: Text("OUT",
                                              style: TextStyles.textStyleLight14()))))

                                ]),
                            Container(
                                padding: EdgeInsets.all(10.w),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Active Staff",
                                          style: TextStyles.textStyleDark16()),
                                      SizedBox(height: 10.w),
                                     Obx(() =>  TextFormField(
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.done,
                                        cursorColor: AppColors.BLACK,
                                        controller: cnt_staff.editingController.value,
                                        focusNode: cnt_staff.fcn_node,
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
                                          focusedErrorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.RED,
                                              )),
                                          //labelText: "Search",
                                          hintText: "Search staff",
                                          labelStyle: TextStyle(
                                              color: AppColors.BLACK, fontSize: 13.sp),
                                          suffixIcon:cnt_staff.fcn_node.hasFocus? InkWell(
                                              onTap: (){
                                                FocusScope.of(context).unfocus();
                                                cnt_staff.fcn_node.unfocus();
                                                cnt_staff.editingController.value!.text="";
                                                cnt_staff.onSearchTextChanged(cnt_staff.editingController.value!.text);
                                                setState(() {
                                                });

                                              },
                                              child: Icon(Icons.cancel,color: Colors.black,)):
                                          InkWell(
                                              onTap: (){
                                                FocusScope.of(context).requestFocus(cnt_staff.fcn_node);
                                                cnt_staff.fcn_node.requestFocus();
                                                },
                                              child: Icon(Icons.search,color: Colors.black,))
                                        ),

                                        onChanged: (value) {
                                          cnt_staff.onSearchTextChanged(cnt_staff.editingController.value!.text);
                                          setState(() {
                                          });
                                        },
                                        onFieldSubmitted: (value) {
                                          setState(() {
                                            cnt_staff.onSearchTextChanged(cnt_staff.editingController.value!.text);
                                            // get_member_list(_textsearch.text);
                                          });
                                          FocusScope.of(context).unfocus();
                                        },
                                        onEditingComplete: (){
                                          setState(() {
                                            cnt_staff.onSearchTextChanged(
                                                cnt_staff.editingController.value!.text);
                                          });
                                          FocusScope.of(context).unfocus();
                                          // get_allProduct_list(_textsearch.text);
                                        },


                                      ))
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
                        onRefresh: cnt_staff.refreshData,
                        child: Container(
                          width: Get.width,
                          // height: Get.height,
                          //padding: EdgeInsets.only(bottom: BOTTOM_HEIGHT.w),
                          child: NotificationListener<
                              OverscrollIndicatorNotification>(
                            onNotification: (overscroll) {
                              overscroll.disallowGlow();
                              return true;
                            },
                            child: SingleChildScrollView(
                              child:  Obx(()=>Column(
                                children: [
                                  if(cnt_staff.selected.value==0)StaffListView(),
                                  if(cnt_staff.selected.value==1)StaffInListView(),
                                  if(cnt_staff.selected.value==2)StaffListView(),
                                ],),)

                            ),),),),],)));
          //margin: EdgeInsets.symmetric(horizontal: 20),
        }));
  }

  //<editor-fold desc = "AppBar">

  Widget AppBarWidget() {
    return Container(
      height: 70.w,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.DARK_GREY,
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(5.w),
            child: Image.asset(
              APP_LOGO,
            ),
          ),

        ],
      ),
    );
  }

  Widget StaffsListView() {
    return Container(
      padding: EdgeInsets.only(left: PADDING, right: PADDING, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //SizedBox(height: 10.w),
          // Text("Expected Visitor", style: TextStyles.textStyleDark16()),
          // SizedBox(height: 15.w),
          ListView.builder(
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return wd_staffListchildview(index);
            },
            itemCount: cnt_staff.arrstafflist.length,
          ),
        ],
      ),
    );
  }

  Widget StaffListView() {
    return Obx(() {
      return FutureBuilder(
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return snapshot.data.length != 0
                ? StaffsListView()
                : Container(
              width: Get.width,
              height: 100,
              alignment: Alignment.center,
              child: Text(
                // cnt_staff.isFaqsEmptyMsg.value,
                "No Data Found",
                style: TextStyle(
                    color: AppColors.BLACK,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
            );
          } else {
            return StaffShimmerEffect();
          }
        },
        future: cnt_staff.futurestaffData.value,
      );
    });
  }

  Widget StaffShimmerEffect() {
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

  Widget wd_staffListchildview(index) {
    StaffModal obj = cnt_staff.arrstafflist[index];

    return Padding(
      padding: EdgeInsets.only(bottom: PADDING),
      child: InkWell(
        //onTap: () => cnt_Properties.GotoDetailpage(obj),
        onTap: () {
          OnClickHandler(obj);
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppColors.WHITE,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [boxShadow]),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  obj.image != null && obj.image?.url != null
                      ? SizedBox(
                      height: 70.h,
                      width: 70.w,
                      child: Center(
                          child: CircleAvatar(
                            child: CachedNetworkImage(
                              imageUrl: obj.image?.url ?? "",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                    // height: 100,
                                    // width: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      //borderRadius: BorderRadius.all(Radius.circular(10)),
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
                  // Image.asset(
                  //   PERSON_ICON,
                  //   height: 70.h,
                  //   width: 70.w,
                  // ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(obj.name ?? "",
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
                              //       if (obj.visitortype != null)
                              //       RichText(
                              //           text: TextSpan(
                              //               text: obj.visitortype?.type
                              //                   .toString() ??
                              //                   "",
                              //               style: TextStyles.textStyleLight12(
                              //                   Colors.grey),
                              //               children: [TextSpan(text: "")])),
                              //     ]),
                              SizedBox(
                                height: 5.w,
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: "",
                                      style: TextStyles.textStyleLight12(
                                          Colors.grey),
                                      children: [TextSpan(text: obj.staff_type?.type.toString() ?? "")])),
                              // Row(
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     mainAxisAlignment:
                              //     MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       if (obj.visitortype != null)
                              //       RichText(
                              //           text: TextSpan(
                              //               text: obj.visitortype?.type
                              //                   .toString() ??
                              //                   "",
                              //               style: TextStyles.textStyleLight12(
                              //                   Colors.grey),
                              //               children: [TextSpan(text: "")])),
                              //     ]),
                              SizedBox(
                                height: 5.w,
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: "Badge No: ",
                                      style: TextStyles.textStyleLight12(
                                          Colors.grey),
                                      children: [TextSpan(text: obj.staff_type?.id.toString() ?? "")])),
                              // SizedBox(
                              //   height: 5.w,
                              // ),
                              // RichText(
                              //     text: TextSpan(
                              //         text: "Badge No: ",
                              //         style: TextStyles.textStyleLight12(
                              //             Colors.grey),
                              //         children: [TextSpan(text: obj.flat_no ?? "")])),
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
                                                  "+91${obj.mobile_no}",
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

  OnClickHandler(StaffModal obj){
    // Get.to(()=>NewsDetailsPage(obj: obj,));
    StaffPageController controller = Get.put(StaffPageController());
    // controller.CreateAllTheme();
    Get.bottomSheet(BuilderStaffDetailsBottomsheet(obj),isScrollControlled: true);
  }

  Widget BuilderStaffDetailsBottomsheet(StaffModal obj){
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
                // borderRadius: BorderRadius.circular(15)),
                borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
              ),
              height: (Get.height * 0.55)/*-50*/,
              padding: EdgeInsets.only(left: 20,right: 20,),

              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizedBox(height: 10,),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     CloseButton(),
                    //   ],
                    // ),
                    SizedBox(height: 20,),
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(15),
                    //   child:
                    //   CachedNetworkImage(
                    //     width:Get.width,
                    //     fit: BoxFit.fill,
                    //     // width: Get.width-10,
                    //     // placeholder: (context, url) => LeadShimmerWidget(),
                    //     fadeInDuration: Duration.zero,
                    //     fadeOutDuration: Duration.zero,
                    //     placeholderFadeInDuration: Duration.zero,
                    //     // imageUrl: obj.imagelist?.url??"",
                    //     imageUrl: "https://s3.us-west-2.amazonaws.com/realtyxv2s3fullaccess/builder-8/awards/record-10/2019-08-01-071234_bc02c808-b42b-11e9-a396-02df5742e9fe.jpg",
                    //     // fit: BoxFit.fill,
                    //     // errorWidget: (context, url, error) {
                    //     //   return
                    //     //     Image.asset(
                    //     //       IMG_BUILD4,
                    //     //       // height: 250,
                    //     //       width: Get.width,
                    //     //       fit: BoxFit.cover,
                    //     //
                    //     //     );
                    //     // },
                    //   ),),
                    obj.image != null && obj.image?.url != null
                        ? SizedBox(
                        height: 70.h,
                        width: 70.w,
                        child: Center(
                            child: CircleAvatar(
                              child: CachedNetworkImage(
                                imageUrl: obj.image?.url ?? "",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      // height: 100,
                                      // width: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: AppColors.SHIMMER_BASE),
                                        shape: BoxShape.circle,
                                        //borderRadius: BorderRadius.all(Radius.circular(10)),
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
                    //Image.asset(obj.image!,width:Get.width,fit: BoxFit.fill,)),
                    // topNewsTitle(
                    //   //     TextStyle(
                    //   //     fontSize: 14,
                    //   //     color: gray_color_1,
                    //   //     fontWeight: FontWeight.w400,
                    //   //     fontFamily: fontFamily
                    //   // )
                    //   TextStyle(color: gray_color_1, fontSize: 12,fontWeight: FontWeight.w500),
                    // ),
                    SizedBox(height: 10,),
                    // SizedBox(
                    //   height: 15,
                    // ),
                    Text(
                      // obj.categoryname??"",
                      obj.name??"",
                      style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.w700),
                    ),
                    // topNewsTitle(
                    //   //     TextStyle(
                    //   //     fontSize: 14,
                    //   //     color: gray_color_1,
                    //   //     fontWeight: FontWeight.w400,
                    //   //     fontFamily: fontFamily
                    //   // )
                    //   TextStyle(color: gray_color_1, fontSize: 12,fontWeight: FontWeight.w500),
                    // ),
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
                                launchMobileNo("tel:91"+obj.mobile_no.toString());
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
                                      "+91 ${obj.mobile_no}",
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
                        Text(
                          // obj.categoryname??"",
                          "Purpose",
                          style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w600),
                        ),
                        Text(
                          // obj.categoryname??"",
                          obj.staff_type?.type??"",
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 16,fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Divider(color: AppColors.BLACK,thickness: 1,),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          // obj.categoryname??"",
                          "Badge No",
                          style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w600),
                        ),
                        Text(
                          // obj.categoryname??"",
                          obj.staff_type?.id??"",
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 16,fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
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
                        Text(
                          // obj.categoryname??"",
                          formattedDate,
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 16,fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    // SizedBox(height: 10,),
                    // Divider(color: AppColors.BLACK,thickness: 1,),
                    SizedBox(height: 30,),
                    CustomButtons.WidgetButton(
                      width: Get.width,
                      height: 45.w,
                      radius: 8.w,
                      onTap: () {
                        Get.back();
                        // cnt_Visitor.OnTapSubmit();
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
            ),)
          // Padding(
          //   padding: const EdgeInsets.only(left: 5,right: 5),
          //   child: Card(
          //     clipBehavior: Clip.hardEdge,
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(cornarradius))
          //     ),
          //     child: Image.asset(obj.image!,height: 180,width:Get.width,fit: BoxFit.fill,),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget StaffsInListView() {
    return Container(
      padding: EdgeInsets.only(left: PADDING, right: PADDING, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //SizedBox(height: 10.w),
          // Text("Expected Visitor", style: TextStyles.textStyleDark16()),
          // SizedBox(height: 15.w),
          ListView.builder(
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return wd_staffListchildview(index);
            },
            itemCount: cnt_staff.arrstaffinlist.length,
          ),
        ],
      ),
    );
  }

  Widget StaffInListView() {
    return Obx(() {
      return FutureBuilder(
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return snapshot.data.length != 0
                ? StaffsInListView()
                : Container(
              width: Get.width,
              height: Get.height/2,
              alignment: Alignment.center,
              child: Text(
                // cnt_staff.isFaqsEmptyMsg.value,
                "No Data Found",
                style: TextStyle(
                    color: AppColors.BLACK,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
            );
          } else {
            return StaffShimmerEffect();
          }
        },
        future: cnt_staff.futurestaffinData.value,
      );
    });
  }

  Widget wd_staffInListchildview(index) {
    StaffModal obj = cnt_staff.arrstaffinlist[index];

    return Padding(
      padding: EdgeInsets.only(bottom: PADDING),
      child: InkWell(
        //onTap: () => cnt_Properties.GotoDetailpage(obj),
        onTap: () {
          OnClickHandler(obj);
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppColors.WHITE,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [boxShadow]),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  obj.image != null && obj.image?.url != null
                      ? SizedBox(
                      height: 70.h,
                      width: 70.w,
                      child: Center(
                          child: CircleAvatar(
                            child: CachedNetworkImage(
                              imageUrl: obj.image?.url ?? "",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                    // height: 100,
                                    // width: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      //borderRadius: BorderRadius.all(Radius.circular(10)),
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
                  // Image.asset(
                  //   PERSON_ICON,
                  //   height: 70.h,
                  //   width: 70.w,
                  // ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(obj.name ?? "",
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
                              //       if (obj.visitortype != null)
                              //       RichText(
                              //           text: TextSpan(
                              //               text: obj.visitortype?.type
                              //                   .toString() ??
                              //                   "",
                              //               style: TextStyles.textStyleLight12(
                              //                   Colors.grey),
                              //               children: [TextSpan(text: "")])),
                              //     ]),
                              SizedBox(
                                height: 5.w,
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: "",
                                      style: TextStyles.textStyleLight12(
                                          Colors.grey),
                                      children: [TextSpan(text: obj.staff_type?.type.toString() ?? "")])),
                              // Row(
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     mainAxisAlignment:
                              //     MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       if (obj.visitortype != null)
                              //       RichText(
                              //           text: TextSpan(
                              //               text: obj.visitortype?.type
                              //                   .toString() ??
                              //                   "",
                              //               style: TextStyles.textStyleLight12(
                              //                   Colors.grey),
                              //               children: [TextSpan(text: "")])),
                              //     ]),
                              SizedBox(
                                height: 5.w,
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: "Badge No: ",
                                      style: TextStyles.textStyleLight12(
                                          Colors.grey),
                                      children: [TextSpan(text: obj.staff_type?.id.toString() ?? "")])),
                              // SizedBox(
                              //   height: 5.w,
                              // ),
                              // RichText(
                              //     text: TextSpan(
                              //         text: "Badge No: ",
                              //         style: TextStyles.textStyleLight12(
                              //             Colors.grey),
                              //         children: [TextSpan(text: obj.flat_no ?? "")])),
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
                                                  "+91${obj.mobile_no}",
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
