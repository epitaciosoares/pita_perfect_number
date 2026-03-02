import 'package:flutter/material.dart';
import 'package:ppn_app/domain/domain.dart';

abstract class ViewModel<T extends Object> extends ChangeNotifier
    implements ViewModelBase<T> {
  ViewModel(this._state);
  T _state;
  @override
  get state => _state;

  @override
  void emit(newState) {
    if (newState == _state) return;
    _state = newState;
    notifyListeners();
  }
}
