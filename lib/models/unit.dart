import 'area.dart';
import 'currency.dart';
import 'data.dart';
import 'energy.dart';
import 'frequency.dart';
import 'fuel_economy.dart';
import 'length.dart';
import 'plane_angle.dart';
import 'power.dart';
import 'pressure.dart';
import 'speed.dart';
import 'temperature.dart';
import 'time.dart';
import 'volume.dart';
import 'weight.dart';

/// [Unit] is a base class for all units.
///
/// It contains the following properties:
/// - [id] is a unique identifier for the unit.
/// - [name] is the name of the unit.
/// - [rate] is the rate of the unit.
/// - [symbol] is the symbol of the unit. (Only for currency)
abstract class Unit {
  const Unit({required this.id, required this.name, this.rate, this.symbol});

  final String id, name;
  final String? symbol;
  final double? rate;
}

enum Units {
  area,
  currency,
  data,
  energy,
  frequency,
  fuel,
  length,
  planeAngle,
  power,
  pressure,
  temperature,
  speed,
  time,
  volume,
  weight,
}

/// The unit list and display label for each category, in one place.
extension UnitsCatalog on Units {
  List<Unit> get units => switch (this) {
    Units.area => Area.areaList,
    Units.currency => Currency.currenciesList,
    Units.data => Data.dataList,
    Units.energy => Energy.energyList,
    Units.frequency => Frequency.frequencyList,
    Units.fuel => FuelEconomy.fuelEconomyList,
    Units.length => Length.lengthList,
    Units.planeAngle => PlaneAngle.planeAngleList,
    Units.power => Power.powerList,
    Units.pressure => Pressure.pressureList,
    Units.speed => Speed.speedList,
    Units.temperature => Temperature.temperatureList,
    Units.time => Time.timeList,
    Units.volume => Volume.volumeList,
    Units.weight => Weight.weightList,
  };

  String get label => switch (this) {
    Units.area => 'Area',
    Units.currency => 'Currency',
    Units.data => 'Data',
    Units.energy => 'Energy',
    Units.frequency => 'Frequency',
    Units.fuel => 'Fuel Economy',
    Units.length => 'Length',
    Units.planeAngle => 'Plane Angle',
    Units.power => 'Power',
    Units.pressure => 'Pressure',
    Units.speed => 'Speed',
    Units.temperature => 'Temperature',
    Units.time => 'Time',
    Units.volume => 'Volume',
    Units.weight => 'Weight',
  };
}
