import 'package:dio/dio.dart';
import 'package:FlutterGank/common/GlobalConfig.dart';
import 'package:flutter/material.dart';

class HttpUtil {
  static HttpUtil instance;
  Dio dio;
  Options options;

  static HttpUtil getInstance() {
    debugPrint('getInstance');
    if (instance == null) {
      instance = new HttpUtil();
    }
    return instance;
  }

  HttpUtil() {
    debugPrint('dio赋值');
    // 或者通过传递一个 `options`来创建dio实例
    options = Options(
      // 请求基地址,可以包含子路径，如: "https://www.google.com/api/".
      baseUrl: GlobalConfig.BASE_URL,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,

      ///  响应流上前后两次接受到数据的间隔，单位为毫秒。如果两次间隔超过[receiveTimeout]，
      ///  [Dio] 将会抛出一个[DioErrorType.RECEIVE_TIMEOUT]的异常.
      ///  注意: 这并不是接收数据的总时限.
      receiveTimeout: 3000,
      headers: {},
    );
    dio = new Dio(options);
  }

  /// GET 请求
  get(url, {data, options, cancelToken}) async {
    debugPrint('get请求启动! url：$url ,body: $data');
    Response response;
    try {
      response = await dio.get(
        url,
        data: data,
        cancelToken: cancelToken,
      );
      debugPrint('get请求成功!response.data：${response.data}');
      debugPrint('get请求成功!response.headers：${response.headers}');
      debugPrint('get请求成功!response.request：${response.request}');
      debugPrint('get请求成功!response.statusCode：${response.statusCode}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        debugPrint('get请求取消! ' + e.message);
      }
      debugPrint('get请求发生错误：$e');
    }
    return response.data;
  }

  /// POST 请求
  post(url, {data, options, cancelToken}) async {
    debugPrint('post请求启动! url：$url ,body: $data');
    Response response;
    try {
      response = await dio.post(
        url,
        data: data,
        cancelToken: cancelToken,
      );
      debugPrint('post请求成功!response.data：${response.data}');
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        debugPrint('post请求取消! ' + e.message);
      }
      debugPrint('post请求发生错误：$e');
    }
    return response.data;
  }
}
