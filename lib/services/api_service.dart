import 'dart:async';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import '../models/meme_modelv2.dart';

part 'api_service.g.dart';

dynamic errorInterceptor(DioError dioError) async {


  return dioError;
}

@RestApi(baseUrl: "http://api.imgflip.com")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  static ApiService create() {
    final dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dio.options.headers["content-type"] = 'application/x-www-form-urlencoded';
    dio.interceptors.add(PrettyDioLogger());
     return ApiService(dio);
  }

  static ApiService createForMultipart() {
    final dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dio.options.headers["content-type"] = 'multipart/form-data';
    dio.interceptors.add(PrettyDioLogger());
    return ApiService(dio);
  }

  @GET("/get_memes")
  Future<ModelMeme> getmemes ();
}

