import 'dart:convert';
import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Config/Utils/Style.dart';
import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:avinashgatekeeper/Config/Utils/images.dart';
import 'package:avinashgatekeeper/Controller/DrawerController/DrawerController.dart';
import 'package:avinashgatekeeper/Modal/DrawerModal/DrawerModal.dart';
import 'package:avinashgatekeeper/Modal/DrawerProjectModal/DrawerProjectModal.dart';
import 'package:avinashgatekeeper/View/CustomerStaffPage/CustomerStaffPage.dart';
import 'package:avinashgatekeeper/View/PrivacyPage/PricvacyPage.dart';
import 'package:avinashgatekeeper/View/TermsAndConditionPage/TermsAndConditionPage.dart';
import 'package:avinashgatekeeper/View/VisitorLogPage/VisitorLogPage.dart';
import 'package:avinashgatekeeper/View/VisitorPage/VisitorPage.dart';
import 'package:avinashgatekeeper/View/VisitorRegistrationPage/VisitorRegistrationPage.dart';
import 'package:avinashgatekeeper/Widget/ShimmerWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../Config/Functions.dart';
import '../View/BuilderStaffPage/AddBuilderStaffPage/AddBuilderStaffPage.dart';
import 'CustomDecoration.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  CustomDrawerController cnt_Drawer = Get.put(CustomDrawerController());
  // BottomNavigationBarController cnt_Bottom = Get.put(BottomNavigationBarController());

  GlobalKey<ScaffoldState> scaffold = GlobalKey();
  Future<List<DrawerModal>>? futureDrawer;



  @override
  void initState() {
    super.initState();
    cnt_Drawer.getDrawerDetails();
    // cnt_Drawer.getprojectlist();
   cnt_Drawer.futureDrawer.value= cnt_Drawer.GetProjectList() ;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: AppColors.WHITE,
        ),
        //endDrawer: CustomDrawer(),
        //onEndDrawerChanged: (value) => cnt_Bottom.OnDrawerChange(value),
        backgroundColor: Colors.transparent,
        body: Container(
            width: Get.width / 1.5,
            height: Get.height,
            color: AppColors.DARK_GREY,
            child: NotificationListener<OverscrollIndicatorNotification>(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      //width: Get.width/2,
                      color: AppColors.WHITE,
                      child: Column(
                        children: [
                          DrawerHeader(),
                          DrawerItemListView(),
                        ],
                      ),
                    ),
                    FooterWidget()
                  ],
                ),
              ),
              onNotification: (overscroll) {
                overscroll.disallowGlow();
                return true;
              },
            )));
  }

  Widget DrawerHeader() {
    return Container(
      padding: EdgeInsets.all(10.w),
      child: Stack(
        children: [
          Container(
            width: Get.width,
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.center,
                    child:
                    cnt_Drawer.profileimage.value != null && cnt_Drawer.profileimage.value != ""
                        ? SizedBox(
                        height: 80.h,
                        width: 80.w,
                        child: Center(
                            child: CircleAvatar(
                              child: CachedNetworkImage(
                                imageUrl: cnt_Drawer.profileimage.value,
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
                        height: 80.h,
                        width: 80.w,
                        child: Center(
                            child: CircleAvatar(
                              backgroundImage: AssetImage(PERSON_IMAGE),
                              radius: 100,
                            ))),
                    // Image.asset(
                    //   PERSON_ICON,
                    //   height: 80.h,
                    //   width: 80.w,
                    // )
                ),
                SizedBox(
                  height: 10.w,
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    //color: AppColors.DARK_GREY.withOpacity(0.5),
                    color: AppColors.TRANSPARENT,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8, top: 5, bottom: 0),
                    child: Center(
                      child: Obx(() {
                        child:
                        return Text(
                          // "+91 9854445335",
                          cnt_Drawer.fullname.value.toString(),
                          // cnt_Drawer.sessionemail,
                          style: TextStyles.textStyleMedium14(AppColors.BLACK),
                        );
                      }),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    //color: AppColors.DARK_GREY.withOpacity(0.5),
                    color: AppColors.TRANSPARENT,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8, top: 5, bottom: 0),
                    child: Center(
                      child: Obx(() {
                        child:
                        return Text(
                          // "+91 9854445335",
                          "+91 ${cnt_Drawer.contactNo.value}",
                          // cnt_Drawer.sessionemail,
                          style: TextStyles.textStyleMedium14(AppColors.BLACK),
                        );
                      }),
                    ),
                  ),
                ),

              ])
          // Positioned(
          //   right: 10.w,
          //   top: Get.mediaQuery.padding.top + 10.w,
          //   child: CustomButtons.RoundIconButton(
          //       onTap: () {
          //         Get.back();
          //       },
          //       height: 40.w,
          //       width: 40.w,
          //       bgColor: AppColors.WHITE,
          //       radius: 40.w / 2,
          //       imgColor: AppColors.BLACK,
          //       image: CANCEL_ICON,
          //       boxShadow: true,
          //       shadowColor: Colors.black.withOpacity(0.1)),
          // ),
          // Positioned(
          //   top: 60.w,
          //   bottom: 0,
          //   left: 20,
          //   child: Container(
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Container(
          //           height: 100.w,
          //           width: 100.w,
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(100.w / 2),
          //               color: AppColors.DARK_GREY,
          //               boxShadow: [boxShadow]),
          //           clipBehavior: Clip.hardEdge,
          //           child: ProfileImage(),
          //         ),
          //         SizedBox(
          //           width: 15.w,
          //         ),
          //         Container(
          //             width: Get.width - 160.w,
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(
          //                   cnt_Drawer.fullname.value,
          //                   style: TextStyles.textStyleDark20(),
          //                 ),
          //                 SizedBox(
          //                   height: 5,
          //                 ),
          //                 Column(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text("C: ${cnt_Drawer.contactNo.value}"),
          //                     SizedBox(
          //                       height: 2,
          //                     ),
          //                     Text("E: ${cnt_Drawer.email.value}")
          //                   ],
          //                 )
          //
          //               ],
          //             )
          //         )
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget DrawerItemListView() {
    return Obx(() {
      return FutureBuilder(
          builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return     Container(

              padding: EdgeInsets.only(bottom: 0),
              child: Obx(() {
                child:
                return  cnt_Drawer.arrProjectDrawerItemList.length>0?  Container(
                  color: AppColors.WHITE,
                  child: ListView.builder(
                    // padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      return /*Obx(() {
                        return*/
                        wd_DrawerItemListChild(index);
                      // });/*/
                    },
                    //itemCount: cnt_Drawer.arrDrawerItemList.length,
                    itemCount: cnt_Drawer.arrProjectDrawerItemList.length,
                  ),
                ):Container();
              }));


        } else {
          print(" im on shimmer effect");
          return ShimmerEffectWidget();
        }
          },
        future: cnt_Drawer.futureProjectListDrawer.value,
      );
    });

           /* } else {
              return ShimmerEffectWidget();
            }*/
    // },
    // ));
  }

  Widget wd_DrawerItemListChild(index) {
DrawerProjectModal obj=cnt_Drawer.arrProjectDrawerItemList[index];
    /* DrawerModal obj = cnt_Drawer.arrDrawerItemList[index];
    return obj.ismainmenu == "1"
        ? */
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1,color: AppColors.DARK_GREY)
            ),
              height: 40.w,
              child: ListTile(
                title: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      // "Magneto Homes",
                      obj.name??"",
                      //cnt_Drawer.sessionData[SESSION_BUILDINGS][0][SESSION_BUILDINGS_PROJECT][SESSION_BUILDINGS_PROJECT_NAME].toString(),
                      style: TextStyles.textStyleLight14(),
                    ),
                  ),
                ),

                // trailing: Icon(
                //   Icons.arrow_forward_ios,
                //   color: Colors.black.withOpacity(0.8),
                //   size: 15.w,
                // ),
              )),
        ),
        //Divider(thickness: 1,color: AppColors.BLACK.withOpacity(0.1),)
      ],
    );
  }

  Widget ProfileImage() {
    return Obx(() {
      return cnt_Drawer.isBinaryImage.value == 0
          ? Image.network(
              cnt_Drawer.profileImg.value,
              fit: BoxFit.fill,
              errorBuilder: (context, url, error) {
                return ShimmerEffect(
                    child:
                        shimmerWidget(height: 100.w, width: 100.w, radius: 40));
              },
            )
          : Image.memory(Base64Decoder().convert(cnt_Drawer.profileImg.value),
              errorBuilder: (context, url, error) {
              return ShimmerEffect(
                  child:
                      shimmerWidget(height: 100.w, width: 100.w, radius: 40));
            }, fit: BoxFit.fill);
    });
  }

  Widget FooterWidget() {
    return Container(
      padding: EdgeInsets.only(left: PADDING, right: PADDING, bottom: 30),
      color: AppColors.DARK_GREY,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(
          //   height: 30.w,
          // ),
          SizedBox(
            height: 15,
          ),
          Column(
            children: [
              // LogoutButton(),
              SubmitButton(),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: (){
              Get.back();
              Get.to(PrivacyPage());
            },
            child: Text(
              "Privacy Policy",
              style: TextStyles.textStyleLight14(),
            ),
          ),
          SizedBox(
            height: 10.w,
          ),
          GestureDetector(
            onTap: (){
              Get.back();
              Get.to(TermsAndConditionPage());
            },
            child: Text(
              "T & C",
              style: TextStyles.textStyleLight14(),
            ),
          ),
          SizedBox(
            height: 10.w,
          ),
          Text(
            "Disclaimer",
            style: TextStyles.textStyleLight14(),
          ),
          SizedBox(
            height: 10.w,
          ),
          Obx(() {
            return Text(
              "App Version ${cnt_Drawer.appVersion.value}",
              style: TextStyles.textStyleLight14(),
            );
          })
        ],
      ),
    );
  }

  Widget SubmitButton() {
    return OnTapButton(
        onTap: () {
          cnt_Drawer.OpenLogoutDialog();
        },
        height: 40,
        decoration: CustomDecorations()
            .backgroundlocal(APP_THEME_COLOR, cornarradius, 0, APP_THEME_COLOR),
        text: "Logout",
        style:
        TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600));
  }

  //</editor-fold>

  //<editor-fold desc = "shimmer effect">
  Widget ShimmerEffectWidget() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: true,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Expanded(child: shimmerWidget(radius: radius, height: 30))
                  ],
                ),
              );
            },
            itemCount: 6,
          ),
        ),
      ),
    );
  }

//</editor-fold>

  //<editor-fold desc = "network image placeholders and image error handler">

  Widget NetworkImageLoad() {
    return Container(
        child: Shimmer.fromColors(
      child: shimmerWidget(radius: 10),
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: true,
    ));
  }

  Widget ErrorImageWidget() {
    return Container(
        child: Shimmer.fromColors(
      child: shimmerWidget(radius: 10),
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: true,
    ));
  }

//</editor-fold>

}
