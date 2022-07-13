class Weight {
  String id, name;
  double rate;

  Weight({required this.id, required this.name, required this.rate});

  static var weight = [
    Weight(id: 'kg', name: 'Kilogram', rate: 1.0),
    Weight(id: 'g', name: 'Gram', rate: 1000.0),
    Weight(id: 'mg', name: 'Miligram', rate: 1000000.0),
    Weight(id: 'μg', name: 'Microgram', rate: 1000000000.0),
    Weight(id: 't', name: 'Tonne', rate: 0.001),
    Weight(id: 'q', name: 'Quintal', rate: 0.01),
    Weight(id: 'ct', name: 'Carat', rate: 5000.0),
    Weight(id: 'lb', name: 'Pound', rate: 2.2046226),
    Weight(id: 'oz', name: 'Ounce', rate: 35.2739619),
    Weight(id: 'gr', name: 'Grain', rate: 15432.3583529),
  ];
}
