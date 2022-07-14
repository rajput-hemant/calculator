class Length {
  String id, name;
  double rate;

  Length({required this.id, required this.name, required this.rate});
  // Base Unit Metre
  static var length = [
    Length(
      name: 'Centimetre',
      id: 'cm',
      rate: 100.0,
    ),
    Length(
      name: 'Decimetre',
      id: 'dm',
      rate: 10.0,
    ),
    Length(
      name: 'Foot',
      id: 'ft',
      rate: 3.2808399,
    ),
    Length(
      name: 'Inch',
      id: 'in',
      rate: 39.3700787,
    ),
    Length(
      name: 'Kilometre',
      id: 'km',
      rate: 0.001,
    ),
    Length(
      name: 'Metre',
      id: 'm',
      rate: 1.0,
    ),
    Length(
      name: 'Micrometre',
      id: 'μm',
      rate: 1000000.0,
    ),
    Length(
      name: 'Mile',
      id: 'mi',
      rate: 0.0006214,
    ),
    Length(
      name: 'Milimetre',
      id: 'mm',
      rate: 1000.0,
    ),
    Length(
      name: 'Nanometre',
      id: 'nm',
      rate: 1000000000.0,
    ),
    Length(
      name: 'Picometre',
      id: 'pm',
      rate: 1000000000000.0,
    ),
  ];
}
