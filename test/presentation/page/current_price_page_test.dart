import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:currency_btc/domain/entities/current_price_entity.dart';
import 'package:currency_btc/presentation/bloc/current_price_bloc.dart';
import 'package:currency_btc/presentation/page/current_price_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrentPriceBloc
    extends MockBloc<CurrentPriceEvent, CurrentPriceState>
    implements CurrentPriceBloc {}

class FakeCurrentPriceState extends Fake implements CurrentPriceState {}

class FakeCurrentPriceEvent extends Fake implements CurrentPriceEvent {}

void main() {
  late MockCurrentPriceBloc mockCurrentPriceBloc;

  setUpAll(() async {
    HttpOverrides.global = null;
    registerFallbackValue(FakeCurrentPriceState());
    registerFallbackValue(FakeCurrentPriceEvent());

    final di = GetIt.instance;
    di.registerFactory(() => mockCurrentPriceBloc);
  });

  setUp(() {
    mockCurrentPriceBloc = MockCurrentPriceBloc();
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

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<CurrentPriceBloc>.value(
      value: mockCurrentPriceBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'should show widget contain current price data when state is has data',
    (WidgetTester tester) async {
      // arrange
      when(() => mockCurrentPriceBloc.state)
          .thenReturn(CurrentPriceHasData(tCurrentPriceEntity));

      // act
      await tester.pumpWidget(_makeTestableWidget(const CurrentPricePage()));
      // await tester.runAsync(() async {
      //   final HttpClient client = HttpClient();
      //   // await client.getUrl(Uri.parse(Urls.weatherIcon('02d')));
      // });
      // await tester.pumpAndSettle();

      // assert
      expect(
          find.byKey(const Key('current_price_data')), equals(findsOneWidget));
    },
  );
}
