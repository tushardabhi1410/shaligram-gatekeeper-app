import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/countries.dart';

import '../Config/Utils/Style.dart';
import '../Config/Utils/color.dart';
import '../Config/Utils/constantValue.dart';
import 'CountryCodeDialog.dart';
import 'CustomDecoration.dart';
import 'IntelCountryCode.dart';

String ccode = "91";
String isocode = "IN";
RxString isocode1 = "INDIA".obs;

typedef void OnTapPress();
typedef void OnChange(String value);
DateTime currentData = DateTime.now();
Future<TimeOfDay?> currenttime = Future(() => TimeOfDay.now());
TextEditingController txtDob = TextEditingController();
TextEditingController txtAnniversary = TextEditingController();
// TextEditingController txtscheduletime = TextEditingController();
Rxn<TextEditingController> txtscheduletime = Rxn(TextEditingController());
Rxn<TextEditingController> txtscheduledate = Rxn(TextEditingController());
FocusNode mobileFocusNode = FocusNode();
Rx<Country> selectedCountry = countryIndia().obs;
RxString countrystr = "IN".obs;
RxString countrycode = "+91".obs;
// TextEditingController txtscheduledate = TextEditingController();

TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
String? _hour, _minute, _time;

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: capitalize(newValue.text),
      selection: newValue.selection,
    );
  }
}

String capitalize(String value) {
  if (value.trim().isEmpty) return "";
  return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
}

Widget SimpleTextField(
  String imageIcon,
  String labelText,
  String hintText,
  TextEditingController controller, [
  double leftIconPadding = 0,
  bool labelAlwaysOpen = true,
  bool isFocus = false,
  String? Function(String?)? validator,
]) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    controller: controller,
    validator: validator,
    style: TextStyle(fontWeight: FontWeight.w600),
    decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: LIGHT_GREY)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: LIGHT_GREY)),
        errorBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        disabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        contentPadding: EdgeInsets.all(20),
        labelStyle: labelAlwaysOpen
            ? TextStyle(
                fontSize: 16,
                color: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.bold)
            : isFocus
                ? TextStyle(fontWeight: FontWeight.bold, color: APP_FONT_COLOR)
                : null,
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey.withOpacity(0.8),
            fontWeight: FontWeight.w400),
        focusColor: Colors.white,
        floatingLabelBehavior: labelAlwaysOpen
            ? FloatingLabelBehavior.always
            : FloatingLabelBehavior.auto,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: leftIconPadding),
          child: Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(10.0),
            decoration: CustomDecorations().backgroundlocal(
                APP_GRAY_COLOR, cornarradius, 0, APP_GRAY_COLOR),
            child: Image.asset(imageIcon),
          ),
        )),
  );
}

Widget SimpleTextFieldNew(
    {OnTapPress? onTap,
    bool autoFocus = false,
    String? imageIcon,
    String? labelText,
    String? hintText,
    Color? labelcolor,
    TextEditingController? controller,
    List<TextInputFormatter>? inputformat,
    String? Function(String?)? validator,
    String? Function(String?)? onChanged,
    String? Function(String?)? onFieldSubmitted,
    TextInputType? textInputType,
    int? maxLength,
    int maxline = 1,
    double leftIconPadding = 0,
    bool labelAlwaysOpen = true,
    bool noautovalidation = false,
    bool isFocus = false}) {
  return TextFormField(
    style: TextStyle(
        fontSize: 18,
        color: AppColors.APP_THEME_COLOR,
        fontWeight: FontWeight.bold),
    autovalidateMode: noautovalidation
        ? AutovalidateMode.disabled
        : AutovalidateMode.onUserInteraction,
    onTap: onTap,
    onChanged: onChanged,
    onFieldSubmitted: onFieldSubmitted,
    maxLength: maxLength,
    validator: validator,
    keyboardType: textInputType,
    controller: controller,
    decoration: InputDecoration(
      border: InputBorder.none,
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: LIGHT_GREY)),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: LIGHT_GREY)),
      errorBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      disabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      focusedErrorBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      enabled: true,
      contentPadding: EdgeInsets.all(20),
      labelStyle: labelAlwaysOpen
          ? TextStyle(
              fontSize: 16,
              color: controller!.text.toString().isNotEmpty
                  ? Colors.grey
                  : Colors.black.withOpacity(0.7),
              //color: Colors.black.withOpacity(0.7),
              // color: labelcolor,
              fontWeight: FontWeight.bold)
          : isFocus
              ? TextStyle(fontWeight: FontWeight.bold, color: APP_FONT_COLOR)
              : null,
      // labelStyle: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.7),
      //     fontWeight: FontWeight.bold),

      // : isFocus
      // ? TextStyle(fontWeight: FontWeight.bold, color: APP_FONT_COLOR)
      // : null,
      labelText: labelText,
      hintText: hintText,
      hintStyle: TextStyle(
          fontSize: 18,
          color: Colors.grey.withOpacity(0.8),
          fontWeight: FontWeight.bold),
      focusColor: Colors.white,
      floatingLabelBehavior: labelAlwaysOpen
          ? FloatingLabelBehavior.always
          : FloatingLabelBehavior.auto,
      //  floatingLabelBehavior:
      // FloatingLabelBehavior.always,
      // prefixIcon: imageIcon!=""?Padding(
      //   padding: EdgeInsets.only(left: 0),
      //   child: Container(
      //     width: 50,
      //     height: 50,
      //     margin: EdgeInsets.only(right: 10),
      //     padding: const EdgeInsets.all(10.0),
      //     decoration: CustomDecorations()
      //         .backgroundlocal(APP_GRAY_COLOR, cornarradius, 0, APP_GRAY_COLOR),
      //     child: Image.asset(imageIcon ?? ""),
      //   ),
      // ):Container(width: 1,height: 1,)
      // prefixIcon: Padding(
      //   padding: EdgeInsets.only(left: leftIconPadding),
      //   child: Container(
      //     width: 50,
      //     height: 50,
      //     margin: EdgeInsets.only(right: 10),
      //     padding: const EdgeInsets.all(10.0),
      //     decoration: CustomDecorations().backgroundlocal(
      //         APP_GRAY_COLOR, cornarradius, 0, APP_GRAY_COLOR),
      //     child: imageIcon.toString().contains("svg")
      //         ? SvgPicture.asset(imageIcon ?? "")
      //         : Image.asset(imageIcon ?? ""),
      //   ),
      // )
    ),
  );
}

