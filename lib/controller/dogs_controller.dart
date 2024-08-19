import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/dog_model.dart';
import '../repository/dogs_repository.dart';

class DogsController extends ValueNotifier<List<DogModel>> {
  DogsRepository repository;
  bool loading = false;
  bool error = false;
  bool select = false;
  String errorMessage = "";
  String id = "";
  int _pageCount = 1;

  DogsController({required this.repository}) : super([]);

  Future<List<DogModel>> getDogs() async {
    loading = true;

    try {
      Response response = await repository.getDogs();

      if (response.statusCode == 200) {
        DogModel dogs = DogModel.fromJson(response.data);
        value = dogs.lista;

        loading = false;

        return value;
      }
    } on DioException catch (e) {
      error = true;
      loading = false;

      if (e.message != null) {
        errorMessage = e.message.toString();
      }

      return value = [];
    }
    return value = [];
  }

  bool selectDog(DogModel dog) {
    id = dog.id;
    if (id.isNotEmpty) {
      return select = true;
    }

    return select = false;
  }

  loadMoreCats() async {
    _pageCount++;
    try {
      Response response = await repository.getDogs(page: _pageCount);

      if (response.statusCode == 200) {
        DogModel dogs = DogModel.fromJson(response.data);

        value.addAll(dogs.lista);
      }
    } on DioException catch (e) {
      if (e.message != null) {
        errorMessage = e.message.toString();
      }
    }
  }
}

class DogByIdController extends ValueNotifier<DogByIdModel> {
  DogsRepository repository;
  bool loading = false;
  bool error = false;
  String errorMessage = "";

  DogByIdController({
    required this.repository,
  }) : super(DogByIdModel(breed: null));

  Future<DogByIdModel> getDogsByid(String id) async {
    loading = true;

    try {
      Response response = await repository.getDogById(id);

      DogByIdModel dogById = DogByIdModel.fromJson(response.data);

      if (response.statusCode == 200) {
        Future.delayed(const Duration(milliseconds: 1300), () {
          loading = false;

          return value = dogById;
        });
      }
    } on DioException catch (e) {
      error = true;
      loading = false;

      if (e.message != null) {
        errorMessage = e.message.toString();
      }

      return value = DogByIdModel(breed: null);
    }
    return value = DogByIdModel(breed: null);
  }
}
