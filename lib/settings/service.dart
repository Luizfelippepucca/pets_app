import 'package:dio/dio.dart';

abstract class DioServiceInterface {
  Future<Response<dynamic>> get({required String path});
  Future<Response<dynamic>> post(
      {required String path, required Map<String, dynamic>? params});
}

class DioService extends DioServiceInterface {
  final _dio = Dio();

  @override
  get({required String path}) {
    return _dio.get(path);
  }

  @override
  post({required String path, required Map<String, dynamic>? params}) {
    return _dio.post(path, data: params);
  }
}
