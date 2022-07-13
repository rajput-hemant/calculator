class Area {
  String id, name;
  double rate;

  Area({
    required this.id,
    required this.name,
    required this.rate,
  });

  static var area = [
    Area(id: 'm2', name: 'Meter', rate: 1),
    Area(id: 'mm2', name: 'Milimeter', rate: 0.0000010),
    Area(id: 'cm2', name: 'Centimeter', rate: 0.0001),
    Area(id: 'dm2', name: 'Decimeter', rate: 0.01),
    Area(id: 'dam2', name: 'Dekameter', rate: 100),
    Area(id: 'hm2', name: 'Hectometer', rate: 10000),
    Area(id: 'km2', name: 'kilometer', rate: 1000000),
    Area(id: 'b', name: 'Barns', rate: 0.00000000000000000000000000010),
    Area(id: 'ct', name: 'Cents', rate: 40.46),
    Area(id: 'ha', name: 'Hectares', rate: 10000),
    Area(id: 'ft2', name: 'Feet', rate: 0.3048),
    Area(id: 'in2', name: 'Inches', rate: 0.00064516),
    Area(id: 'μm2', name: 'Micrometer', rate: 0.0000000000010),
    Area(id: 'mi2', name: 'Miles', rate: 2589988.110336),
    Area(id: 'ac', name: 'acre', rate: 4046.8564224),
    Area(id: 'yd2', name: 'Yard', rate: 0.83612736),
    Area(id: 'nm2', name: 'Nanometer', rate: 0.0000000000000000010),
    Area(id: 'mil', name: 'Mil', rate: 0.0000254),
    Area(id: 'ch2', name: 'Chain', rate: 404.68564224),
  ];
}
