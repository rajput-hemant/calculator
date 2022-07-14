class Area {
  String id, name;
  double rate;

  Area({
    required this.id,
    required this.name,
    required this.rate,
  });
  // Base Unit Square metre
  static var area = [
    Area(
      name: 'Acre',
      id: 'ac',
      rate: 0.0002471,
    ),
    Area(
      name: 'Are',
      id: 'ar',
      rate: 0.01,
    ),
    Area(
      name: 'Hectares',
      id: 'ha',
      rate: 0.0001,
    ),
    Area(
      name: 'Square Centimeter',
      id: 'cm2',
      rate: 10000.0,
    ),
    Area(
      name: 'Square Decimeter',
      id: 'dm2',
      rate: 100.0,
    ),
    Area(
      name: 'Square Foot',
      id: 'ft2',
      rate: 10.764,
    ),
    Area(
      name: 'Square Inch',
      id: 'in2',
      rate: 1550.0031,
    ),
    Area(
      name: 'Square kilometer',
      id: 'km2',
      rate: 1e-6,
    ),
    Area(
      name: 'Square Metre',
      id: 'm2',
      rate: 1,
    ),
    Area(
      name: 'Square Mile',
      id: 'mi2',
      rate: 3.86e-7,
    ),
    Area(
      name: 'Square Milimeter',
      id: 'mm2',
      rate: 1000000.0,
    ),
    Area(
      name: 'Square Yard',
      id: 'yd2',
      rate: 1.19599,
    ),
  ];
}
