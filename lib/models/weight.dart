class Weight {
  String id, name;
  double rate;

  Weight({required this.id, required this.name, required this.rate});
  //Base Unit Kilogram
  static var weight = [
    Weight(
      name: 'Carat',
      id: 'ct',
      rate: 5000.0,
    ),
    Weight(
      name: 'Grain',
      id: 'gr',
      rate: 15432.3583529,
    ),
    Weight(
      name: 'Gram',
      id: 'g',
      rate: 1000.0,
    ),
    Weight(
      name: 'Kilogram',
      id: 'kg',
      rate: 1.0,
    ),
    Weight(
      name: 'Microgram',
      id: 'μg',
      rate: 1000000000.0,
    ),
    Weight(
      name: 'Miligram',
      id: 'mg',
      rate: 1000000.0,
    ),
    Weight(
      name: 'Ounce',
      id: 'oz',
      rate: 35.2739619,
    ),
    Weight(
      name: 'Pound',
      id: 'lb',
      rate: 2.2046226,
    ),
    Weight(
      name: 'Quintal',
      id: 'q',
      rate: 0.01,
    ),
    Weight(
      name: 'Tonne',
      id: 't',
      rate: 0.001,
    ),
  ];
}