Widget PhoneNumberTextField(
  Rxn<TextEditingController>? controller,
) {
  return IntlPhoneCustomField(
    controller: controller?.value,
    disableLengthCheck: false,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    textAlign: TextAlign.left,
    focusNode: mobileFocusNode,
    autofocus: false,
    keyboardType: TextInputType.number,
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    textAlignVertical: TextAlignVertical.bottom,
    selectedCountry: selectedCountry.value,
    flagsButtonPadding: EdgeInsets.only(left: 20),
    validator: (value) => mobilevalidation(value!),
    onSubmitted: (value) {
      //FocusScope.of(contextCommon).requestFocus(cnt_Leads.emailFocusNode);
    },
    style: TextStyles.textStyleDark18(APP_FONT_COLOR),
    dropdownIconPosition: IconPosition.trailing,
    dropdownIcon: Icon(Icons.arrow_drop_down),
    dropdownTextStyle: TextStyles.textStyleDark18(APP_FONT_COLOR),
    showCountryFlag: false,
    hintText: "9876543210",

    hintStyle: TextStyle(
        fontSize: 18,
        color: Colors.grey.withOpacity(0.8),
        fontWeight: FontWeight.bold),
    pickerDialogStyle: PickerDialogCustomStyle(
      backgroundColor: AppColors.WHITE,
      countryCodeStyle: TextStyles.textStyleMedium14(APP_FONT_COLOR),
      searchFieldCursorColor: AppColors.BLACK,
      countryNameStyle: TextStyles.textStyleMedium14(APP_FONT_COLOR),
      listTileDivider: Container(
        height: 0.5,
        color: LIGHT_GREY,
      ),
    ),
    initialCountryCode: 'IN',
    cursorColor: AppColors.BLACK,
    onChanged: (phone) {
      countrycode.value = phone.countryCode;
      if (controller!.value!.text.isNotEmpty) {
        // formMobileKey.currentState!.validate();
      }
    },
    onCountryChanged: (country) {
      selectedCountry.value = country;
      controller?.value?.text = "";
      // formMobileKey.currentState!.validate();
    },
    // ),
    decoration: InputDecoration(
      counterText: "",

      contentPadding: EdgeInsets.only(bottom: 16),
      // contentPadding: EdgeInsets.all(20),
      //labelText: labelOpen ? "" : null,
      hintText: "9876543210",
      hintStyle: TextStyle(
          fontSize: 18,
          color: Colors.grey.withOpacity(0.8),
          fontWeight: FontWeight.bold),

      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: LIGHT_GREY)),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: LIGHT_GREY)),
      errorBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      disabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      focusedErrorBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      //labelText: 'Email',
    ),
  );
}

