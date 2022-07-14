class Volume {
  String id, name;
  double rate;

  Volume({
    required this.id,
    required this.name,
    required this.rate,
  });
  //Basic Unit Cubic metre
  static var volume = [
    Volume(
      name: 'Centilitre',
      id: 'cl',
      rate: 100000.0,
    ),
    Volume(
      name: 'Cubic centimetre',
      id: 'cm3',
      rate: 1000000.0,
    ),
    Volume(
      name: 'Cubic decimeter',
      id: 'dm3',
      rate: 1000.0,
    ),
    Volume(
      name: 'Cubic foot',
      id: 'ft3',
      rate: 35.3147248,
    ),
    Volume(
      name: 'Cubic inch',
      id: 'in3',
      rate: 61023.8445022,
    ),
    Volume(
      name: 'Cubic metre',
      id: 'm3',
      rate: 1.0,
    ),
    Volume(
      name: 'Cubic millimetre',
      id: 'mm3',
      rate: 1000000000.0,
    ),
    Volume(
      name: 'Cubic yard',
      id: 'yd3',
      rate: 1.3079528,
    ),
    Volume(
      name: 'Decilitre',
      id: 'dl',
      rate: 10000.0,
    ),
    Volume(
      name: 'Gallon',
      id: 'gal',
      rate: 264.1720524,
    ),
    Volume(
      name: 'Hectolitre',
      id: 'hl',
      rate: 10.0,
    ),
    Volume(
      name: 'Litre',
      id: 'l',
      rate: 1000.0,
    ),
    Volume(
      name: 'Millilitre',
      id: 'ml',
      rate: 1000000.0,
    ),
  ];
}
