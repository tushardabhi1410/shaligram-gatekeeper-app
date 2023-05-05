import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Config/Helper/HextoColor.dart';
import '../Config/Utils/Style.dart';


class CustomDecorations {
  BoxDecoration background(String bgcolor,double radius,double width,String bordercolor){
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(
            color:HexColor(bordercolor) ,
            width: width),
        color: HexColor(bgcolor)
    );
  }

  BoxDecoration backgroundlocal(MaterialColor bgcolor,double radius,double width,MaterialColor bordercolor){
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(
            color:bordercolor,
            width: width),
        color: bgcolor,
      boxShadow: [
        fullcontainerboxShadow
      ]
    );
  }

  BoxDecoration backgroundwithoutborder(MaterialColor bgcolor,double radius,double width){
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        // border: Border.all(
        //     // color:bordercolor,
        //     width: width),
        color: bgcolor
    );
  }

  BoxDecoration backgroundwithshadow(
      MaterialColor bgcolor,double radius,double width,MaterialColor bordercolor){
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        boxShadow: [smallcontainerboxShadow],
        border: Border.all(
            color:bordercolor,
            width: width),
        color: bgcolor
    );
  }


}





