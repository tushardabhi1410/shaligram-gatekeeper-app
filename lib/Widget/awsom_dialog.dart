library awesome_dialog;

import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:avinashgatekeeper/Config/Utils/images.dart';
import 'package:avinashgatekeeper/Widget/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

enum DialogButtonType{
  WITHOUT_BACK_BUTTON,
  WITH_BACK_BUTTON
}

enum DialogType {
  INFO,
  INFO_REVERSED,
  WARNING,
  ERROR,
  SUCCES,
  QUESTION,
  NO_HEADER
}
enum AnimType { SCALE, LEFTSLIDE, RIGHSLIDE, BOTTOMSLIDE, TOPSLIDE }

enum DismissType {
  BTN_OK,
  BTN_CANCEL,
  TOP_ICON,
  MODAL_BARRIER,
  ANDROID_BACK_BTN,
  OTHER
}

class AwesomeDialogCustom {
  /// [@required]
  final BuildContext context;

  final DialogButtonType dialogButtonType;

  /// Dialog Type can be INFO, WARNING, ERROR, SUCCES, NO_HEADER
  final DialogType dialogType;

  /// Widget with priority over DialogType, for a custom header widget
  final Widget? customHeader;

  /// Dialog Title
  final String? title;

  /// The [TextStyle] of the title
  ///
  /// If not set, it will be the [ThemeData.textTheme.headline6]
  final TextStyle? titleTextStyle;

  /// Set the description text of the dialog.
  final String? desc;

  /// The [TextStyle] of the description
  ///
  /// If not set, it will be the [DefaultTextStyle]
  final TextStyle? descTextStyle;

  /// Create your own Widget for body, if this property is set title and description will be ignored.
  final Widget? body;

  /// Text for the Ok button
  final String? btnOkText;

  /// Icon to use for the Ok button
  final IconData? btnOkIcon;

  /// Function to execute when Ok button is pressed
  final Function()? btnOkOnPress;

  /// Color of the Ok Button
  final Color? btnOkColor;

  /// Text for the Cancel button
  final String? btnCancelText;

  /// Icon to use for the Cancel button
  final IconData? btnCancelIcon;

  /// Function to execute when Cancel button is pressed
  final Function()? btnCancelOnPress;

  /// Color of the Cancel Button
  final Color? btnCancelColor;

  /// Custom Btn OK
  final Widget? btnOk;

  /// Custom Btn Cancel
  final Widget? btnCancel;

  /// Barrier Dissmisable
  final bool dismissOnTouchOutside;

  /// Callback to execute after dialog get dissmised
  final Function(DismissType type)? onDissmissCallback;

  /// Anim Type can be { SCALE, LEFTSLIDE, RIGHSLIDE, BOTTOMSLIDE, TOPSLIDE }
  final AnimType animType;

  ///Border Radius for the Dialog
  final BorderRadiusGeometry? dialogBorderRadius;

  /// Alignment of the Dialog
  final AlignmentGeometry aligment;

  /// Padding off inner content of Dialog
  final EdgeInsetsGeometry? padding;

  /// This Prop is usefull to Take advantage of screen dimensions
  final bool isDense;

  /// Whenever the animation Header loops or not.
  final bool headerAnimationLoop;

  /// To use the Rootnavigator
  final bool useRootNavigator;

  /// For Autho Hide Dialog after some Duration.
  final Duration? autoHide;

  ///Control if add or not the Padding EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom).
  final bool keyboardAware;

  ///Control if Dialog is dissmis by back key.
  final bool dismissOnBackKeyPress;

  ///Max with of entire Dialog.
  final double? width;

  ///Border Radius for built in buttons.
  final BorderRadiusGeometry? buttonsBorderRadius;

  ///TextStyle for built in buttons.
  final TextStyle? buttonsTextStyle;

  /// Control if close icon is appear.
  final bool showCloseIcon;

  /// Custom closeIcon.
  final Widget? closeIcon;

  /// Custom background color for dialog + header
  final Color? dialogBackgroundColor;

  /// Set BorderSide of DialogShape
  final BorderSide? borderSide;

  /// Set to `false` when you want to pass data from custom [Navigator.pop]
  ///
  /// Defaults to `true`
  final bool autoDismiss;

