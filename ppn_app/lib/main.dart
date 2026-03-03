import 'package:flutter/material.dart';
import 'package:ppn_app/config/dependencies.dart';
import 'package:ppn_app/main_viewmodel.dart';
import 'package:ppn_app/routing/router.dart';
import 'package:ppn_app/ui/core/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(ViewModelProvider<MainViewModel>(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Pita Numero Perfeito',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: router,
    );
  }
}
