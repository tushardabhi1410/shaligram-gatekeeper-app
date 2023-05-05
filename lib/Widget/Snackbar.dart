

import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


showSnackBar({required Status status, String? message, String? title = ""}){
  Get.snackbar(
    title! != "" ? title : status == Status.Successful ? "Success!" : "Error!",
    message ?? "",
    onTap: (_) => {},backgroundColor: status == Status.Successful ?Colors.green: AppColors.RED,colorText: Colors.white,
    duration: const Duration(seconds: 3),
    animationDuration: const Duration(milliseconds: 800),
    snackPosition: SnackPosition.TOP,
  );
}

enum Status{
  Successful,
  Error
}