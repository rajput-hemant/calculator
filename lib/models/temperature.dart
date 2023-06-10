import 'models.dart';

class Temperature implements Unit {
  const Temperature({
    required this.id,
    required this.name,
  });

  @override
  @override
  final String id, name;
  @override
  double? get rate => null;
  @override
  String? get flag => null;
  @override
  String? get symbol => null;

// Base Unit Celsius
  static const temperatureList = [
    Temperature(
      id: '°C',
      name: 'Celsius',
    ),
    Temperature(
      id: '°F',
      name: 'Fahrenheit',
    ),
    Temperature(
      id: 'K',
      name: 'Kelvin',
    ),
    Temperature(
      id: 'R',
      name: 'Rankine',
    ),
    Temperature(
      id: '°Re',
      name: 'Réaumur',
    ),
    Temperature(
      id: '°Ro',
      name: 'Rømer',
    ),
  ];
}