  /// [Color] of the barrier around the dialog
  ///
  /// Defaults to `Colors.black54`
  final Color? barrierColor;

  /// If true, then hitting `Enter` key will be equivalent to clicking `Ok` button.
  ///
  /// Useful for desktop or web platforms.
  ///
  /// Defaults to `false`
  final bool enableEnterKey;

  /// Sets **gap/distance** between the top of the body and header
  /// when [dialogType] is [DialogType.NO_HEADER]
  ///
  /// Defaults to `15.0`
  final double bodyHeaderDistance;

  final double headerwidth;

  final double headerheight;

  final Color headerboderColor;

  final EdgeInsets buttonPadding;

  /// Creates a Dialog that is shown using the [showDialog] function
  ///
  /// Returns null if [autoDismiss] is true, else returns data passed to custom [Navigator.pop] function
  AwesomeDialogCustom({
    required this.context,
    this.dialogType = DialogType.INFO,
    this.customHeader,
    this.title,
    this.titleTextStyle,
    this.desc,
    this.descTextStyle,
    this.body,
    this.btnOk,
    this.btnCancel,
    this.btnOkText,
    this.btnOkIcon,
    this.btnOkOnPress,
    this.btnOkColor,
    this.btnCancelText,
    this.btnCancelIcon,
    this.btnCancelOnPress,
    this.btnCancelColor,
    this.onDissmissCallback,
    this.isDense = false,
    this.dismissOnTouchOutside = true,
    this.headerAnimationLoop = true,
    this.aligment = Alignment.center,
    this.animType = AnimType.SCALE,
    this.padding,
    this.useRootNavigator = false,
    this.autoHide,
    this.keyboardAware = true,
    this.dismissOnBackKeyPress = true,
    this.width,
    this.dialogBorderRadius,
    this.buttonsBorderRadius,
    this.showCloseIcon = false,
    this.closeIcon,
    this.dialogBackgroundColor,
    this.borderSide,
    this.buttonsTextStyle,
    this.autoDismiss = true,
    this.barrierColor = Colors.black54,
    this.enableEnterKey = false,
    this.bodyHeaderDistance = 15.0,
    this.headerheight = 90,
    this.headerwidth = 90,
    this.headerboderColor = Colors.white,
    this.buttonPadding = EdgeInsets.zero,
    this.dialogButtonType = DialogButtonType.WITHOUT_BACK_BUTTON
  }) : assert(
  autoDismiss || onDissmissCallback != null,
  'If autoDismiss is false, you must provide an onDissmissCallback to pop the dialog',
  );

  /// The type for dismissal of the dialog
  DismissType _dismissType = DismissType.OTHER;

  /// Used to check if the [onDissmissCallback] is called. (also to see if dialog is popped)
  ///
  /// Initialized to `false`
  bool _onDissmissCallbackCalled = false;

  /// Shows the dialog using the [showDialog] function
  ///
  /// Returns `null` if [autoDismiss] is true, else returns data passed to custom [Navigator.pop] function
  Future<dynamic> show() => showDialog(
    context: context,
    useRootNavigator: useRootNavigator,
    barrierDismissible: dismissOnTouchOutside,
    barrierColor: barrierColor,
    builder: (BuildContext context) {
      if (autoHide != null) {
        Future<void>.delayed(autoHide!).then(
              (dynamic value) => _onDissmissCallbackCalled ? null : dismiss(),
        );
      }
      switch (animType) {
        case AnimType.SCALE:
          return  _buildDialog;

        case AnimType.LEFTSLIDE:
          return _buildDialog;

        case AnimType.RIGHSLIDE:
          return _buildDialog;

        case AnimType.BOTTOMSLIDE:
          return _buildDialog;

        case AnimType.TOPSLIDE:
          return _buildDialog;

        default:
          return _buildDialog;
      }
    },
  )..then(
        (dynamic value) => _onDissmissCallbackCalled
        ? null
        : onDissmissCallback?.call(_dismissType),
  );

  /// Return the header of the dialog
  Widget? get _buildHeader {
    if (customHeader != null) {
      return customHeader;
    }
    if (dialogType == DialogType.NO_HEADER) {
      return null;
    }
    return Container(

    );
  }

