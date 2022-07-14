class Currency {
  String type;
  double? amount = 1.0;

  Currency(this.type, {this.amount});
}

class CurrenciesData {
  String id, name;
  CurrenciesData({required this.id, required this.name});

  static var currenciesData = [
    CurrenciesData(
      name: "Australian Dollar",
      id: "AUD",
    ),
    CurrenciesData(
      name: "Brazilian Real",
      id: "BRL",
    ),
    CurrenciesData(
      name: "British Pound",
      id: "GBP",
    ),
    CurrenciesData(
      name: "Canadian Dollar",
      id: "CAD",
    ),
    CurrenciesData(
      name: "Chilean Peso",
      id: "CLP",
    ),
    CurrenciesData(
      name: "Chinese Yuan",
      id: "CNY",
    ),
    CurrenciesData(
      name: "Colombian Peso",
      id: "COP",
    ),
    CurrenciesData(
      name: "Czech Koruna",
      id: "CZK",
    ),
    CurrenciesData(
      name: "Danish Krone",
      id: "DKK",
    ),
    CurrenciesData(
      name: "Egyptian Pound",
      id: "EGP",
    ),
    CurrenciesData(
      name: "Euro",
      id: "EUR",
    ),
    CurrenciesData(
      name: "Hong Kong Dollar",
      id: "HKD",
    ),
    CurrenciesData(
      name: "Hungarian Forint",
      id: "HUF",
    ),
    CurrenciesData(
      name: "Indian Rupee",
      id: "INR",
    ),
    CurrenciesData(
      name: "Indonesian Rupiah",
      id: "IDR",
    ),
    CurrenciesData(
      name: "Israeli New Sheqel",
      id: "ILS",
    ),
    CurrenciesData(
      name: "Japanese Yen",
      id: "JPY",
    ),
    CurrenciesData(
      name: "Kuwaiti Dinar",
      id: "KWD",
    ),
    CurrenciesData(
      name: "Malaysian Ringgit",
      id: "MYR",
    ),
    CurrenciesData(
      name: "Mexican Peso",
      id: "MXN",
    ),
    CurrenciesData(
      name: "New Taiwan Dollar",
      id: "TWD",
    ),
    CurrenciesData(
      name: "New Zealand Dollar",
      id: "NZD",
    ),
    CurrenciesData(
      name: "Norwegian Krone",
      id: "NOK",
    ),
    CurrenciesData(
      name: "Philippine Peso",
      id: "PHP",
    ),
    CurrenciesData(
      name: "Polish Zloty",
      id: "PLN",
    ),
    CurrenciesData(
      name: "Romanian Leu",
      id: "RON",
    ),
    CurrenciesData(
      name: "Russian Ruble",
      id: "RUB",
    ),
    CurrenciesData(
      name: "Saudi Riyal",
      id: "SAR",
    ),
    CurrenciesData(
      name: "Singapore Dollar",
      id: "SGD",
    ),
    CurrenciesData(
      name: "South African Rand",
      id: "ZAR",
    ),
    CurrenciesData(
      name: "South Korean Won",
      id: "KRW",
    ),
    CurrenciesData(
      name: "Sri Lankan Rupee",
      id: "LKR",
    ),
    CurrenciesData(
      name: "Swedish Krona",
      id: "SEK",
    ),
    CurrenciesData(
      name: "Swiss Franc",
      id: "CHF",
    ),
    CurrenciesData(
      name: "Thai Baht",
      id: "THB",
    ),
    CurrenciesData(
      name: "Turkish New Lira",
      id: "TRY",
    ),
    CurrenciesData(
      name: "UAE Dirham",
      id: "AED",
    ),
    CurrenciesData(
      name: "United States Dollar",
      id: "USD",
    ),
  ];
}