Widget SimpleTextFieldNewwithcustomization(
    {OnTapPress? onTap,
    bool autoFocus = false,
    String? imageIcon,
    String? labelText,
    String? hintText,
    Color? labelcolor,
    Rxn<TextEditingController>? controller,
    TextCapitalization? textCapitalization,
    List<TextInputFormatter>? inputformat,
    String? Function(String?)? validator,
    String? Function(String?)? onChanged,
    String? Function(String?)? onFieldSubmitted,
    TextInputType? textInputType,
    int? maxLength,
    int maxline = 1,
    double leftIconPadding = 0,
    bool labelAlwaysOpen = true,
    bool noautovalidation = false,
    bool isFocus = false}) {
  return Obx(() => TextFormField(
        style: TextStyles.textStyleDark18(gray_color),
        // TextStyle(fontSize: 18, color: APP_FONT_COLOR, fontWeight: FontWeight.bold),
        autovalidateMode: noautovalidation
            ? AutovalidateMode.disabled
            : AutovalidateMode.onUserInteraction,
        onTap: onTap,

        onChanged: onChanged ??
            (value) {
              controller?.update((val) {});
            },
        // textCapitalization: TextCapitalization.sentences,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        onFieldSubmitted: onFieldSubmitted,
        maxLength: maxLength,
        validator: validator,
        keyboardType: textInputType,
        inputFormatters: inputformat,
        controller: controller?.value,
        decoration: InputDecoration(
          counterText: "",
          border: InputBorder.none,
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: LIGHT_GREY)),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: LIGHT_GREY)),
          errorBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          disabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          enabled: true,
          contentPadding: EdgeInsets.all(20),
          labelStyle: labelAlwaysOpen
              ? TextStyle(
                  fontSize: 16,
                  color: controller!.value!.text.toString().isNotEmpty
                      ? Colors.grey.withOpacity(0.7)
                      : Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w600)
              : isFocus
                  ? TextStyle(
                      fontWeight: FontWeight.w600, color: APP_FONT_COLOR)
                  : null,
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 18,
              color: Colors.grey.withOpacity(0.7),
              fontWeight: FontWeight.bold),
          focusColor: Colors.white,
          floatingLabelBehavior: labelAlwaysOpen
              ? FloatingLabelBehavior.always
              : FloatingLabelBehavior.auto,
        ),
      ));
}

String? mobilevalidation(String value) {
  print(isocode1.value.toString());
  print("isocode1.value.toString()");
  if (value.isEmpty) {
    return "       " + "Please Enter Mobile Number";
  } else if (value.trim().isNotEmpty && !value.trim().isNumberOnly()) {
    return "       " + "Please Enter Only Digits";
  } else if (value.length < 10) {
    return "       " + "Please Enter 10 Digits";
  } else if (value.length > 10) {
    return "       " + "Please Enter Only 10 Digits";
  } else if (isocode1.isEmpty || isocode1.value == "INDIA") {
    return "       " + "Please Select Country Code";
  } else {
    return null;
  }
}

Widget CommonDropDownTextField(
    {OnTapPress? onTap,
    bool autoFocus = false,
    String? imageIcon,
    String? labelText,
    String? hintText,
    TextEditingController? controller,
    List<TextInputFormatter>? inputformat,
    String? Function(String?)? validator,
    String? Function(String?)? onChanged,
    String? Function(String?)? onFieldSubmitted,
    TextInputType? textInputType,
    int? maxLength,
    int maxline = 1,
    double leftIconPadding = 0,
    bool labelAlwaysOpen = true,
    bool noautovalidation = false,
    double padding = 0,
    bool isFocus = false}) {
  return TextFormField(
    onTap: onTap,
    style: TextStyles.textStyleDark18(APP_FONT_COLOR),
    readOnly: true,
    controller: controller,
    validator: validator,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: LIGHT_GREY)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: LIGHT_GREY)),
        errorBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        disabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        contentPadding: EdgeInsets.all(20),
        labelStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey.withOpacity(0.7),
            fontWeight: FontWeight.bold),
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyles.textStyleDark18(APP_FONT_COLOR),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIconConstraints: BoxConstraints(maxWidth: 40, minWidth: 10),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Icon(Icons.arrow_drop_down),
        )),
  );
}

