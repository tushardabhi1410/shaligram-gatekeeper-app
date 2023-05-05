import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Config/Utils/Style.dart';
import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/Config/Utils/images.dart';
import 'package:avinashgatekeeper/Controller/HomeController/HomePageController.dart';
import 'package:avinashgatekeeper/Controller/VisitorRegistrationPageController/VisitorRegistrationPageController.dart';
import 'package:avinashgatekeeper/Modal/Visitor/VisitorModel.dart';
import 'package:avinashgatekeeper/View/VisitorLogPage/VisitorLogPage.dart';
import 'package:avinashgatekeeper/View/VisitorPage/VisitorPage.dart';
import 'package:avinashgatekeeper/Widget/CustomDrawer.dart';
import 'package:avinashgatekeeper/Widget/RefreshIndicatorWidget.dart';
import 'package:avinashgatekeeper/Widget/ShimmerWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import '../../Config/Helper/HextoColor.dart';
import '../../Modal/VisitorLogModel/VisitorLogModel.dart';

class HomePage extends StatefulWidget {
  // FilterModal? filterData = FilterModal.instance();
  // bool isFilterApply;
  // HomePage({this.filterData, this.isFilterApply = false});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  VisitorRegistrationPageController cnt_Visitor =
      Get.put(VisitorRegistrationPageController());
  HomePageController cnt_Home = Get.put(HomePageController());
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController scrollController = ScrollController();

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

