import 'package:dio/dio.dart';
import '../settings/service.dart';

class CatsRepository {
  final DioService service;

  CatsRepository({required this.service});
  getCats({int page = 0}) async {
    Response response = await service.get(
        path: 'https://api.thecatapi.com/v1/images/search?limit=10&page=$page');

    return response;
  }

  getCatById(String id) async {
    Response response =
        await service.get(path: 'https://api.thecatapi.com/v1/images/$id');

    return response;
  }
}
