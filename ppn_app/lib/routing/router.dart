import 'package:go_router/go_router.dart';
import 'package:ppn_app/config/dependencies.dart';
import 'package:ppn_app/routing/routes.dart';
import 'package:ppn_app/ui/home/home.dart';
import 'package:ppn_app/ui/home/viewmodels/home_viewmodel.dart';

final router = GoRouter(
  initialLocation: routePaths.home,
  routes: [
    GoRoute(
      path: routePaths.home,
      builder: (context, state) {
        return ViewModelProvider<HomeViewmodel>(child: const Home());
      },
    ),
  ],
);
