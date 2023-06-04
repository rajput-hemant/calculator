import 'models.dart';

class Power implements Unit {
  const Power({
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

  // Base unit Watt
  static const powerList = [
    Power(
      id: 'Btu/s',
      name: 'British thermal unit/second',
      rate: 0.0009478171,
    ),
    Power(
      id: 'ft.lb/s',
      name: 'Foot-pound/second',
      rate: 0.7375621489,
    ),
    Power(
      id: 'hp',
      name: 'Horsepower',
      rate: 0.0013410221,
    ),
    Power(
      id: 'J/s',
      name: 'Joule/second',
      rate: 1.0,
    ),
    Power(
      id: 'kcal/s',
      name: 'Kilocalorie/second',
      rate: 0.000239,
    ),
    Power(
      id: 'kg.m/s',
      name: 'Kilogram-meter/second',
      rate: 0.1019716213,
    ),
    Power(
      id: 'kW',
      name: 'Kilowatt',
      rate: 0.001,
    ),
    Power(
      id: 'PS',
      name: 'Metric horsepower',
      rate: 0.0013596216,
    ),
    Power(
      id: 'N.m/s',
      name: 'Newton-meter/second',
      rate: 1.0,
    ),
    Power(
      id: 'W',
      name: 'Watt',
      rate: 1.0,
    ),
  ];
}
