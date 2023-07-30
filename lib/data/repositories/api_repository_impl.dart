import 'dart:io';

import 'package:currency_btc/data/datasources/remote_data_source.dart';
import 'package:currency_btc/data/exception.dart';
import 'package:currency_btc/data/failure.dart';
import 'package:currency_btc/domain/entities/current_price_entity.dart';
import 'package:currency_btc/domain/repositories/api_repository.dart';
import 'package:dartz/dartz.dart';

class ApiRepositoryImpl implements ApiRepository {
  final RemoteDataSource remoteDataSource;

  ApiRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, CurrentPriceEntity>> getCurrentPrice() async {
    try {
      final result = await remoteDataSource.getCurrentPrice();
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}