Widget ContactTextField(
  Rxn<TextEditingController> controller, [
  double leftPadding = 0,
  bool labelOpen = true,
  bool hasFocus = false,
  bool padding = false,
  String? Function(String?)? onChanged,
]) {
  return Obx(() => TextFormField(
        onChanged: onChanged ??
            (value) {
              print("im here value is changed");
              controller.update((val) {});
            },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        keyboardType: TextInputType.number,
        controller: controller.value,
        maxLength: 10,
        textAlignVertical: TextAlignVertical.bottom,
        // style: TextStyles.textStyleDark18(APP_FONT_COLOR),
        // textCapitalization: TextCapitalization.words,
        style: TextStyles.textStyleDark18(APP_FONT_COLOR),
        // keyboardType: TextInputType.number,
        autofocus: false,
        //maxLength: 10,
        validator: (value) => mobilevalidation(value!),

        // onSaved: (String? val) {
        //   email = val!;
        // },cursorColor: colorPrimary,
        decoration: InputDecoration(
          counterText: "",
          //prefixIcon: Icon(Icons.star),
          prefixIcon: InkWell(
              onTap: () {
                CountryCodePicker(
                  //showDropDownButton: true,
                  //showOnlyCountryWhenClosed: false,
                  showFlag: false,
                  //enabled: false,
                  //showFlagMain: false,
                  //hideMainText: false,
                  padding: EdgeInsets.only(right: 0),
                  // initialSelection: isocode.toUpperCase(),
                  initialSelection:
                      isocode != null ? isocode.toString().toUpperCase() : "IN",

                  textStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.withOpacity(0.8),
                      fontWeight: FontWeight.bold),
                  onChanged: (CountryCode code) {
                    print(code.name); //get the country name eg: Antarctica
                    print(code
                        .code); //get the country code like AQ for Antarctica
                    print(code
                        .dialCode); //get the country dial code +672 for Antarctica
                    print(code.flagUri);
                    // isocode = code.code!;
                    ccode = code.dialCode!;

                    //get the URL of flag. flags/aq.png for Antarctica
                  },
                );
              },
              child: Padding(
                  padding: EdgeInsets.only(top: 0, left: 10),
                  child: SizedBox(
                      width: 80.w,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            // Padding(
                            //   padding: EdgeInsets.only(left: leftPadding),
                            //   child: Container(
                            //     width: 50,
                            //     height: 50,
                            //     margin: EdgeInsets.only(
                            //       right: 0,
                            //     ),
                            //     padding: EdgeInsets.all(10.0),
                            //     decoration: CustomDecorations()
                            //         .backgroundlocal(APP_GRAY_COLOR,
                            //         cornarradius, 0, APP_GRAY_COLOR),
                            //     child:
                            //     // SvgPicture.asset(IMG_CALL_SVG),
                            //     SvgPicture.asset(IMG_CALL_SVG_NEW),
                            //     //Image.asset(IMG_TELEPHONE),
                            //   ),
                            // ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      padding:
                                          EdgeInsets.only(left: 10, top: 0),
                                      child: Text(
                                        "Mobile*",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: controller.value!.text
                                                    .toString()
                                                    .isNotEmpty
                                                ? Colors.grey.withOpacity(0.7)
                                                : Colors.black.withOpacity(0.7),
                                            // Colors.black
                                            //     .withOpacity(0.7),
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            // alignment: Alignment.center,
                                            width: 50.w,
                                            height: 35,
                                            // color: Colors.green,
                                            padding: EdgeInsets.only(
                                                right: isocode1 == "INDIA"
                                                    ? 0
                                                    : 0),
                                            margin: EdgeInsets.only(
                                                bottom: isocode1 == "INDIA"
                                                    ? 2
                                                    : 0),
                                            child: Obx(() => CountryCodePicker(
                                                  //showDropDownButton: true,
                                                  //showOnlyCountryWhenClosed: false,
                                                  showFlag: false,
                                                  //enabled: false,
                                                  //showFlagMain: false,
                                                  //hideMainText: false,
                                                  padding:
                                                      EdgeInsets.only(right: 0),
                                                  // initialSelection: isocode.toUpperCase(),
                                                  initialSelection:
                                                      isocode1 == ""
                                                          ? "IN"
                                                          : isocode.toString(),
                                                  textStyle: isocode1 ==
                                                              "INDIA" ||
                                                          isocode1.value == ""
                                                      ? TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.grey
                                                              .withOpacity(0.8),
                                                          fontWeight:
                                                              FontWeight.bold)
                                                      : TextStyles
                                                          .textStyleDark18(
                                                              APP_FONT_COLOR),
                                                  onChanged:
                                                      (CountryCode code) {
                                                    print(code
                                                        .name); //get the country name eg: Antarctica
                                                    print(code
                                                        .code); //get the country code like AQ for Antarctica
                                                    print(code
                                                        .dialCode); //get the country dial code +672 for Antarctica
                                                    print(code.flagUri);
                                                    isocode = code.code!;
                                                    isocode1.value = isocode;
                                                    // ccode = code.dialCode!;
                                                    //get the URL of flag. flags/aq.png for Antarctica
                                                  },
                                                ))),
                                        Padding(
                                            padding: EdgeInsets.only(top: 1.w),
                                            child: Icon(Icons.arrow_drop_down)),
                                      ]),
                                ])
                          ])))),
          //suffixIcon: user_email.text.isNotEmpty ?InkWell(child: Icon(Icons.check_circle,size: 15,color: Color(0xff6FCF97),)):SizedBox(),

          contentPadding: EdgeInsets.only(
              top: isocode1 == "INDIA" ? 10.w : 15.w,
              bottom: isocode1 == "INDIA" ? 15 : 19),
          // contentPadding: EdgeInsets.all(20),
          labelText: labelOpen ? "" : null,
          hintText: "9876543210",
          hintStyle: TextStyle(
              fontSize: 18,
              color: Colors.grey.withOpacity(0.8),
              fontWeight: FontWeight.bold),
          floatingLabelBehavior: labelOpen
              ? FloatingLabelBehavior.always
              : FloatingLabelBehavior.never,
          labelStyle: TextStyle(
              fontSize: 16,
              color: controller.value!.text.toString().isNotEmpty
                  ? Colors.grey.withOpacity(0.7)
                  : Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w600),

          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: LIGHT_GREY)),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: LIGHT_GREY)),
          errorBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          disabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          //labelText: 'Email',
        ),
      ));
}

