
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Config/Utils/Style.dart';

class CustomDetailsAppBar extends StatefulWidget {
  late final String title;
  late final double height;
  MaterialColor? color;
  List<Widget>? leadingWidget;
  List<Widget>? trillingWidget;

  CustomDetailsAppBar(
      {required this.title,
        required this.height,
        this.leadingWidget,
        this.trillingWidget,
        this.color});

  @override
  _CustomDetailsAppBarState createState() => _CustomDetailsAppBarState();
}

class _CustomDetailsAppBarState extends State<CustomDetailsAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          fullcontainerboxShadow
        ],
        // boxShadow: [
        //   BoxShadow(color:  Colors.grey.shade300,offset: Offset(0,4),blurRadius: 5,spreadRadius: 4),],
        color: widget.color == null ? Colors.white : widget.color,
      ),
      // color: widget.color == null ? Colors.white : widget.color,
      height: widget.height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                children: widget.leadingWidget!,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10),
            child: Row(
              children: widget.trillingWidget!,
            ),
          )
        ],
      ),
    );
  }
}