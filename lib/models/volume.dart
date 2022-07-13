class Volume {
  String id, name;
  double rate;

  Volume({
    required this.id,
    required this.name,
    required this.rate,
  });
  //Basic Unit Cubic metre
  static var volume = [
    Volume(id: 'm3', name: 'Cubic metre', rate: 1.0),
    Volume(id: 'cm3', name: 'Cubic centimetre', rate: 0.000001),
    Volume(id: 'mm3', name: 'Cubic millimetre', rate: .000000001),
    Volume(id: 'l', name: 'Litre', rate: 0.001),
    Volume(id: 'ml', name: 'Millilitre', rate: 0.000001),
    Volume(id: 'gal', name: 'Gallon', rate: 0.0037854118),
    Volume(id: 'yd3', name: 'Cubic yard', rate: 0.764554858),
    Volume(id: 'ft3', name: 'Cubic foot', rate: 0.0283168466),
    Volume(id: 'in3', name: 'Cubic inch', rate: 0.0000163871),
    Volume(id: 'dm3', name: 'Cubic decimeter', rate: 0.0000163871),
    Volume(id: 'hl', name: 'Hectolitre', rate: 0.1),
    Volume(id: 'dl', name: 'Decilitre', rate: 0.0001),
    Volume(id: 'cl', name: 'Centilitre', rate: 0.00001),
    Volume(id: 'μL', name: 'Microliter', rate: 0.000000001),
    Volume(id: 'nL', name: 'Nanoliter', rate: .000000000001),
  ];
}
