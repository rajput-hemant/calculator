import 'models.dart';

class Data implements Unit {
  const Data({
    required this.id,
    required this.name,
    required this.rate,
  });

  @override
  @override
  final String id, name;
  @override
  final double rate;
  @override
  String? get flag => null;
  @override
  String? get symbol => null;

  // Base Unit Megabit
  static const dataList = [
    Data(
      id: 'b',
      name: 'Bit',
      rate: 1048576,
    ),
    Data(
      id: 'B',
      name: 'Byte',
      rate: 131072,
    ),
    Data(
      id: 'gb',
      name: 'Gigabit',
      rate: 0.0009765625,
    ),
    Data(
      id: 'GB',
      name: 'GigaByte',
      rate: 0.0001220703125,
    ),
    Data(
      id: 'kb',
      name: 'Kilobit',
      rate: 1024,
    ),
    Data(
      id: 'KB',
      name: 'KiloByte',
      rate: 128,
    ),
    Data(
      id: 'mb',
      name: 'Megabit',
      rate: 1,
    ),
    Data(
      id: 'MB',
      name: 'MegaByte',
      rate: 0.125,
    ),
    Data(
      id: 'nibble',
      name: 'Nibble',
      rate: 262144,
    ),
    Data(
      id: 'pb',
      name: 'Petabit',
      rate: 0.931322e-11,
    ),
    Data(
      id: 'PB',
      name: 'PetaByte',
      rate: 1.16415e-10,
    ),
    Data(
      id: 'tb',
      name: 'Terabit',
      rate: 9.5367e-7,
    ),
    Data(
      id: 'TB',
      name: 'TeraByte',
      rate: 1.1920e-7,
    ),
  ];
}
