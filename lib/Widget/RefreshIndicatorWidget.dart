import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:flutter/material.dart';

typedef Future<void> OnRefresh();

class RefreshIndicatorWidget extends StatefulWidget {
  Widget child;
  OnRefresh onRefresh;

  RefreshIndicatorWidget({required this.child, required this.onRefresh});

  @override
  _RefreshIndicatorWidgetState createState() => _RefreshIndicatorWidgetState();
}

class _RefreshIndicatorWidgetState extends State<RefreshIndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: widget.child,
      onRefresh: widget.onRefresh,
      color: AppColors.BARRIERCOLOR,
    );
  }
}
