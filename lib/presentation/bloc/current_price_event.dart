part of 'current_price_bloc.dart';

abstract class CurrentPriceEvent extends Equatable{
  const CurrentPriceEvent();
  @override
  List<Object?> get props => [];
}

class OnCurrentPrice extends CurrentPriceEvent {
  const OnCurrentPrice();

  @override
  List<Object?> get props => [];
}

class OnFetchData extends CurrentPriceEvent {
  const OnFetchData();

  @override
  List<Object?> get props => [];
}
