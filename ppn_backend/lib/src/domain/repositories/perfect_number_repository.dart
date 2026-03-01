import 'package:ppn_backend/src/domain/entities/perfect_number_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract class PerfectNumberRepository {
  AsyncResult<PerfectNumberEntity> isPerfect(int number);
  AsyncResult<List<PerfectNumberEntity>> findInRange(int start, int end);
}
