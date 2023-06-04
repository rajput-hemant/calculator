import 'models.dart';

class Money {
  const Money(
    this.type, {
    this.amount = 1.0,
  });

  final String type;
  final double? amount;
}

class Currency implements Unit {
  const Currency({
    required this.id,
    required this.name,
    required this.flag,
    required this.symbol,
  });

  @override
  @override
  @override
  @override
  final String id, name, flag, symbol;

  @override
  double? get rate => null;

  static const currenciesList = [
    Currency(
      id: "AUD",
      name: "Australian Dollar",
      flag: "🇦🇺",
      symbol: '\$',
    ),
    Currency(
      id: "BRL",
      name: "Brazilian Real",
      flag: "🇧🇷",
      symbol: "R\$",
    ),
    Currency(
      id: "GBP",
      name: "British Pound",
      flag: "🇬🇧",
      symbol: "£",
    ),
    Currency(
      id: "CAD",
      name: "Canadian Dollar",
      flag: "🇨🇦",
      symbol: "\$",
    ),
    Currency(
      id: "CLP",
      name: "Chilean Peso",
      flag: "🇨🇱",
      symbol: "\$",
    ),
    Currency(
      id: "CNY",
      name: "Chinese Yuan",
      flag: "🇨🇳",
      symbol: "¥",
    ),
    Currency(
      id: "COP",
      name: "Colombian Peso",
      flag: "🇨🇴",
      symbol: "\$",
    ),
    Currency(
      id: "CZK",
      name: "Czech Koruna",
      flag: "🇨🇿",
      symbol: "Kč",
    ),
    Currency(
      id: "DKK",
      name: "Danish Krone",
      flag: "🇩🇰",
      symbol: "kr",
    ),
    Currency(
      id: "EGP",
      name: "Egyptian Pound",
      flag: "🇪🇬",
      symbol: "£",
    ),
    Currency(
      id: "EUR",
      name: "Euro",
      flag: "🇪🇺",
      symbol: "€",
    ),
    Currency(
      id: "HKD",
      name: "HongKong Dollar",
      flag: "🇭🇰",
      symbol: "\$",
    ),
    Currency(
      id: "HUF",
      name: "Hungarian Forint",
      flag: "🇭🇺",
      symbol: "Ft",
    ),
    Currency(
      id: "INR",
      name: "Indian Rupee",
      flag: "🇮🇳",
      symbol: "₹",
    ),
    Currency(
      id: "IDR",
      name: "Indonesian Rupiah",
      flag: "🇮🇩",
      symbol: "Rp",
    ),
    Currency(
      id: "ILS",
      name: "Israeli New Sheqel",
      flag: "🇮🇱",
      symbol: "₪",
    ),
    Currency(
      id: "JPY",
      name: "Japanese Yen",
      flag: "🇯🇵",
      symbol: "¥",
    ),
    Currency(
      id: "KWD",
      name: "Kuwaiti Dinar",
      flag: "🇰🇼",
      symbol: "د.ك",
    ),
    Currency(
      id: "MYR",
      name: "Malaysian Ringgit",
      flag: "🇲🇾",
      symbol: "RM",
    ),
    Currency(
      id: "MXN",
      name: "Mexican Peso",
      flag: "🇲🇽",
      symbol: "\$",
    ),
    Currency(
      id: "TWD",
      name: "New Taiwan Dollar",
      flag: "🇹🇼",
      symbol: "NT\$",
    ),
    Currency(
      id: "NZD",
      name: "New Zealand Dollar",
      flag: "🇳🇿",
      symbol: "\$",
    ),
    Currency(
      id: "NOK",
      name: "Norwegian Krone",
      flag: "🇳🇴",
      symbol: "kr",
    ),
    Currency(
      id: "PHP",
      name: "Philippine Peso",
      flag: "🇵🇭",
      symbol: "₱",
    ),
    Currency(
      id: "PLN",
      name: "Polish Zloty",
      flag: "🇵🇱",
      symbol: "zł",
    ),
    Currency(
      id: "RON",
      name: "Romanian Leu",
      flag: "🇷🇴",
      symbol: "lei",
    ),
    Currency(
      id: "RUB",
      name: "Russian Ruble",
      flag: "🇷🇺",
      symbol: "₽",
    ),
    Currency(
      id: "SAR",
      name: "Saudi Riyal",
      flag: "🇸🇦",
      symbol: "﷼",
    ),
    Currency(
      id: "SGD",
      name: "Singapore Dollar",
      flag: "🇸🇬",
      symbol: "\$",
    ),
    Currency(
      id: "ZAR",
      name: "South African Rand",
      flag: "🇿🇦",
      symbol: "R",
    ),
    Currency(
      id: "KRW",
      name: "South Korean Won",
      flag: "🇰🇷",
      symbol: "₩",
    ),
    Currency(
      id: "LKR",
      name: "Sri Lankan Rupee",
      flag: "🇱🇰",
      symbol: "₨",
    ),
    Currency(
      id: "SEK",
      name: "Swedish Krona",
      flag: "🇸🇪",
      symbol: "kr",
    ),
    Currency(
      id: "CHF",
      name: "Swiss Franc",
      flag: "🇨🇭",
      symbol: "CHF",
    ),
    Currency(
      id: "THB",
      name: "Thai Baht",
      flag: "🇹🇭",
      symbol: "฿",
    ),
    Currency(
      id: "TRY",
      name: "Turkish New Lira",
      flag: "🇹🇷",
      symbol: "₺",
    ),
    Currency(
      id: "AED",
      name: "UAE Dirham",
      flag: "🇦🇪",
      symbol: "د.إ",
    ),
    Currency(
      id: "USD",
      name: "US Dollar",
      flag: "🇺🇸",
      symbol: "\$",
    ),
  ];
}