Widget DropDownDOB(
    String imageIcon,
    String labelText,
    String hintText,
    // TextEditingController controller,
    Rxn<TextEditingController>? controller,
    [double leftPadding = 0,
    bool labelOpen = true,
    FontWeight fontWeight = FontWeight.w600,
    bool isFocus = false]) {
  return Obx(() => TextFormField(
        onChanged: (value) {
          print("im in on change " + value);
          controller?.update((val) {});
        },
        readOnly: true,
        validator: (value) => validation(value, "Please select date"),
        onTap: () {
          OpenDatePickerDOBDialog(DateTime(1900), DateTime.now(), controller);
          controller?.update((val) {});
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller?.value,
        style: TextStyles.textStyleDark18(APP_FONT_COLOR),
        // TextStyle(fontSize: 18, color: APP_FONT_COLOR, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: LIGHT_GREY)),
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: LIGHT_GREY)),
            errorBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            disabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            focusedErrorBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            contentPadding: EdgeInsets.all(20),
            labelStyle: labelOpen
                ? TextStyle(
                    fontSize: 16,
                    color: controller!.value!.text.toString().isNotEmpty
                        ? Colors.grey.withOpacity(0.7)
                        : Colors.black.withOpacity(0.7),
                    //color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.bold)
                : isFocus
                    ? TextStyle(
                        fontWeight: FontWeight.bold, color: APP_FONT_COLOR)
                    : null,
            labelText: labelText,
            hintText: hintText,
            hintStyle: TextStyles.textStyleDark18(Colors.grey.withOpacity(0.8)),
            floatingLabelBehavior: labelOpen
                ? FloatingLabelBehavior.always
                : FloatingLabelBehavior.auto,
            suffixIconConstraints: BoxConstraints(maxWidth: 40, minWidth: 10),
            // prefixIconConstraints: BoxConstraints(maxWidth: 50),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(Icons.arrow_drop_down),
            )),
      ));
}

Widget DropDownScheduleDate(String imageIcon, String labelText, String hintText,
    Rxn<TextEditingController>? controller,
    [double leftPadding = 0,
    bool labelOpen = true,
    FontWeight fontWeight = FontWeight.bold]) {
  return InkWell(
    onTap: () {},
    child: TextFormField(
      readOnly: true,
      validator: (value) => validation(value, "Please select date"),
      onTap: () {
        OpenDatePickerDOBDialog(DateTime(1900), DateTime.now(), controller);
      },
      controller: controller?.value,
      style: TextStyles.textStyleDark18(APP_FONT_COLOR),
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: LIGHT_GREY)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: LIGHT_GREY)),
        errorBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        disabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        contentPadding: EdgeInsets.all(20),
        labelStyle: TextStyle(
            fontSize: 16,
            color: controller!.value!.text.toString().isNotEmpty
                ? Colors.grey.withOpacity(0.7)
                : Colors.black.withOpacity(0.7),
            // color: Colors.black.withOpacity(0.7),
            fontWeight: FontWeight.bold),
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyles.textStyleDark18(
          Colors.grey.withOpacity(0.8),
        ),
        floatingLabelBehavior: labelOpen
            ? FloatingLabelBehavior.always
            : FloatingLabelBehavior.auto,
      ),
    ),
  );
}

