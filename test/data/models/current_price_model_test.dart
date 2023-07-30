import 'dart:convert';

import 'package:currency_btc/data/models/current_price_model.dart';
import 'package:currency_btc/domain/entities/current_price_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/json_reader.dart';

void main() {
  var tCurrentPriceModel = CurrentPriceModel(
      time: Time(
          updated: "Jul 30, 2023 09:23:00 UTC",
          updatedIso: DateTime.parse("2023-07-30T09:23:00+00:00"),
          updateduk: "Jul 30, 2023 at 10:23 BST"),
      disclaimer:
          "This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org",
      chartName: "Bitcoin",
      bpi: Bpi(
          usd: Currency(
              code: "USD",
              symbol: "&#36;",
              rate: "29,291.9084",
              description: "United States Dollar",
              rateFloat: 29291.9084),
          gbp: Currency(
              code: "GBP",
              symbol: "&pound;",
              rate: "24,476.0843",
              description: "British Pound Sterling",
              rateFloat: 24476.0843),
          eur: Currency(
              code: "EUR",
              symbol: "&euro;",
              rate: "28,534.5954",
              description: "Euro",
              rateFloat: 28534.5954)));
  var tCurrentPriceEntity = CurrentPriceEntity(
      time: TimeEntity(
          updated: "Jul 30, 2023 09:23:00 UTC",
          updatedIso: DateTime.parse("2023-07-30T09:23:00+00:00"),
          updateduk: "Jul 30, 2023 at 10:23 BST"),
      disclaimer:
          "This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org",
      chartName: "Bitcoin",
      bpi: BpiEntity(
          usd: CurrencyEntity(
              code: "USD",
              symbol: "&#36;",
              rate: "29,291.9084",
              description: "United States Dollar",
              rateFloat: 29291.9084),
          gbp: CurrencyEntity(
              code: "GBP",
              symbol: "&pound;",
              rate: "24,476.0843",
              description: "British Pound Sterling",
              rateFloat: 24476.0843),
          eur: CurrencyEntity(
              code: "EUR",
              symbol: "&euro;",
              rate: "28,534.5954",
              description: "Euro",
              rateFloat: 28534.5954)));

  group('to entity', () {
    test(
      'should be a subclass of current price entity',
      () async {
        // assert
        final result = tCurrentPriceModel.toEntity();
        expect(result, equals(tCurrentPriceEntity));
      },
    );
  });

  group('from json', () {
    test(
      'should return a valid model from json',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          readJson('helpers/dummy_data/dummy_response.json'),
        );

        // act
        final result = CurrentPriceModel.fromJson(jsonMap);

        // assert
        expect(result, equals(tCurrentPriceModel));
      },
    );
  });

  group('to json', () {
    test(
      'should return a json map containing proper data',
      () async {
        // act
        final result = tCurrentPriceModel.toJson();

        // assert
        final expectedJsonMap = {
          "time": {
            "updated": "Jul 30, 2023 09:23:00 UTC",
            "updatedISO":
                DateTime.parse(("2023-07-30T09:23:00+00:00")).toIso8601String(),
            "updateduk": "Jul 30, 2023 at 10:23 BST"
          },
          "disclaimer":
              "This data was produced from the CoinDesk Bitcoin Price Index (USD). Non-USD currency data converted using hourly conversion rate from openexchangerates.org",
          "chartName": "Bitcoin",
          "bpi": {
            "USD": {
              "code": "USD",
              "symbol": "&#36;",
              "rate": "29,291.9084",
              "description": "United States Dollar",
              "rate_float": 29291.9084
            },
            "GBP": {
              "code": "GBP",
              "symbol": "&pound;",
              "rate": "24,476.0843",
              "description": "British Pound Sterling",
              "rate_float": 24476.0843
            },
            "EUR": {
              "code": "EUR",
              "symbol": "&euro;",
              "rate": "28,534.5954",
              "description": "Euro",
              "rate_float": 28534.5954
            }
          }
        };
        expect(result, equals(expectedJsonMap));
      },
    );
  });
}
