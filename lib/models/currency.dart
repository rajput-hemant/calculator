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
      flag: "ð¦ðº",
      symbol: '\$',
    ),
    CurrenciesData(
      name: "Brazilian Real",
      id: "BRL",
      flag: "ð§ð·",
      symbol: "R\$",
    ),
    CurrenciesData(
      name: "British Pound",
      id: "GBP",
      flag: "ð¬ð§",
      symbol: "Â£",
    ),
    CurrenciesData(
      name: "Canadian Dollar",
      id: "CAD",
      flag: "ð¨ð¦",
      symbol: "\$",
    ),
    CurrenciesData(
      name: "Chilean Peso",
      id: "CLP",
      flag: "ð¨ð±",
      symbol: "\$",
    ),
    CurrenciesData(
      name: "Chinese Yuan",
      id: "CNY",
      flag: "ð¨ð³",
      symbol: "Â¥",
    ),
    CurrenciesData(
      name: "Colombian Peso",
      id: "COP",
      flag: "ð¨ð´",
      symbol: "\$",
    ),
    CurrenciesData(
      name: "Czech Koruna",
      id: "CZK",
      flag: "ð¨ð¿",
      symbol: "KÄ",
    ),
    CurrenciesData(
      name: "Danish Krone",
      id: "DKK",
      flag: "ð©ð°",
      symbol: "kr",
    ),
    CurrenciesData(
      name: "Egyptian Pound",
      id: "EGP",
      flag: "ðªð¬",
      symbol: "Â£",
    ),
    CurrenciesData(
      name: "Euro",
      id: "EUR",
      flag: "ðªðº",
      symbol: "â¬",
    ),
    CurrenciesData(
      name: "HongKong Dollar",
      id: "HKD",
      flag: "ð­ð°",
      symbol: "\$",
    ),
    CurrenciesData(
      name: "Hungarian Forint",
      id: "HUF",
      flag: "ð­ðº",
      symbol: "Ft",
    ),
    CurrenciesData(
      name: "Indian Rupee",
      id: "INR",
      flag: "ð®ð³",
      symbol: "â¹",
    ),
    CurrenciesData(
      name: "Indonesian Rupiah",
      id: "IDR",
      flag: "ð®ð©",
      symbol: "Rp",
    ),
    CurrenciesData(
      name: "Israeli New Sheqel",
      id: "ILS",
      flag: "ð®ð±",
      symbol: "âª",
    ),
    CurrenciesData(
      name: "Japanese Yen",
      id: "JPY",
      flag: "ð¯ðµ",
      symbol: "Â¥",
    ),
    CurrenciesData(
      name: "Kuwaiti Dinar",
      id: "KWD",
      flag: "ð°ð¼",
      symbol: "Ø¯.Ù",
    ),
    CurrenciesData(
      name: "Malaysian Ringgit",
      id: "MYR",
      flag: "ð²ð¾",
      symbol: "RM",
    ),
    CurrenciesData(
      name: "Mexican Peso",
      id: "MXN",
      flag: "ð²ð½",
      symbol: "\$",
    ),
    CurrenciesData(
      name: "New Taiwan Dollar",
      id: "TWD",
      flag: "ð¹ð¼",
      symbol: "NT\$",
    ),
    CurrenciesData(
      name: "New Zealand Dollar",
      id: "NZD",
      flag: "ð³ð¿",
      symbol: "\$",
    ),
    CurrenciesData(
      name: "Norwegian Krone",
      id: "NOK",
      flag: "ð³ð´",
      symbol: "kr",
    ),
    CurrenciesData(
      name: "Philippine Peso",
      id: "PHP",
      flag: "ðµð­",
      symbol: "â±",
    ),
    CurrenciesData(
      name: "Polish Zloty",
      id: "PLN",
      flag: "ðµð±",
      symbol: "zÅ",
    ),
    CurrenciesData(
      name: "Romanian Leu",
      id: "RON",
      flag: "ð·ð´",
      symbol: "lei",
    ),
    CurrenciesData(
      name: "Russian Ruble",
      id: "RUB",
      flag: "ð·ðº",
      symbol: "â½",
    ),
    CurrenciesData(
      name: "Saudi Riyal",
      id: "SAR",
      flag: "ð¸ð¦",
      symbol: "ï·¼",
    ),
    CurrenciesData(
      name: "Singapore Dollar",
      id: "SGD",
      flag: "ð¸ð¬",
      symbol: "\$",
    ),
    CurrenciesData(
      name: "South African Rand",
      id: "ZAR",
      flag: "ð¿ð¦",
      symbol: "R",
    ),
    CurrenciesData(
      name: "South Korean Won",
      id: "KRW",
      flag: "ð°ð·",
      symbol: "â©",
    ),
    CurrenciesData(
      name: "Sri Lankan Rupee",
      id: "LKR",
      flag: "ð±ð°",
      symbol: "â¨",
    ),
    CurrenciesData(
      name: "Swedish Krona",
      id: "SEK",
      flag: "ð¸ðª",
      symbol: "kr",
    ),
    CurrenciesData(
      name: "Swiss Franc",
      id: "CHF",
      flag: "ð¨ð­",
      symbol: "CHF",
    ),
    CurrenciesData(
      name: "Thai Baht",
      id: "THB",
      flag: "ð¹ð­",
      symbol: "à¸¿",
    ),
    CurrenciesData(
      name: "Turkish New Lira",
      id: "TRY",
      flag: "ð¹ð·",
      symbol: "âº",
    ),
    CurrenciesData(
      name: "UAE Dirham",
      id: "AED",
      flag: "ð¦ðª",
      symbol: "Ø¯.Ø¥",
    ),
    CurrenciesData(
      name: "US Dollar",
      id: "USD",
      flag: "ðºð¸",
      symbol: "\$",
    ),
  ];
}
