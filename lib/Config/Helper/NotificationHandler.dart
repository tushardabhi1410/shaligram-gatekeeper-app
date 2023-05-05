import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';


import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../Utils/color.dart';



class NotificationHandler {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidNotificationChannel androidNotificationChannel = AndroidNotificationChannel(
      'default', 'AvinashGateKeeper Notification',
      description: "This is notification channel", importance: Importance.max,);

  NotificationHandler() {
    createChannelOnDevice();
    requestPermission();
    // this._initNotification();
    // initNotification();
    _initNotification();
  }

  NotificationHandler.instance();

  createChannelOnDevice() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
  }

  requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("---notification permission granted-----");
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print("----notification permission provisional----");
    } else {
      print("----notification permission denied----");
    }
  }

  onMessageOpenApp(RemoteMessage message) async {
    // showNotification("Second", message.notification!.body!, message.data);

    print(
        "-----------------------------------onMessageOpenApp--------------------------------------");
    print(message.data);
    ClickNotification(message.data);
    // NotificationHandler().onNotificationClickListener(message.data);
    // int count = await getNotificationRead();
    // setNotificationRead(count+1);
  }

  onMessage(RemoteMessage message) async {
    // int count = await getNotificationCount();
    // print("app open : ${count + 1}");
    // setNotificationCount(count + 1);

    print("-----------------------------------onMessage--------------------------------------");
    print(message.toString());
    print(message.data);
    // print(message.notification!.android!.imageUrl);
    Map<String, dynamic> data = message.data;

    if (Platform.isIOS) {
      if (message.notification?.apple?.imageUrl != null &&
          message.notification?.apple?.imageUrl != "") {
        String? url = message.notification?.apple?.imageUrl!;
        showBigNotification(message.notification!, data, url!);
      } else {
        showNotification(message.notification!, data);
      }
    } else if (Platform.isAndroid) {
      if (message.notification?.android?.imageUrl != null &&
          message.notification?.android?.imageUrl != "") {
        String? url = message.notification?.android?.imageUrl!;
        showBigNotification(message.notification!, data, url!);
      } else {
        showNotification(message.notification!, data);
      }
    }
  }

  _initNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('ic_launcher');
    // AndroidInitializationSettings('notification_icon');
    IOSInitializationSettings iosInitializationSettings = IOSInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? playload) {
      Map<String, dynamic> data = jsonDecode(playload!);
      ClickNotification(data);
    });
  }

  ClickNotification(Map<String, dynamic> data, [bool isFormNotification = false]) async {
    // int count = await getNotificationCount();
    // setNotificationCount(0);
    // GotoNotificationPage(isFormNotification);
    print("ClickNotification $data");

    if (data.containsKey("n_id")) {
      // ReadNotificationStatus(data["n_id"]);
    }

    print("flag * * * ${data['flag']}");

    if (data.containsKey("flag")) {
      if (data['flag'].toString().isEmpty) {
        // GotoNotificationPage(isFormNotification);
      } else {
        // if(data['flag'].toString().toLowerCase()==UPLOADMARKETING_APPMENUNAME){
        //   Get.to(UploadMarketingPage(id:data.containsKey("id") ? data['id'] : "",propertyname: data.containsKey("propertyname") ? data['propertyname'] : "",purpackageid: data.containsKey("purpackageid") ? data['purpackageid'] : "",));
        // }else{
        // ClickHandler(data['flag'], 0,id: data.containsKey("id") ? data['id'] : "");
      }
      //}

      // pageNo = data['flag'];
    } else {
      // GotoNotificationPage(isFormNotification);
    }
  }


  // GotoNotificationPage([bool isFormNotification = false]) async {
  //   bool value = await Get.to(() => NotificationPage(
  //             isFromNotification: true,
  //           )) ??
  //       isFormNotification;
  //   GotoHomePage(value);
  // }



  showNotification(RemoteNotification notification, Map<String, dynamic> playload) async {

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      "default", "AvinashGateKeeper Notification",
      importance: Importance.max,
      priority: Priority.high,
      icon: "ic_launcher",
      color: AppColors.GREEN,
      tag: "your message is recived",
      styleInformation: BigTextStyleInformation(''),
    );

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    NotificationDetails notificationDetails =
        NotificationDetails(iOS: iosNotificationDetails, android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        notification.hashCode, notification.title, notification.body, notificationDetails,
        payload: jsonEncode(playload));
  }

  showBigNotification(
      RemoteNotification notification, Map<String, dynamic> playload, String url) async {
    //String url = playload['image'];
    ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(await _getByteArrayFromUrl(url));
    final BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(
        bigPicture,
        contentTitle: notification.title,
        summaryText: notification.body);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("default", "AvinashGateKeeper Notification",
            importance: Importance.max,
            priority: Priority.high,
            icon: "ic_launcher",
            color: AppColors.GREEN,

            styleInformation: bigPictureStyleInformation);

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    if (url != "") {
      final String bigPicturePath = await DownloadFile(url);
      iosNotificationDetails = IOSNotificationDetails(
          attachments: <IOSNotificationAttachment>[IOSNotificationAttachment(bigPicturePath)]);
    }
    NotificationDetails notificationDetails = NotificationDetails(iOS: iosNotificationDetails, android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        notification.hashCode, notification.title, notification.body, notificationDetails,
        payload: jsonEncode(playload));
  }

  Future<String> DownloadFile(String printurl) async {
    Dio dio = new Dio();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    final name = p.basename(printurl);
    var response = await dio.download(printurl, '$appDocPath/$name');
    if (response.statusCode == 200) {
      return '$appDocPath/$name';
    }
    return "";
  }

  Future<Uint8List> _getByteArrayFromUrl(String url) async {
    dio.Options options = dio.Options(responseType: dio.ResponseType.bytes);
    dio.Dio d = dio.Dio();
    dio.Response response = await d.getUri(Uri.parse(url), options: options);

    return response.data;
  }

}
