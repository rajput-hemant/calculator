class Power {
  String id, name;
  double rate;

  Power({required this.id, required this.name, required this.rate});
  // Base unit Watt
  static var power = [
    Power(
      name: 'British thermal unit/second',
      id: 'Btu/s',
      rate: 0.0009478171,
    ),
    Power(
      name: 'Foot-pound/second',
      id: 'ft.lb/s',
      rate: 0.7375621489,
    ),
    Power(
      name: 'Horsepower',
      id: 'hp',
      rate: 0.0013410221,
    ),
    Power(
      name: 'Joule/second',
      id: 'J/s',
      rate: 1.0,
    ),
    Power(
      name: 'Kilocalorie/second',
      id: 'kcal/s',
      rate: 0.000239,
    ),
    Power(
      name: 'Kilogram-meter/second',
      id: 'kg.m/s',
      rate: 0.1019716213,
    ),
    Power(
      name: 'Kilowatt',
      id: 'kW',
      rate: 0.001,
    ),
    Power(
      name: 'Metric horsepower',
      id: 'PS',
      rate: 0.0013596216,
    ),
    Power(
      name: 'Newton-meter/second',
      id: 'N.m/s',
      rate: 1.0,
    ),
    Power(
      name: 'Watt',
      id: 'W',
      rate: 1.0,
    ),
  ];
}
