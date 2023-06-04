/// [Unit] is a base class for all units.
///
/// It contains the following properties:
/// - [id] is a unique identifier for the unit.
/// - [name] is the name of the unit.
/// - [rate] is the rate of the unit.
/// - [flag] is the flag of the country. (Only for currency)
/// - [symbol] is the symbol of the unit. (Only for currency)
abstract class Unit {
  const Unit({
    required this.id,
    required this.name,
    this.rate,
    this.flag,
    this.symbol,
  });

  final String id, name;
  final String? flag, symbol;
  final double? rate;
}
