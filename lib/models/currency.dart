class Currency {
  String type;
  double? amount = 1.0;

  Currency(this.type, {this.amount});
}

class CurrenciesData {
  String id, name, flag, symbol;
  CurrenciesData({
    required this.id,
    required this.name,
    required this.flag,
    required this.symbol,
  });

  static var currenciesData = [
    CurrenciesData(
      name: "Australian Dollar",
      id: "AUD",
      flag: "🇦🇺",
      symbol: '\$',
    ),
    CurrenciesData(
      name: "Brazilian Real",
      id: "BRL",
      flag: "🇧🇷",
      symbol: "R\$",
    ),
    CurrenciesData(
      name: "British Pound",
      id: "GBP",
      flag: "🇬🇧",
      symbol: "£",
    ),
    CurrenciesData(
      name: "Canadian Dollar",
      id: "CAD",
      flag: "🇨🇦",
      symbol: "\$",
    ),
    CurrenciesData(
      name: "Chilean Peso",
      id: "CLP",
      flag: "🇨🇱",
      symbol: "\$",
    ),
    CurrenciesData(
      name: "Chinese Yuan",
      id: "CNY",
      flag: "🇨🇳",
      symbol: "¥",
    ),
    CurrenciesData(
      name: "Colombian Peso",
      id: "COP",
      flag: "🇨🇴",
      symbol: "\$",
    ),
    CurrenciesData(
      name: "Czech Koruna",
      id: "CZK",
      flag: "🇨🇿",
      symbol: "Kč",
    ),
    CurrenciesData(
      name: "Danish Krone",
      id: "DKK",
      flag: "🇩🇰",
      symbol: "kr",
    ),
    CurrenciesData(
      name: "Egyptian Pound",
      id: "EGP",
      flag: "🇪🇬",
      symbol: "£",
    ),
    CurrenciesData(
      name: "Euro",
      id: "EUR",
      flag: "🇪🇺",
      symbol: "€",
    ),
    CurrenciesData(
      name: "HongKong Dollar",
      id: "HKD",
      flag: "🇭🇰",
      symbol: "\$",
    ),
    CurrenciesData(
      name: "Hungarian Forint",
      id: "HUF",
      flag: "🇭🇺",
      symbol: "Ft",
    ),
    CurrenciesData(
      name: "Indian Rupee",
      id: "INR",
      flag: " 🇮🇳",
      symbol: "₹",
    ),
    CurrenciesData(
      name: "Indonesian Rupiah",
      id: "IDR",
      flag: "🇮🇳",
      symbol: "Rp",
    ),
    CurrenciesData(
      name: "Israeli New Sheqel",
      id: "ILS",
      flag: "🇮🇱",
      symbol: "₪",
    ),
    CurrenciesData(
      name: "Japanese Yen",
      id: "JPY",
      flag: "🇯🇵",
      symbol: "¥",
    ),
    CurrenciesData(
      name: "Kuwaiti Dinar",
      id: "KWD",
      flag: "🇰🇼",
      symbol: "د.ك",
    ),
    CurrenciesData(
      name: "Malaysian Ringgit",
      id: "MYR",
      flag: "🇲🇾",
      symbol: "RM",
    ),
    CurrenciesData(
      name: "Mexican Peso",
      id: "MXN",
      flag: "🇲🇽",
      symbol: "\$",
    ),
    CurrenciesData(
      name: "New Taiwan Dollar",
      id: "TWD",
      flag: "🇹🇼",
      symbol: "NT\$",
    ),
    CurrenciesData(
      name: "New Zealand Dollar",
      id: "NZD",
      flag: "🇳🇿",
      symbol: "\$",
    ),
    CurrenciesData(
      name: "Norwegian Krone",
      id: "NOK",
      flag: "🇳🇴",
      symbol: "kr",
    ),
    CurrenciesData(
      name: "Philippine Peso",
      id: "PHP",
      flag: "🇵🇭",
      symbol: "₱",
    ),
    CurrenciesData(
      name: "Polish Zloty",
      id: "PLN",
      flag: "🇵🇱",
      symbol: "zł",
    ),
    CurrenciesData(
      name: "Romanian Leu",
      id: "RON",
      flag: "🇷🇴",
      symbol: "lei",
    ),
    CurrenciesData(
      name: "Russian Ruble",
      id: "RUB",
      flag: "🇷🇺",
      symbol: "₽",
    ),
    CurrenciesData(
      name: "Saudi Riyal",
      id: "SAR",
      flag: "🇸🇦",
      symbol: "﷼",
    ),
    CurrenciesData(
      name: "Singapore Dollar",
      id: "SGD",
      flag: "🇸🇬",
      symbol: "\$",
    ),
    CurrenciesData(
      name: "South African Rand",
      id: "ZAR",
      flag: "🇿🇦",
      symbol: "R",
    ),
    CurrenciesData(
      name: "South Korean Won",
      id: "KRW",
      flag: "🇰🇷",
      symbol: "₩",
    ),
    CurrenciesData(
      name: "Sri Lankan Rupee",
      id: "LKR",
      flag: "🇱🇰",
      symbol: "₨",
    ),
    CurrenciesData(
      name: "Swedish Krona",
      id: "SEK",
      flag: "🇸🇪",
      symbol: "kr",
    ),
    CurrenciesData(
      name: "Swiss Franc",
      id: "CHF",
      flag: "🇨🇭",
      symbol: "CHF",
    ),
    CurrenciesData(
      name: "Thai Baht",
      id: "THB",
      flag: "🇹🇭",
      symbol: "฿",
    ),
    CurrenciesData(
      name: "Turkish New Lira",
      id: "TRY",
      flag: "🇹🇷",
      symbol: "₺",
    ),
    CurrenciesData(
      name: "UAE Dirham",
      id: "AED",
      flag: "🇦🇪",
      symbol: "د.إ",
    ),
    CurrenciesData(
      name: "US Dollar",
      id: "USD",
      flag: "🇺🇸",
      symbol: "\$",
    ),
  ];
}
