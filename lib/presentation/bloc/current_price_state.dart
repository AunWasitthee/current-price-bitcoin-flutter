part of 'current_price_bloc.dart';

abstract class CurrentPriceState extends Equatable {
  const CurrentPriceState();

  @override
  List<Object?> get props => [];
}

class CurrentPriceInitial extends CurrentPriceState {}

class CurrentPriceLoading extends CurrentPriceState {}

class CurrentPriceError extends CurrentPriceState {
  final String message;

  const CurrentPriceError(this.message);

  @override
  List<Object?> get props => [message];
}

class CurrentPriceHasData extends CurrentPriceState {
  final CurrentPriceEntity result;

  CurrentPriceHasData(this.result);

  @override
  List<Object?> get props => [result];
}
