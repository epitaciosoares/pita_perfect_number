import 'package:ppn_app/ui/core/viewmodels/view_model.dart';
import 'package:ppn_app/utils/custom_injector.dart';
import 'package:provider/provider.dart';

final _injector = CustomInjector();

void setupDependencies() {
  _injector.commit();
}

void disposeDependencies() {
  _injector.dispose();
}

class ViewModelProvider<T extends ViewModel> extends ChangeNotifierProvider<T> {
  ViewModelProvider({super.key, super.child})
    : super(create: (context) => _injector.getViewModel<T>());
}
