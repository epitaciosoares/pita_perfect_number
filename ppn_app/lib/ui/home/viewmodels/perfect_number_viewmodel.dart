import 'package:ppn_app/domain/repositories/perfect_number_repository.dart';
import 'package:ppn_app/ui/core/viewmodels/view_model.dart';
import 'package:result_dart/result_dart.dart';
import '../states/perfect_number_state.dart';

class PerfectNumberViewmodel extends ViewModel<PerfectNumberState> {
  final PerfectNumberRepository _repository;

  PerfectNumberViewmodel(this._repository) : super(PerfectNumberInitialState());

  Future<void> checkNumber(int number) async {
    emit(PerfectNumberLoadingState());

    await _repository.isPerfectNumber(number).fold(
      (onSuccess) => emit(PerfectNumberSuccessState(onSuccess)),
      (onError) async {
        await _repository
            .offlinePerfectNumber(number)
            .fold(
              (offlineSuccess) =>
                  emit(PerfectNumberSuccessOfflineState(offlineSuccess)),
              (offlineError) => emit(
                PerfectNumberErrorState('Numero $number não é perfeito.'),
              ),
            );
      },
    );
  }
}
