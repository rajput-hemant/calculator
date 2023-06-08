import 'models.dart';

class Time implements Unit {
  const Time({
    required this.id,
    required this.name,
    required this.rate,
  });

  @override
  final String id, name;
  @override
  final double rate;
  @override
  String? get flag => null;
  @override
  String? get symbol => null;

// Base Unit Second
  static const timeList = [
    Time(
      id: 's',
      name: 'Second',
      rate: 1,
    ),
    Time(
      id: 'ms',
      name: 'Millisecond',
      rate: 1000,
    ),
    Time(
      id: 'min',
      name: 'Minute',
      rate: 1.66667e-2,
    ),
    Time(
      id: 'hr',
      name: 'Hour',
      rate: 2.77778e-4,
    ),
    Time(
      id: 'day',
      name: 'Day',
      rate: 1.15741e-5,
    ),
    Time(
      id: 'week',
      name: 'Week',
      rate: 1.65344e-6,
    ),
    Time(
      id: 'month',
      name: 'Month',
      rate: 3.80517e-7,
    ),
    Time(
      id: 'year',
      name: 'Year',
      rate: 3.17098e-8,
    ),
    Time(
      id: 'decade',
      name: 'Decade',
      rate: 3.17098e-9,
    ),
    Time(
      id: 'century',
      name: 'Century',
      rate: 3.17098e-10,
    ),
    Time(
      id: 'millennium',
      name: 'Millennium',
      rate: 3.17098e-11,
    ),
  ];
}
