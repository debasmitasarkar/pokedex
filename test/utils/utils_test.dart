import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/utils/utils.dart';

void main() {
  group('Int extension', () {
    // 9 => #009
    // 99 => #099
    // 100 => #100

    test('should return formatted string', () {
      int input = 9;
      expect(input.formatId(), '#009');
    });

    test('should return formatted string', () {
      int input = 99;
      expect(input.formatId(), '#099');
    });

    test('should return formatted string', () {
      int input = 100;
      expect(input.formatId(), '#100');
    });
  });
}
