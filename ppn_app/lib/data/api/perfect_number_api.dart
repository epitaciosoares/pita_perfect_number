import 'package:dio/dio.dart';
import 'package:ppn_app/domain/entities/perfect_number_entity.dart';

abstract class PerfectNumberApi {
  Future<PerfectNumberEntity> checkPerfectNumber(int number);

  Future<List<PerfectNumberEntity>> findPerfectNumber(int start, int end);
}

class PerfectNumberApiImpl implements PerfectNumberApi {
  final Dio _dio;

  PerfectNumberApiImpl(this._dio);

  @override
  Future<PerfectNumberEntity> checkPerfectNumber(int number) async {
    try {
      final response = await _dio.get('/perfectnumber/check?number=$number');
      return PerfectNumberEntity(
        number: response.data['number'],
        isPerfect: response.data['isPerfect'],
      );
    } catch (e) {
      throw Exception('Failed to check perfect number: $e');
    }
  }

  @override
  Future<List<PerfectNumberEntity>> findPerfectNumber(
    int start,
    int end,
  ) async {
    try {
      final response = await _dio.get(
        '/perfectnumber/find?start=$start&end=$end',
      );
      return (response.data as List)
          .map(
            (item) => PerfectNumberEntity(
              number: item['number'],
              isPerfect: item['isPerfect'],
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to find perfect numbers: $e');
    }
  }
}
