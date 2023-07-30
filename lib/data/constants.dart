class Urls {
  static const String baseUrl = 'https://api.coindesk.com/v1/bpi';
  static String currentPrice() => '$baseUrl/currentprice.json';
}