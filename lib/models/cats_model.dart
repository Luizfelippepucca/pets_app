class CatModel {
  late String id;
  late String url;
  List<CatModel> lista = [];
  CatModel({required this.id, required this.url});

  CatModel.fromJson(List<dynamic> json) {
    List<CatModel> listaCats = [];
    for (var element in json) {
      listaCats.add(
        CatModel(id: element['id'], url: element['url']),
      );
    }
    lista = listaCats;
  }
}

class CatByIdModel {
  BreedModel? breed;
  CatByIdModel({required this.breed});

  CatByIdModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> listBreeds = json['breeds'] ?? [];

    for (var element in listBreeds) {
      breed = BreedModel(
        id: element['id'],
        name: element['name'],
        cfaUrl: element['cfa_url'],
        vetstreetUrl: element['vetstreet_url'],
        vcahospitalsUrl: element['vcahospitals_url'],
        temperament: element['temperament'],
        origin: element['origin'],
        countryCodes: element['country_codes'],
        countryCode: element['ountry_code'],
        description: element['description'],
        lifeSpan: element['life_span'],
        indoor: element['indoor'],
        lap: element['lap'],
        altNames: element['alt_names'],
        adaptability: element['adaptability'],
        affectionLevel: element['affection_level'],
        childFriendly: element['child_friendly'],
        dogFriendly: element['dog_friendly'],
        energyLevel: element['energy_level'],
        grooming: element['grooming'],
        healthIssues: element['health_issues'],
        intelligence: element['intelligence'],
        sheddingLevel: element['shedding_level'],
        socialNeeds: element['social_needs'],
        strangerFriendly: element['stranger_friendly'],
        vocalisation: element['vocalisation'],
        experimental: element['experimental'],
        hairless: element['hairless'],
        rare: element['rare'],
        natural: element['natural'],
        rex: element['rex'],
        suppressedTail: element['suppressed_tail"'],
        shortLegs: element['short_legs'],
        wikipediaUrl: element['wikipedia_url'],
        hypoallergenic: element['hypoallergenic'],
      );
    }
  }
}

class BreedModel {
  String? id;
  String? name;
  String? cfaUrl;
  String? vetstreetUrl;
  String? vcahospitalsUrl;
  String? temperament;
  String? origin;
  String? countryCodes;
  String? countryCode;
  String? description;
  String? lifeSpan;
  int? indoor;
  int? lap;
  String? altNames;
  int? adaptability;
  int? affectionLevel;
  int? childFriendly;
  int? dogFriendly;
  int? energyLevel;
  int? grooming;
  int? healthIssues;
  int? intelligence;
  int? sheddingLevel;
  int? socialNeeds;
  int? strangerFriendly;
  int? vocalisation;
  int? experimental;
  int? hairless;
  int? natural;
  int? rare;
  int? rex;
  int? suppressedTail;
  int? shortLegs;
  String? wikipediaUrl;
  int? hypoallergenic;

  BreedModel({
    required this.id,
    required this.name,
    required this.cfaUrl,
    required this.vetstreetUrl,
    required this.vcahospitalsUrl,
    required this.temperament,
    required this.origin,
    required this.countryCodes,
    required this.countryCode,
    required this.description,
    required this.lifeSpan,
    required this.indoor,
    required this.lap,
    required this.altNames,
    required this.adaptability,
    required this.affectionLevel,
    required this.childFriendly,
    required this.dogFriendly,
    required this.energyLevel,
    required this.grooming,
    required this.healthIssues,
    required this.intelligence,
    required this.sheddingLevel,
    required this.socialNeeds,
    required this.strangerFriendly,
    required this.vocalisation,
    required this.experimental,
    required this.hairless,
    required this.rare,
    required this.natural,
    required this.rex,
    required this.suppressedTail,
    required this.shortLegs,
    required this.wikipediaUrl,
    required this.hypoallergenic,
  });
}
