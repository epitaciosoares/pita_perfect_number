import 'package:ppn_backend/src/domain/repositories/perfect_number_repository_impl.dart';
import 'package:result_dart/result_dart.dart';
import 'package:test/test.dart';

void main() {
  late PerfectNumberRepositoryImpl repository;

  setUp(() {
    repository = PerfectNumberRepositoryImpl();
  });

  group('PerfectNumberRepositoryImpl', () {
    group('isPerfect', () {
      test('should return true for perfect number 6', () async {
        final result = await repository.isPerfect(6).getOrNull();
        expect(result, isNotNull);
        expect(result!.number, 6);
        expect(result.isPerfect, isTrue);
      });

      test('should return true for perfect number 28', () async {
        final result = await repository.isPerfect(28).getOrNull();

        expect(result, isNotNull);
        expect(result!.number, 28);
        expect(result.isPerfect, isTrue);
      });

      test('should return true for perfect number 496', () async {
        final result = await repository.isPerfect(496).getOrNull();

        expect(result, isNotNull);
        expect(result!.number, 496);
        expect(result.isPerfect, isTrue);
      });

      test('should return false for non-perfect number 10', () async {
        final result = await repository.isPerfect(10).getOrNull();

        expect(result, isNotNull);
        expect(result!.number, 10);
        expect(result.isPerfect, isFalse);
      });

      test('should return false for number 1', () async {
        final result = await repository.isPerfect(1).getOrNull();

        expect(result, isNotNull);
        expect(result!.number, 1);
        expect(result.isPerfect, isFalse);
      });
    });

    group('findInRange', () {
      test('should find perfect numbers 6 and 28 in range 1-30', () async {
        final result = await repository.findInRange(1, 30).getOrNull();

        expect(result, isNotNull);
        expect(result!.length, 2);
        expect(result[0].number, 6);
        expect(result[0].isPerfect, isTrue);
        expect(result[1].number, 28);
        expect(result[1].isPerfect, isTrue);
      });

      test('should find single perfect number 6 in range 1-10', () async {
        final result = await repository.findInRange(1, 10).getOrNull();

        expect(result, isNotNull);
        expect(result!.length, 1);
        expect(result[0].number, 6);
        expect(result[0].isPerfect, isTrue);
      });

      test('should return only numbers within range', () async {
        final result = await repository.findInRange(20, 40).getOrNull();

        expect(result, isNotNull);
        expect(result!.length, 1);
        expect(result[0].number, 28);
        expect(result[0].isPerfect, isTrue);
      });
    });
  });
}
