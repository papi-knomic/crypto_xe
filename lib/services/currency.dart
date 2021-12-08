import 'dart:convert';

class Currency {
  String name;
  var price;
  String symbol;
  String imageUrl;
  var percentChange24h;
  var percentChange7d;
  var ath;

  Currency(
      {this.name,
      this.price,
      this.symbol,
      this.imageUrl,
      this.percentChange24h,
      this.ath,
      this.percentChange7d});

  factory Currency.fromJson(Map<String, dynamic> jsonData) {
    return Currency(
      name: jsonData['name'],
      price: jsonData['current_price'],
      symbol: jsonData['symbol'],
      imageUrl: jsonData['image'],
      percentChange24h: jsonData['price_change_percentage_24h'],
      ath: jsonData['ath'],
      percentChange7d: jsonData['price_change_percentage_7d_in_currency'],
    );
  }

  static Map<String, dynamic> toMap(Currency currency) => {
        'name': currency.name,
        'current_price': currency.price,
        'symbol': currency.symbol,
        'image': currency.imageUrl,
        'price_change_percentage_24h': currency.percentChange24h,
        'ath': currency.ath,
        'price_change_percentage_7d_in_currency': currency.percentChange7d,
      };

  static String encode(List<Currency> currencies) => json.encode(
        currencies
            .map<Map<String, dynamic>>((currency) => Currency.toMap(currency))
            .toList(),
      );

  static List<Currency> decode(String currency) =>
      (json.decode(currency) as List<dynamic>)
          .map<Currency>((currency) => Currency.fromJson(currency))
          .toList();
}
