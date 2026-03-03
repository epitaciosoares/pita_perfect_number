import 'package:dio/dio.dart';
import 'package:ppn_app/data/api/perfect_number_api.dart';
import 'package:ppn_app/data/repositories/perfect_number_repository_impl.dart';
import 'package:ppn_app/domain/repositories/perfect_number_repository.dart';
import 'package:ppn_app/ui/core/viewmodels/view_model.dart';
import 'package:ppn_app/ui/home/viewmodels/home_viewmodel.dart';
import 'package:ppn_app/ui/home/viewmodels/perfect_number_viewmodel.dart';
import 'package:ppn_app/ui/home/viewmodels/range_perfect_number_viewmodel.dart';
import 'package:ppn_app/utils/custom_injector.dart';
import 'package:provider/provider.dart';

part 'dio/dio_factory.dart';

final _injector = CustomInjector();

Future<void> setupDependencies() async {
  _injector.addLazySingleton<Dio>(() => createDio());

  _injector.addLazySingleton<PerfectNumberApi>(
    () => PerfectNumberApiImpl(_injector.get<Dio>()),
  );

  _injector.addRepository<PerfectNumberRepository>(
    PerfectNumberRepositoryImpl.new,
  );

  _injector.addViewModel<HomeViewmodel>(HomeViewmodel.new);

  // viewmodels for perfect number features
  _injector.addViewModel<PerfectNumberViewmodel>(PerfectNumberViewmodel.new);
  _injector.addViewModel<RangePerfectNumberViewmodel>(
    RangePerfectNumberViewmodel.new,
  );
  _injector.commit();
}

void disposeDependencies() {
  _injector.dispose();
}

class ViewModelProvider<T extends ViewModel> extends ChangeNotifierProvider<T> {
  ViewModelProvider({super.key, super.child})
    : super(create: (context) => _injector.getViewModel<T>());
}
