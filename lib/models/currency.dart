import 'models.dart';

// class Money {
//   Money(
//     this.type, {
//     this.amount = 1.0,
//   });

//   final String type;
//   double? amount;
// }

class Currency implements Unit {
  const Currency({
    required this.id,
    required this.name,
    required this.flag,
    required this.symbol,
  });

  @override
  final String id, name, flag, symbol;

  @override
  double? get rate => null;
  static const List<Currency> currenciesList = [
    Currency(
      id: "AUD",
      name: "Australian Dollar",
      flag: "🇦🇺",
      symbol: '\$',
    ),
    Currency(
      id: "BGN",
      name: "Bulgarian Lev",
      flag: "🇧🇬",
      symbol: 'лв',
    ),
    Currency(
      id: "BRL",
      name: "Brazilian Real",
      flag: "🇧🇷",
      symbol: 'R\$',
    ),
    Currency(
      id: "CAD",
      name: "Canadian Dollar",
      flag: "🇨🇦",
      symbol: '\$',
    ),
    Currency(
      id: "CHF",
      name: "Swiss Franc",
      flag: "🇨🇭",
      symbol: 'CHF',
    ),
    Currency(
      id: "CNY",
      name: "Chinese Yuan",
      flag: "🇨🇳",
      symbol: '¥',
    ),
    Currency(
      id: "CZK",
      name: "Czech Republic Koruna",
      flag: "🇨🇿",
      symbol: 'Kč',
    ),
    Currency(
      id: "DKK",
      name: "Danish Krone",
      flag: "🇩🇰",
      symbol: 'kr',
    ),
    Currency(
      id: "GBP",
      name: "British Pound Sterling",
      flag: "🇬🇧",
      symbol: '£',
    ),
    Currency(
      id: "HKD",
      name: "Hong Kong Dollar",
      flag: "🇭🇰",
      symbol: 'HK\$',
    ),
    Currency(
      id: "HRK",
      name: "Croatian Kuna",
      flag: "🇭🇷",
      symbol: 'kn',
    ),
    Currency(
      id: "HUF",
      name: "Hungarian Forint",
      flag: "🇭🇺",
      symbol: 'Ft',
    ),
    Currency(
      id: "IDR",
      name: "Indonesian Rupiah",
      flag: "🇮🇩",
      symbol: 'Rp',
    ),
    Currency(
      id: "ILS",
      name: "Israeli New Sheqel",
      flag: "🇮🇱",
      symbol: '₪',
    ),
    Currency(
      id: "INR",
      name: "Indian Rupee",
      flag: "🇮🇳",
      symbol: '₹',
    ),
    Currency(
      id: "ISK",
      name: "Icelandic Króna",
      flag: "🇮🇸",
      symbol: 'kr',
    ),
    Currency(
      id: "JPY",
      name: "Japanese Yen",
      flag: "🇯🇵",
      symbol: '¥',
    ),
    Currency(
      id: "KRW",
      name: "South Korean Won",
      flag: "🇰🇷",
      symbol: '₩',
    ),
    Currency(
      id: "MXN",
      name: "Mexican Peso",
      flag: "🇲🇽",
      symbol: 'Mex\$',
    ),
    Currency(
      id: "MYR",
      name: "Malaysian Ringgit",
      flag: "🇲🇾",
      symbol: 'RM',
    ),
    Currency(
      id: "NOK",
      name: "Norwegian Krone",
      flag: "🇳🇴",
      symbol: 'kr',
    ),
    Currency(
      id: "NZD",
      name: "New Zealand Dollar",
      flag: "🇳🇿",
      symbol: '\$',
    ),
    Currency(
      id: "PHP",
      name: "Philippine Peso",
      flag: "🇵🇭",
      symbol: '₱',
    ),
    Currency(
      id: "PLN",
      name: "Polish Zloty",
      flag: "🇵🇱",
      symbol: 'zł',
    ),
    Currency(
      id: "RON",
      name: "Romanian Leu",
      flag: "🇷🇴",
      symbol: 'lei',
    ),
    Currency(
      id: "RUB",
      name: "Russian Ruble",
      flag: "🇷🇺",
      symbol: '₽',
    ),
    Currency(
      id: "SEK",
      name: "Swedish Krona",
      flag: "🇸🇪",
      symbol: 'kr',
    ),
    Currency(
      id: "SGD",
      name: "Singapore Dollar",
      flag: "🇸🇬",
      symbol: 'S\$',
    ),
    Currency(
      id: "THB",
      name: "Thai Baht",
      flag: "🇹🇭",
      symbol: '฿',
    ),
    Currency(
      id: "TRY",
      name: "Turkish Lira",
      flag: "🇹🇷",
      symbol: '₺',
    ),
    Currency(
      id: "USD",
      name: "US Dollar",
      flag: "🇺🇸",
      symbol: '\$',
    ),
    Currency(
      id: "ZAR",
      name: "South African Rand",
      flag: "🇿🇦",
      symbol: 'R',
    ),
  ];
}
