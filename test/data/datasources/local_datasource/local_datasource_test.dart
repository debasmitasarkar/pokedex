import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/data/datasources/local_datasource/local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_datasource_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late LocalDatasource localDatasource;
  MockSharedPreferences mockSharedPreferences = MockSharedPreferences();
  final List<String> dataList = ['1', '2', '3'];

  setUpAll(() {
    localDatasource = LocalDatasource(mockSharedPreferences);
  });

  group('LocalDatasource', () {
    test('should return list of String', () {
      // arrange
      when(mockSharedPreferences.getStringList(any)).thenReturn(dataList);
      //act
      final result = localDatasource.fetchFavouritesList();
      //assert
      verify(mockSharedPreferences.getStringList(any));
      expect(dataList, result);
    });

    test('should return emptyList', () {
      // arrange
      when(mockSharedPreferences.getStringList(any)).thenReturn(null);
      //act
      final result = localDatasource.fetchFavouritesList();
      //assert
      verify(mockSharedPreferences.getStringList(any));
      expect([], result);
    });

    test('should return true when saved to list', () async {
      // arrange
      when(mockSharedPreferences.setStringList(any, any))
          .thenAnswer((_) => Future.value(true));
      //act
      final result = await localDatasource.saveToFavouritesList('1');
      //assert
      verify(mockSharedPreferences.setStringList(any, any));
      expect(true, result);
    });

    test('should return true if pokemon name is there in favourites list',
        () async {
      // arrange
      when(mockSharedPreferences.getStringList(any)).thenReturn(dataList);
      //act
      final result = localDatasource.checkIfFavourite('1');
      //assert
      verify(mockSharedPreferences.getStringList(any));
      expect(true, result);
    });

    test('should return true after removing pokemon name from favourites list',
        () async {
      // arrange
      when(mockSharedPreferences.getStringList(any)).thenReturn(dataList);
      when(mockSharedPreferences.setStringList(any, any))
          .thenAnswer((_) => Future.value(true));
      //act
      final result = await localDatasource.removeFromFavourites('1');
      //assert
      verify(mockSharedPreferences.setStringList(any, any));
      expect(true, result);
    });
  });
}
