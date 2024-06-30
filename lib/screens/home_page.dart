import 'package:flutter/material.dart';
import '../../widgets/training_form.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calcular Zonas de Treino'),
      ),
      body: const TrainingForm(),
    );
  }
}
