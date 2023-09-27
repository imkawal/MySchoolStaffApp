import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../controller/dashboard_controller.dart';
import '../utils/stringconstant.dart';
import 'app_manager.dart';
import 'app_snackbar.dart';
import 'endpoints.dart';

class NetworkManager {
  static final NetworkManager _apiService = NetworkManager._internal();
  //DashBoardController dashBoardController = Get.put(DashBoardController());

  Dio _dio = Dio();

  bool isContentTypeJson = true;
  bool _isHttpRequest = false;
  bool _urlEncode = false;
  bool stDATA = true;
  String baseUrl = Endpoints.baseURL;
  String? appUrl;

  factory NetworkManager() {
    return _apiService;
  }

  NetworkManager._internal();

  Dio getDio({isJsonType = true, isHttpRequest = false, isUrlEncoded = false}) {
    isContentTypeJson = isJsonType;
    _urlEncode = isUrlEncoded;
    _isHttpRequest = isHttpRequest;
    _init();
    return _dio;
  }

  static NetworkManager get instance => _apiService;

  _init() async {
    _dio = Dio();
    _dio.options.baseUrl = baseUrl;
    _dio.options.contentType = Headers.jsonContentType;
    _dio.interceptors.add(LogInterceptor());
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      compact: false,
    ));
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      if (AppManager.statusHelper.getLoginStatus) {
        String postToken = GetStorage().read(Constants.token) ?? "";

        options.headers["Authorization"] = "Bearer $postToken";
      }

      if (isContentTypeJson) options.headers["Content-Type"] = "application/json";

      if (_urlEncode) options.headers["Content-Type"] = "application/x-www-form-urlencoded";

      if (_isHttpRequest) options.headers["X-Requested-With"] = "XMLHttpRequest";
      return handler.next(options); //continue
    }, onResponse: (response, handler) {
      return handler.next(response); // continue
    }, onError: (DioError e, handler) async {
      if (e.response?.statusCode == 403) {
        // try {
        var input = {
          "operation": "RefreshToken",
          "user": {"UserName": "${GetStorage().read(Constants.userNameSaved)}"}
        };
        await _dio.post(Endpoints.refreshToken, data: input).then((value) async {
          GetStorage().write(Constants.token, value.data['token']);
          String postToken = GetStorage().read(Constants.token);
          e.requestOptions.headers["Authorization"] = "Bearer $postToken";

          //create request with new access token
          final opts = Options(method: e.requestOptions.method, headers: e.requestOptions.headers);
          final cloneReq = await _dio.request(e.requestOptions.path,
              options: opts, data: e.requestOptions.data, queryParameters: e.requestOptions.queryParameters);

          return handler.resolve(cloneReq);
          // }
          // return handler.(e);
        });
        // } catch (e, st) {}
        if (!kReleaseMode) {
          AppSnackbar.showSnackbar(
              "API ERROR : ${e.requestOptions.path}", e.response.toString(), AlertType.internalInfo,
              position: SnackPosition.BOTTOM, duration: const Duration(seconds: 4));
        }
        // return handler.next(e); //continue
      } else {
        return handler.next(e);
      }
    }));

    _dio.options.receiveTimeout = 30000;
  }
}
