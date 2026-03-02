import 'package:auto_injector/auto_injector.dart';

import '../domain/domain.dart';

class CustomInjector {
  final _injector = AutoInjector();

  void addRepository<T extends Repository>(Function constructor) {
    _injector.addLazySingleton<T>(
      constructor,
      config: BindConfig(onDispose: (value) => value.dispose()),
    );
  }

  void addService<T extends Service>(Function constructor) {
    _injector.addSingleton<T>(
      constructor,
      config: BindConfig(onDispose: (value) => value.dispose()),
    );
  }

  void addInstance<T>(T instance) {
    _injector.addInstance<T>(instance);
  }

  void addLazySingleton<T>(T Function() factory) {
    _injector.addLazySingleton<T>(factory);
  }

  void addViewModel<T extends ViewModelBase>(Function constructor) {
    _injector.add<T>(constructor);
  }

  T get<T>() {
    return _injector.get<T>();
  }

  void commit() {
    _injector.commit();
  }

  void dispose() {
    _injector.dispose();
  }

  T getViewModel<T extends ViewModelBase>() {
    return _injector.get<T>();
  }
}
