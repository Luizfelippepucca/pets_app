import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/cats_model.dart';
import '../repository/cats_repository.dart';

class CatsController extends ValueNotifier<List<CatModel>> {
  CatsRepository repository;
  bool loading = false;
  bool error = false;
  bool select = false;
  String errorMessage = "";
  String id = "";
  int _pageCount = 1;

  CatsController({required this.repository}) : super([]);

  Future<List<CatModel>> getCats() async {
    loading = true;

    try {
      Response response = await repository.getCats();

      if (response.statusCode == 200) {
        CatModel cats = CatModel.fromJson(response.data);
        value = cats.lista;

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

  bool selectCat(CatModel cat) {
    id = cat.id;
    if (id.isNotEmpty) {
      return select = true;
    }

    return select = false;
  }

  loadMoreCats() async {
    _pageCount++;
    try {
      Response response = await repository.getCats(page: _pageCount);

      if (response.statusCode == 200) {
        CatModel cats = CatModel.fromJson(response.data);

        value.addAll(cats.lista);
      }
    } on DioException catch (e) {
      if (e.message != null) {
        errorMessage = e.message.toString();
      }
    }
  }
}

class CatByIdController extends ValueNotifier<CatByIdModel> {
  CatsRepository repository;
  bool loading = false;
  bool error = false;
  String errorMessage = "";

  CatByIdController({
    required this.repository,
  }) : super(CatByIdModel(breed: null));

  Future<CatByIdModel> getCatsByid(String id) async {
    loading = true;

    try {
      Response response = await repository.getCatById(id);
      CatByIdModel catById = CatByIdModel.fromJson(response.data);

      if (response.statusCode == 200) {
        Future.delayed(const Duration(milliseconds: 1300), () {
          loading = false;

          return value = catById;
        });
      }
    } on DioException catch (e) {
      error = true;
      loading = false;

      if (e.message != null) {
        errorMessage = e.message.toString();
      }

      return value = CatByIdModel(breed: null);
    }
    return value = CatByIdModel(breed: null);
  }

  void openLinkToBrowser(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