Widget DropDownTime(String imageIcon, String labelText, String hintText,
    Rxn<TextEditingController> controller,
    [double leftPadding = 0,
    bool labelOpen = true,
    FontWeight fontWeight = FontWeight.bold]) {
  return InkWell(
    onTap: () {
      _selectTime(Get.context!);
      //OpenDatePickerDOBDialog(DateTime(1900),DateTime(2100));
    },
    child: TextFormField(
      readOnly: true,
      onTap: () {
        OpenTimePicker();
      },
      controller: txtscheduletime.value,
      style: TextStyle(
          fontSize: 18, color: APP_FONT_COLOR, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: LIGHT_GREY)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: LIGHT_GREY)),
        contentPadding: EdgeInsets.all(20),
        labelStyle: TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(0.7),
            fontWeight: FontWeight.bold),
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(color: APP_FONT_COLOR, fontWeight: fontWeight),
        floatingLabelBehavior: labelOpen
            ? FloatingLabelBehavior.always
            : FloatingLabelBehavior.auto,
        prefixIcon: Container(
          width: 50,
          height: 50,
          margin: EdgeInsets.only(right: 10, left: leftPadding),
          padding: const EdgeInsets.all(10.0),
          decoration: CustomDecorations()
              .backgroundlocal(APP_GRAY_COLOR, cornarradius, 0, APP_GRAY_COLOR),
          child: Image.asset(imageIcon),
        ),
      ),
    ),
  );
}

Widget DropDownAnniversary(
    String imageIcon,
    String labelText,
    String hintText,
    // TextEditingController controller,
    Rxn<TextEditingController>? controller,
    [double leftPadding = 0,
    bool labelOpen = true,
    FontWeight fontWeight = FontWeight.bold,
    bool isFocus = false]) {
  return Obx(() => TextFormField(
        readOnly: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => validation(value, "Please select date"),
        onChanged: (value) {
          print("im in on change " + value);
          controller?.update((val) {});
        },

        onTap: () {
          // OpenDatePickerDOBDialog( DateTime(1900), DateTime.now(), controller);
          // controller?.update((val) { });
          OpenDatePickerAnniveraryDialog(
              DateTime(1900), DateTime.now(), controller);
          controller?.update((val) {});
        },
        controller: controller?.value,
        style: TextStyles.textStyleDark18(APP_FONT_COLOR),
        //TextStyle(fontSize: 18, color: APP_FONT_COLOR, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: LIGHT_GREY)),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: LIGHT_GREY)),
          errorBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          disabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          contentPadding: EdgeInsets.all(20),
          labelStyle: labelOpen
              ? TextStyle(
                  fontSize: 16,
                  color: controller!.value!.text.toString().isNotEmpty
                      ? Colors.grey.withOpacity(0.7)
                      : Colors.black.withOpacity(0.7),
                  // color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.bold)
              : isFocus
                  ? TextStyle(
                      fontWeight: FontWeight.bold, color: APP_FONT_COLOR)
                  : null,
          // TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.bold),
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(
              color: /*APP_FONT_COLOR*/ Colors.grey.withOpacity(0.8),
              fontWeight: fontWeight),
          floatingLabelBehavior: labelOpen
              ? FloatingLabelBehavior.always
              : FloatingLabelBehavior.auto,
        ),
      ));
}

OpenDatePickerDOBDialog(DateTime firstdate, DateTime lastdate,
    Rxn<TextEditingController>? datecontroller) async {
  DateTime? _datePicker = await showDatePicker(
    context: Get.context!,
    initialDate: currentData,
    firstDate: firstdate,
    lastDate: lastdate,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: APP_THEME_COLOR, // <-- SEE HERE
            onPrimary: AppColors.WHITE, // <-- SEE HERE
            onSurface: AppColors.BLACK, // <-- SEE HERE
          ),
          textTheme: TextTheme(
              bodyText1: TextStyle(
                  fontSize: 10), // <-- here you can do your font smaller
              bodyText2:
                  TextStyle(fontSize: 8.0, fontFamily: 'Poppins-Medium')),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: AppColors.BLACK, // button text color
            ),
          ),
        ),
        child: child!,
      );
    },
  );

  if (_datePicker != null) {
    currentData = _datePicker;
    var dateFormat = DateFormat("d MMMM y");

    print(_datePicker);
    datecontroller?.value?.text = dateFormat.format(_datePicker);
    datecontroller?.update((val) {});
  }
}

Future<Null> _selectTime(BuildContext context) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: selectedTime,
  );
  if (picked != null)
    // setState(() {
    selectedTime = picked;
  _hour = selectedTime.hour.toString();
  _minute = selectedTime.minute.toString();
  _time = _hour! + ' : ' + _minute!;
  txtscheduletime.value?.text = _time!;
}

OpenTimePicker() async {
  Future<TimeOfDay?> selectedTime = showTimePicker(
      initialTime: TimeOfDay.now(),
      context: Get.context!,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: APP_THEME_COLOR, // <-- SEE HERE
              onPrimary: AppColors.WHITE, // <-- SEE HERE
              onSurface: AppColors.BLACK, // <-- SEE HERE
            ),
            textTheme: TextTheme(
                bodyText1: TextStyle(
                    fontSize: 10), // <-- here you can do your font smaller
                bodyText2:
                    TextStyle(fontSize: 8.0, fontFamily: 'Poppins-Medium')),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: AppColors.BLACK, // button text color
              ),
            ),
          ),
          child: child!,
        );
      });

  currenttime = selectedTime;
  print(selectedTime);
}

