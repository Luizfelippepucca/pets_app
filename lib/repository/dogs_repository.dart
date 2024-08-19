import 'package:dio/dio.dart';
import '../settings/service.dart';

class DogsRepository {
  final DioService service;

  DogsRepository({required this.service});
  getDogs({int page = 0}) async {
    Response response = await service.get(
        path: 'https://api.thedogapi.com/v1/images/search?limit=10&page=$page');

    return response;
  }

  getDogById(String id) async {
    Response response =
        await service.get(path: 'https://api.thedogapi.com/v1/images/$id');

    return response;
  }
}
