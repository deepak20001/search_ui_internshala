import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:search_ui_internshala/utils/common_colors.dart';
import 'package:search_ui_internshala/utils/show_toast.dart';
import '../../main.dart';
import 'api_url_constants.dart';
import 'network_response.dart';

class DioNetworkClass {
  Dio dio = Dio();
  String endUrl = "";
  String filePath = "";
  String param = "";
  List<String> imageArray = [];
  late NetworkResponse networkResponse;
  Map<String, dynamic> jsonBody = {};
  late StateSetter stateSetter;
  AlertDialog? alertDialog;
  int requestCode = 0;
  bool isShowing = false;
  double progress = 0;

  DioNetworkClass(
      {required this.endUrl,
      required this.networkResponse,
      required this.requestCode});

  DioNetworkClass.fromNetworkClass(
      {required this.endUrl,
      required this.networkResponse,
      required this.requestCode,
      required this.jsonBody});

  DioNetworkClass.fromDioMultiPartSingleImage(
      {required this.endUrl,
      required this.networkResponse,
      required this.requestCode,
      required this.jsonBody,
      required this.filePath,
      required this.param});

  DioNetworkClass.fromDioMultiPartMultiImage(
      {required this.endUrl,
      required this.networkResponse,
      required this.requestCode,
      required this.jsonBody,
      required this.imageArray,
      required this.param});

  // GET     /posts
  // POST    /posts
  // PUT     /posts/1
  // PATCH   /posts/1
  // DELETE

  Future<void> callRequestService(
    bool showLoader,
    String requestType,
  ) async {
    try {
      var fromData = FormData.fromMap(jsonBody);

      Options options = Options(method: requestType.toUpperCase());
      dio.options.connectTimeout = const Duration(seconds: 90);
      options.sendTimeout = const Duration(seconds: 90); //5s
      dio.options.receiveTimeout = const Duration(seconds: 90);
      dio.options.contentType = Headers.jsonContentType;
      debugPrint("7===> ");

      // Append API key as a query parameter
      String apiUrl = "$baseURL$endUrl";
      if (jsonBody.containsKey("api_key")) {
        apiUrl += "?api_key=${jsonBody["api_key"]}";
        jsonBody.remove("api_key");
      }

      debugPrint("${requestType}Url: $apiUrl");

      if (requestType == "get" ||
          requestType == "post" && jsonBody.isNotEmpty) {
        dio.options.queryParameters = jsonBody;
        debugPrint(
            "${requestType.toUpperCase()} Query Parameters: ${dio.options.queryParameters}");
      } else {
        debugPrint("${requestType}Map: $jsonBody");
      }

      late Response response;

      if (imageArray.isNotEmpty || filePath.isNotEmpty) {
        response = await dio.request(
          apiUrl,
          data: fromData,
          options: options,
        );
      } else {
        debugPrint("====I am here");
        response = await dio.request(apiUrl, options: options);
        debugPrint("====I am here");
      }

      debugPrint("ResultBody=========>: ${response.data.toString()}");

      if (alertDialog != null && isShowing) {
        isShowing = false;
        Navigator.of(navigatorKey.currentContext!, rootNavigator: true).pop();
      }

      if (response.statusCode! <= 201) {
        networkResponse.onResponse(
            requestCode: requestCode, response: jsonEncode(response.data));
      }
    } on DioException catch (e) {
      if (alertDialog != null && isShowing) {
        isShowing = false;
        Navigator.of(navigatorKey.currentContext!, rootNavigator: true).pop();
      }
      debugPrint("Error========>${e.error}");
      debugPrint("Error Type ========>${e.type}");
      if (e.error is SocketException) {
        commonSocketException((e.error as SocketException).osError!.errorCode,
            (e.error as SocketException).message);
      } else if (e.type == DioExceptionType.badResponse) {
        networkResponse.onApiError(
            requestCode: requestCode, response: jsonEncode(e.response!.data));
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        showToast(
          context: navigatorKey.currentContext!,
          message: "Connection Time Out",
          color: CommonColors.errorColor,
        );
      }
    } catch (err) {
      if (alertDialog != null && isShowing) {
        debugPrint("SocketException");
        isShowing = false;
        Navigator.of(navigatorKey.currentContext!, rootNavigator: true).pop();
      }
      debugPrint('Error While Making network call -> $err');
    }
  }

  Future<void> showLoaderDialog(BuildContext context) async {
    if (alertDialog != null && isShowing) {
      isShowing = false;
    }
    alertDialog = AlertDialog(
      elevation: 0,
      backgroundColor: Colors.white.withOpacity(0),
      content: const Center(
        child: CircularProgressIndicator(
          color: CommonColors.appThemeColor,
        ),
      ),
    );
    await showDialog(
      barrierDismissible: false,
      barrierColor: Colors.white.withOpacity(0),
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () => Future.value(false), child: alertDialog!);
      },
    );
  }

  void commonSocketException(int errorCode, String errorMessage) {
    switch (errorCode) {
      case 7:
        debugPrint("Internet Connection Error");
        showToast(
          context: navigatorKey.currentContext!,
          message: "Internet Connection Error",
          color: CommonColors.errorColor,
        );
        break;

      case 8:
        debugPrint("Internet Connection Error");
        showToast(
          context: navigatorKey.currentContext!,
          message: "Internet Connection Error",
          color: CommonColors.errorColor,
        );
        break;

      case 111:
        debugPrint("Unable to connect Server");
        showToast(
          context: navigatorKey.currentContext!,
          message: "Internet Connection Error",
          color: CommonColors.errorColor,
        );
        break;

      default:
        debugPrint("Unknown Error :$errorMessage");
        showToast(
          context: navigatorKey.currentContext!,
          message: "Internet Connection Error",
          color: CommonColors.errorColor,
        );
    }
  }
}
