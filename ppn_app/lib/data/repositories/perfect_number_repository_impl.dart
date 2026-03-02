import 'package:ppn_app/data/api/perfect_number_api.dart';
import 'package:ppn_app/domain/entities/perfect_number_entity.dart';
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
  Future<List<PerfectNumberEntity>> findPerfectNumbers(
    int start,
    int end,
  ) async {
    return await _api.findPerfectNumber(start, end).fold(
      (onSuccess) => onSuccess,
      (onError) {
        return _searchPerfectNumbersOffline(start, end);
      },
    );
  }

  @override
  Future<PerfectNumberEntity> isPerfectNumber(int number) async {
    return await _api.checkPerfectNumber(number).fold(
      (onSuccess) => onSuccess,
      (onError) {
        return _findOfflinePerfectNumber(number);
      },
    );
  }

  List<PerfectNumberEntity> _searchPerfectNumbersOffline(int start, int end) {
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
    return perfectNumbers;
  }

  PerfectNumberEntity _findOfflinePerfectNumber(int number) {
    if (_containIntoLocaList(number)) {
      return _listPerfectNumbersMaxInt.firstWhere(
        (element) => element.number == number,
      );
    } else {
      return PerfectNumberEntity(
        number: number,
        isPerfect: false,
        isCalculating: false,
      );
    }
  }

  bool _containIntoLocaList(int number) {
    return _listPerfectNumbersMaxInt.any((element) => element.number == number);
  }
}
