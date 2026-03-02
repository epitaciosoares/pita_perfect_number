import 'package:ppn_app/domain/contracts/repository.dart';
import 'package:ppn_app/domain/entities/perfect_number_entity.dart';

abstract class PerfectNumberRepository extends Repository {
  Future<PerfectNumberEntity> isPerfectNumber(int number);
  Future<List<PerfectNumberEntity>> findPerfectNumbers(int start, int end);
}
