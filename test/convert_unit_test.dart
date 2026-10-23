import 'package:calculator/models/models.dart';
import 'package:calculator/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TextEditingController from;
  late TextEditingController to;

  setUp(() {
    // textEditingController origins are not needed for conversion math; a
    // plain controller with a valid caret works and keeps the test focused.
    from = TextEditingController(text: '1');
    to = TextEditingController(text: '');
  });

  test('temperature identity: same unit in gives the same value out', () {
    from.text = '37.5';
    to.text = '999';

    convertUnit(from, to, 0, 0, Temperature.temperatureList, true);

    expect(to.text, '37.5');
    expect(from.text, '37.5');
  });

  test('rare temperature identity (Rømer) also holds', () {
    from.text = '21';
    to.text = '';

    // '°Ro' is index 5, left out of the old if-chain entirely.
    convertUnit(from, to, 5, 5, Temperature.temperatureList, true);

    expect(to.text, '21');
  });

  test('celsius to fahrenheit keeps its formula', () {
    convertUnit(from, to, 0, 1, Temperature.temperatureList, true);

    expect(to.text, '33.800000');
  });

  test('rate-based identity: metre to metre keeps the value', () {
    from.text = '42';
    to.text = '999';

    convertUnit(from, to, 5, 5, Length.lengthList, true);

    expect(to.text, '42');
  });

  test('rate-based conversion keeps its formula', () {
    convertUnit(from, to, 5, 0, Length.lengthList, true);

    expect(double.parse(to.text), closeTo(100, 1e-9));
  });

  test('a failed parse leaves both fields alone', () {
    from.text = 'abc';
    to.text = '400';
    final fromValue = from.text;

    convertUnit(from, to, 5, 0, Length.lengthList, true);

    expect(to.text, '400');
    expect(from.text, fromValue);
  });

  test('empty input does not crash and clears nothing', () {
    from.text = '';
    to.text = '100';

    convertUnit(from, to, 5, 0, Length.lengthList, true);

    expect(to.text, '100');
  });

  test('partial input does not crash and clears nothing', () {
    from.text = '1.2.3';
    to.text = '100';

    convertUnit(from, to, 5, 0, Length.lengthList, true);

    expect(to.text, '100');
  });

  test('fuel economy: 10 km/l is 10 l/100km (reciprocal, not 0.1)', () {
    final kmPerLitre = _fuelIndex('km/l');
    final litresPer100Km = _fuelIndex('l/100km');
    from.text = '10';
    to.text = '';

    convertUnit(
      from,
      to,
      kmPerLitre,
      litresPer100Km,
      FuelEconomy.fuelEconomyList,
      true,
    );

    expect(double.parse(to.text), closeTo(10, 1e-9));
  });

  test('fuel economy: 0 l/100km leaves the other field unchanged', () {
    final kmPerLitre = _fuelIndex('km/l');
    final litresPer100Km = _fuelIndex('l/100km');
    from.text = '0';
    to.text = '12.5';

    convertUnit(
      from,
      to,
      litresPer100Km,
      kmPerLitre,
      FuelEconomy.fuelEconomyList,
      true,
    );

    expect(to.text, '12.5');
  });
}

int _fuelIndex(String id) =>
    FuelEconomy.fuelEconomyList.indexWhere((unit) => unit.id == id);
