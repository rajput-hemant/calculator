class Speed {
  String id, name;
  double rate;

  Speed({required this.id, required this.name, required this.rate});

  static var speed = [
    Speed(id: 'm/s', name: 'Meter/second', rate: 1.0),
    Speed(id: 'km/s', name: 'Kilometer/second', rate: 0.001),
    Speed(id: 'c', name: 'Speed of light', rate: 3.356e-9),
    Speed(id: 'km/h', name: 'Kilometer/hour', rate: 3.6),
    Speed(id: 'mph', name: 'Mile/hour', rate: 2.236936),
  ];
}
