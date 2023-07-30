import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:currency_btc/domain/entities/current_price_entity.dart';
import 'package:currency_btc/domain/usecases/get_current_price.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'current_price_event.dart';

part 'current_price_state.dart';

class CurrentPriceBloc extends Bloc<CurrentPriceEvent, CurrentPriceState> {
  final GetCurrentPrice _getCurrentPrice;
  StreamSubscription? _periodicSubscription;
  List<CurrentPriceEntity> currentPriceList = [];
  CurrentPriceEntity currentPrice = CurrentPriceEntity();

  CurrentPriceBloc(this._getCurrentPrice) : super(CurrentPriceInitial()) {
    on<CurrentPriceEvent>(
          (event, emit) async {
        emit(CurrentPriceLoading());
        if (_periodicSubscription == null) {
          _periodicSubscription ??=
              Stream.periodic(const Duration(minutes: 1), (x) => x).startWith(
                  0).listen(
                          (_) => add(const OnFetchData()),
                      onError: (error) => print("Do something with $error"));
                  } else {
                  _periodicSubscription?.resume();
                  }

                  if (event is OnFetchData)
          {
            final result = await _getCurrentPrice.execute();
            result.fold(
                  (failure) {
                emit(CurrentPriceError(failure.message));
              },
                  (data) {
                    currentPrice = data;
                    currentPriceList.add(data);
                emit(CurrentPriceHasData(data));
              },
            );
          }
        },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  @override
  Future<void> close() async {
    await _periodicSubscription?.cancel();
    _periodicSubscription = null;
    return super.close();
  }
}
