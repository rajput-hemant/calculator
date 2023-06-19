import 'models.dart';

class Energy implements Unit {
  const Energy({
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

  // Basic Unit: Joule (J)
  static final energyList = [
    const Energy(
      id: 'btu',
      name: 'British Thermal Unit',
      rate: 0.000947817,
    ),
    const Energy(
      id: 'cal',
      name: 'Calorie',
      rate: 0.239006,
    ),
    const Energy(
      id: 'ev',
      name: 'Electronvolt',
      rate: 6.242e+18,
    ),
    const Energy(
      id: 'ftlbf',
      name: 'Foot-Pound',
      rate: 0.737562,
    ),
    const Energy(
      id: 'gcal',
      name: 'Gram Calorie',
      rate: 0.239006,
    ),
    const Energy(
      id: 'j',
      name: 'Joule',
      rate: 1.0,
    ),
    const Energy(
      id: 'kj',
      name: 'Kilojoule',
      rate: 0.001,
    ),
    const Energy(
      id: 'kcal',
      name: 'Kilocalorie',
      rate: 0.000239006,
    ),
    const Energy(
      id: 'kwh',
      name: 'Kilowatt-Hour',
      rate: 0.000277778,
    ),
    const Energy(
      id: 'therm',
      name: 'Therm',
      rate: 9.480434e-9,
    ),
    const Energy(
      id: 'wh',
      name: 'Watt-Hour',
      rate: 0.000277778,
    ),
  ];
}

