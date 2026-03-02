abstract class ViewModelBase<T> {
  T get state;

  void emit(T newState);
}
