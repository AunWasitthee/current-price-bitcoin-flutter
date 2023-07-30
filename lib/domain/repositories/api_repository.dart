import 'package:currency_btc/data/failure.dart';
import 'package:currency_btc/domain/entities/current_price_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ApiRepository{
  Future<Either<Failure,CurrentPriceEntity>> getCurrentPrice();
}