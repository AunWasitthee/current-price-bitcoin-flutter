import 'package:currency_btc/data/datasources/remote_data_source.dart';
import 'package:currency_btc/domain/repositories/api_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  ApiRepository,
  RemoteDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}