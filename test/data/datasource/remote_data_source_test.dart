import 'dart:convert';

import 'package:currency_btc/data/constants.dart';
import 'package:currency_btc/data/datasources/remote_data_source.dart';
import 'package:currency_btc/data/exception.dart';
import 'package:currency_btc/data/models/current_price_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late RemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = RemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get current price', () {
    final tCurrentPriceModel = CurrentPriceModel.fromJson(
        json.decode(readJson('helpers/dummy_data/dummy_response.json')));

    test(
      'should return current price model when the response code is 200',
      () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse(Urls.currentPrice())),
        ).thenAnswer(
          (_) async => http.Response(
              readJson('helpers/dummy_data/dummy_response.json'), 200),
        );

        // act
        final result = await dataSource.getCurrentPrice();

        // assert
        expect(result, equals(tCurrentPriceModel));
      },
    );

    test(
      'should throw a server exception when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse(Urls.currentPrice())),
        ).thenAnswer(
          (_) async => http.Response('Not found', 404),
        );

        // act
        final call = dataSource.getCurrentPrice();

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
