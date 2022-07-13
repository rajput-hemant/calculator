class Temperature {
  String id, name;
  double rate;

  Temperature({required this.id, required this.name, required this.rate});
  //Base Unit Celsius
  static var temperature = [
    Temperature(id: 'K', name: 'Kelvin', rate: 0.0),
    Temperature(id: '°C', name: 'Celsius', rate: 0.0),
    Temperature(id: '°F', name: 'Fahrenheit', rate: 0.0),
  ];
}
