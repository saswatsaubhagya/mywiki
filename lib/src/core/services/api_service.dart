import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@injectable
class ApiService {
  static const String BASE_URL =
      'https://en.wikipedia.org//w/api.php?action=query&format=json';
  static const String RESULt = BASE_URL +
      '&prop=extracts%7Cpageimages%7Crevisions&redirects=1&formatversion=2&titles=';
  static const String QUERY = BASE_URL +
      "&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=5&wbptterms=description&gpslimit=10&gpssearch=";

  Future<Dio> getDioClient() async {
    final Dio _dio = Dio();

    _dio
      ..options.headers.addAll({
        'Content-Type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
      })
      ..interceptors.clear()
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90))
      ..options.baseUrl = ApiService.BASE_URL;

    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      // Do something before request is sent
      return options; //continue
      // If you want to resolve the request with some custom data，
      // you can return a `Response` object or return `dio.resolve(data)`.
      // If you want to reject the request with a error message,
      // you can return a `DioError` object or return `dio.reject(errMsg)`
    }, onResponse: (Response response) async {
      // response.data = response.data['data'];
      return response; // continue
    }, onError: (DioError error) async {
      return error;
    }));
    return _dio;
  }
}
