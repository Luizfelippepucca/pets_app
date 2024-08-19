class AssetModel {
  final String _image;
  final String _name;
  final String _route;
  final String _tag;

  AssetModel(this._image, this._name, this._route, this._tag);

  String get getImage {
    return _image;
  }

  String get getName {
    return _name;
  }

  String get getRoute {
    return _route;
  }

  String get getTag {
    return _tag;
  }
}