  /// Returns the body of the dialog
  Widget get _buildDialog => WillPopScope(
    onWillPop: _onWillPop,
    child: _getDialogWidget(
      child: dialogButtonType == DialogButtonType.WITHOUT_BACK_BUTTON ? VerticalStackDialogCustom(
        dialogBackgroundColor: dialogBackgroundColor,
        borderSide: borderSide,
        borderRadius: dialogBorderRadius,
        header: _buildHeader,
        title: title,
        titleStyle: titleTextStyle,
        desc: desc,
        descStyle: descTextStyle,
        body: body,
        isDense: isDense,
        alignment: aligment,
        keyboardAware: keyboardAware,
        width: width,
        padding: padding ?? const EdgeInsets.only(left: 5, right: 5),
        bodyHeaderDistance: bodyHeaderDistance,
        btnOk: btnOk ?? (btnOkOnPress != null ? _buildFancyButtonOk : null),
        btnCancel: btnCancel ??
            (btnCancelOnPress != null ? _buildFancyButtonCancel : null),
        showCloseIcon: showCloseIcon,
        onClose: () {
          _dismissType = DismissType.TOP_ICON;
          dismiss.call();
        },
        closeIcon: closeIcon,
        buttonPadding: buttonPadding,
        headerborderColor: headerboderColor,
        headerheight: headerheight,
        headerwidth: headerwidth,
      ) : VerticalStackDialogCustomWithBackButton(
        dialogBackgroundColor: dialogBackgroundColor,
        borderSide: borderSide,
        borderRadius: dialogBorderRadius,
        header: _buildHeader,
        title: title,
        titleStyle: titleTextStyle,
        desc: desc,
        descStyle: descTextStyle,
        body: body,
        isDense: isDense,
        alignment: aligment,
        keyboardAware: keyboardAware,
        width: width,
        padding: padding ?? const EdgeInsets.only(left: 5, right: 5),
        bodyHeaderDistance: bodyHeaderDistance,
        btnOk: btnOk ?? (btnOkOnPress != null ? _buildFancyButtonOk : null),
        btnCancel: btnCancel ??
            (btnCancelOnPress != null ? _buildFancyButtonCancel : null),
        showCloseIcon: showCloseIcon,
        onClose: () {
          _dismissType = DismissType.TOP_ICON;
          dismiss.call();
        },
        closeIcon: closeIcon,
        buttonPadding: buttonPadding,
        headerborderColor: headerboderColor,
        headerheight: headerheight,
        headerwidth: headerwidth,
      ),
    ),
  );

  Widget get _buildFancyButtonOk => AnimatedButton(
    isFixedHeight: false,
    pressEvent: () {
      _dismissType = DismissType.BTN_OK;
      dismiss();
      btnOkOnPress?.call();
    },
    text: btnOkText ?? 'Ok',
    color: btnOkColor ?? const Color(0xFF00CA71),
    icon: btnOkIcon,
    borderRadius: buttonsBorderRadius,
    buttonTextStyle: buttonsTextStyle,
  );

  /// Returns the default `Cancel Button` widget
  Widget get _buildFancyButtonCancel => AnimatedButton(
    isFixedHeight: false,
    pressEvent: () {
      _dismissType = DismissType.BTN_CANCEL;
      dismiss();
      btnCancelOnPress?.call();
    },
    text: btnCancelText ?? 'Cancel',
    color: btnCancelColor ?? Colors.red,
    icon: btnCancelIcon,
    borderRadius: buttonsBorderRadius,
    buttonTextStyle: buttonsTextStyle,
  );

