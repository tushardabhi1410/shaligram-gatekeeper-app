import 'dart:async';
import 'dart:convert';
import 'package:avinashgatekeeper/Config/Utils/constantValue.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:totality_mobile_app/Config/Utils/Constant.dart';

class ApiResponse {
  Map<String, dynamic> data;
  String base_url;
  ApiHeaderType apiHeaderType;
  RequestType requestType;
  bool? masterList;
  Map<String, dynamic>? headers;

  ApiResponse(
      {required this.data,
      required this.base_url,
      required this.apiHeaderType,
      required this.requestType,
      this.headers,});

  Future<Map<String, dynamic>> _Header() async {
    SharedPreferences? sp = await SharedPreferences.getInstance();

    String platform = "7";

    Map<String, dynamic> header = {};

    if(apiHeaderType == ApiHeaderType.NONE){
    //  header.addAll(headers!);
    }else if (apiHeaderType == ApiHeaderType.Login) {
      header = {
        'Content-Type': 'application/x-www-form-urlencoded',
        "key":APP_KEY,
        "platform": PLATFORM,
        "cmpid": CMPID_BEFORE_LOGIN,
        "iss":ISS

      };
    } else if (apiHeaderType == ApiHeaderType.Content) {
      header = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'key': sp.getString(SESSION_KEY)??"",
        'unqkey': sp.getString(SESSION_UNQKEY)!,
        'iss': sp.getString(SESSION_ISS)!,
        'uid': sp.getString(SESSION_UID)!,
        'platform': "7",
        'os': "a",
        'responsetype': "JSON",
        'cmpid': sp.getString(SESSION_CMPID)!,
        'userlogintype' :sp.getString(SESSION_USERLOGINTYPE)
      };
    }
    if(headers != null && headers!.isNotEmpty){
      header.addAll(headers!);
    }
    print(header);
    return header;
  }


  Future<Map<String, dynamic>?> getResponse() async {
    // final HttpMetric metric = FirebasePerformance.instance.newHttpMetric(base_url, HttpMethod.Post);
    // await metric.start();

    Dio dio = Dio();
    Response response;

    Map<String, dynamic> headers = await _Header();
    //print(headers);

    Options options = Options(headers: headers);
    if(requestType==RequestType.post) {


      response = await dio
          .post(base_url, options: options, data: FormData.fromMap(data))
          .catchError(onError);


    }else{
      response = await dio
          .get(base_url, options: options)
          .catchError(onError);
    }

    try {
      // metric.httpResponseCode = response.statusCode;

      if (response.statusCode == 200) {


        return response.data;



      } else {
        // RemoveAppLoader(context);
        final error = response.data.errors[0] ?? "Error";
        print("Server Not Responding \n$error");
        // displayDialog(context,error.toString(),"Server Not Responding");

        throw Exception(error);
      }
    } catch (e) {
      if (e is DioError) {
        if (DioErrorType.receiveTimeout == e.type || DioErrorType.connectTimeout == e.type) {
          Commonmessage =
              "Oops! No Internet!\nServer is not reachable. Please verify your internet connection and try again";

          // displayDialog(context,"Server is not reachable. Please verify your internet connection and try again","Oops! No Internet!");
        } else if (DioErrorType.response == e.type) {
          Commonmessage = "Someting Went Wrong";

          //displayDialog(context,"Someting Went Wrong" ,"");
        } else if (DioErrorType.other == e.type) {
          if (e.message.contains('SocketException')) {
            Commonmessage = "Make sure your network connection is on";

            // displayDialog(context,"Make sure your network connection is on" ,"Oops! No Internet!");
          }
        } else {
          Commonmessage = "Problem connecting to the server. Please try again.";

          //displayDialog(context,"Problem connecting to the server. Please try again." ,"");
        }
      }
    } finally {
      // metric.stop();
    }
    return null;
  }

  void onError(dynamic e) {
    // if (this.context != null) {
    // RemoveAppLoader(Get.Get.context!);
    // }

    if (DioErrorType.receiveTimeout == e.type || DioErrorType.connectTimeout == e.type) {
      Commonmessage =
          "Oops! No Internet!\nServer is not reachable. Please verify your internet connection and try again";

      // displayDialog(context,);

    } else if (DioErrorType.response == e.type) {
      Commonmessage = "Someting Went Wrong";
      //   displayDialog(context,);

    } else if (DioErrorType.other == e.type) {
      if (e.message.contains('SocketException')) {
        Commonmessage = "Oops! No Internet!\nMake sure your network connection is on";
        // if (!isErrorDialogShow) {
        //   ErrorDialog(Commonmessage);
        //   isErrorDialogShow = true;
        // }
        // displayDialog(context,"Make sure your network connection is on" ,"Oops! No Internet!");

      } else if (e.message.contains('FormatException')) {
        //displayDialog(context,e.message ,"Alert!!!");
        Commonmessage = "Alert!!!\n" + e.message;
      }
    } else {
      Commonmessage = "Server Problem!!!\nProblem connecting to the server. Please try again.";

      // displayDialog(context,"Problem connecting to the server. Please try again." ,"Server Problem");
    }
  }
}

// ErrorDialog(String message) {
//   OpenDialogBox(
//       child: AlertDialogBox.messageShoeDialogWithCloseButton(
//           message: message, status: Status.Error,minHeight: 135.w));
// }

enum ApiHeaderType { Login, Content , NONE }
enum RequestType { post, get }
