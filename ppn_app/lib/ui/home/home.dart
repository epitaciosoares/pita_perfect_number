import 'package:flutter/material.dart';
import 'package:ppn_app/ui/home/viewmodels/home_viewmodel.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<HomeViewmodel>();
    return const Placeholder();
  }
}
