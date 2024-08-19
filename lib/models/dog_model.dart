class DogModel {
  late String id;
  late String url;
  List<DogModel> lista = [];
  DogModel({required this.id, required this.url});

  DogModel.fromJson(List<dynamic> json) {
    List<DogModel> listaDogs = [];
    for (var element in json) {
      listaDogs.add(
        DogModel(id: element['id'], url: element['url']),
      );
    }
    lista = listaDogs;
  }
}

class DogByIdModel {
  DogBreedModel? breed;
  DogByIdModel({required this.breed});

  DogByIdModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> listBreeds = json['breeds'] ?? [];

    for (var element in listBreeds) {
      breed = DogBreedModel(
          id: element['id'],
          name: element['name'],
          origin: element['origin'],
          lifeSpan: element['life_span'],
          bredFor: element['bred_for'],
          breedGroup: element['breed_group'],
          temperament: element['temperament']);
    }
  }
}

class DogBreedModel {
  int? id;
  String? name;
  String? bredFor;
  String? breedGroup;
  String? lifeSpan;
  String? temperament;
  String? origin;

  DogBreedModel({
    required this.id,
    required this.name,
    required this.bredFor,
    required this.breedGroup,
    required this.lifeSpan,
    required this.origin,
    required this.temperament,
  });
}
