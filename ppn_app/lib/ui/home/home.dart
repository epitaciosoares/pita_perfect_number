import 'package:flutter/material.dart';
import 'package:ppn_app/ui/home/viewmodels/home_viewmodel.dart';
import 'package:ppn_app/ui/home/viewmodels/perfect_number_viewmodel.dart';
import 'package:ppn_app/ui/home/viewmodels/range_perfect_number_viewmodel.dart';
import 'package:ppn_app/ui/home/widgets/info_page.dart';
import 'package:ppn_app/ui/home/widgets/range_check_page.dart';
import 'package:ppn_app/ui/home/widgets/single_check_page.dart';
import 'package:provider/provider.dart';
import '../../config/dependencies.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const InfoPage();
      case 1:
        return ViewModelProvider<PerfectNumberViewmodel>(
          child: const SingleCheckPage(),
        );
      case 2:
        return ViewModelProvider<RangePerfectNumberViewmodel>(
          child: const RangeCheckPage(),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<HomeViewmodel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Numero Perfeito')),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF3B82F6),
        currentIndex: _selectedIndex,
        onTap: (idx) => setState(() => _selectedIndex = idx),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Verificar'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Buscar'),
        ],
      ),
    );
  }
}
