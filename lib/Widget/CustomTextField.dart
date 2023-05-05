import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:avinashgatekeeper/Config/Utils/Style.dart';
import 'package:avinashgatekeeper/Config/Utils/color.dart';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef String? Validator(String? value);
typedef void OnChange(String value);
typedef void OnTapPress();

class CustomTextField extends StatefulWidget {
  String? labelText;
  TextEditingController? controller;
  Validator? validator;
  int? length;
  TextInputType keybordType;
  bool autoFocus;
  Widget? prefix;

  CustomTextField(
      {this.controller,
      this.labelText,
      this.validator,
      this.length,
      this.keybordType = TextInputType.text,
      this.autoFocus = false,this.prefix});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.length,
      keyboardType: widget.keybordType,
      textInputAction: TextInputAction.done,
      controller: widget.controller,
      cursorColor: AppColors.BLACK,
      validator: widget.validator,
      autofocus: widget.autoFocus,
      decoration: InputDecoration(
        counterText: "",
        contentPadding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 12.w),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black38,
        )),
        alignLabelWithHint: true,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: AppColors.BLACK,
        )),
        errorBorder:OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.RED,
            )) ,
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.RED,
            )) ,
        labelText: widget.labelText,
        labelStyle: TextStyle(color: AppColors.BLACK,fontSize: 13.sp),
        prefix: widget.prefix
      ),

    );
  }
}

Widget UnderLineTextField(
    {BuildContext? context,
    String? label,
    String? hint,
    int? maxline,
    bool? focusLabel,
    bool? readOnly = false,
    bool? autoFocus = false,
    required TextEditingController controller,
    TextInputType? inputType,
    FocusNode? focusNode,
    FocusNode? nextFocusNode,
    TextInputType? keybordType,
    String? Function(String?)? validator}) {
  return TextFormField(
    maxLines: maxline,
    keyboardType: keybordType,
    autofocus: autoFocus!,
    controller: controller,
    cursorColor: AppColors.BLACK,
    focusNode: focusNode,
    validator: validator,
    onFieldSubmitted: (value) {
      FocusScope.of(context!).requestFocus(nextFocusNode);
    },
    readOnly: readOnly!,
    textInputAction: TextInputAction.done,
    decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.BLACK)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.BLACK)),
        errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.RED)),
        focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.BLACK)),
        labelText: label,
        labelStyle: TextStyle(
          color: AppColors.BLACK,
          fontSize: 18,
          // fontWeight: FontWeight.bold
        ),
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.SHADOW),
        floatingLabelBehavior:
            focusLabel! ? FloatingLabelBehavior.always : FloatingLabelBehavior.auto),
  );
}

Widget OutlineTextWithLineField(
    {OnTapPress? onTap,
      bool autoFocus = false,
      TextEditingController? controller,
      bool readOnly = false,
      Color cursorColor = Colors.black,
      Color borderColor = Colors.black,
      String hintText = "",
      TextStyle? hintStyle,
      Widget? prefix,
      Widget? suffix,
      TextInputType? textInputType,
      EdgeInsetsGeometry? padding,
      String? errorText = "",
      String? Function(String?)? validator,
      int? maxLength}) {
  return TextFormField(
    onTap: onTap ?? null,
    autofocus: autoFocus,
    maxLength: maxLength,
    keyboardType: textInputType,
    style: TextStyle(color: AppColors.BLACK),

    validator: validator,
    readOnly: readOnly,
    controller: controller,
    cursorColor: cursorColor,
    textInputAction: TextInputAction.done,
    decoration: InputDecoration(
      counterText: "",
      contentPadding: padding ?? EdgeInsets.symmetric(vertical: 15.h, horizontal: 0.w),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.BLACK)),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.BLACK)),
      errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.RED)),
      focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.BLACK)),
      // focusedBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: borderColor)),
      // enabledBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: borderColor)),
      // errorBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: AppColors.RED)),
      // focusedErrorBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: borderColor)),
      hintText: hintText,
      hintStyle:  TextStyle(color: AppColors.SHADOW),
      prefixIcon: prefix ?? null,
      suffixIcon: suffix ?? null,
    ),
  );
}

Widget OutlineTextField(
    {OnTapPress? onTap,
    bool autoFocus = false,
    TextEditingController? controller,
    bool readOnly = false,
    Color cursorColor = Colors.black,
    Color borderColor = Colors.black,
    String hintText = "",
    TextStyle? hintStyle,
    Widget? prefix,
    Widget? suffix,
    TextInputType? textInputType,
    EdgeInsetsGeometry? padding,
    String? errorText = "",
    String? Function(String?)? validator,
    int? maxLength}) {
  return TextFormField(
    onTap: onTap ?? null,
    autofocus: autoFocus,
    maxLength: maxLength,
    keyboardType: textInputType,
    style: TextStyle(color: AppColors.BLACK),
    validator: validator,
    readOnly: readOnly,
    controller: controller,
    cursorColor: cursorColor,
    textInputAction: TextInputAction.done,
    decoration: InputDecoration(
      counterText: "",
      contentPadding: padding ?? EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          )),
      alignLabelWithHint: true,
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.BLACK,
          )),
      errorBorder:OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.RED,
          )) ,
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.RED,
          )) ,
      hintText: hintText,
      hintStyle: hintStyle,
      prefixIcon: prefix ?? null,
      suffixIcon: suffix ?? null,
    ),
  );
}

Widget WithoutBorderTextField({
  BuildContext? context,
  OnTapPress? onTap,
  String? label,
  String? hint,
  bool? focusLabel,
  bool? readOnly = false,
  bool? autoFocus = false,
  int? totalText,
  required TextEditingController controller,
  String? Function(String?)? validator,
  int? maxLine,
  TextInputType? textInputType,
  bool capitalization = false,
  OnChange? onChange,
  Widget? prefix,
  Widget? suffix,
  EdgeInsetsGeometry? padding,
  List<TextInputFormatter>? inputFormatter,
  TextInputAction? textInputAction



}) {
  return Container(
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(color: AppColors.WHITE, borderRadius: BorderRadius.circular(radius)),
    child: TextFormField(
      maxLines: maxLine,
      textCapitalization: capitalization? TextCapitalization.characters : TextCapitalization.none,
      controller: controller,
      maxLength: totalText,
      readOnly: readOnly!,
      onTap:  onTap ?? null,
      keyboardType: textInputType,
      autofocus: autoFocus!,
      validator: validator,
      onChanged: onChange,
      inputFormatters: inputFormatter ?? [],
      textInputAction: textInputAction ?? null,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "$hint",
        hintStyle: TextStyles.textStyleLight14(Colors.black54),
        counterText: "",
        contentPadding: padding ?? EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
        prefixIcon: prefix ?? null,
        suffixIcon: suffix ?? null,
      ),
    ),
  );
}