OpenDatePickerAnniveraryDialog(DateTime firstdate, DateTime lastdate,
    Rxn<TextEditingController>? anniverserycontroller) async {
  DateTime? _datePicker = await showDatePicker(
    context: Get.context!,
    initialDate: currentData,
    firstDate: firstdate,
    lastDate: lastdate,
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: APP_THEME_COLOR, // <-- SEE HERE
            onPrimary: AppColors.WHITE, // <-- SEE HERE
            onSurface: AppColors.BLACK, // <-- SEE HERE
          ),
          textTheme: TextTheme(
              bodyText1: TextStyle(
                  fontSize: 10), // <-- here you can do your font smaller
              bodyText2:
                  TextStyle(fontSize: 8.0, fontFamily: 'Poppins-Medium')),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: AppColors.BLACK, // button text color
            ),
          ),
        ),
        child: child!,
      );
    },
  );

  if (_datePicker != null) {
    currentData = _datePicker;
    var dateFormat = DateFormat("d MMMM y");

    print(_datePicker);
    anniverserycontroller?.value?.text = dateFormat.format(_datePicker);
    anniverserycontroller?.update((val) {});
  }
}

_selectTime_with_no(BuildContext context, int startTime) async {
  final TimeOfDay? picked = await showTimePicker(
    builder: (BuildContext? context, Widget? child) {
      return Column(
        children: [
          Theme(
            data: Theme.of(context!).copyWith(
              colorScheme: ColorScheme.light(
                primary: APP_THEME_COLOR, // <-- SEE HERE
                onPrimary: AppColors.WHITE, // <-- SEE HERE
                onSurface: APP_THEME_COLOR, // <-- SEE HERE
              ),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 10), // <-- here you can do your font smaller
                  bodyText2:
                      TextStyle(fontSize: 8.0, fontFamily: 'Poppins-Medium')),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: APP_THEME_COLOR, // button text color
                ),
              ),
            ),
            child: child!
            /* MediaQuery(
            data: MediaQuery.of(context!).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          )*/
            ,
          ),
        ],
      );
    },
    context: context,
    initialTime: startTime == 0
        ? TimeOfDay.now()
        : TimeOfDay(hour: startTime ~/ 60, minute: startTime % 60),
  );
  if (picked != null) {
    selectedTime = picked;
  }
  final now = new DateTime.now();
  final dt = DateTime(
      now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
  final format = DateFormat.jm();
  // print(tod.hour);//"6:00 AM"
  //   print(tod.minute);//"6:00 AM"
  //return format.format(dt);
  // int totoalmnt = (selectedTime.hour * 60) + selectedTime.minute;
  txtscheduletime.value?.text = format.format(dt);
  print(txtscheduletime.toString() + "scheduledtimedsg");
  txtscheduletime.update((val) {});

  // return totoalmnt;
}

Widget DropDownTimeSelect(String imageIcon, String labelText, String hintText,
    Rxn<TextEditingController>? controller,
    [double leftPadding = 0,
    bool labelOpen = true,
    FontWeight fontWeight = FontWeight.w600,
    bool isFocus = false]) {
  return Obx(() => InkWell(
        onTap: () {
          print("time");
          //_selectTime_with_no(Get.context!, 0);
        },
        child: TextFormField(
          onChanged: (value) {
            controller?.update((val) {});
          },

          onTap: () {
            _selectTime_with_no(Get.context!, 0);
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) => validation(value, "Please select time"),
          readOnly: true,
          controller: txtscheduletime.value,
          style: TextStyles.textStyleDark18(APP_FONT_COLOR),
          // TextStyle(fontSize: 18, color: APP_FONT_COLOR, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: LIGHT_GREY)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: LIGHT_GREY)),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)),
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)),
              focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red)),
              contentPadding: EdgeInsets.all(20),
              labelStyle: labelOpen
                  ? TextStyle(
                      fontSize: 16,
                      color: controller!.value!.text.toString().isNotEmpty
                          ? Colors.grey.withOpacity(0.7)
                          : Colors.black.withOpacity(0.7),
                      // color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.bold)
                  : isFocus
                      ? TextStyle(
                          fontWeight: FontWeight.bold, color: APP_FONT_COLOR)
                      : null,
              // TextStyle(
              //     fontSize: 16, color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.bold),
              labelText: labelText,
              hintText: hintText,
              hintStyle: TextStyles.textStyleDark18(
                Colors.grey.withOpacity(0.8),
              ),
              floatingLabelBehavior: labelOpen
                  ? FloatingLabelBehavior.always
                  : FloatingLabelBehavior.auto,
              suffixIconConstraints: BoxConstraints(maxWidth: 40, minWidth: 10),
              // prefixIconConstraints: BoxConstraints(maxWidth: 50),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(Icons.arrow_drop_down),
              )),
        ),
      ));
}

