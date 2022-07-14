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
      rate: 4046.8564224,
    ),
    Area(
      name: 'Are',
      id: 'ar',
      rate: 100,
    ),
    Area(
      name: 'Hectares',
      id: 'ha',
      rate: 10000,
    ),
    Area(
      name: 'Square Centimeter',
      id: 'cm2',
      rate: 0.0001,
    ),
    Area(
      name: 'Square Decimeter',
      id: 'dm2',
      rate: 0.01,
    ),
    Area(
      name: 'Square Foot',
      id: 'ft2',
      rate: 0.3048,
    ),
    Area(
      name: 'Square Hectometer',
      id: 'hm2',
      rate: 10000,
    ),
    Area(
      name: 'Square Inch',
      id: 'in2',
      rate: 0.00064516,
    ),
    Area(
      name: 'Square kilometer',
      id: 'km2',
      rate: 1000000,
    ),
    Area(
      name: 'Square Metre',
      id: 'm2',
      rate: 1,
    ),
    Area(
      name: 'Square Micrometer',
      id: 'μm2',
      rate: 0.0000000000010,
    ),
    Area(
      name: 'Square Mile',
      id: 'mi2',
      rate: 2589988.110336,
    ),
    Area(
      name: 'Square Milimeter',
      id: 'mm2',
      rate: 0.0000010,
    ),
    Area(
      name: 'Square Yard',
      id: 'yd2',
      rate: 0.83612736,
    ),
  ];
}
