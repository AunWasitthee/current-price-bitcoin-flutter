import 'package:currency_btc/data/datasources/remote_data_source.dart';
import 'package:currency_btc/data/repositories/api_repository_impl.dart';
import 'package:currency_btc/domain/repositories/api_repository.dart';
import 'package:currency_btc/presentation/bloc/current_price_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'domain/usecases/get_current_price.dart';

final locator = GetIt.instance;

void init(){

  // bloc
  locator.registerFactory(() => CurrentPriceBloc(locator()));

  //usecase
  locator.registerLazySingleton(() => GetCurrentPrice(locator()));

// repository
  locator.registerLazySingleton<ApiRepository>(
        () => ApiRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  // data source
  locator.registerLazySingleton<RemoteDataSource>(
        () => RemoteDataSourceImpl(
      client: locator(),
    ),
  );


  // external
  locator.registerLazySingleton(() => http.Client());
}