Widget DropDownTextField(String imageIcon, String labelText, String hintText,
    TextEditingController controller,
    [double leftPadding = 0,
    bool labelOpen = true,
    FontWeight fontWeight = FontWeight.w600]) {
  return InkWell(
    onTap: () {},
    child: TextFormField(
      style: TextStyle(
          fontSize: 16, color: APP_FONT_COLOR, fontWeight: FontWeight.w600),
      readOnly: true,
      decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: LIGHT_GREY)),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: LIGHT_GREY)),
          contentPadding: EdgeInsets.all(20),
          labelStyle: TextStyle(
              fontSize: 16,
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.bold),
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(
            color: APP_FONT_COLOR,
            fontWeight: fontWeight,
          ),
          floatingLabelBehavior: labelOpen
              ? FloatingLabelBehavior.always
              : FloatingLabelBehavior.auto,
          prefixIcon: Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.only(right: 10, left: leftPadding),
            padding: const EdgeInsets.all(10.0),
            decoration: CustomDecorations().backgroundlocal(
                APP_GRAY_COLOR, cornarradius, 0, APP_GRAY_COLOR),
            child: Image.asset(imageIcon),
          ),
          suffixIcon: Icon(Icons.arrow_drop_down)),
    ),
  );
}

Widget SimpleTextFormField(
    {BuildContext? context,
    OnTapPress? onTap,
    bool autoFocus = false,
    bool obscureText = false,
    TextEditingController? controller,
    bool readOnly = false,
    bool showCursor = true,
    bool firstCharCapital = true,
    Color cursorColor = Colors.black,
    Color borderColor = Colors.black,
    String hintText = "Send Message...",
    // String errorText = "",
    TextStyle? hintStyle,
    Widget? prefix,
    Widget? suffix,
    FontWeight? fontWeight,
    TextInputType? keyboardType,
    EdgeInsetsGeometry? padding,
    String? errorText = "",
    FocusNode? focusNode,
    FocusNode? nextFocusNode,
    TextInputAction? textInputAction,
    double? fontSize = 16,
    String? Function(String?)? validator,
    int? maxLength,
    OnChange? onChange,
    List<TextInputFormatter>? inputFormatters}) {
  return TextFormField(
    onTap: onTap,
    autofocus: autoFocus,
    maxLength: maxLength,
    textCapitalization: firstCharCapital
        ? TextCapitalization.sentences
        : TextCapitalization.none,
    style: TextStyle(
        color: AppColors.WHITE, fontSize: 15, fontWeight: fontWeight ?? null),
    validator: validator,
    readOnly: readOnly,
    focusNode: focusNode,
    controller: controller,
    keyboardType: keyboardType,
    // autovalidateMode: AutovalidateMode.disabled ,
    // textCapitalization: TextCapitalization.characters,
    obscureText: obscureText,
    cursorColor: cursorColor,
    showCursor: showCursor,
    inputFormatters: inputFormatters,
    textInputAction: textInputAction,
    // onSubmitted: (value) {
    //   FocusScope.of(context!).requestFocus(nextFocusNode);
    // },
    onFieldSubmitted: (value) {
      FocusScope.of(context!).requestFocus(nextFocusNode);
    },
    onChanged: onChange,
    decoration: InputDecoration(
      // errorText: errorText!.isNotEmpty ? errorText : null,
      counterText: "",
      border: InputBorder.none,
      contentPadding:
          // padding ?? EdgeInsets.symmetric(vertical: 17, horizontal: 15),
          EdgeInsets.only(top: 15, left: 15),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.APP_THEME_COLOR)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.APP_THEME_COLOR)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.APP_THEME_COLOR)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.APP_THEME_COLOR)),
      hintText: "Send Message...",
      hintStyle: TextStyle(
        fontSize: 15,
        color: LIGHT_GREY.withOpacity(0.3),
      ),
      prefixIcon: prefix ?? null,
      suffixIcon: Padding(
        padding: EdgeInsets.only(top: 15, bottom: 15),
        child: IconButton(
          padding: EdgeInsets.all(0),
          icon: Container(),
          onPressed: () {},
        ),
      ),
    ),
  );
}

String? validation(String? value, String message) {
  if (value!.trim().isEmpty) {
    return message;
  } else {
    return null;
  }
}

String? emailvalidation(String? value) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value!);
  if (value.trim().isEmpty) {
    return "" + "Please enter your email";
  } else if (!emailValid) {
    return "" + "Please enter your valid email";
  } else {
    return null;
  }
}
