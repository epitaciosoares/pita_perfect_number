import 'package:dio/dio.dart';
import 'package:ppn_app/ui/core/viewmodels/view_model.dart';
import 'package:ppn_app/ui/home/viewmodels/home_viewmodel.dart';
import 'package:ppn_app/utils/custom_injector.dart';
import 'package:provider/provider.dart';

part 'dio/dio_factory.dart';

final _injector = CustomInjector();

Future<void> setupDependencies() async {
  _injector.addViewModel<HomeViewmodel>(HomeViewmodel.new);

  _injector.addLazySingleton<Dio>(() => createDio());

  _injector.commit();
}

void disposeDependencies() {
  _injector.dispose();
}

class ViewModelProvider<T extends ViewModel> extends ChangeNotifierProvider<T> {
  ViewModelProvider({super.key, super.child})
    : super(create: (context) => _injector.getViewModel<T>());
}
