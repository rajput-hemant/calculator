import 'models.dart';

class PlaneAngle implements Unit {
  const PlaneAngle({
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

  static const planeAngleList = [
    PlaneAngle(
      id: 'degree',
      name: 'Degree',
      rate: 1.0,
    ),
    PlaneAngle(
      id: 'radian',
      name: 'Radian',
      rate: 0.0174533,
    ),
    PlaneAngle(
      id: 'gradian',
      name: 'Gradian',
      rate: 0.9,
    ),
    PlaneAngle(
      id: 'arcminute',
      name: 'Arcminute',
      rate: 60.0,
    ),
    PlaneAngle(
      id: 'arcsecond',
      name: 'Arcsecond',
      rate: 3600.0,
    ),
    PlaneAngle(
      id: 'milliradian',
      name: 'Milliradian',
      rate: 17.4533e-6,
    ),
    PlaneAngle(
      id: 'microradian',
      name: 'Microradian',
      rate: 1.74533e-8,
    ),
    PlaneAngle(
      id: 'mil',
      name: 'Mil',
      rate: 0.05625,
    ),
  ];
}
