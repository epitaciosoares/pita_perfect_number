import 'package:ppn_app/domain/entities/perfect_number_entity.dart';

sealed class PerfectNumberState {}

class PerfectNumberInitialState extends PerfectNumberState {}

class PerfectNumberLoadingState extends PerfectNumberState {}

class PerfectNumberSuccessState extends PerfectNumberState {
  final PerfectNumberEntity result;

  PerfectNumberSuccessState(this.result);
}

class PerfectNumberSuccessOfflineState extends PerfectNumberState {
  final PerfectNumberEntity result;

  PerfectNumberSuccessOfflineState(this.result);
}

class PerfectNumberErrorState extends PerfectNumberState {
  final String message;

  PerfectNumberErrorState(this.message);
}
