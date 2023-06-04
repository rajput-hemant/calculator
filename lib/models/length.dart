import 'models.dart';

class Length implements Unit {
  const Length({
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
  // Base Unit Metre
  static const lengthList = [
    Length(
      id: 'cm',
      name: 'Centimetre',
      rate: 100.0,
    ),
    Length(
      id: 'dm',
      name: 'Decimetre',
      rate: 10.0,
    ),
    Length(
      id: 'ft',
      name: 'Foot',
      rate: 3.2808399,
    ),
    Length(
      id: 'in',
      name: 'Inch',
      rate: 39.3700787,
    ),
    Length(
      id: 'km',
      name: 'Kilometre',
      rate: 0.001,
    ),
    Length(
      id: 'm',
      name: 'Metre',
      rate: 1.0,
    ),
    Length(
      id: 'μm',
      name: 'Micrometre',
      rate: 1000000.0,
    ),
    Length(
      id: 'mi',
      name: 'Mile',
      rate: 0.0006214,
    ),
    Length(
      id: 'mm',
      name: 'Milimetre',
      rate: 1000.0,
    ),
    Length(
      id: 'nm',
      name: 'Nanometre',
      rate: 1000000000.0,
    ),
    Length(
      id: 'pm',
      name: 'Picometre',
      rate: 1000000000000.0,
    ),
  ];
}
