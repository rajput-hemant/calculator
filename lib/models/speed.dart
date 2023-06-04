import 'models.dart';

class Speed implements Unit {
  const Speed({
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

  //Basic Unit Metre/second
  static const speedList = [
    Speed(
      id: 'km/h',
      name: 'Kilometer/hour',
      rate: 3.6,
    ),
    Speed(
      id: 'km/s',
      name: 'Kilometer/second',
      rate: 0.001,
    ),
    Speed(
      id: 'm/s',
      name: 'Metre/second',
      rate: 1.0,
    ),
    Speed(
      id: 'mph',
      name: 'Mile/hour',
      rate: 2.236936,
    ),
    Speed(
      id: 'c',
      name: 'Speed of light',
      rate: 3.356e-9,
    ),
  ];
}
