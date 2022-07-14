class Data {
  String id, name;
  double rate;
  Data({
    required this.id,
    required this.name,
    required this.rate,
  });
  //Basic Unit Megabit
  static var data = [
    Data(
      name: 'Bit',
      id: 'b',
      rate: 1048576,
    ),
    Data(
      name: 'Byte',
      id: 'B',
      rate: 131072,
    ),
    Data(
      name: 'Gigabit',
      id: 'gb',
      rate: 0.0009765625,
    ),
    Data(
      name: 'GigaByte',
      id: 'GB',
      rate: 0.0001220703125,
    ),
    Data(
      name: 'Kilobit',
      id: 'kb',
      rate: 1024,
    ),
    Data(
      name: 'KiloByte',
      id: 'KB',
      rate: 128,
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
      name: 'Nibble',
      id: 'nibble',
      rate: 262144,
    ),
    Data(
      name: 'Petabit',
      id: 'pb',
      rate: 0.931322e-11,
    ),
    Data(
      name: 'PetaByte',
      id: 'PB',
      rate: 1.16415e-10,
    ),
    Data(
      name: 'Terabit',
      id: 'tb',
      rate: 9.5367e-7,
    ),
    Data(
      name: 'TeraByte',
      id: 'TB',
      rate: 1.1920e-7,
    ),
  ];
}
