import 'models.dart';

class Pressure implements Unit {
  const Pressure({
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

  //Basic Unit Hectopascal
  static const pressureList = [
    Pressure(
      id: "bar",
      name: "Bar",
      rate: 0.001,
    ),
    Pressure(
      id: "hPa",
      name: "Hectopascal",
      rate: 1.0,
    ),
    Pressure(
      id: "inHg",
      name: "Inch of mercury",
      rate: 0.02953,
    ),
    Pressure(
      id: "kg.f/cm2",
      name: "Kilogram-force/square centimetre",
      rate: 0.0010197,
    ),
    Pressure(
      id: "kg.f/m2",
      name: "Kilogram-force/square metre",
      rate: 10.1971621,
    ),
    Pressure(
      id: "kPa",
      name: "Kilopascal",
      rate: 0.1,
    ),
    Pressure(
      id: "MPa",
      name: "Megapascal",
      rate: 1e-4,
    ),
    Pressure(
      id: "mbar",
      name: "Millibar",
      rate: 1.0,
    ),
    Pressure(
      id: "mmH2O",
      name: "Millimeter of Water",
      rate: 10.19716,
    ),
    Pressure(
      id: "mmHg",
      name: "Millimetre of mercury",
      rate: 0.7500617,
    ),
    Pressure(
      id: "psf",
      name: "Pounds/square foot",
      rate: 2.088543512,
    ),
    Pressure(
      id: "psi",
      name: "Pounds/square inch",
      rate: 0.014503774,
    ),
    Pressure(
      id: "atm",
      name: "Standard atmosphere",
      rate: 9.86923e-4,
    ),
  ];
}
