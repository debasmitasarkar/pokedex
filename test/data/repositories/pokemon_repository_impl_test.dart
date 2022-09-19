import 'package:pokedex/data/datasources/local_datasource/local_datasource.dart';
import 'package:pokedex/data/datasources/remote_datasource/remote_datasource.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/data/models/pokemon_model.dart';
import 'package:pokedex/data/repositories/pokemon_repository_impl.dart';

import '../../domain/entities/pokemon_detail_entity_mock.dart';
import '../../domain/entities/pokemon_response_entity_mock.dart';
import '../models/pokemon_detail_model_mock.dart';
import '../models/pokemon_model_mock.dart';
import 'pokemon_repository_impl_test.mocks.dart';

@GenerateMocks([RemoteDataSource, LocalDatasource])
void main() {
  late PokemonRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource = MockRemoteDataSource();
  MockLocalDatasource mockLocalDataSource = MockLocalDatasource();
  const List<String> dataList = ['1', '2', '3'];

  setUp(() {
    repository = PokemonRepositoryImpl(
      dataSource: mockRemoteDataSource,
      localDatasource: mockLocalDataSource,
    );
  });

  PokemonResponseModel mockResponseModel =
      PokemonResponseModel.fromJson(mockResponseJson);

  group('getPokemons', () {
    test(
      'should get pokemon response',
      () async {
        // arrange
        when(mockRemoteDataSource.getPokemons(any))
            .thenAnswer((_) async => mockResponseModel);
        // act
        final result = await repository.getPokemons(null);
        // assert
        verify(mockRemoteDataSource.getPokemons(any));
        expect(result, mockPokemonResponseEntity);
      },
    );
    test('throws an exception', () async {
      //arrange
      when(mockRemoteDataSource.getPokemons(any))
          .thenThrow((_) async => Exception());
      //act
      final call = repository.getPokemons;
      //assert
      expect(() => call(null), throwsA(const TypeMatcher<Exception>()));
    });
  });

  group('getPokemonsByName', () {
    test(
      'should get pokemon detail',
      () async {
        // arrange
        when(mockRemoteDataSource.getPokemonByName(any))
            .thenAnswer((_) async => mockPokemonDetailModel);
        // act
        final result = await repository.getPokemonByName('bulbasaur');
        // assert
        expect(result, mockPokemonDetailEntity);
      },
    );
    test('throws an exception', () async {
      //arrance
      when(mockRemoteDataSource.getPokemonByName(any))
          .thenThrow((_) async => Exception());
      //act
      final call = repository.getPokemonByName;
      //assert
      expect(() => call(''), throwsA(const TypeMatcher<Exception>()));
    });
  });

  group('repository', () {
    test('should return list of String', () {
      // arrange
      when(mockLocalDataSource.fetchFavouritesList()).thenReturn(dataList);
      //act
      final result = repository.fetchFavourites();
      //assert
      verify(mockLocalDataSource.fetchFavouritesList());
      expect(dataList, result);
    });

    test('should return true when saved to list', () async {
      // arrange
      when(mockLocalDataSource.saveToFavouritesList(any))
          .thenAnswer((_) => Future.value(true));
      //act
      final result = await repository.saveToFavouritesList('1');
      //assert
      verify(mockLocalDataSource.saveToFavouritesList(any));
      expect(true, result);
    });

    test('should return true if pokemon name is there in favourites list',
        () async {
      // arrangex
      when(mockLocalDataSource.checkIfFavourite(any)).thenReturn(true);
      //act
      final result = repository.checkIfFavourite('1');
      //assert
      verify(mockLocalDataSource.checkIfFavourite(any));
      expect(true, result);
    });

    test('should return true when removing pokemon name', () async {
      // arrange
      when(mockLocalDataSource.removeFromFavourites(any))
          .thenAnswer((_) => Future.value(true)); //act
      final result = await repository.removeFromFavourites('1');
      //assert
      verify(mockLocalDataSource.removeFromFavourites(any));
      expect(true, result);
    });
  });
}
