import 'dart:io';

import 'package:currency_btc/data/exception.dart';
import 'package:currency_btc/data/failure.dart';
import 'package:currency_btc/data/models/current_price_model.dart';
import 'package:currency_btc/data/repositories/api_repository_impl.dart';
import 'package:currency_btc/domain/entities/current_price_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late ApiRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = ApiRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });

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

  group('get current price', () {
    test(
      'should return current price when a call to data source is successful',
      () async {
        // arrange
        when(mockRemoteDataSource.getCurrentPrice())
            .thenAnswer((_) async => tCurrentPriceModel);

        // act
        final result = await repository.getCurrentPrice();

        // assert
        verify(mockRemoteDataSource.getCurrentPrice());
        expect(result, equals(Right(tCurrentPriceEntity)));
      },
    );

    test(
      'should return server failure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getCurrentPrice())
            .thenThrow(ServerException());

        // act
        final result = await repository.getCurrentPrice();

        // assert
        verify(mockRemoteDataSource.getCurrentPrice());
        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device has no internet',
      () async {
        // arrange
        when(mockRemoteDataSource.getCurrentPrice())
            .thenThrow(SocketException('Failed to connect to the network'));

        // act
        final result = await repository.getCurrentPrice();

        // assert
        verify(mockRemoteDataSource.getCurrentPrice());
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });
}
