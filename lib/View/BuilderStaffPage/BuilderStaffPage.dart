import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Config/Utils/Style.dart';
import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/Config/Utils/images.dart';
import 'package:avinashgatekeeper/Controller/BuilderStaffController/BuilderStaffController.dart';
import 'package:avinashgatekeeper/Modal/BuilderStaff/BuilderStaffModel.dart';
import 'package:avinashgatekeeper/Modal/VisitorLogModel/VisitorLogModel.dart';
import 'package:avinashgatekeeper/View/BuilderStaffPage/AddBuilderStaffPage/AddBuilderStaffPage.dart';
import 'package:avinashgatekeeper/View/VisitorLogPage/VisitorLogPage.dart';
import 'package:avinashgatekeeper/Widget/CustomDrawer.dart';
import 'package:avinashgatekeeper/Widget/RefreshIndicatorWidget.dart';
import 'package:avinashgatekeeper/Widget/ShimmerWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Modal/BuilderStaff/BuilderStaffCheckInOutData.dart';
import '../../Widget/CustomButton.dart';

class BuilderStaffPage extends StatefulWidget {
  // FilterModal? filterData = FilterModal.instance();
  // bool isFilterApply;
  // HomePage({this.filterData, this.isFilterApply = false});

  @override
  _BuilderStaffState createState() => _BuilderStaffState();
}

class _BuilderStaffState extends State<BuilderStaffPage> with WidgetsBindingObserver {
  BuilderStaffPageController cnt_builder = Get.put(BuilderStaffPageController());
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('kk:mm a').format(DateTime.now());
  ScrollController scrollController = ScrollController();
  // var currentPage = 0.0;

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

  // state variables                           <-- state
  final _myDuration = Duration(seconds: 1);
  var _myValue = Color(0xFF00BB00);
  final _myNewValue = Color(0xFF0000FF);

