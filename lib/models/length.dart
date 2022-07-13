class Length {
  String id, name;
  double rate;

  Length({required this.id, required this.name, required this.rate});
  // Base Unit Metre
  static var length = [
    Length(id: 'km', name: 'Kilo Metre', rate: 0.001),
    Length(id: 'm', name: 'Metre', rate: 1.0),
    Length(id: 'dm', name: 'Deci Metre', rate: 10.0),
    Length(id: 'cm', name: 'Centi Metre', rate: 100.0),
    Length(id: 'mm', name: 'Mili Metre', rate: 1000.0),
    Length(id: 'μm', name: 'Micro Metre', rate: 1000000.0),
    Length(id: 'nm', name: 'Nano Metre', rate: 1000000000.0),
    Length(id: 'pm', name: 'Pico Metre', rate: 1000000000000.0),
    Length(id: 'in', name: 'Inch', rate: 39.3700787),
    Length(id: 'mi', name: 'Mile', rate: 0.0006214),
    Length(id: 'ft', name: 'Foot', rate: 3.2808399),
  ];
}
