import 'package:ppn_app/domain/contracts/repository.dart';
import 'package:ppn_app/domain/entities/perfect_number_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract class PerfectNumberRepository extends Repository {
  AsyncResult<PerfectNumberEntity> isPerfectNumber(int number);
  AsyncResult<List<PerfectNumberEntity>> findPerfectNumbers(int start, int end);
  AsyncResult<PerfectNumberEntity> offlinePerfectNumber(int number);
  AsyncResult<List<PerfectNumberEntity>> offlinePerfectNumbers(
    int start,
    int end,
  );
}
