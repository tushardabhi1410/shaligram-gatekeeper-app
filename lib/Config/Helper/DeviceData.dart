import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:package_info/package_info.dart';


class DeviceData {
  final  FirebaseMessaging? firebaseMessaging= FirebaseMessaging.instance;


  int isforcefully = 0, isforcelogout = 0;

  String updateAppMsg = "";




  //<editor-fold desc = "Send Device Data">

  Future<Map<String, String>> getDeviceData() async {
    Map<String, String> deviceData = <String, String>{};

    String os = "";
    String deviceModelName = "";
    String macAddress = "";
    String deviceID = "";
    String osVersion = "";
    String appVersion = "";

    try {
      FirebaseMessaging.instance.requestPermission();

      await firebaseMessaging!.getToken(vapidKey: "").then((value) {
        deviceID = value!;
        print('DEVICE_ID=====================================> $deviceID');
      });


      PackageInfo info = await PackageInfo.fromPlatform();
      appVersion = info.version;
      // osVersion = Platform.operatingSystemVersion;

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        os = "i";
        // deviceID = iosInf
        osVersion = iosInfo.systemVersion ?? "";
        deviceModelName = iosInfo.model ?? "";
        macAddress = iosInfo.identifierForVendor ?? "";
      } else if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        // deviceID = androidInfo.id!;
        os = "a";
        osVersion = androidInfo.version.release ?? "";
        deviceModelName = androidInfo.model ?? "";
        macAddress = androidInfo.androidId ?? "";
      }
    } catch (e) {
      print(e);
    }
    // deviceData['action'] = 'adddevicedata';
   deviceData['appversion'] = appVersion;
   deviceData['devicemodelname'] = deviceModelName;
   deviceData['macaddress'] = macAddress;
   deviceData['deviceid'] = deviceID;
    deviceData['os'] = os;
    // deviceData['device_id'] = deviceModelName;
   deviceData['osversion'] = osVersion;

    return deviceData;
  }
}
