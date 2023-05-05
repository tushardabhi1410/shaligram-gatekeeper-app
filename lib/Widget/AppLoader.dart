import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Config/Utils/images.dart';
import 'package:flutter/material.dart';


BuildContext? _appLoaderContex;

AppLoader(BuildContext context){

    showGeneralDialog(context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      pageBuilder: (_, __, ___) {
        _appLoaderContex = context;
        return Align(
          alignment: Alignment.center,
          child: Container(
            width: 80.w,
            height: 80.w,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox.expand(
                  child: Image.asset(LOADER_ICON,
                      height: 70.w, width: 70.w)),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(80.w / 2),
            ),
          ),
        );
      },);
}

void RemoveAppLoader(BuildContext context) {
  if (_appLoaderContex != null) {
    Navigator.of(_appLoaderContex!).pop();
  }
  // Navigator.of(context, rootNavigator: false).pop('dialog');
}