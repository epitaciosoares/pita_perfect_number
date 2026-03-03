import 'package:flutter/material.dart';
import 'package:ppn_app/ui/home/states/perfect_number_state.dart';
import 'package:ppn_app/ui/home/viewmodels/perfect_number_viewmodel.dart';
import 'package:provider/provider.dart';

class SingleCheckPage extends StatefulWidget {
  const SingleCheckPage({super.key});

  @override
  State<SingleCheckPage> createState() => _SingleCheckPageState();
}

class _SingleCheckPageState extends State<SingleCheckPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PerfectNumberViewmodel>();
    final state = vm.state;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            const Text(
              'É Perfeito?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Um número perfeito é um inteiro positivo que é igual à soma de todos os seus divisores positivos, excluindo o número em si.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'DIGITE UM NÚMERO',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3B82F6),
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                hintText: 'ex. 27',
                hintStyle: const TextStyle(
                  color: Color(0xCCBDBDBD),
                  fontSize: 24,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFE5E7EB),
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF3B82F6),
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                counterText: '',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final text = _controller.text.trim();
                final num = int.tryParse(text);
                if (num != null) {
                  vm.checkNumber(num);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calculate, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Verificar Perfeição',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            _buildResultCard(state),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(PerfectNumberState state) {
    if (state is PerfectNumberLoadingState) {
      return const Center(
        child: SizedBox(
          height: 60,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
          ),
        ),
      );
    }

    if (state is PerfectNumberSuccessState) {
      final isPerfect = state.result.isPerfect;
      return _buildResultBox(
        number: state.result.number,
        isPerfect: isPerfect,
        isOffline: false,
      );
    }

    if (state is PerfectNumberSuccessOfflineState) {
      final isPerfect = state.result.isPerfect;
      return _buildResultBox(
        number: state.result.number,
        isPerfect: isPerfect,
        isOffline: true,
      );
    }

    if (state is PerfectNumberErrorState) {
      return _buildErrorBox(state.message);
    }

    return const SizedBox.shrink();
  }

  Widget _buildResultBox({
    required int number,
    required bool isPerfect,
    required bool isOffline,
  }) {
    late Color bgColor;
    late Color iconBgColor;
    late Color iconColor;
    late IconData icon;
    late String resultText;

    if (isOffline) {
      bgColor = const Color(0xFFFEF3C7);
      iconBgColor = const Color(0xFFFFEDD5);
      iconColor = const Color(0xFFF59E0B);
      icon = Icons.cloud_off;
      resultText = '$number é um número perfeito (offline)';
    } else if (isPerfect) {
      bgColor = const Color(0xFFDEFCF9);
      iconBgColor = const Color(0xFFD1FADF);
      iconColor = const Color(0xFF10B981);
      icon = Icons.check_circle;
      resultText = '$number é um Número Perfeito';
    } else {
      bgColor = const Color(0xFFFEE2E2);
      iconBgColor = const Color(0xFFFECACA);
      iconColor = const Color(0xFFEF4444);
      icon = Icons.cancel;
      resultText = '$number NÃO é um Número Perfeito';
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 32),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Resultado',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  resultText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorBox(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFEE2E2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFECACA),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.error, color: Color(0xFFEF4444), size: 32),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Erro',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
