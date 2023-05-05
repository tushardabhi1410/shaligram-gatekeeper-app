import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:avinashgatekeeper/Config/Utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget RentalShimmerWidget({double height =0, double width=0,double radius=10}){
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        color: AppColors.WHITE,
        borderRadius: BorderRadius.circular(radius)
    ),
  );
}

Widget shimmerWidget({double height =0, double width=0,double radius=0}){
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        color: AppColors.WHITE,
        borderRadius: BorderRadius.circular(radius)
    ),
  );
}

Widget ShimmerEffect({required Widget child}){
  return Shimmer.fromColors(child: child, baseColor: AppColors.SHIMMER_BASE, highlightColor: AppColors.SHIMMER_HIGHLIGHT);
}

Widget loadingWidget(){
  return Text(loading,
    style: TextStyle(
        color: AppColors.BLACK,
        fontSize: 21.sp,
        fontWeight: FontWeight.w600
    ),);
}