class Volume {
  String id, name;
  double rate;

  Volume({
    required this.id,
    required this.name,
    required this.rate,
  });

  static var volume = [
    Volume(id: 'm3', name: 'Cubic meter', rate: 1.0),
    Volume(id: 'km3', name: 'Cubic kilometer', rate: 1000000000.0),
    Volume(id: 'cm3', name: 'Cubic centemeter', rate: 0.000001),
    Volume(id: 'mm3', name: 'Cubic milimeter', rate: .000000001),
    Volume(id: 'L', name: 'Litre', rate: 0.001),
    Volume(id: 'mL', name: 'Mililitre', rate: 0.000001),
    Volume(id: 'gal', name: 'Gallon', rate: 0.0037854118),
    Volume(id: 'qt', name: 'Quart', rate: 0.0009463529),
    Volume(id: 'pt', name: 'Pint', rate: 0.0004731765),
    Volume(id: 'mi3', name: 'Cubic mile', rate: 4168181825.4),
    Volume(id: 'yd3', name: 'Cubic yard', rate: 0.764554858),
    Volume(id: 'ft3', name: 'Cubic foot', rate: 0.0283168466),
    Volume(id: 'in3', name: 'Cubic inch', rate: 0.0000163871),
    Volume(id: 'dm3', name: 'Cubic decimeter', rate: 0.0000163871),
    Volume(id: 'EL', name: 'Exaliter', rate: 1000000000000000.0),
    Volume(id: 'PL', name: 'Petalitre', rate: 1000000000000.0),
    Volume(id: 'TL', name: 'Teraliter', rate: 1000000000.0),
    Volume(id: 'GL', name: 'Gigaliter', rate: 1000000.0),
    Volume(id: 'ML', name: 'Megalitre', rate: 1000.0),
    Volume(id: 'kL', name: 'Kilolitre', rate: 1.0),
    Volume(id: 'hL', name: 'Hectolitre', rate: 0.1),
    Volume(id: 'daL', name: 'Dekalitre', rate: 0.01),
    Volume(id: 'dL', name: 'Decilitre', rate: 0.0001),
    Volume(id: 'cL', name: 'Centilitre', rate: 0.00001),
    Volume(id: 'μL', name: 'Microliter', rate: 0.000000001),
    Volume(id: 'nL', name: 'Nanoliter', rate: .000000000001),
    Volume(id: 'pL', name: 'Picoliter', rate: 0.000000000000001),
    Volume(id: 'fL', name: 'Femtoliter', rate: 0.000000000000000001),
    Volume(id: 'aL', name: 'Attoliter', rate: 0.000000000000000000001),
    Volume(id: 'cc', name: 'Cc', rate: 0.000001),
    Volume(id: 'st', name: 'Stere', rate: 1.0),
    Volume(id: 'cd', name: 'Cord', rate: 3.6245563638),
    Volume(id: 'dr', name: 'Dram', rate: 0.0000036967),
  ];
}
