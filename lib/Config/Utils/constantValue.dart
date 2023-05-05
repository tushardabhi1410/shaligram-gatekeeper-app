// bottom navigator height
import 'package:avinashgatekeeper/Config/Helper/SizeConfige.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl_phone_field/countries.dart';

import 'color.dart';

const BOTTOM_HEIGHT = 65.0;
const APP_BAR_HEIGHT = 65;
String Commonmessage = "";
// padding of screen
const PADDING = 15.0;


const BUILDER_ID = "avinashgroup";
//<editor-fold desc = "Bottom Navigator Icon Key">

const HOMEMENU = "visitor";
const PROPERTIESMENU = "staff";
const FAVOURITEMENU = "builderstaff";
const ACCOUNTMENU = "directory";
const MENU = "menu";

//</editor-fold>






TextStyle descTextStyle = TextStyle(
  fontSize: 15
);

TextStyle mediumLightTextStyle = TextStyle(
  fontSize: 16,
  color: AppColors.BLACK
);

TextStyle mediumDarkTextStyle = TextStyle(
    fontSize: 20,
    color: AppColors.BLACK,
  fontWeight: FontWeight.bold
);

TextStyle titleTextStyle = TextStyle(
  fontSize: 25.sp,
  fontWeight: FontWeight.w500
);
//</editor-fold>

BoxShadow boxShadow = BoxShadow(
    color: AppColors.SHADOW,
    blurRadius: 1,
    spreadRadius: 1,
    offset: Offset(0,1)
);

BoxShadow boxShadowback = BoxShadow(
    color: AppColors.SHADOW,
    blurRadius: 1,
    spreadRadius: 1,
    offset: Offset(-1,-1)
);

FontWeight fontWeight = FontWeight.w500;

//<editor-fold desc = "API AND KEY">

const LOCAL_URL = "https://productionapi.realtyx.co.in/gatekeeper/v1/";
const UAT_URL = "https://shaligramgroup.totalityre.com/api/repeople-app/v1.0/";
const PRODUCTION_URL = "https://productionapi.realtyx.co.in/gatekeeper/v1/";


//const BASE_URL = PRODUCTION_URL;
const BASE_URL = UAT_URL;
const URL_LOGIN = BASE_URL + "login.php";
const URL_VISITOR = BASE_URL + "visitor.php";
const URL_INSERT_VISITOR = BASE_URL + "visitor.php";
const URL_PROJECT_ASSIGNED = BASE_URL + "master.php";
const URL_STAFF = BASE_URL + "staffs/";
const URL_ADD_STAFF = BASE_URL + "gk/";
// const URL_BUILDER_STAFF = BASE_URL + "staff/list/";
const URL_BUILDER_STAFF = BASE_URL + "gatekeeper.php";
const URL_BUILDERIN_STAFF = BASE_URL + "staff/list/";
const URL_DIRECTORY = BASE_URL + "directory.php";
const URL_PRIVACY_POLICY = BASE_URL + "privacypolicy.php";
const URL_FLATCHOICE= BASE_URL + "gatekeeper.php";
const URL_CHECKIN_VISITOR= BASE_URL + "gatekeeper.php";

const URL_VENDORROLESLIST= BASE_URL + "master.php";
const URL_ADDVISITOR= BASE_URL + "visitor.php";
const URL_VISITOR_FILTER= BASE_URL + "visitor.php";
const URL_ADDVENDOR= BASE_URL+"vendors.php";
const URL_ADD_BUILDER_STAFF= BASE_URL + "gatekeeper.php";

const URL_BUILDERSTAFFTYPEDIALOG= "https://productionapi.realtyx.co.in/staff/v1/types/";



const SESSION_UID = "uid";
const SESSION_CUSTOMERID = "customerid";
const SESSION_ROLECODE = "rolecode";
const SESSION_COUNTRY_ID = 'countryid';
const SESSION_USERNAME = "username";
const SESSION_TOKEN = "token";
const SESSION_TOKEN_DETAILS = "token_details";

const SESSION_UNQKEY = "unqkey";
const SESSION_ISS = "iss";
const SESSION_CUSTOMER_EXIST ="iscustomerexist";
const SESSION_FIRSTNAME = "firstName";
const SESSION_LASTNAME = "lastName";
const SESSION_EMAIL = "email";
const SESSION_CONTACTNO = "contactno";
const SESSION_ARRAY = "session_array";
const SESSION_ROLECODETEXT = "rolecodetext";

