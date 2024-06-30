import 'package:flutter/material.dart';
import '../../utils/pdf_generator.dart';
import '../../utils/share_manager.dart';

class ResultPage extends StatelessWidget {
  final String name;
  final int age;
  final double distance;
  final int timeMinutes;
  final int timeSeconds;

  const ResultPage({
    super.key,
    required this.name,
    required this.age,
    required this.distance,
    required this.timeMinutes,
    required this.timeSeconds,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Resultados para $name:'),
            const SizedBox(height: 10.0),
            Text('Idade: $age'),
            Text('Distância do Teste: ${distance.toStringAsFixed(0)} m'),
            Text('Tempo Total: $timeMinutes min $timeSeconds s'),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                await PDFGenerator().generatePDF(name, age, distance, timeMinutes, timeSeconds);
              },
              child: const Text('Gerar PDF'),
            ),
            ElevatedButton(
              onPressed: () async {
                await ShareManager().sharePDF(name);
              },
              child: const Text('Compartilhar Resultados'),
            ),
          ],
        ),
      ),
    );
  }
}
