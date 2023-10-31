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
      id: 'cm²',
      name: 'Centimeter²',
      rate: 10000.0,
    ),
    Area(
      id: 'dm²',
      name: 'Decimeter²',
      rate: 100.0,
    ),
    Area(
      id: 'ft²',
      name: 'Foot²',
      rate: 10.764,
    ),
    Area(
      id: 'ha',
      name: 'Hectares',
      rate: 0.0001,
    ),
    Area(
      id: 'in²',
      name: 'Inch²',
      rate: 1550.0031,
    ),
    Area(
      id: 'km²',
      name: 'Kilometer²',
      rate: 1e-6,
    ),
    Area(
      id: 'm²',
      name: 'Metre²',
      rate: 1,
    ),
    Area(
      id: 'mi²',
      name: 'Mile²',
      rate: 3.86e-7,
    ),
    Area(
      id: 'mm²',
      name: 'Milimeter²',
      rate: 1000000.0,
    ),
    Area(
      id: 'yd²',
      name: 'Yard²',
      rate: 1.19599,
    ),
  ];
}