const SESSION_CAN_UPDATE_PROFILE = "canupdateprofile";

const SESSION_USER = "user";
const SESSION_USER_MOBILENO = "mobile_no";
const SESSION_USER_EMAIL = "email";

//login details
const ISLOGIN = "isLogin";
const SESSION_CMPID = "cmpid";
const SESSION_KEY = "key";
const SESSION_PERSONNAME = "personname";
const SESSION_CONTACT = "contact";
const SESSION_PROFILEPIC = "icon";
const SESSION_USERLOGINTYPE = "userlogintype";
const SESSION_USERLOGINTYPENAME = "userlogintypename";
const SESSION_ISREGISTERED = "isregistered";


//session related declaration
const APP_KEY="f6ae9e240acc761a32e7ab6dc53096f7";
// const CMPID_BEFORE_LOGIN="60549434a958c62f010daa2f";
const CMPID_BEFORE_LOGIN="60549434a958c62f010daa2f";
const PLATFORM="7";
const ISS="repeople-app";

const SESSION_BUILDINGS = "buildings";
const SESSION_USER_ID = "id";


const SESSION_BUILDINGS_PROJECT = "project";
const SESSION_BUILDINGS_PROJECT_NAME = "name";
const SESSION_BUILDINGS_PROJECT_ID = "id";
const SESSION_BUILDINGS_PROJECT_STATUS = "status";
const SESSION_BUILDINGS_PROJECT_MOBILEVIEW = "website_url";
const SESSION_BUILDINGS_PROJECT_WEBSITEURL = "website_url";
const SESSION_BUILDINGS_PROJECT_PROJECTSHARE = "project_share";
const SESSION_BUILDINGS_PROJECT_WHATSAPPNUMBER = "whatsapp_number";
const SESSION_BUILDINGS_PROJECT_WHATSAPPSHARETEXT = "whatsapp_share_text";
const SESSION_BUILDINGS_PROJECT_CALLNUMBER = "call_number";
// const SESSION_USER = "user";

const SESSION_PERSONAL_DETAILS = "personal_details";
const SESSION_PERSONAL_DETAILS_FIRSTNAME = "first_name";
const SESSION_PERSONAL_DETAILS_LASTNAME = "last_name";
const SESSION_PERSONAL_DETAILS_APPDISPLAYNAME = "app_display_name";
const SESSION_PERSONAL_DETAILS_USERDISPLAYNAME = "user_display_name";
const SESSION_PERSONAL_DETAILS_PROFILEIMAGE = "profile_image";
const SESSION_PERSONAL_DETAILS_PROFILEIMAGE_URL = "url";

const SESSION_IS_EMPLOYEE = "IsEmployee";
const SESSION_EMPLOYEE_ID = "EmployeeID";
const SESSION_HAS_EMPLOYEE = "HasEmpLogin";
const SESSION_EMPLOYEE_DATA = "session_employee";

const SESSION_IS_LOGIN = "isLogin";
const ISUPDATENOTNOW = "updatenotnowclick";



const radius = 10.0;
bool isErrorDialogShow = false;
bool isLocationPermissionCheck = false;
bool isUpdateDialogShow = true;
const HIDEDURATION = 2;

const APP_ID = 'com.prestigeapp';

const

String APP_STORE_URL = 'https://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftwareUpdate?id=$APP_ID&mt=8';
String PLAY_STORE_URL = 'https://play.google.com/store/apps/details?id=$APP_ID';


const bottomSafeArea = false;
const Duration nImageDuration = Duration.zero;

int drawerIndex = -1;

bool updateDialogOpen = false;

//New Declaration

Rx<Country> countryIndia = Country(
  name: "India",
  flag: "🇮🇳",
  code: "IN",
  dialCode: "91",
  minLength: 10,
  maxLength: 10,
).obs;

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
  bool isNumberOnly() {
    return RegExp(
        r'^[0-9]+$').hasMatch(this);
  }

  bool isLettersOnly() {
    return RegExp(
        r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$")
        .hasMatch(this);
  }

  bool isValidGSTNO() {
    return RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$')
        .hasMatch(this);
  }
}

double cornarradius = 8;
const APPBAR_HEIGHT = 70.0;