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
    Area(id: 'm2', name: 'Square Metre', rate: 1),
    Area(id: 'mm2', name: 'Square Milimeter', rate: 0.0000010),
    Area(id: 'cm2', name: 'Square Centimeter', rate: 0.0001),
    Area(id: 'dm2', name: 'Square Decimeter', rate: 0.01),
    Area(id: 'hm2', name: 'Square Hectometer', rate: 10000),
    Area(id: 'km2', name: 'Square kilometer', rate: 1000000),
    Area(id: 'ar', name: 'Are', rate: 100),
    Area(id: 'ha', name: 'Hectares', rate: 10000),
    Area(id: 'ft2', name: 'Square Foot', rate: 0.3048),
    Area(id: 'in2', name: 'Square Inch', rate: 0.00064516),
    Area(id: 'μm2', name: 'Square Micrometer', rate: 0.0000000000010),
    Area(id: 'mi2', name: 'Square Mile', rate: 2589988.110336),
    Area(id: 'ac', name: 'Acre', rate: 4046.8564224),
    Area(id: 'yd2', name: 'Square Yard', rate: 0.83612736),
  ];
}
