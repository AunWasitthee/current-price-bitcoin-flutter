import 'dart:convert';

import 'package:currency_btc/data/constants.dart';
import 'package:currency_btc/data/exception.dart';
import 'package:currency_btc/data/models/current_price_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<CurrentPriceModel> getCurrentPrice();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<CurrentPriceModel> getCurrentPrice() async {
    final response = await client.get(Uri.parse(Urls.currentPrice()));

    if (response.statusCode == 200) {
      return CurrentPriceModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
