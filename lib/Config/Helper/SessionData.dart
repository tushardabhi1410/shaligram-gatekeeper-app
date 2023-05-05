import 'dart:convert';

import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:shared_preferences/shared_preferences.dart';




Future storeSessionArray(Map<String , dynamic> responseData)async{
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setString(SESSION_ARRAY, jsonEncode(responseData));
  sp.commit();
}

Future<String> getData(String key)async{
  SharedPreferences sp = await SharedPreferences.getInstance();
    Map<String,dynamic> data = jsonDecode(sp.getString(SESSION_ARRAY) ?? "");

   return data[key].toString();
}

Future<void> StoreLoginSessionData(Map<String, dynamic> responseData) async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setBool(ISLOGIN, true);

  sp.setString(SESSION_UID, responseData[SESSION_UID] ?? "");
  sp.setString(SESSION_CMPID, responseData[SESSION_CMPID] ?? "");
  sp.setString(SESSION_KEY, responseData[SESSION_KEY] ?? "");
  sp.setString(SESSION_UNQKEY, responseData[SESSION_UNQKEY] ?? "");
  sp.setString(SESSION_ISS, responseData[SESSION_ISS] ?? "");
  sp.setString(SESSION_PERSONNAME, responseData[SESSION_PERSONNAME] ?? "");
  sp.setString(SESSION_EMAIL, responseData[SESSION_EMAIL] ?? "");
  sp.setString(SESSION_CONTACT, responseData[SESSION_CONTACT] ?? "");
  sp.setString(SESSION_PROFILEPIC, responseData[SESSION_PROFILEPIC] ?? "");
  sp.setString(SESSION_FIRSTNAME, responseData[SESSION_FIRSTNAME] ?? "");
  sp.setString(SESSION_LASTNAME, responseData[SESSION_LASTNAME] ?? "");
  sp.setString(SESSION_USERLOGINTYPE, responseData[SESSION_USERLOGINTYPE].toString() );
  sp.setString(SESSION_USERLOGINTYPENAME, responseData[SESSION_USERLOGINTYPENAME].toString());
  sp.setString(SESSION_ISREGISTERED, responseData[SESSION_ISREGISTERED].toString());
  sp.commit();
}


Future<void> updateData(String key,String value)async{
  SharedPreferences sp = await SharedPreferences.getInstance();
  Map<String,dynamic> data = jsonDecode(sp.getString(SESSION_ARRAY) ?? "");
  data[key] = value;
  print(data);
  sp.setString(SESSION_ARRAY, jsonEncode(data));
}
Future<void> setData(String key,String value)async{
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setString(key, value);
}

Future clearSessionData()async{
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.clear();
}

Future<void> StoreIsUpdateNotNowSessionData(bool flag) async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setBool(ISUPDATENOTNOW, flag);

  sp.commit();
}

Future<bool> getIsUpdateNotNow() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  bool value = sp.getBool(ISUPDATENOTNOW) ?? false;
  return value;
}


