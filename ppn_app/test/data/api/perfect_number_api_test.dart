import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ppn_app/config/dependencies.dart';
import 'package:ppn_app/data/api/perfect_number_api.dart';
import 'package:ppn_app/domain/entities/perfect_number_entity.dart';

void main() {
  test("Valida se um numero é Perfeito", () async {
    Dio dio = createDio();
    // Arrange
    final number = 28;

    // Act
    PerfectNumberEntity isPerfect = await PerfectNumberApiImpl(
      dio,
    ).checkPerfectNumber(number);

    // Assert
    expect(isPerfect.isPerfect, true);
  });

  test("Encontra numeros perfeitos em um intervalo", () async {
    Dio dio = createDio();
    // Arrange
    final start = 1;
    final end = 30;

    // Act
    List<PerfectNumberEntity> perfectNumbers = await PerfectNumberApiImpl(
      dio,
    ).findPerfectNumber(start, end);

    // Assert
    expect(perfectNumbers.length, 2);
    expect(perfectNumbers[0].number, 6);
    expect(perfectNumbers[1].number, 28);
  });
}
