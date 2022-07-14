class Data {
  String id, name;
  double rate;
  Data({
    required this.id,
    required this.name,
    required this.rate,
  });

  static var data = [
    Data(
      name: 'Bit',
      id: 'b',
      rate: 1e+6,
    ),
    Data(
      name: 'Byte',
      id: 'B',
      rate: 125000,
    ),
    Data(
      name: 'Gigabit',
      id: 'gb',
      rate: 0.001,
    ),
    Data(
      name: 'GigaByte',
      id: 'GB',
      rate: 0.000125,
    ),
    Data(
      name: 'Kilobit',
      id: 'kb',
      rate: 1000,
    ),
    Data(
      name: 'KiloByte',
      id: 'KB',
      rate: 125,
    ),
    Data(
      name: 'Megabit',
      id: 'mb',
      rate: 1,
    ),
    Data(
      name: 'MegaByte',
      id: 'MB',
      rate: 0.125,
    ),
    Data(
      name: 'Petabit',
      id: 'pb',
      rate: 1e-9,
    ),
    Data(
      name: 'PetaByte',
      id: 'PB',
      rate: 1.25e-10,
    ),
    Data(
      name: 'Terabit',
      id: 'tb',
      rate: 1e-6,
    ),
    Data(
      name: 'TeraByte',
      id: 'TB',
      rate: 1.25e-7,
    ),
  ];
}
