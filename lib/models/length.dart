class Length {
  String id, name;
  double rate;

  Length({required this.id, required this.name, required this.rate});

  static var length = [
    Length(id: 'km', name: 'Kilo Meter', rate: 0.001),
    Length(id: 'm', name: 'Meter', rate: 1.0),
    Length(id: 'dm', name: 'Deci Meter', rate: 10.0),
    Length(id: 'cm', name: 'Centi Meter', rate: 100.0),
    Length(id: 'mm', name: 'Mili Meter', rate: 1000.0),
    Length(id: 'μm', name: 'Micro Meter', rate: 1000000.0),
    Length(id: 'nm', name: 'Nano Meter', rate: 1000000000.0),
    Length(id: 'pm', name: 'Pico Meter', rate: 1000000000000.0),
    Length(id: 'in', name: 'Inch', rate: 39.3700787),
    Length(id: 'mi', name: 'Mile', rate: 0.0006214),
    Length(id: 'ft', name: 'Foot', rate: 3.2808399),
  ];
}