  Widget _getDialogWidget({required Widget child}) {
    return enableEnterKey
        ? RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (RawKeyEvent event) {
        if (event.isKeyPressed(LogicalKeyboardKey.enter) ||
            event.isKeyPressed(LogicalKeyboardKey.numpadEnter)) {
          if (btnOk == null && btnOkOnPress != null) {
            _dismissType = DismissType.BTN_OK;
            dismiss();
            btnOkOnPress?.call();
          }
        }
      },
      child: child,
    )
        : child;
  }


  /// Returns the default `Cancel Button` widget


  /// Called to dismiss the dialog using the [Navigator.pop] method
  /// or calls the [onDissmissCallback] function if [autoDismiss] is `false`
  void dismiss() {
    if (autoDismiss) {
      Navigator.of(context, rootNavigator: useRootNavigator).pop();
    }
    onDissmissCallback?.call(_dismissType);
    _onDissmissCallbackCalled = true;
  }

  /// Executes when `back button` pressed or `barrier dismissed`
  Future<bool> _onWillPop() async {
    //Determine whenever the dismiss is from Modal Barrier or BackButton
    if (StackTrace.current.toString().contains('ModalBarrier')) {
      if (dismissOnTouchOutside) {
        _dismissType = DismissType.MODAL_BARRIER;
        dismiss();
      }
    } else if (dismissOnBackKeyPress) {
      //BackButton
      _dismissType = DismissType.ANDROID_BACK_BTN;
      dismiss();
    }

    return false;
  }
}



class VerticalStackDialogCustom extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;
  final String? desc;
  final TextStyle? descStyle;
  final Widget? btnOk;
  final Widget? btnCancel;
  final Widget? header;
  final Widget? body;
  final bool isDense;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry padding;
  final bool keyboardAware;
  final double? width;
  final bool? showCloseIcon;
  final Function() onClose;
  final Widget? closeIcon;
  final Color? dialogBackgroundColor;
  final BorderSide? borderSide;
  final BorderRadiusGeometry? borderRadius;
  final double bodyHeaderDistance;
  final double headerheight;
  final double headerwidth;
  final Color headerborderColor;
  final EdgeInsets buttonPadding;

  const VerticalStackDialogCustom({
    Key? key,
    this.title,
    this.titleStyle,
    this.desc,
    this.descStyle,
    this.btnOk,
    this.btnCancel,
    this.body,
    this.alignment,
    this.isDense = true,
    required this.header,
    required this.padding,
    this.keyboardAware = true,
    this.width,
    this.showCloseIcon,
    required this.onClose,
    this.closeIcon,
    this.dialogBackgroundColor,
    this.borderSide,
    this.borderRadius,
    this.bodyHeaderDistance = 15.0,
    this.headerheight =90,
    this.headerwidth =90,
    this.headerborderColor = Colors.white,
    this.buttonPadding =  const EdgeInsets.all(0)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      alignment: alignment,
      padding: EdgeInsets.only(
          bottom: keyboardAware ? mediaQueryData.viewInsets.bottom : 0),
      child: Stack(
        children: <Widget>[
          Container(
            width: width ?? mediaQueryData.size.width,
            padding: isDense
                ?  EdgeInsets.only(
                top: headerwidth.w / 2, left: 15.w, right: 15.w, bottom: 15.0.w)
                :  EdgeInsets.only(
                top: headerwidth.w / 2, left: 40.0.w, right: 40.0.w, bottom: 15.0.w),
            child: Material(
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius ??
                    const BorderRadius.all(
                      Radius.circular(20),
                    ),
                side: borderSide ?? BorderSide.none,
              ),
              elevation: 0.5,
              color: dialogBackgroundColor ?? theme.cardColor,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: headerwidth.w / 2 + bodyHeaderDistance,
                    ),
                    body ??
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            if (title != null) ..._titleBody(title!, theme),
                            if (desc != null)
                              Flexible(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Text(
                                    desc!,
                                    textAlign: TextAlign.center,
                                    style: descStyle,
                                  ),
                                ),
                              ),
                          ],
                        ),
                    if (desc != null)
                      SizedBox(
                        height: 15.w,
                      ),
                    if (btnOk != null || btnCancel != null)
                      Container(
                        padding: buttonPadding,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            if (btnCancel != null)
                              Expanded(
                                child: btnCancel ?? Container(),
                              ),
                            // if (btnCancel != null && btnOk != null)
                            //    SizedBox(
                            //     width: 10.w,
                            //   ),
                            if (btnOk != null)
                              Expanded(
                                child: btnOk!,
                              )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          if (header != null)
            SizedBox(
              width: width ?? mediaQueryData.size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: headerwidth.w,
                    height: headerheight.w,
                    decoration: BoxDecoration(
                        color: APP_THEME_COLOR,
                        borderRadius: BorderRadius.circular(headerwidth.w / 2),
                        border: Border.all(
                            color: APP_THEME_COLOR, width: 1)),
                    child: CircleAvatar(
                      backgroundColor: APP_THEME_COLOR,
                      radius: headerwidth.w / 2,
                      child: header,
                    ),
                  ),
                ],
              ),
            ),
          if (showCloseIcon!)
            Positioned(
              right: 50.0,
              top: 75.0,
              child: GestureDetector(
                onTap: () {
                  onClose.call();
                },
                child: closeIcon ?? const Icon(Icons.close),
              ),
            ),
        ],
      ),
    );
  }

  /// The default widget for the Title of dialog
  List<Widget> _titleBody(String title, ThemeData theme) => <Widget>[
    Text(
      title,
      textAlign: TextAlign.center,
      style: titleStyle ?? theme.textTheme.headline6,
    ),
    const SizedBox(
      height: 10.0,
    ),
  ];
}


