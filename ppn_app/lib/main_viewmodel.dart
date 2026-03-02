import 'package:ppn_app/ui/core/viewmodels/view_model.dart';

class MainViewModel extends ViewModel<MainState> {
  MainViewModel() : super(MainInitialState());
}

sealed class MainState {}

class MainInitialState extends MainState {}
