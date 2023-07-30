import 'package:currency_btc/data/failure.dart';
import 'package:currency_btc/domain/entities/current_price_entity.dart';
import 'package:currency_btc/domain/repositories/api_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrentPrice{
  final ApiRepository apiRepository;
  GetCurrentPrice(this.apiRepository);

  Future<Either<Failure,CurrentPriceEntity>> execute() async{
    return apiRepository.getCurrentPrice();
  }
}