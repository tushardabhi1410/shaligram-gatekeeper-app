import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/Config/Utils/images.dart';
import 'package:avinashgatekeeper/Modal/BottomNavigatorModal/BottomNavigatorIconList.dart';
import 'package:avinashgatekeeper/View/HomePage/HomePage.dart';
import 'package:avinashgatekeeper/View/StaffPage/StaffPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationBarController extends GetxController {

  RxList<BottomNavigationIconList> arrBottomIconList = RxList<BottomNavigationIconList>();
  RxInt selectedIndex = 0.obs;
  String roleCode = "";

  @override
  void onInit() {
    super.onInit();
    this.CreateIconList();
  }

  CreateIconList() {
    arrBottomIconList = RxList([]);
    arrBottomIconList.add(BottomNavigationIconList(name: "Visitors", image: HOME_ICON, alias: HOMEMENU));
    arrBottomIconList.add(BottomNavigationIconList(name: "Staff", image: STAFF_ICON, alias: PROPERTIESMENU));
    arrBottomIconList.add(BottomNavigationIconList(name: "Builder Staff", image: STAFF_ICON, alias: FAVOURITEMENU));
    arrBottomIconList.add(BottomNavigationIconList(name: "Directory", image: DIRECTORY_ICON, alias: ACCOUNTMENU));

    arrBottomIconList.refresh();
  }

  NavigationHandler(int index) {
    BottomNavigationIconList obj = arrBottomIconList[index];
    switch (obj.name) {
      case HOMEMENU:
        GotoHomePage();
        break;
      case PROPERTIESMENU:
        GotoStaffPage();
        break;
      case FAVOURITEMENU:
        GotoBuilderStaffPage();
        break;
      case ACCOUNTMENU:
        GotoDirectoryStaffPage();
        break;
    }
  }


  GotoHomePage() async {
    Get.to(HomePage());
  }

  GotoStaffPage() async {
    Get.to(StaffPage());
  }

  GotoBuilderStaffPage() async {
    Get.to(HomePage());
  }

  GotoDirectoryStaffPage() async {
    Get.to(HomePage());
  }

  SelectIndex(int index) {
    selectedIndex.value = index;
    selectedIndex.refresh();
  }

  DrawerOpen(GlobalKey<ScaffoldState> globalKey) {
    globalKey.currentState!.openEndDrawer();
  }

  OnDrawerChange(bool value) {
  }

  Widget CustomBottomNavigation(GlobalKey<ScaffoldState> globalKey) {
    return Stack(
      children: [
        Container(
          width: Get.width,
          height: 75.w,
          color: Colors.transparent,
        ),
        Positioned(bottom: 0, child: BottomIconSet()),
        //Positioned(top: 0, right: 16, child: PopMenuButton(globalKey)),
      ],
    );
    return Stack(
      children: [
        Container(
          width: Get.width,
          height: 75.w,
          color: Colors.black38,
        ),
        Positioned(bottom: 0, child: BottomIconSet()),
        Positioned(top: 0, right: 16, child: PopMenuButton(globalKey)),
      ],
    );
  }

  Widget BottomIconSet() {
    return Container(
        width: Get.width,
        height: BOTTOM_HEIGHT.w,
        decoration: BoxDecoration(color: AppColors.WHITE, boxShadow: [boxShadow]),
        child: Obx(() {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              return _generateNavigationCell1(i);
            },
            itemCount: arrBottomIconList.length > 0 ? arrBottomIconList.length : 0,
          );
        }));
  }

  Widget _generateNavigationCell1(int index) {

    BottomNavigationIconList obj = arrBottomIconList[index];

    return  InkWell(
            onTap: () => NavigationHandler(index),
            // onTap: () {
            //   print("Hello");
            // },
            child: Container(
                width: Get.width / 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            obj.image,
                            fit: BoxFit.contain,
                            height: 28.w,
                            width: 28.w,
                            color: AppColors.BLACK,
                          ),
                          Text(
                            obj.name,
                            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.w,
                    ),
                    selectedIndex.value == index
                        ? Container(
                            width: 5.w,
                            height: 5.w,
                            decoration: BoxDecoration(
                                color: AppColors.BLACK,
                                borderRadius: BorderRadius.circular(20)),
                          )
                        : Container()
                  ],
                )),
          );

  }

  Widget PopMenuButton(GlobalKey<ScaffoldState> globalKey) {
    BottomNavigationIconList obj = arrBottomIconList[3];
    return InkWell(
      splashColor: AppColors.TRANSPARENT,
      hoverColor: AppColors.TRANSPARENT,
      focusColor: AppColors.TRANSPARENT,
      onTap: () => DrawerOpen(globalKey),
      child: Container(
        width: 48.w,
        height: 48.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48.w / 2),
          color: AppColors.BLACK,
        ),
        child: Padding(
          padding: EdgeInsets.all(13.0.w),
          child: Image.asset(
            obj.image,
            color: AppColors.WHITE,
          ),
        ),
      ),
    );
  }
//</editor-fold>
}
