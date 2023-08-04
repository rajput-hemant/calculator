import 'models.dart';

class FuelEconomy implements Unit {
  const FuelEconomy({
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

  static const fuelEconomyList = [
    FuelEconomy(
      id: 'km/l',
      name: 'Kilometers/liter',
      rate: 1.0,
    ),
    FuelEconomy(
      id: 'mi/l',
      name: 'Miles/liter',
      rate: 0.621371,
    ),
    FuelEconomy(
      id: 'l/100km',
      name: 'Liters/100 Kilometers',
      rate: 100.0,
    ),
    FuelEconomy(
      id: 'mpg',
      name: 'Miles/gallon',
      rate: 2.35215,
    ),
  ];
}
