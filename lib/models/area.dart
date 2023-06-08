import 'unit.dart';

class Area implements Unit {
  const Area({
    required this.id,
    required this.name,
    required this.rate,
  });

  @override
  final String id, name;
  @override
  final double rate;
  @override
  String? get flag => null;
  @override
  String? get symbol => null;

  // Base Unit Square metre
  static const areaList = [
    Area(
      id: 'm\u00B2',
      name: 'Metre\u00B2',
      rate: 1,
    ),
    Area(
      id: 'cm\u00B2',
      name: 'Centimeter\u00B2',
      rate: 10000.0,
    ),
    Area(
      id: 'ha',
      name: 'Hectares',
      rate: 0.0001,
    ),
    Area(
      id: 'ac',
      name: 'Acre',
      rate: 0.0002471,
    ),
    Area(
      id: 'ar',
      name: 'Are',
      rate: 0.01,
    ),
    Area(
      id: 'dm\u00B2',
      name: 'Decimeter\u00B2',
      rate: 100.0,
    ),
    Area(
      id: 'ft\u00B2',
      name: 'Foot\u00B2',
      rate: 10.764,
    ),
    Area(
      id: 'in\u00B2',
      name: 'Inch\u00B2',
      rate: 1550.0031,
    ),
    Area(
      id: 'km\u00B2',
      name: 'kilometer\u00B2',
      rate: 1e-6,
    ),
    Area(
      id: 'mi\u00B2',
      name: 'Mile\u00B2',
      rate: 3.86e-7,
    ),
    Area(
      id: 'mm\u00B2',
      name: 'Milimeter\u00B2',
      rate: 1000000.0,
    ),
    Area(
      id: 'yd\u00B2',
      name: 'Yard\u00B2',
      rate: 1.19599,
    ),
  ];
}
