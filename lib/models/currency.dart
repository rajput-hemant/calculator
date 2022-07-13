class Currency {
  String type;
  double? amount = 1.0;

  Currency(this.type, {this.amount});
}

class CurrenciesData {
  String id, name;
  CurrenciesData({required this.id, required this.name});

  static var currenciesData = [
    CurrenciesData(id: "USD", name: "United States Dollar"),
    CurrenciesData(id: "EGP", name: "Egyptian Pound"),
    CurrenciesData(id: "LKR", name: "Sri Lankan Rupee"),
    CurrenciesData(id: "EUR", name: "Euro"),
    CurrenciesData(id: "JPY", name: "Japanese Yen"),
    CurrenciesData(id: "GBP", name: "British Pound"),
    CurrenciesData(id: "AUD", name: "Australian Dollar"),
    CurrenciesData(id: "CAD", name: "Canadian Dollar"),
    CurrenciesData(id: "CHF", name: "Swiss Franc"),
    CurrenciesData(id: "CNY", name: "Chinese Yuan"),
    CurrenciesData(id: "HKD", name: "Hong Kong Dollar"),
    CurrenciesData(id: "NZD", name: "New Zealand Dollar"),
    CurrenciesData(id: "SEK", name: "Swedish Krona"),
    CurrenciesData(id: "KRW", name: "South Korean Won"),
    CurrenciesData(id: "SGD", name: "Singapore Dollar"),
    CurrenciesData(id: "NOK", name: "Norwegian Krone"),
    CurrenciesData(id: "MXN", name: "Mexican Peso"),
    CurrenciesData(id: "INR", name: "Indian Rupee"),
    CurrenciesData(id: "RUB", name: "Russian Ruble"),
    CurrenciesData(id: "ZAR", name: "South African Rand"),
    CurrenciesData(id: "TRY", name: "Turkish New Lira"),
    CurrenciesData(id: "BRL", name: "Brazilian Real"),
    CurrenciesData(id: "TWD", name: "New Taiwan Dollar"),
    CurrenciesData(id: "DKK", name: "Danish Krone"),
    CurrenciesData(id: "PLN", name: "Polish Zloty"),
    CurrenciesData(id: "THB", name: "Thai Baht"),
    CurrenciesData(id: "IDR", name: "Indonesian Rupiah"),
    CurrenciesData(id: "HUF", name: "Hungarian Forint"),
    CurrenciesData(id: "CZK", name: "Czech Koruna"),
    CurrenciesData(id: "ILS", name: "Israeli New Sheqel"),
    CurrenciesData(id: "CLP", name: "Chilean Peso"),
    CurrenciesData(id: "PHP", name: "Philippine Peso"),
    CurrenciesData(id: "AED", name: "UAE Dirham"),
    CurrenciesData(id: "COP", name: "Colombian Peso"),
    CurrenciesData(id: "SAR", name: "Saudi Riyal"),
    CurrenciesData(id: "MYR", name: "Malaysian Ringgit"),
    CurrenciesData(id: "RON", name: "Romanian Leu"),
    CurrenciesData(id: "KWD", name: "Kuwaiti Dinar"),
  ];
}
