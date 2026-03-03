import 'package:ppn_app/data/api/perfect_number_api.dart';
import 'package:ppn_app/domain/entities/perfect_number_entity.dart';
import 'package:ppn_app/domain/exceptions/app_esception.dart';
import 'package:ppn_app/domain/repositories/perfect_number_repository.dart';
import 'package:result_dart/result_dart.dart';

class PerfectNumberRepositoryImpl extends PerfectNumberRepository {
  final PerfectNumberApi _api;
  final List<PerfectNumberEntity> _listPerfectNumbersMaxInt = [
    PerfectNumberEntity(number: 6, isPerfect: true, isCalculating: false),
    PerfectNumberEntity(number: 28, isPerfect: true, isCalculating: false),
    PerfectNumberEntity(number: 496, isPerfect: true, isCalculating: false),
    PerfectNumberEntity(number: 8128, isPerfect: true, isCalculating: false),
    PerfectNumberEntity(
      number: 33550336,
      isPerfect: true,
      isCalculating: false,
    ),
  ];

  PerfectNumberRepositoryImpl(this._api);

  @override
  AsyncResult<List<PerfectNumberEntity>> findPerfectNumbers(
    int start,
    int end,
  ) async {
    return await _api.findPerfectNumber(start, end);
  }

  @override
  AsyncResult<PerfectNumberEntity> isPerfectNumber(int number) async {
    return await _api.checkPerfectNumber(number);
  }

  bool _containIntoLocaList(int number) {
    return _listPerfectNumbersMaxInt.any((element) => element.number == number);
  }

  @override
  AsyncResult<PerfectNumberEntity> offlinePerfectNumber(int number) async {
    if (_containIntoLocaList(number)) {
      PerfectNumberEntity success = _listPerfectNumbersMaxInt.firstWhere(
        (element) => element.number == number,
      );
      return Success(success);
    } else {
      return Failure(
        SilentException(message: 'Número $number não é perfeito.'),
      );
    }
  }

  @override
  AsyncResult<List<PerfectNumberEntity>> offlinePerfectNumbers(
    int start,
    int end,
  ) async {
    final perfectNumbers = <PerfectNumberEntity>[];

    for (int num = start; num <= end; num++) {
      if (_containIntoLocaList(num)) {
        perfectNumbers.add(
          PerfectNumberEntity(
            number: num,
            isPerfect: true,
            isCalculating: false,
          ),
        );
      }
    }
    return Success(perfectNumbers);
  }
}
