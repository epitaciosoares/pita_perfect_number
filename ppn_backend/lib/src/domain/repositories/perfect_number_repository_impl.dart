import 'package:ppn_backend/src/domain/entities/perfect_number_entity.dart';
import 'package:ppn_backend/src/domain/repositories/perfect_number_repository.dart';
import 'package:result_dart/result_dart.dart';
import 'package:vaden/vaden.dart';

@Repository()
class PerfectNumberRepositoryImpl implements PerfectNumberRepository {
  /// Checks whether [number] is a perfect number.
  AsyncResult<PerfectNumberEntity> isPerfect(int number) async {
    if (number < 1) {
      return await AsyncResult.error('Please enter a positive integer.');
    }

    final isPerfect = _isPerfectNumber(number);
    if (isPerfect) {
      return await Success(
        PerfectNumberEntity(number: number, isPerfect: true),
      );
    } else {
      return Success(PerfectNumberEntity(number: number, isPerfect: false));
    }
  }

  /// Finds all perfect numbers between [start] and [end] (inclusive).
  AsyncResult<List<PerfectNumberEntity>> findInRange(int start, int end) async {
    final perfectNumbers = <PerfectNumberEntity>[];

    for (int num = start; num <= end; num++) {
      if (_isPerfectNumber(num)) {
        perfectNumbers.add(PerfectNumberEntity(number: num, isPerfect: true));
      }
    }
    return await Success(perfectNumbers);
  }

  bool _isPerfectNumber(int number) {
    if (number <= 1) return false;

    int sum = 1; // 1 sempre é divisor

    // percorre até a raiz quadrada
    for (int i = 2; i * i <= number; i++) {
      if (number % i == 0) {
        sum += i;

        int pairDivisor = number ~/ i;

        // evita duplicar quando for raiz exata
        if (pairDivisor != i) {
          sum += pairDivisor;
        }
      }
    }

    return sum == number;
  }
}