class VerticalStackDialogCustomWithBackButton extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;
  final String? desc;
  final TextStyle? descStyle;
  final Widget? btnOk;
  final Widget? btnCancel;
  final Widget? header;
  final Widget? body;
  final bool isDense;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry padding;
  final bool keyboardAware;
  final double? width;
  final bool? showCloseIcon;
  final Function() onClose;
  final Widget? closeIcon;
  final Color? dialogBackgroundColor;
  final BorderSide? borderSide;
  final BorderRadiusGeometry? borderRadius;
  final double bodyHeaderDistance;
  final double headerheight;
  final double headerwidth;
  final Color headerborderColor;
  final EdgeInsets buttonPadding;

  const VerticalStackDialogCustomWithBackButton({
    Key? key,
    this.title,
    this.titleStyle,
    this.desc,
    this.descStyle,
    this.btnOk,
    this.btnCancel,
    this.body,
    this.alignment,
    this.isDense = true,
    required this.header,
    required this.padding,
    this.keyboardAware = true,
    this.width,
    this.showCloseIcon,
    required this.onClose,
    this.closeIcon,
    this.dialogBackgroundColor,
    this.borderSide,
    this.borderRadius,
    this.bodyHeaderDistance = 15.0,
    this.headerheight =90,
    this.headerwidth =90,
    this.headerborderColor = Colors.white,
    this.buttonPadding =  const EdgeInsets.all(0)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      alignment: alignment,
      padding: EdgeInsets.only(
          bottom: keyboardAware ? mediaQueryData.viewInsets.bottom : 0),
      child: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(
                maxHeight: Get.height / 2
            ),
            width: width ?? mediaQueryData.size.width,
            padding: isDense
                ?  EdgeInsets.only(
                top: headerwidth.w / 2, left: 15.w, right: 15.w, bottom: 60.0.w)
                :  EdgeInsets.only(
                top: headerwidth.w / 2, left: 40.0.w, right: 40.0.w, bottom: 15.0.w),
            child: Material(
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius ??
                    const BorderRadius.all(
                      Radius.circular(20),
                    ),
                side: borderSide ?? BorderSide.none,
              ),
              elevation: 0.5,
              color: dialogBackgroundColor ?? theme.cardColor,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: headerwidth.w / 2 + bodyHeaderDistance,
                    ),
                    body ??
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            if (title != null) ..._titleBody(title!, theme),
                            if (desc != null)
                              Flexible(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Text(
                                    desc!,
                                    textAlign: TextAlign.center,
                                    style: descStyle,
                                  ),
                                ),
                              ),

                          ],
                        ),
                    SizedBox(
                      height: headerwidth.w / 2,
                    ),
                    if (desc != null)
                      SizedBox(
                        height: 15.w,
                      ),
                    if (btnOk != null || btnCancel != null)
                      Container(
                        padding: buttonPadding,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            if (btnCancel != null)
                              Expanded(
                                child: btnCancel ?? Container(),
                              ),
                            // if (btnCancel != null && btnOk != null)
                            //    SizedBox(
                            //     width: 10.w,
                            //   ),
                            if (btnOk != null)
                              Expanded(
                                child: btnOk!,
                              )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          if (header != null)
            SizedBox(
              width: width ?? mediaQueryData.size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: headerwidth.w,
                    height: headerheight.w,
                    // decoration: BoxDecoration(
                    //     color: AppColors.WHITE,
                    //     borderRadius: BorderRadius.circular(headerwidth.w / 2),
                    //     border: Border.all(
                    //         color: headerborderColor, width: 1)),
                    child: CircleAvatar(
                      backgroundColor: dialogBackgroundColor ?? theme.cardColor,
                      radius: headerwidth.w / 2,
                      child: header,
                    ),
                  ),
                ],
              ),
            ),
          // if (showCloseIcon!)
          //   Positioned(
          //     right: 50.0,
          //     top: 75.0,
          //     child: GestureDetector(
          //       onTap: () {
          //         onClose.call();
          //       },
          //       child: closeIcon ?? const Icon(Icons.close),
          //     ),
          //   ),
          //
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Material(
              color: AppColors.TRANSPARENT,
              child: Center(
                child: CustomButtons.RoundIconButton(
                    image: CANCEL_ICON,
                    onTap: () {
                      Get.back();
                    },
                    bgColor: AppColors.WHITE,
                    radius: 40.w / 2,
                    height: 40.w,
                    width: 40.w,
                    boxShadow: false,
                    imgColor: AppColors.BLACK),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// The default widget for the Title of dialog
  List<Widget> _titleBody(String title, ThemeData theme) => <Widget>[
    Text(
      title,
      textAlign: TextAlign.center,
      style: titleStyle ?? theme.textTheme.headline6,
    ),
    const SizedBox(
      height: 10.0,
    ),
  ];
}

class AnimatedButton extends StatefulWidget {
  /// Function to execute when button is pressed
  final Function() pressEvent;

  /// Text of the [AnimatedButton]
  final String? text;

  /// Icon for the [AnimatedButton]
  final IconData? icon;

  /// Width of the [AnimatedButton]
  final double width;

  /// Height of the [AnimatedButton]
  final double? height;

  /// If true, height is setted to `50.0`.
  ///
  /// Priority over [height]
  final bool isFixedHeight;

  /// Color for the [AnimatedButton]
  final Color? color;

  /// Border Radius of the [AnimatedButton]
  final BorderRadiusGeometry? borderRadius;

  /// Textstyle to use for the text of the [AnimatedButton]
  final TextStyle? buttonTextStyle;

  const AnimatedButton({
    Key? key,
    required this.pressEvent,
    this.text,
    this.icon,
    this.color,
    this.height,
    this.isFixedHeight = true,
    this.width = double.infinity,
    this.borderRadius,
    this.buttonTextStyle,
  }) : super(key: key);

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  static const int _forwardDurationNumber = 150;
  late AnimationController _animationController;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _forwardDurationNumber),
      reverseDuration: const Duration(milliseconds: 100),
    )..addStatusListener(
      _animationStatusListener,
    );
    _scale = Tween<double>(
      begin: 1,
      end: 0.9,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeIn,
      ),
    );
  }

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _onTap() async {
    _animationController.forward();
    //Delayed added in purpose to keep same animation behavior as previous version when dialog was closed while animation was still playing
    await Future<void>.delayed(
      const Duration(milliseconds: _forwardDurationNumber ~/ 2),
    );
    widget.pressEvent();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: _animatedButtonUI,
    );
  }

  Widget get _animatedButtonUI => SizedBox(
    width: widget.width,
    height: widget.isFixedHeight ? 50 : widget.height,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: widget.color,
        shape: RoundedRectangleBorder(
          borderRadius: widget.borderRadius ??
              const BorderRadius.all(
                Radius.circular(100),
              ),
        ),
      ),
      onPressed: _onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (widget.icon != null) ...<Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Icon(
                widget.icon,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
          Flexible(
            child: Text(
              '${widget.text}',
              // maxLines: 1,
              textAlign: TextAlign.center,
              style: widget.buttonTextStyle ??
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
            ),
          ),
        ],
      ),
    ),
  );
}