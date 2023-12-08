enum PhotoFileFormat {
  jpg('jpg'),
  jpeg('jpeg'),
  ;

  final String _name;
  const PhotoFileFormat(this._name);

  String get name => _name;
}

final String regExpOfPhotoFileFormat =
    '(${PhotoFileFormat.jpg._name}|${PhotoFileFormat.jpeg._name})' r'$';
