import 'package:ppn_app/domain/entities/perfect_number_entity.dart';

sealed class RangePerfectNumberState {}

class RangeInitialState extends RangePerfectNumberState {}

class RangeLoadingState extends RangePerfectNumberState {}

class RangeSuccessState extends RangePerfectNumberState {
  final List<PerfectNumberEntity> results;

  RangeSuccessState(this.results);
}

class RangeSuccessOfflineState extends RangePerfectNumberState {
  final List<PerfectNumberEntity> results;

  RangeSuccessOfflineState(this.results);
}

class RangeErrorState extends RangePerfectNumberState {
  final String message;

  RangeErrorState(this.message);
}
