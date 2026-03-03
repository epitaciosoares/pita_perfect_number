import 'package:ppn_app/domain/repositories/perfect_number_repository.dart';
import 'package:ppn_app/ui/core/viewmodels/view_model.dart';
import 'package:result_dart/result_dart.dart';
import '../states/range_perfect_number_state.dart';

class RangePerfectNumberViewmodel extends ViewModel<RangePerfectNumberState> {
  final PerfectNumberRepository _repository;

  RangePerfectNumberViewmodel(this._repository) : super(RangeInitialState());

  Future<void> searchRange(int start, int end) async {
    emit(RangeLoadingState());
    await _repository.findPerfectNumbers(start, end).fold(
      (onSuccess) => emit(RangeSuccessState(onSuccess)),
      (onError) async {
        await _repository
            .offlinePerfectNumbers(start, end)
            .fold(
              (offlineSuccess) =>
                  emit(RangeSuccessOfflineState(offlineSuccess)),
              (offlineError) => emit(RangeErrorState(offlineError.toString())),
            );
      },
    );
  }
}
