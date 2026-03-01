import 'package:vaden/vaden.dart';

@DTO()
class PerfectNumberEntity {
  final int number;
  final bool isPerfect;

  PerfectNumberEntity({required this.number, required this.isPerfect});
}
