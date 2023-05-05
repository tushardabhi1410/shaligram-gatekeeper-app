import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Controller/PrivacyPageController/PrivacyPageController.dart';
import 'package:avinashgatekeeper/Modal/PrivacyPageModel/PrivacyPageModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Config/Utils/Style.dart';
import '../../Config/Utils/color.dart';
import '../../Config/Utils/constantValue.dart';
import '../../Config/Utils/images.dart';
import '../../Widget/CustomAppBar.dart';
import '../../Widget/RefreshIndicatorWidget.dart';
import '../../Widget/ShimmerWidget.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;


class PrivacyPage extends StatefulWidget {
  const PrivacyPage({Key? key}) : super(key: key);

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {

  @override
  void initState() {
    // TODO: implement initState
    cnt_priv.RetrievePrivacyDataNew();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  PrivacyPageController cnt_priv=Get.put(PrivacyPageController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: cnt_priv.scaffoldKey,
      backgroundColor: AppColors.WHITE,
        appBar: AppBar(toolbarHeight: 0),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(children: [
            PrivacyPageView(),
            Positioned(
                top: 0,
                child: CustomAppBar(
                    title: "Privacy Policy",
                    bgColor: AppColors.WHITE,
                    backimgbgColor: AppColors.DARK_GREY,
                    onTapCallBack: () {
                      Get.back();
                    })),
          ]),
        )
      //),
    );
  }


  Widget PrivacyPageView(){
    return Container(
        width: Get.width,
        height: Get.height,
        child:
        Scaffold(
          appBar: AppBar(toolbarHeight: 0,elevation: 0,backgroundColor: AppColors.TRANSPARENT,),
          backgroundColor: AppColors.WHITE,
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child:
            Container(
              padding: EdgeInsets.only(left: PADDING, right: PADDING, top: APP_BAR_HEIGHT.h, bottom: 0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PrivacyPageWidget()
                  ],
              ),
            ),



          ),
        )

    );
  }

  Widget PrivacyPageWidget(){
    return Obx(() {
      return FutureBuilder(
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return (snapshot.data.length != 0 || cnt_priv.arrPrivacyList.length>0)
                ?PrivacyMainWidget()
                : Container(
              width: Get.width,
              height: 500,
              alignment: Alignment.center,
              child: Text(
                cnt_priv.isFaqsEmptyMsg.value,
                style: TextStyle(
                    color: AppColors.BLACK,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
            );
          } else {
            return PrivacyShimmerEffect();
            // return Container();
          }
        },
        future: cnt_priv.futurePrivacyData.value,
      );
    });
  }


  Widget PrivacyShimmerEffect() {
    print("im in shimmer effect");
    return Container(
        child: ShimmerEffect(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15,),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return Container(
                    width: Get.width,
                    padding:
                    EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 30.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        shimmerWidget(
                            height: 25.w, width: Get.width*0.4, radius: 10.w),
                        SizedBox(
                          height: 8.w,
                        ),
                        shimmerWidget(
                            height: 100.w, width: Get.width, radius: 10.w),
                      ],
                    ),
                  );
                },
                itemCount: 3,
              ),
            ],
          ),
        ));
  }

  Widget PrivacyMainWidget() {
    return Container(
      padding:
      EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 30.w),
       child: ListView.builder(
           shrinkWrap: true,
           scrollDirection: Axis.vertical,
           physics: BouncingScrollPhysics(),
           itemCount: cnt_priv.arrPrivacyList.length,
           itemBuilder: (context,index){
             PrivacyPageModel obj=cnt_priv.arrPrivacyList[index];
             return Container(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(obj.title ?? "",style: TextStyles.textStyleDark18(),),
                   Html(data: obj.description,shrinkWrap: true),
                   SizedBox(height: 30,)
                 ],
               ),
             );
           }
           ),
    );
  }

}
