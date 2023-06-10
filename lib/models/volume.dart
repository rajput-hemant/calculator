import 'models.dart';

class Volume implements Unit {
  const Volume({
    required this.id,
    required this.name,
    required this.rate,
  });

  @override
  @override
  final String id, name;
  @override
  final double rate;
  @override
  String? get flag => null;
  @override
  String? get symbol => null;

  //Basic Unit Cubic metre
  static const volumeList = [
    Volume(
      id: 'cl',
      name: 'Centilitre',
      rate: 100000.0,
    ),
    Volume(
      id: 'cm3',
      name: 'Cubic centimetre',
      rate: 1000000.0,
    ),
    Volume(
      id: 'dm3',
      name: 'Cubic decimeter',
      rate: 1000.0,
    ),
    Volume(
      id: 'dl',
      name: 'Decilitre',
      rate: 10000.0,
    ),
    Volume(
      id: 'ft3',
      name: 'Cubic foot',
      rate: 35.3147248,
    ),
    Volume(
      id: 'gal',
      name: 'Gallon',
      rate: 264.1720524,
    ),
    Volume(
      id: 'hl',
      name: 'Hectolitre',
      rate: 10.0,
    ),
    Volume(
      id: 'in3',
      name: 'Cubic inch',
      rate: 61023.8445022,
    ),
    Volume(
      id: 'l',
      name: 'Litre',
      rate: 1000.0,
    ),
    Volume(
      id: 'm3',
      name: 'Cubic metre',
      rate: 1.0,
    ),
    Volume(
      id: 'ml',
      name: 'Millilitre',
      rate: 1000000.0,
    ),
    Volume(
      id: 'mm3',
      name: 'Cubic millimetre',
      rate: 1000000000.0,
    ),
    Volume(
      id: 'yd3',
      name: 'Cubic yard',
      rate: 1.3079528,
    ),
  ];
}
