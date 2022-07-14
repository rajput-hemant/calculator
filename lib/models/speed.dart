class Speed {
  String id, name;
  double rate;

  Speed({required this.id, required this.name, required this.rate});
  //Basic Unit Metre/second
  static var speed = [
    Speed(
      name: 'Kilometer/hour',
      id: 'km/h',
      rate: 3.6,
    ),
    Speed(
      name: 'Kilometer/second',
      id: 'km/s',
      rate: 0.001,
    ),
    Speed(
      name: 'Metre/second',
      id: 'm/s',
      rate: 1.0,
    ),
    Speed(
      name: 'Mile/hour',
      id: 'mph',
      rate: 2.236936,
    ),
    Speed(
      name: 'Speed of light',
      id: 'c',
      rate: 3.356e-9,
    ),
  ];
}
