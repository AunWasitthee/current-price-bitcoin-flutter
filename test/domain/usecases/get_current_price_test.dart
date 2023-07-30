import 'package:currency_btc/domain/entities/current_price_entity.dart';
import 'package:currency_btc/domain/usecases/get_current_price.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockApiRepository mockApiRepository;
  late GetCurrentPrice usecase;

  setUp(() {
    mockApiRepository = MockApiRepository();
    usecase = GetCurrentPrice(mockApiRepository);
  });

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

  test(
    'should get current price detail from the repository',
    () async {
      // arrange
      when(mockApiRepository.getCurrentPrice())
          .thenAnswer((_) async => Right(tCurrentPriceEntity));

      // act
      final result = await usecase.execute();

      // assert
      expect(result, equals(Right(tCurrentPriceEntity)));
    },
  );
}
