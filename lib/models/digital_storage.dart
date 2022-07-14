class DigitalStorage {
  String id, name;
  double rate;
  DigitalStorage({
    required this.id,
    required this.name,
    required this.rate,
  });

  static var digitalStorage = [
    DigitalStorage(id: 'b', name: 'Bit', rate: 1e+6),
    DigitalStorage(id: 'mb', name: 'Megabit', rate: 1),
    DigitalStorage(id: 'kb', name: 'Kilobit', rate: 1000),
    DigitalStorage(id: 'gb', name: 'Gigabit', rate: 0.001),
    DigitalStorage(id: 'tb', name: 'Terabit', rate: 1e-6),
    DigitalStorage(id: 'pb', name: 'Petabit', rate: 1e-9),
    DigitalStorage(id: 'B', name: 'Byte', rate: 125000),
    DigitalStorage(id: 'KB', name: 'KiloByte', rate: 125),
    DigitalStorage(id: 'MB', name: 'MegaByte', rate: 0.125),
    DigitalStorage(id: 'GB', name: 'GigaByte', rate: 0.000125),
    DigitalStorage(id: 'TB', name: 'TeraByte', rate: 1.25e-7),
    DigitalStorage(id: 'PB', name: 'PetaByte', rate: 1.25e-10),
  ];
}