  //stopwatch declaration
  final _isHours = true;
  final StopWatchTimer stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    // onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
    onStopped: () {
      print('onStop');
    },
    onEnded: () {
      print('onEnded');
    },
  );

  @override
  void initState() {
    cnt_builder.LoadPage();
    // TODO: implement initState
    super.initState();
    cnt_builder.selected.value=0;
    cnt_builder.editingController.value!.text="";
    scrollController.addListener(() {
      cnt_builder.scrollUpdate(scrollController);
    });

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
    return Scaffold(
        floatingActionButton:
        FloatingActionButton(onPressed: (){
          showDialog(
            context: context,
            builder: (ctx) => CupertinoAlertDialog(
              title: const Text("Builder"),
              //content: const Text("You have raised a Alert Dialog Box"),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Get.back();
                    Get.to(AddBuilderStaffPage());
                    initState();
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(14),
                    child: const Text("Add New Builder Staff"),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                    Get.to(VisitorLogPage(title: "Builder Staff Log",))?.then((value) {
                      print("im coming back with valuee");
                      print(value.toString());
                      setState(() {
                        visitordata(value);
                      });
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(14),
                    child: const Text("Builder Staff Log"),
                  ),
                ),
              ],
            ),
          );
        },child: Icon(Icons.add),
            backgroundColor: Colors.blue),
        // SpeedDial(
        //
        //   icon: Icons.add,
        //   activeIcon: Icons.close,
        //   spacing: 3,
        //   openCloseDial: isDialOpen,
        //   childPadding: const EdgeInsets.all(5),
        //   spaceBetweenChildren: 4,
        //   buttonSize:
        //   buttonSize, // it's the SpeedDial size which defaults to 56 itself
        //   label: extend
        //       ? const Text("Open")
        //       : null, // The label of the main button.
        //   activeLabel: extend ? const Text("Close") : null,
        //   childrenButtonSize: childrenButtonSize,
        //   visible: visible,
        //   direction: speedDialDirection,
        //   switchLabelPosition: switchLabelPosition,
        //   closeManually: closeManually,
        //   renderOverlay: false,
        //   onOpen: () => debugPrint('OPENING DIAL'),
        //   onClose: () => debugPrint('DIAL CLOSED'),
        //   useRotationAnimation: useRAnimation,
        //   tooltip: 'Open Speed Dial',
        //   heroTag: 'speed-dial-hero-tag',
        //   // foregroundColor: Colors.black,
        //   // backgroundColor: Colors.white,
        //   // activeForegroundColor: Colors.red,
        //   // activeBackgroundColor: Colors.blue,
        //   elevation: 0.0,
        //   animationCurve: Curves.elasticInOut,
        //   isOpenOnStart: false,
        //   backgroundColor:AppColors.APP_THEME_COLOR,
        //   animationDuration: const Duration(milliseconds: 500),
        //   shape: customDialRoot
        //       ? const RoundedRectangleBorder()
        //       : const StadiumBorder(),
        //   // childMargin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        //   children: [
        //
        //     SpeedDialChild(
        //       labelStyle: TextStyle(color: AppColors.BLACK.withOpacity(0.4), fontWeight: FontWeight.bold),
        //       labelBackgroundColor: AppColors.WHITE,
        //       child: Padding(padding: EdgeInsets.all(15),child: Image.asset("assets/images/fab_icon.png",fit: BoxFit.cover)),
        //       backgroundColor: AppColors.YELLOW,
        //       foregroundColor: Colors.white,
        //       label: 'Builder Staff Log',
        //       onTap: () {
        //         Get.to(VisitorLogPage());
        //       },
        //     ),
        //
        //     SpeedDialChild(
        //       labelStyle: TextStyle(color: AppColors.BLACK.withOpacity(0.4), fontWeight: FontWeight.bold),
        //       labelBackgroundColor: AppColors.WHITE,
        //       child: Padding(padding: EdgeInsets.all(15),child: Image.asset("assets/images/fab_icon.png",fit: BoxFit.cover)),
        //       backgroundColor: Colors.redAccent,
        //       foregroundColor: Colors.white,
        //       label: 'Add New Builder Staff',
        //       onTap: () {
        //         Get.to(AddBuilderStaffPage());
        //       },
        //     ),
        //   ],
        // ),
        appBar: AppBar(toolbarHeight: 0, elevation: 0),
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        drawer: CustomDrawer(),
        backgroundColor: AppColors.WHITE,
        body: StatefulBuilder(builder: (BuildContext context,
            StateSetter setState){
          return Obx(() => CustomScrollView(
            physics: cnt_builder.IsScroll.isTrue ? BouncingScrollPhysics():NeverScrollableScrollPhysics(),
            slivers: [
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
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Image.asset(
                            APP_LOGO_NEW,
                            height: 80,
                            width: 150,
                            fit: BoxFit.contain,
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
                  toolbarHeight: 132.h,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.red,

                  flexibleSpace: Container(
                    decoration: BoxDecoration(color: AppColors.WHITE,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Material(
                          elevation: 5,
                          child: Row(
                              children: [
                                Expanded(child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        cnt_builder.IsScroll.value=false;
                                        cnt_builder.selected.value = 0;
                                        cnt_builder.clearvalue();
                                        FocusScope.of(context).unfocus();
                                        cnt_builder.RetrieveBuilderStaffDataNew();
                                      });
                                    },
                                    child:Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5.0),
                                      child: AnimatedContainer(
                                        curve: Curves.fastOutSlowIn,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(color: cnt_builder.selected.value==0?Colors.black:Colors.transparent,width: cnt_builder.selected.value==0?1:0),
                                          // color: _myValue,
                                        ),

                                        duration: Duration(milliseconds: 200),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Container(
                                            padding: EdgeInsets.all(5.w),
                                            height: 30.h,
                                            decoration: BoxDecoration(
                                                color: cnt_builder.selected.value==0?APP_THEME_COLOR:AppColors.SHIMMER_BASE,
                                                borderRadius: BorderRadius.circular(12)
                                            ),
                                            child: Image.asset(
                                                METER_ICON,
                                                height: 20.h,
                                                width: 20.w,
                                                color: cnt_builder.selected.value==0?AppColors.WHITE:AppColors.BLACK
                                            ),),
                                        ),
                                      ),
                                    ))),
                                Expanded(child: GestureDetector(
                                    onTap: (){
                                      setState((){
                                        //cnt_builder.IsScroll.value=false;
                                        cnt_builder.selected.value=1;
                                        //cnt_builder.clearvalue();
                                        FocusScope.of(context).unfocus();
                                        cnt_builder.RetrieveBuilderStaffCheckInDataNew();
                                      });
                                    },
                                    child:Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5.0),
                                      child: AnimatedContainer(
                                        curve: Curves.fastOutSlowIn,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(color: cnt_builder.selected.value==1?Colors.black:Colors.transparent,width: cnt_builder.selected.value==1?1:0),
                                          // color: _myValue,
                                        ),
                                        duration: Duration(milliseconds: 200),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Container(
                                            padding: EdgeInsets.all(5.w),
                                            height: 30.h,
                                            decoration: BoxDecoration(
                                                color: cnt_builder.selected.value==1?APP_THEME_COLOR:AppColors.SHIMMER_BASE,
                                                borderRadius: BorderRadius.circular(12)
                                            ),
                                            alignment: Alignment.center,
                                            child:Text("IN",
                                                style: TextStyles.textStyleLight14(cnt_builder.selected.value==1?AppColors.WHITE:AppColors.BLACK)),),
                                        ),
                                      ),
                                    ))),
                                Expanded(child: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        cnt_builder.IsScroll.value=false;
                                        cnt_builder.selected.value =2;
                                        //cnt_builder.clearvalue();
                                        FocusScope.of(context).unfocus();
                                        cnt_builder.RetrieveBuilderStaffCheckOutDataNew();
                                      });
                                    },
                                    child:Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5.0),
                                      child: AnimatedContainer(
                                        curve: Curves.fastOutSlowIn,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(color: cnt_builder.selected.value==2?Colors.black:Colors.transparent,width: cnt_builder.selected.value==2?1:0),
                                          // color: _myValue,
                                        ),
                                        duration: Duration(milliseconds: 200),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Container(
                                              height: 30.h,
                                              padding: EdgeInsets.all(5.w),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: cnt_builder.selected.value==2?APP_THEME_COLOR:AppColors.SHIMMER_BASE,
                                                  borderRadius: BorderRadius.circular(12)
                                              ),
                                              child: Text("OUT",
                                                  style: TextStyles.textStyleLight14(cnt_builder.selected.value==2?AppColors.WHITE:AppColors.BLACK))),
                                        ),
                                      ),
                                    )))

                              ]),
                        ),
                        Container(
                            padding: EdgeInsets.all(10.w),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Text("Builder Staff",
                                  //     style: TextStyles.textStyleDark16()),
                                  SizedBox(height: 10.w),
                                  Obx(() =>   TextFormField(
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
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.RED,
                                            )),
                                        hintText: "Search builder staff",
                                        labelStyle: TextStyle(
                                            color: AppColors.BLACK, fontSize: 13.sp),
                                        suffixIcon:cnt_builder.fcn_node.hasFocus? InkWell(
                                            onTap: (){
                                              FocusScope.of(context).unfocus();
                                              cnt_builder.fcn_node.unfocus();
                                              cnt_builder.editingController.value!.text="";
                                              cnt_builder.onSearchTextChanged(cnt_builder.editingController.value!.text);
                                              setState(() {
                                              });

                                            },
                                            child: Icon(Icons.cancel,color: Colors.black,)):
                                        InkWell(
                                            onTap: (){
                                              FocusScope.of(context).requestFocus(cnt_builder.fcn_node);
                                              cnt_builder.fcn_node.requestFocus();
                                            },
                                            child: Icon(Icons.search,color: Colors.black,))
                                    ),
                                    controller: cnt_builder.editingController.value,
                                    focusNode: cnt_builder.fcn_node,
                                    onChanged: (value) {
                                      cnt_builder.onSearchTextChanged(cnt_builder.editingController.value!.text);
                                      setState(() {
                                      });
                                    },
                                    onFieldSubmitted: (value) {
                                      setState(() {
                                        cnt_builder.onSearchTextChanged(cnt_builder.editingController.value!.text);
                                        // get_member_list(_textsearch.text);
                                      });
                                      FocusScope.of(context).unfocus();
                                    },
                                    onEditingComplete: (){
                                      setState(() {
                                        cnt_builder.onSearchTextChanged(
                                            cnt_builder.editingController.value!.text);
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
                  actions: []),
              SliverList(delegate: SliverChildListDelegate([
                Stack(
                  children: [
                    RefreshIndicatorWidget(
                      onRefresh: cnt_builder.refreshData,
                      child: Container(
                        width: Get.width,
                        height: Get.height,
                        //padding: EdgeInsets.only(bottom: BOTTOM_HEIGHT.w),
                        child: NotificationListener<
                            OverscrollIndicatorNotification>(
                          onNotification: (overscroll) {
                            overscroll.disallowGlow();
                            return true;
                          },
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              children: [
                                // SizedBox(
                                //   height: 60.h,
                                // ),
                                if(cnt_builder.selected==0)BuilderStaffListView(),
                                if(cnt_builder.selected==1)BUilderCheckInView(),
                                if(cnt_builder.selected==2)BuilderCheckOutView(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ]))
            ],
          ));}
        )
        // StatefulBuilder(builder: (BuildContext context,
        //     StateSetter setState /*You can rename this!*/) {
        //   return NestedScrollView(
        //       headerSliverBuilder:
        //           (BuildContext context, bool innerBoxIsScrolled) {
        //         return <Widget>[
        //
        //         ];
        //       },
        //       body: SafeArea(
        //           bottom: bottomSafeArea,
        //           child: Stack(
        //             children: [
        //               RefreshIndicatorWidget(
        //                 onRefresh: cnt_builder.refreshData,
        //                 child: Container(
        //                   width: Get.width,
        //                   height: Get.height,
        //                   //padding: EdgeInsets.only(bottom: BOTTOM_HEIGHT.w),
        //                   child: NotificationListener<
        //                       OverscrollIndicatorNotification>(
        //                     onNotification: (overscroll) {
        //                       overscroll.disallowGlow();
        //                       return true;
        //                     },
        //                     child: SingleChildScrollView(
        //                       controller: scrollController,
        //                       child: Column(
        //                         children: [
        //                           // SizedBox(
        //                           //   height: 60.h,
        //                           // ),
        //                           if(cnt_builder.selected==0)BuilderStaffListView(),
        //                           if(cnt_builder.selected==1)BUilderCheckInView(),
        //                           if(cnt_builder.selected==2)BuilderCheckOutView(),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           )));
        //   //margin: EdgeInsets.symmetric(horizontal: 20),
        // }));
    );}



  Widget LogFilter(String title){
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                child: Text(
                  title ?? "Builder Staff Log",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontFamily: fontFamily,
                  ),
                ),
              ),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                child: GestureDetector(
                  onTap: () {
                    cnt_builder.obj_builder = null;
                    cnt_builder.futureBuilderDataNew.value = cnt_builder.RetrieveBuilderStaffDataNew();
                  },
                  child: Text(
                    "clear",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontFamily: fontFamily,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: Wrap(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(VisitorLogPage(
                      vistorModel: cnt_builder.obj_builder,
                      title: "Builder Staff Log",
                    ))?.then((value) {
                      visitordata(value);
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 5, vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border:
                        Border.all(color: Colors.grey, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "start date: ",
                          ),
                          Text(
                            cnt_builder.obj_builder?.StartDate ?? "",
                            style: TextStyles.textStyleDark14(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(VisitorLogPage(
                      title: "Builder Staff Log",
                      vistorModel: cnt_builder.obj_builder,
                    ))?.then((value) {
                      visitordata(value);
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 5, vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border:
                        Border.all(color: Colors.grey, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "end date: ",
                          ),
                          Text(
                            cnt_builder.obj_builder?.EndDate ?? "",
                            style: TextStyles.textStyleDark14(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(VisitorLogPage(
                      title: "Builder Staff Log",
                      vistorModel: cnt_builder.obj_builder,
                    ))?.then((value) {
                      print("im coming back with valuee");
                      print(value.toString());
                      visitordata(value);
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 5, vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border:
                        Border.all(color: Colors.grey, width: 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "project name: ",
                          ),
                          Text(
                            cnt_builder.obj_builder?.projectmodel?.name ??
                                "",
                            style: TextStyles.textStyleDark14(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }

  Widget BuilderStaffListView() {
    return Obx(() {
      return FutureBuilder(
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return snapshot.data.length != 0 && cnt_builder.arrBuilderStaffList.length>0
                ? BuilderStaffsListView()
                : Container(
              width: Get.width,
              height: 500,
              alignment: Alignment.center,
              child: Text("No Data Found", style: TextStyle(color: AppColors.BLACK, fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            );
          } else {
            return StaffShimmerEffect();
          }
        },
        future: cnt_builder.futurestaffDataNew.value,
      );
    });
  }

  Widget BuilderStaffsListView() {
    return Container(
      padding: EdgeInsets.only(left: PADDING, right: PADDING, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (cnt_builder.obj_builder != null)
            LogFilter("Builder Log"),
          if (cnt_builder.obj_builder != null)
            SizedBox(
              height: 25,
            ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return wd_builderstaffListchildview(index);
            },
            itemCount: cnt_builder.arrBuilderStaffList.length,
          ),
          SizedBox(
            height: 350.h,
          ),
        ],
      ),
    );
  }


  visitordata(dynamic value) {
    if (value != null && value != "") {
      VistorModel obj = value;
      cnt_builder.obj_builder = null;
      if (obj.StartDate != null &&
          obj.StartDate!.isNotEmpty &&
          obj.EndDate != null &&
          obj.EndDate != "" &&
          obj.projectmodel != null) {
        cnt_builder.obj_builder = value;
        cnt_builder.filtrationupdatae();
        setState(() {});
      }
    }
  }

  Widget wd_builderstaffListchildview(index) {
    BuilderStaffModalNew obj = cnt_builder.arrBuilderStaffList[index];
    return Padding(
      padding: EdgeInsets.only(bottom: PADDING),
      child: InkWell(
        // onTap: () => cnt_Properties.GotoDetailpage(obj),
        onTap: () {
       OnClickHandler(obj);
        },
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
                                  child: Text("Hello"),
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
                          ),),),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(obj.personname ?? "",
                            style: TextStyles.textStyleDark16()),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5.w,
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: "",
                                      style: TextStyles.textStyleLight12(
                                          Colors.grey),
                                      children: [TextSpan(text: obj.designation!.first.name.toString() ?? "")])),

                              SizedBox(
                                height: 5.w,
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: "Badge No: ",
                                      style: TextStyles.textStyleLight12(
                                          AppColors.BLACK.withOpacity(0.5)),
                                      children: [TextSpan(text: obj.number.toString() ?? "")])),
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
                                        onTap: () {
                                          launchMobileNo("tel:"+obj.contact.toString());
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
                                                "+91 ${obj.contact}",
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

  Widget BuilderStaffInListView() {
    return Obx(() {
      return FutureBuilder(
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return snapshot.data.length != 0
                ? BuilderStaffsInListView()
                : Container(
              width: Get.width,
              height: 100,
              alignment: Alignment.center,
              child: Text(
                // cnt_builder.isFaqsEmptyMsg.value,
                "NO Data Found",
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
        future: cnt_builder.futurestaffinData.value,
      );
    });
  }

  Widget BuilderStaffsInListView() {
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
              return wd_builderstaffinListchildview(index);
            },
            itemCount: cnt_builder.arrbuilderstaffinlist.length,
          ),
          SizedBox(
            height: 60.h,
          ),
        ],
      ),
    );
  }


  Widget wd_builderstaffinListchildview(index) {
    BuilderStaffModal obj = cnt_builder.arrbuilderstaffinlist[index];
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
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (obj.visitortype != null)
                                      RichText(
                                          text: TextSpan(
                                              text: obj.visitortype?.type
                                                  .toString() ??
                                                  "",
                                              style: TextStyles.textStyleLight12(
                                                  Colors.grey),
                                              children: [TextSpan(text: "")])),
                                  ]),
                              SizedBox(
                                height: 5.w,
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: "Badge No: ",
                                      style: TextStyles.textStyleLight12(
                                          Colors.grey),
                                      children: [TextSpan(text: obj.flat_no ?? "")])),
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

  OnClickHandler(BuilderStaffModalNew obj){
    BuilderStaffPageController controller = Get.put(BuilderStaffPageController());
    Get.bottomSheet(BuilderStaffDetailsBottomsheet(obj),isScrollControlled: true);
  }

  BuilderStaffCheckOut(BuilderStaffCheckInOutData obj){
    // BuilderStaffPageController controller = Get.put(BuilderStaffPageController());
    Get.bottomSheet(BuilderStaffChekOutDetailsBottomsheet(obj),isScrollControlled: true);
  }

  Widget BuilderStaffDetailsBottomsheet(BuilderStaffModalNew obj){
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
              decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),),
              height: (Get.height * 0.55),
              padding: EdgeInsets.only(left: 20,right: 20,),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    obj.image != null && obj.image != null
                        ? SizedBox(
                        height: 70.h,
                        width: 70.w,
                        child: Center(
                            child: CircleAvatar(
                              child: CachedNetworkImage(
                                imageUrl: obj.image ?? "",
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
                      obj.personname??"",
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
                                launchMobileNo("tel:91"+obj.contact.toString());
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
                                     "+91 ${obj.contact}",
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
                    Text("Role", style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w600),),
                    Text(obj.designation?.first.name??"", style: TextStyle(color: Colors.grey.shade600, fontSize: 16,fontWeight: FontWeight.w600),),
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
                          obj.number.toString() ??"",
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
                        Text(DateFormat('hh:mm a').format(DateTime.now()), style: TextStyle(color: Colors.grey.shade600, fontSize: 16,fontWeight: FontWeight.w600),
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
                        cnt_builder.BUILDER_CHECKIN_CHECKOUT(type: "in",visitorid: obj.id.toString());
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
        ],
      ),
    );
  }

  Widget BuilderStaffChekOutDetailsBottomsheet(BuilderStaffCheckInOutData obj){
    stopWatchTimer.clearPresetTime();
    stopWatchTimer.onResetTimer();
    stopWatchTimer.setPresetTime(mSec: cnt_builder.dateandtimechanger(obj.checkinDateTime.toString()  ?? DateTime.now().toString()));
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
              decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),),
              height: (Get.height * 0.6),
              padding: EdgeInsets.only(left: 20,right: 20,),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    obj.profile != null && obj.profile != null
                        ? SizedBox(
                        height: 70.h,
                        width: 70.w,
                        child: Center(
                            child: CircleAvatar(
                              child: CachedNetworkImage(
                                imageUrl: obj.profile ?? "",
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
                    SizedBox(height: 10,),
                    Text(obj.personname??"", style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.w700),),

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
                                launchMobileNo("tel:91"+obj.contact.toString());
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
                                     "${obj.contact}".trim(),
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
                    Text("Role", style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w600),),
                    Text(obj.role ??"", style: TextStyle(color: Colors.grey.shade600, fontSize: 16,fontWeight: FontWeight.w600),),
                  ],
                ),
                    SizedBox(height: 10),
                    Divider(color: AppColors.BLACK,thickness: 1),
                    SizedBox(height: 10),
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
                          obj.badgeno.toString() ??"",
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
                        Text(obj.checkinTime ?? "", style: TextStyle(color: Colors.grey.shade600, fontSize: 16,fontWeight: FontWeight.w600),
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
                        cnt_builder.BUILDER_CHECKIN_CHECKOUT(type: "out",visitorid: obj.builderstatffId.toString());
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



  //<editor-fold desc = "CheckInWidgets">

  Widget BUilderCheckInView() {
    return Obx(() {
      return FutureBuilder(
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return (snapshot.data.length != 0 || cnt_builder.arrBuilderStaffCheckInList.length>0)
                ? BuilderCheckInListView()
                : Container(
              width: Get.width,
              height: 500,
              alignment: Alignment.center,
              child: Text(
                cnt_builder.noDataFound.isFalse ? cnt_builder.isFaqsEmptyMsg.value : "No Data Found",
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
        future: cnt_builder.futurestaffCheckInDataNew.value,
      );
    });
  }

  Widget BuilderCheckInListView() {
    return Container(
      padding: EdgeInsets.only(left: PADDING, right: PADDING, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (cnt_builder.obj_builder != null)
            LogFilter("Builder Checkin Log"),
          if (cnt_builder.obj_builder != null)
            SizedBox(
              height: 25,
            ),
          ListView.builder(
            scrollDirection: Axis.vertical,
             physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return BuilderCheckInListchildview(index);
            },
            itemCount: cnt_builder.arrBuilderStaffCheckInList.length,
          ),
        ],
      ),
    );
  }

  Widget BuilderCheckInListchildview(int index) {
    BuilderStaffCheckInOutData obj = cnt_builder.arrBuilderStaffCheckInList[index];
   return Padding(
      padding: EdgeInsets.only(bottom: PADDING),
      child: InkWell(
        onTap: () {
          BuilderStaffCheckOut(obj);
        },
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.RED_LIGHT,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [boxShadow,boxShadowback]),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    obj.profile != null && obj.profile != ""
                        ? SizedBox(
                        height: 70.h,
                        width: 70.w,
                        child: Center(
                            child: CircleAvatar(
                              child: CachedNetworkImage(
                                imageUrl: obj.profile ?? "",
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
                              radius: 100,
                            )))
                        : SizedBox(
                        height: 70.h,
                        width: 70.w,
                        child: Center(
                            child: CircleAvatar(
                              backgroundImage: AssetImage(PERSON_ICON),
                              radius: 100,
                            ))
                    ),

                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(obj.personname ?? "",
                              style: TextStyles.textStyleDark16()),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5.w,
                                ),
                                RichText(
                                    text: TextSpan(
                                        text: "",
                                        style: TextStyles.textStyleLight12(AppColors.BLACK.withOpacity(0.5)),
                                        children: [TextSpan(text: obj.role ?? "")])),

                                SizedBox(
                                  height: 5.w,
                                ),
                                RichText(
                                    text: TextSpan(
                                        text: "Badge No: ",
                                        style: TextStyles.textStyleLight12(
                                            AppColors.BLACK.withOpacity(0.5)),
                                        children: [TextSpan(text: obj.badgeno.toString() ?? "")])),
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
                                          onTap: () {
                                            launchMobileNo("tel:"+obj.contact.toString());
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
                                                  "${obj.contact}".trim(),
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
              ),
              Container(
                  height: 40,
                  color: AppColors.RED_BOTTOM,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child:

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("CheckIn"),
                        RichText(
                            text: TextSpan(
                                text: obj.checkinDateTime,
                                style: TextStyles.textStyleDark14(),
                              )),

                      ],
                    ), )
              )
            ],
          ),
        ),
      ),
    );
  }

  //</editor-fold>

  //<editor-fold desc = "CheckOutWidgets">

  Widget BuilderCheckOutView() {
    return Obx(() {
      return FutureBuilder(
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return (snapshot.data.length != 0 || cnt_builder.arrBuilderStaffCheckOutList.length>0)
                ? BuilderCheckOutListView()
                : Container(
              width: Get.width,
              height: 500,
              alignment: Alignment.center,
              child: Text(
                cnt_builder.noDataFound.isFalse ? cnt_builder.isFaqsEmptyMsg.value : "No Data Found",
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
        future: cnt_builder.futurestaffCheckOutDataNew.value,
      );
    });
  }

  Widget BuilderCheckOutListView() {
    return Container(
      padding: EdgeInsets.only(left: PADDING, right: PADDING, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (cnt_builder.obj_builder != null)
            LogFilter("Builder Checkout Log"),
          if (cnt_builder.obj_builder != null)
            SizedBox(
              height: 25,
            ),
          ListView.builder(
            scrollDirection: Axis.vertical,
             physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return BuilderCheckOutListchildview(index);
            },
            itemCount: cnt_builder.arrBuilderStaffCheckOutList.length,
          ),
          SizedBox(
            height: 350.h,
          ),
        ],
      ),
    );
  }

  Widget BuilderCheckOutListchildview(int index) {
    BuilderStaffCheckInOutData obj = cnt_builder.arrBuilderStaffCheckOutList[index];
    return Padding(
      padding: EdgeInsets.only(bottom: PADDING),
      child: InkWell(
        onTap: () {
          // OnClickHandler(obj);
        },
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.WHITE,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [boxShadow,boxShadowback]),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    obj.profile != null && obj.profile != null
                        ? SizedBox(
                        height: 70.h,
                        width: 70.w,
                        child: Center(
                            child: CircleAvatar(
                              child: CachedNetworkImage(
                                imageUrl: obj.profile ?? "",
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

                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(obj.personname ?? "",
                              style: TextStyles.textStyleDark16()),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5.w,
                                ),
                                RichText(
                                    text: TextSpan(
                                        text: "",
                                        style: TextStyles.textStyleLight12(
                                            Colors.grey),
                                        children: [TextSpan(text: obj.role ?? "")])),


                                SizedBox(
                                  height: 5.w,
                                ),
                                RichText(
                                    text: TextSpan(
                                        text: "Badge No: ",
                                        style: TextStyles.textStyleLight12(
                                            Colors.grey),
                                        children: [TextSpan(text: obj.badgeno.toString() ?? "")])),
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
                                          onTap: () {
                                            launchMobileNo("tel:91"+obj.contact.toString());
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
                                                  "${obj.contact}".trim(),
                                                  style: TextStyles
                                                      .textStyleMedium14(
                                                      AppColors.BLACK),
                                                ),
                                              ),
                                            ),
                                          )),
                                      Text(
                                        "${obj.checkoutDate ?? ""}",
                                        style: TextStyles
                                            .textStyleMedium14(
                                            AppColors.BLACK),
                                      ),
                                    ])
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(

                  color: AppColors.GREEN.withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child:
                    Row(
                      children: [
                        Container(
                          width: Get.width*0.2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("CheckIn",maxLines: 1,style: TextStyles.textStyleLight10,),
                              Text(obj.checkinTime.toString(),maxLines: 1,style: TextStyles.textStyleDark12(),),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Row(
                            children: [
                              Icon(Icons.circle_outlined,size: 14,),
                              Flexible(child: Container(width: Get.width, child: Divider(color: AppColors.APP_THEME_COLOR,))),
                              Icon(Icons.circle_outlined,size: 14,),
                            ],
                          ),
                        ),
                        Container(
                          width: Get.width*0.25,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Total Time",maxLines: 1,style: TextStyles.textStyleLight10,),
                              Text(obj.totaldurations.toString(),maxLines: 1,style: TextStyles.textStyleDark12(),),

                            ],
                          ),
                        ),
                        Flexible(
                          child: Row(
                            children: [
                              Icon(Icons.circle_outlined,size: 14,),
                              Flexible(child: Container(width: Get.width, child: Divider(color: AppColors.APP_THEME_COLOR,))),
                              Icon(Icons.circle_outlined,size: 14,),
                            ],
                          ),
                        ),
                        Container(
                          width: Get.width*0.2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("CheckOut",maxLines: 1,style: TextStyles.textStyleLight10,),
                              Text(obj.checkoutTime.toString(),maxLines: 1,style: TextStyles.textStyleDark12(),),
                            ],
                          ),
                        ),
                      ],
                    ),

                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  //</editor-fold>

  //<editor-fold desc = "ShimmerEffect">
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
    //</editor-fold >

}