  @override
  void initState() {
    cnt_Home.selected.value = 0;
    cnt_Home.stopWatchTimer.clearPresetTime();
    cnt_Home.stopWatchTimer.onResetTimer();
    cnt_Home.LoadPage();
    scrollController.addListener(() {
      cnt_Home.scrollUpdate(scrollController);
    });
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
      floatingActionButton:
      // SpeedDial(
      //   icon: Icons.add,
      //   activeIcon: Icons.close,
      //   spacing: 3,
      //   openCloseDial: isDialOpen,
      //   childPadding: const EdgeInsets.all(5),
      //   spaceBetweenChildren: 4,
      //   buttonSize: buttonSize,
      //   // it's the SpeedDial size which defaults to 56 itself
      //   label: extend ? const Text("Open") : null,
      //   // The label of the main button.
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
      //   elevation: 0.0,
      //   animationCurve: Curves.elasticInOut,
      //   isOpenOnStart: false,
      //   backgroundColor: AppColors.APP_THEME_COLOR,
      //   animationDuration: const Duration(milliseconds: 500),
      //   shape: customDialRoot
      //       ? const RoundedRectangleBorder()
      //       : const StadiumBorder(),
      //   children: [
      //     SpeedDialChild(
      //       labelStyle: TextStyle(
      //           color: AppColors.BLACK.withOpacity(0.4),
      //           fontWeight: FontWeight.bold),
      //       labelBackgroundColor: AppColors.WHITE,
      //       child: Padding(
      //           padding: EdgeInsets.all(15),
      //           child: Image.asset("assets/images/fab_icon.png",
      //               fit: BoxFit.cover)),
      //       backgroundColor: Colors.green,
      //       foregroundColor: Colors.white,
      //       label: 'Visitor Check In',
      //       onTap: () {
      //         Get.to(VisitorPage(
      //           title: "Visitor",
      //           unittypeid: cnt_Visitor.txt_unit_number.text ?? "",
      //           SelectedRetiriveList:
      //               cnt_Visitor.arrselectedpropertylistretriver.value,
      //         ));
      //       },
      //     ),
      //     SpeedDialChild(
      //       labelStyle: TextStyle(
      //           color: AppColors.BLACK.withOpacity(0.4),
      //           fontWeight: FontWeight.bold),
      //       labelBackgroundColor: AppColors.WHITE,
      //       child: Padding(
      //           padding: EdgeInsets.all(15),
      //           child: Image.asset("assets/images/fab_icon.png",
      //               fit: BoxFit.cover)),
      //       backgroundColor: Colors.redAccent,
      //       foregroundColor: Colors.white,
      //       label: 'Vendor Check In',
      //       onTap: () {
      //         Get.to(VisitorPage(
      //           title: "Vendor",
      //           unittypeid: "",
      //         ));
      //       },
      //     ),
      //     SpeedDialChild(
      //       labelStyle: TextStyle(
      //           color: AppColors.BLACK.withOpacity(0.4),
      //           fontWeight: FontWeight.bold),
      //       labelBackgroundColor: AppColors.WHITE,
      //       child: Padding(
      //           padding: EdgeInsets.all(15),
      //           child: Image.asset("assets/images/fab_icon.png",
      //               fit: BoxFit.cover)),
      //       backgroundColor: AppColors.YELLOW,
      //       foregroundColor: Colors.white,
      //       label: 'Visitor Log',
      //       onTap: () {
      //         Get.to(VisitorLogPage())?.then((value) {
      //           visitordata(value);
      //         });
      //       },
      //     ),
      //   ],
      // ),
      FloatingActionButton(onPressed: (){
        print("Open Dialog");
        showDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
            title: const Text("Visitor"),
            //content: const Text("You have raised a Alert Dialog Box"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.to(VisitorLogPage())?.then((value) {
                    visitordata(value);
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(14),
                  child: const Text("Visitor Log"),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.to(VisitorPage(
                                title: "Visitor",
                                unittypeid: cnt_Visitor.txt_unit_number.text ?? "",
                                SelectedRetiriveList:
                                    cnt_Visitor.arrselectedpropertylistretriver.value,
                              ));
                },
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(14),
                  child: const Text("Visitor Check In"),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.to(VisitorPage(
                                title: "Vendor",
                                unittypeid: "",
                              ));                },
                child: SingleChildScrollView(
                   physics: NeverScrollableScrollPhysics(),
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(14),
                    child: const Text("Vendor Check In"),
                  ),
                ),
              ),
            ],
          ),
        );
      },child: Icon(Icons.add),
      backgroundColor: Colors.blue),
      appBar: AppBar(toolbarHeight: 0, elevation: 0),
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      //endDrawer: CustomDrawer(),
      drawer: CustomDrawer(),
      backgroundColor: AppColors.WHITE,
      body: StatefulBuilder(builder: (BuildContext context,
          StateSetter setState /*You can rename this!*/) {
        return Obx(() => CustomScrollView(
          physics: cnt_Home. IsScroll.isTrue ? BouncingScrollPhysics(): NeverScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
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
                      padding: EdgeInsets.all(0.w),
                      child: Image.asset(
                        APP_LOGO_NEW,
                          height: 150,
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
                primary: false,
                toolbarHeight: 132.h,
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                flexibleSpace: Container(
                  decoration: BoxDecoration(color: AppColors.WHITE),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Material(
                        elevation: 5,
                        child: Row(children: [
                          Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    setState((){
                                      // initState();
                                    });
                                    cnt_Home.IsScroll.value=false;
                                    cnt_Home.selected.value = 0;
                                    cnt_Home.selected.refresh();
                                    cnt_Home.fcn_node.unfocus();
                                    FocusScope.of(context).unfocus();
                                    cnt_Home.clearvalue();
                                    cnt_Home.editingController.value!
                                        .clear();
                                    cnt_Home.RetrieveVisitorsData();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 5.0),
                                    child: AnimatedContainer(
                                      curve: Curves.fastOutSlowIn,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(12),
                                        border: Border.all(
                                            color:
                                            cnt_Home.selected.value == 0
                                                ? Colors.black
                                                : Colors.transparent,
                                            width:
                                            cnt_Home.selected.value == 0
                                                ? 1
                                                : 0),
                                        // color: _myValue,
                                      ),
                                      duration: Duration(milliseconds: 200),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Container(
                                          padding: EdgeInsets.all(5.w),
                                          height: 30.h,
                                          decoration: BoxDecoration(
                                              color: cnt_Home
                                                  .selected.value ==
                                                  0
                                                  ? APP_THEME_COLOR
                                                  : AppColors.SHIMMER_BASE,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  12)),
                                          child: Image.asset(METER_ICON,
                                              height: 20.h,
                                              width: 20.w,
                                              color:
                                              cnt_Home.selected.value ==
                                                  0
                                                  ? AppColors.WHITE
                                                  : AppColors.BLACK),
                                        ),
                                      ),
                                    ),
                                  ))),
                          Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    cnt_Home.IsScroll.value=false;
                                    // cnt_Home.obj_visitor = null;
                                    cnt_Home.selected.value = 1;
                                    cnt_Home.selected.refresh();
                                    cnt_Home.fcn_node.unfocus();
                                    FocusScope.of(context).unfocus();
                                    cnt_Home.editingController.value!.clear();
                                    // cnt_Home.clearvalue();
                                    cnt_Home.RetrieveVisitorsCheckInData();

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 5.0),
                                    child: AnimatedContainer(
                                      curve: Curves.fastOutSlowIn,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(12),
                                        border: Border.all(
                                            color:
                                            cnt_Home.selected.value == 1
                                                ? Colors.black
                                                : Colors.transparent,
                                            width:
                                            cnt_Home.selected.value == 1
                                                ? 1
                                                : 0),
                                        // color: _myValue,
                                      ),
                                      duration: Duration(milliseconds: 200),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Container(
                                          padding: EdgeInsets.all(5.w),
                                          height: 30.h,
                                          decoration: BoxDecoration(
                                              color: cnt_Home
                                                  .selected.value ==
                                                  1
                                                  ? APP_THEME_COLOR
                                                  : AppColors.SHIMMER_BASE,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  12)),
                                          alignment: Alignment.center,
                                          child: Text("CHECK IN",
                                              style: TextStyles
                                                  .textStyleLight14(cnt_Home
                                                  .selected
                                                  .value ==
                                                  1
                                                  ? AppColors.WHITE
                                                  : AppColors.BLACK)),
                                        ),
                                      ),
                                    ),
                                  ))),
                          Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    cnt_Home.IsScroll.value=false;
                                    //cnt_Home.obj_visitor = null;
                                    cnt_Home.selected.value = 2;
                                    cnt_Home.selected.refresh();
                                    cnt_Home.fcn_node.unfocus();
                                    cnt_Home.editingController.value!
                                        .clear();
                                    //cnt_Home.clearvalue();
                                    cnt_Home.RetrieveVisitorsCheckOutData();
                                    FocusScope.of(context).unfocus();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 5.0),
                                    child: AnimatedContainer(
                                      curve: Curves.fastOutSlowIn,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(12),
                                        border: Border.all(
                                            color:
                                            cnt_Home.selected.value == 2
                                                ? Colors.black
                                                : Colors.transparent,
                                            width:
                                            cnt_Home.selected.value == 2
                                                ? 1
                                                : 0),
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
                                                color: cnt_Home.selected
                                                    .value ==
                                                    2
                                                    ? APP_THEME_COLOR
                                                    : AppColors
                                                    .SHIMMER_BASE,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    12)),
                                            child: Text("CHECK OUT",
                                                style: TextStyles
                                                    .textStyleLight14(cnt_Home
                                                    .selected
                                                    .value ==
                                                    2
                                                    ? AppColors.WHITE
                                                    : AppColors
                                                    .BLACK))),
                                      ),
                                    ),
                                  ))),
                        ]),
                      )),
                      Container(
                          padding: EdgeInsets.all(10.w),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Text("Visitor",
                                //     style: TextStyles.textStyleDark16()),
                                SizedBox(height: 10.w),
                                Obx(() => TextFormField(
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  cursorColor: AppColors.BLACK,
                                  focusNode: cnt_Home.fcn_node,
                                  controller:
                                  cnt_Home.editingController.value,
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
                                      hintText: "Search your visitors",
                                      labelStyle: TextStyle(
                                          color: AppColors.BLACK,
                                          fontSize: 13.sp),
                                      // suffixIcon: Image.asset(
                                      //   BARCODE_ICON,
                                      //   fit: BoxFit.cover,
                                      // ),
                                      suffixIcon: cnt_Home.fcn_node.hasFocus
                                          ? InkWell(
                                          onTap: () {
                                            FocusScope.of(context)
                                                .unfocus();
                                            cnt_Home.fcn_node.unfocus();
                                            cnt_Home.editingController
                                                .value!.text = "";
                                            cnt_Home.onSearchTextChanged(
                                                cnt_Home
                                                    .editingController
                                                    .value!
                                                    .text);
                                            setState(() {});
                                          },
                                          child: Icon(
                                            Icons.cancel,
                                            color: Colors.black,
                                          ))
                                          : InkWell(
                                          onTap: () {
                                            FocusScope.of(context)
                                                .requestFocus(
                                                cnt_Home.fcn_node);
                                            cnt_Home.fcn_node
                                                .requestFocus();
                                            setState(() {});
                                          },
                                          child: Icon(
                                            Icons.search,
                                            color: Colors.black,
                                          ))),
                                  onChanged: (value) {
                                    cnt_Home.onSearchTextChanged(cnt_Home
                                        .editingController.value!.text);
                                    setState(() {});
                                  },
                                  onFieldSubmitted: (value) {
                                    setState(() {
                                      cnt_Home.onSearchTextChanged(cnt_Home
                                          .editingController.value!.text);
                                      // get_member_list(_textsearch.text);
                                    });
                                    FocusScope.of(context).unfocus();
                                  },
                                  onEditingComplete: () {
                                    setState(() {
                                      cnt_Home.onSearchTextChanged(cnt_Home
                                          .editingController.value!.text);
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
            // SliverAppBar(
            //     expandedHeight: Get.height,
            //     elevation: 0,
            //     automaticallyImplyLeading: false,
            //     backgroundColor: Colors.white,
            //     flexibleSpace:
            //     pinned: true,
            //     actions: []),
            SliverList(
                delegate: SliverChildListDelegate([
                  SizedBox(
                    child: SafeArea(
                        bottom: bottomSafeArea,
                        child: Stack(
                          children: [
                            RefreshIndicatorWidget(
                              onRefresh: cnt_Home.refreshData,
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
                                    child: Obx(() => Column(
                                      children: [
                                        if (cnt_Home.selected.value == 0)
                                          VisitorView(),
                                        if (cnt_Home.selected.value == 1)
                                          VisitorCheckInView(),
                                        if (cnt_Home.selected.value == 2)
                                          VisitorCheckOutView(),
                                      ],
                                    )),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ]))
          ],
        ));
        //margin: EdgeInsets.symmetric(horizontal: 20),
      }),
    );
  }

  Widget VisitorShimmerEffect() {
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

  visitordata(dynamic value) {
    if (value != null && value != "") {
      VistorModel obj = value;
      cnt_Home.obj_visitor = null;
      if (obj.StartDate != null &&
          obj.StartDate!.isNotEmpty &&
          obj.EndDate != null &&
          obj.EndDate != "" &&
          obj.projectmodel != null) {
        cnt_Home.obj_visitor = value;
        cnt_Home.filtrationupdatae();
        setState(() {});
      }
    }
  }

  //<editor-fold desc = "CheckInWidgets">

  Widget VisitorCheckInView() {
    return Obx(() {
      return FutureBuilder(
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return snapshot.data.length != 0 ||
                    cnt_Home.arrvisitorcheckinlistNew.length > 0
                ? VisitorsCheckInListView()
                : Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: Get.width,
                      height: 300.h,
                      alignment: Alignment.center,
                      child: Text(
                        cnt_Home.noDataFound.isFalse
                            ? cnt_Home.isFaqsEmptyMsg.value
                            : "No Data Found",
                        style: TextStyle(
                            color: AppColors.BLACK,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
          } else {
            return VisitorShimmerEffect();
          }
        },
        future: cnt_Home.futurevisitorcheckinDataNew.value,
      );
    });
  }

  Widget VisitorCheckInListchildview(int index) {
    VisitorModelNew obj = cnt_Home.arrvisitorcheckinlistNew[index];
    cnt_Home.stopWatchTimer.setPresetTime(
        mSec: cnt_Home.dateandtimechanger(
            obj.checkinDatetime.toString() ?? DateTime.now().toString()));

    return Padding(
      padding: EdgeInsets.only(bottom: PADDING),
      child: InkWell(
        onTap: () {
          cnt_Home.VisitorCheckOut(obj);
        },
        child: Container(
          decoration: BoxDecoration(
              // color: HexColor(obj.color ?? "#ffffff"),
              color: AppColors.RED_LIGHT,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [boxShadow, boxShadowback]),
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
                            height: 50.h,
                            width: 50.w,
                            child: Center(
                                child: CircleAvatar(
                              child: CachedNetworkImage(
                                imageUrl: obj.profile ?? "",
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
                            height: 50.h,
                            width: 50.w,
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
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (obj.visitor_role != null &&
                                          obj.visitor_role != "")
                                        Expanded(
                                          child: RichText(
                                              maxLines: 1,
                                              text: TextSpan(
                                                  text: "Role : ",
                                                  style: TextStyles
                                                      .textStyleLight12(
                                                          AppColors
                                                              .BLACK
                                                              .withOpacity(
                                                                  0.5)),
                                                  children: [
                                                    TextSpan(
                                                        text: obj.visitor_role
                                                                .toString() ??
                                                            "")
                                                  ])),
                                        ),
                                      if (obj.vehicleno != "" &&
                                          obj.vehicleno != null)
                                        Expanded(
                                          child: RichText(
                                              maxLines: 1,
                                              text: TextSpan(
                                                  text: "Vehical No : ",
                                                  style: TextStyles
                                                      .textStyleLight12(
                                                          AppColors
                                                              .BLACK
                                                              .withOpacity(
                                                                  0.5)),
                                                  children: [
                                                    TextSpan(
                                                        text:
                                                            obj.vehicleno ?? "")
                                                  ])),
                                        ),
                                    ]),
                                SizedBox(
                                  height: 5.w,
                                ),
                                RichText(
                                    text: TextSpan(
                                  text: obj.unitdetails ?? "",
                                  style: TextStyles.textStyleLight12(
                                      AppColors.BLACK.withOpacity(0.5)),
                                )),
                                if (obj.vehicleno != "" &&
                                    obj.vehicleno != null)
                                  SizedBox(
                                    height: 5.w,
                                  ),
                                SizedBox(
                                  height: 5.w,
                                ),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                  "+${obj.mobile ?? ""}",
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("CheckIn"),
                        Row(
                          children: [
                            RichText(
                                text: TextSpan(
                                    text: obj.checkinDatetime ?? "",
                                    style: TextStyles.textStyleDark14(),
                                    children: [])),
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget VisitorsCheckInListView() {
    return Container(
      padding: EdgeInsets.only(left: PADDING, right: PADDING, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (cnt_Home.obj_visitor != null)
            LogFilter("Visitor Checkin Log"),
          if (cnt_Home.obj_visitor != null)
            SizedBox(
              height: 25,
            ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return VisitorCheckInListchildview(index);
            },
            itemCount: cnt_Home.arrvisitorcheckinlistNew.length,
          ),
          SizedBox(
            height: 350.h,
          ),
        ],
      ),
    );
  }

  //</editor-fold>

  //<editor-fold desc = "CheckOutWidgets">

  Widget VisitorCheckOutView() {
    return Obx(() {
      return FutureBuilder(
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return (snapshot.data.length != 0 ||
                    cnt_Home.arrvisitorcheckoutlistNew.length > 0)
                ? VisitorsCheckOutListView()
                : Container(
                    width: Get.width,
                     height: 500,
                    alignment: Alignment.center,
                    child: Text(
                      cnt_Home.noDataFound.isFalse
                          ? cnt_Home.isFaqsEmptyMsg.value
                          : "No Data Found",
                      style: TextStyle(
                          color: AppColors.BLACK,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  );
          } else {
            return VisitorShimmerEffect();
          }
        },
        future: cnt_Home.futurevisitorcheckoutDataNew.value,
      );
    });
  }

  Widget VisitorCheckOutListchildview(int index) {
    VisitorModelNew obj = cnt_Home.arrvisitorcheckoutlistNew[index];
    return Padding(
      padding: EdgeInsets.only(bottom: PADDING),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              color: HexColor(obj.color ?? "#ffffff"),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [boxShadow, boxShadowback]),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    obj.profile != null && obj.profile != ""
                        ? SizedBox(
                            height: 50.h,
                            width: 50.w,
                            child: Center(
                                child: CircleAvatar(
                              child: CachedNetworkImage(
                                imageUrl: obj.profile ?? "",
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
                            height: 50.h,
                            width: 50.w,
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
                        mainAxisSize: MainAxisSize.min,
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
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (obj.visitor_role != null)
                                        RichText(
                                            text: TextSpan(
                                                text: obj.visitor_role
                                                        .toString() ??
                                                    "",
                                                style:
                                                    TextStyles.textStyleLight12(
                                                        Colors.grey),
                                                children: [
                                              TextSpan(text: "")
                                            ])),
                                    ]),
                                SizedBox(
                                  height: 5.w,
                                ),
                                if (obj.unitdetails!.isNotEmpty)
                                  RichText(
                                      text: TextSpan(
                                    text: obj.unitdetails ?? "",
                                    style: TextStyles.textStyleLight12(
                                        Colors.grey),
                                  )),
                                if (obj.unitdetails!.isNotEmpty)
                                  SizedBox(
                                    height: 5.w,
                                  ),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "+${obj.mobile ?? ""}",
                                                      style: TextStyles
                                                          .textStyleMedium14(
                                                              AppColors.BLACK),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${obj.checkout_date ?? ""}",
                                          style: TextStyles.textStyleMedium14(
                                              AppColors.BLACK),
                                        ),
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
                    child: Row(
                      children: [
                        Container(
                          width: Get.width * 0.2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "CheckIn",
                                maxLines: 1,
                                style: TextStyles.textStyleLight10,
                              ),
                              Text(
                                obj.checkinTime.toString(),
                                maxLines: 1,
                                style: TextStyles.textStyleDark12(),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle_outlined,
                                size: 14,
                              ),
                              Flexible(
                                  child: Container(
                                      width: Get.width,
                                      child: Divider(
                                        color: AppColors.APP_THEME_COLOR,
                                      ))),
                              Icon(
                                Icons.circle_outlined,
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: Get.width * 0.25,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Total Time",
                                maxLines: 1,
                                style: TextStyles.textStyleLight10,
                              ),
                              Text(
                                obj.totaldurations.toString()!,
                                maxLines: 1,
                                style: TextStyles.textStyleDark12(),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle_outlined,
                                size: 14,
                              ),
                              Flexible(
                                  child: Container(
                                      width: Get.width,
                                      child: Divider(
                                        color: AppColors.APP_THEME_COLOR,
                                      ))),
                              Icon(
                                Icons.circle_outlined,
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: Get.width * 0.2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "CheckOut",
                                maxLines: 1,
                                style: TextStyles.textStyleLight10,
                              ),
                              Text(
                                obj.checkout_time.toString(),
                                maxLines: 1,
                                style: TextStyles.textStyleDark12(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget VisitorsCheckOutListView() {
    return Container(
      padding: EdgeInsets.only(left: PADDING, right: PADDING, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (cnt_Home.obj_visitor != null)
            LogFilter("Visitor Checkout Log"),
          if (cnt_Home.obj_visitor != null)
            SizedBox(
              height: 25,
            ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return VisitorCheckOutListchildview(index);
            },
            itemCount: cnt_Home.arrvisitorcheckoutlistNew.length,
          ),
          SizedBox(
            height: 350.h,
          )
        ],
      ),
    );
  }

  //</editor-fold>

  //<editor-fold desc = "VisitorListWidgets">

  Widget VisitorView() {
    return Obx(() {
      return FutureBuilder(
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return snapshot.data.length != 0 &&
                    cnt_Home.arrvisitorlistNew.length > 0
                ? VisitorsListView()
                : Container(
                    width: Get.width,
                    height: 300.h,
                    alignment: Alignment.center,
                    child: Text(
                      cnt_Home.noDataFound.isFalse
                          ? cnt_Home.isFaqsEmptyMsg.value
                          : "No Data Found",
                      style: TextStyle(
                          color: AppColors.BLACK,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  );
          } else {
            return VisitorShimmerEffect();
          }
        },
        future: cnt_Home.futurevisitorDataNew.value,
      );
    });
  }

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
                  title ?? "Visitor Log",
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
                    cnt_Home.obj_visitor = null;
                    cnt_Home.futurevisitorDataNew.value = cnt_Home.RetrieveVisitorsData();
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
                      vistorModel: cnt_Home.obj_visitor,
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
                            cnt_Home.obj_visitor?.StartDate ?? "",
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
                      vistorModel: cnt_Home.obj_visitor,
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
                            cnt_Home.obj_visitor?.EndDate ?? "",
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
                      vistorModel: cnt_Home.obj_visitor,
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
                            "project name: ",
                          ),
                          Text(
                            cnt_Home.obj_visitor?.projectmodel?.name ??
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

  Widget VisitorsListView() {
    return Container(
      padding: EdgeInsets.only(left: PADDING, right: PADDING, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (cnt_Home.obj_visitor != null)
            LogFilter("Visitor Log"),
          if (cnt_Home.obj_visitor != null)
            SizedBox(
              height: 25,
            ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return VisitorListchildview(index);
            },
            itemCount: cnt_Home.arrvisitorlistNew.length,
          ),
        ],
      ),
    );
  }

  Widget VisitorListchildview(int index) {
    VisitorModelNew obj = cnt_Home.arrvisitorlistNew[index];

    return Padding(
      padding: EdgeInsets.only(bottom: PADDING),
      child: InkWell(
        onTap: () {
          cnt_Home.OnClickHandler(obj);
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: AppColors.WHITE,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [boxShadow, boxShadowback]),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              Row(
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
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (obj.visitor_role != null)
                                      RichText(
                                          text: TextSpan(
                                              text:
                                                  obj.visitor_role.toString() ??
                                                      "",
                                              style:
                                                  TextStyles.textStyleLight12(
                                                      Colors.grey),
                                              children: [TextSpan(text: "")])),
                                  ]),
                              SizedBox(
                                height: 5.w,
                              ),
                              RichText(
                                  text: TextSpan(
                                text: obj.unitdetails ?? "",
                                style: TextStyles.textStyleLight12(Colors.grey),
                                //     children: [
                                //   TextSpan(text: "909" ?? "")
                                // ]
                              )),
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
                                                "+${obj.mobile ?? ""}",
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

//</editor-fold>
}
