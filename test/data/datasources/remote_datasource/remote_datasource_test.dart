import 'dart:convert';

import 'package:pokedex/data/datasources/remote_api.dart';
import 'package:pokedex/data/datasources/remote_datasource/remote_datasource.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/data/models/pokemon_detail_model.dart';
import 'package:pokedex/data/models/pokemon_model.dart';

import '../../models/pokemon_detail_model_mock.dart';
import '../../models/pokemon_model_mock.dart';
import 'remote_datasource_test.mocks.dart';

@GenerateMocks([RemoteApi, http.Client])
void main() {
  late RemoteDataSource dataSource;
  MockClient mockHttpClient = MockClient();

  setUp(() {
    dataSource = RemoteDataSource(mockHttpClient);
  });

  void setUpMockHttpClientSuccess200(Map<String, dynamic> mockJson) {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(json.encode(mockJson), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  PokemonResponseModel mockResponseModel =
      PokemonResponseModel.fromJson(mockResponseJson);

  group('getPokemons', () {
    test(
      'should get pokemon the http call completes successfully',
      () async {
        // arrange
        setUpMockHttpClientSuccess200(mockResponseJson);
        // act
        final result = await dataSource.getPokemons(null);
        // assert
        expect(result.pokemonModels.length,
            mockResponseModel.pokemonModels.length);
      },
    );
    test('throws an exception if the http call completes with an error',
        () async {
      //arrance
      setUpMockHttpClientFailure404();
      //act
      final call = dataSource.getPokemons;
      //assert
      expect(() => call(null), throwsA(const TypeMatcher<Exception>()));
    });
  });

  group('getPokemonsByName', () {
    test(
      'should get pokemon detail the http call completes successfully',
      () async {
        // arrange
        setUpMockHttpClientSuccess200(mockPokemonDetailJson);
        // act
        final result = await dataSource.getPokemonByName('bulbasaur');
        // assert
        expect(result, PokemonDetail.fromJson(mockPokemonDetailJson));
      },
    );
    test('throws an exception if the http call completes with an error',
        () async {
      //arrance
      setUpMockHttpClientFailure404();
      //act
      final call = dataSource.getPokemonByName;
      //assert
      expect(() => call('bulbasaur'), throwsA(const TypeMatcher<Exception>()));
    });
  });
}
