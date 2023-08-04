import 'models.dart';

class Frequency implements Unit {
  const Frequency({
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

  static const frequencyList = [
    Frequency(
      id: 'hz',
      name: 'Hertz',
      rate: 1.0,
    ),
    Frequency(
      id: 'khz',
      name: 'Kilohertz',
      rate: 0.001,
    ),
    Frequency(
      id: 'mhz',
      name: 'Megahertz',
      rate: 0.000001,
    ),
    Frequency(
      id: 'ghz',
      name: 'Gigahertz',
      rate: 0.000000001,
    ),
  ];
}
