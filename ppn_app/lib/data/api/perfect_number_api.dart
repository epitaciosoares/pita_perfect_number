import 'package:dio/dio.dart';
import 'package:ppn_app/domain/entities/perfect_number_entity.dart';
import 'package:ppn_app/domain/exceptions/app_esception.dart';
import 'package:result_dart/result_dart.dart';

abstract class PerfectNumberApi {
  AsyncResult<PerfectNumberEntity> checkPerfectNumber(int number);

  AsyncResult<List<PerfectNumberEntity>> findPerfectNumber(int start, int end);
}

class PerfectNumberApiImpl implements PerfectNumberApi {
  final Dio _dio;

  PerfectNumberApiImpl(this._dio);

  @override
  AsyncResult<PerfectNumberEntity> checkPerfectNumber(int number) async {
    try {
      final response = await _dio.get('/perfectnumber/check?number=$number');
      return Success(
        PerfectNumberEntity(
          number: response.data['number'],
          isPerfect: response.data['isPerfect'],
          isCalculating: true,
        ),
      );
    } catch (e, stackTrace) {
      return Failure(
        SilentException(
          message: 'Failed to check perfect number: $e',
          stackTrace: stackTrace,
          originalException: e as Exception,
        ),
      );
    }
  }

  @override
  AsyncResult<List<PerfectNumberEntity>> findPerfectNumber(
    int start,
    int end,
  ) async {
    try {
      final response = await _dio.get(
        '/perfectnumber/find?start=$start&end=$end',
      );
      return Success(
        (response.data as List)
            .map(
              (item) => PerfectNumberEntity(
                number: item['number'],
                isPerfect: item['isPerfect'],
                isCalculating: true,
              ),
            )
            .toList(),
      );
    } catch (e, stackTrace) {
      return Failure(
        SilentException(
          message: 'Failed to find perfect numbers: $e',
          stackTrace: stackTrace,
          originalException: e as Exception,
        ),
      );
    }
  }
}
