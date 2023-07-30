import 'package:bloc_test/bloc_test.dart';
import 'package:currency_btc/data/failure.dart';
import 'package:currency_btc/domain/entities/current_price_entity.dart';
import 'package:currency_btc/domain/usecases/get_current_price.dart';
import 'package:currency_btc/presentation/bloc/current_price_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'current_price_bloc_test.mocks.dart';

@GenerateMocks([GetCurrentPrice])
void main() {
  late MockGetCurrentPrice mockGetCurrentPrice;
  late CurrentPriceBloc currentPriceBloc;

  setUp(() {
    mockGetCurrentPrice = MockGetCurrentPrice();
    currentPriceBloc = CurrentPriceBloc(mockGetCurrentPrice);
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
    'initial state should be empty',
    () {
      expect(currentPriceBloc.state, CurrentPriceInitial());
    },
  );

  blocTest<CurrentPriceBloc, CurrentPriceState>(
    'should emit [loading, has data] when data is gotten successfully -- blocTest timeout more than 30 seconds fail in flutter test',
    build: () {
      when(mockGetCurrentPrice.execute())
          .thenAnswer((_) async => Right(tCurrentPriceEntity));

      return currentPriceBloc;
    },
    act: (bloc) async {
      bloc.add(const OnCurrentPrice());
      await Future<void>.delayed(const Duration(minutes: 1));
    },
    wait: const Duration(milliseconds: 500),
    expect: () => [
      CurrentPriceLoading(),
      CurrentPriceHasData(tCurrentPriceEntity),
    ],
    verify: (bloc) {
      verify(mockGetCurrentPrice.execute());
    },
  );

  blocTest<CurrentPriceBloc, CurrentPriceState>(
    'should emit [loading, error] when get data is unsuccessful -- blocTest timeout more than 30 seconds fail in flutter test',
    build: () {
      when(mockGetCurrentPrice.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server failure')));
      return currentPriceBloc;
    },
    act: (bloc) async {
      bloc.add(const OnCurrentPrice());
      await Future<void>.delayed(const Duration(minutes: 1));
    },
    wait: const Duration(milliseconds: 500),
    expect: () => [
      CurrentPriceLoading(),
      const CurrentPriceError('Server failure'),
    ],
    verify: (bloc) {
      verify(mockGetCurrentPrice.execute());
    },
  );
}
