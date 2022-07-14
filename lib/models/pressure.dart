class Pressure {
  String id, name;
  double rate;

  Pressure({required this.id, required this.name, required this.rate});
  //Basic Unit Hectopascal
  static var pressure = [
    Pressure(
      name: "Bar",
      id: "bar",
      rate: 0.001,
    ),
    Pressure(
      name: "Hectopascal",
      id: "hPa",
      rate: 1.0,
    ),
    Pressure(
      name: "Inch of mercury",
      id: "inHg",
      rate: 0.02953,
    ),
    Pressure(
      name: "Kilogram-force/square centimetre",
      id: "kgf/cm2",
      rate: 0.0010197,
    ),
    Pressure(
      name: "Kilogram-force/square metre",
      id: "kgf/m2",
      rate: 10.1971621,
    ),
    Pressure(
      name: "Kilopascal",
      id: "kPa",
      rate: 0.1,
    ),
    Pressure(
      name: "Megapascal",
      id: "MPa",
      rate: 1e-4,
    ),
    Pressure(
      name: "Millibar",
      id: "mbar",
      rate: 1.0,
    ),
    Pressure(
      name: "Millimeter of Water",
      id: "mmH2O",
      rate: 10.19716,
    ),
    Pressure(
      name: "Millimetre of mercury",
      id: "mmHg",
      rate: 0.7500617,
    ),
    Pressure(
      name: "Pounds/square foot",
      id: "psf",
      rate: 2.088543512,
    ),
    Pressure(
      name: "Pounds/square inch",
      id: "psi",
      rate: 0.014503774,
    ),
    Pressure(
      name: "Standard atmosphere",
      id: "atm",
      rate: 9.86923e-4,
    ),
  ];
}
