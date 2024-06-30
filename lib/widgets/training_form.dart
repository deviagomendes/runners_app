import 'package:flutter/material.dart';
import '../../utils/training_calculator.dart';
import 'input_field.dart';
import '../screens/result_page.dart';

class TrainingForm extends StatefulWidget {
  const TrainingForm({super.key});

  @override
  _TrainingFormState createState() => _TrainingFormState();
}

class _TrainingFormState extends State<TrainingForm> {
  final TrainingCalculator _calculator = TrainingCalculator();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _minutesController = TextEditingController();
  final TextEditingController _secondsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InputField(controller: _nameController, labelText: 'Nome do Aluno'),
          InputField(controller: _ageController, labelText: 'Idade', keyboardType: TextInputType.number),
          InputField(controller: _distanceController, labelText: 'Distância do Teste (metros)', keyboardType: TextInputType.number),
          Row(
            children: [
              Expanded(
                child: InputField(controller: _minutesController, labelText: 'Minutos', keyboardType: TextInputType.number),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: InputField(controller: _secondsController, labelText: 'Segundos', keyboardType: TextInputType.number),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              _validateAndNavigate(context);
            },
            child: const Text('Calcular Zonas de Treino'),
          ),
        ],
      ),
    );
  }

  void _validateAndNavigate(BuildContext context) {
    String name = _nameController.text.trim();
    int age = int.tryParse(_ageController.text.trim()) ?? 0;
    double distance = double.tryParse(_distanceController.text.trim()) ?? 0.0;
    int minutes = int.tryParse(_minutesController.text.trim()) ?? 0;
    int seconds = int.tryParse(_secondsController.text.trim()) ?? 0;

    if (_validateInputs(name, age, distance, minutes, seconds)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
            name: name,
            age: age,
            distance: distance,
            timeMinutes: minutes,
            timeSeconds: seconds,
          ),
        ),
      );
    } else {
      _showErrorSnackbar(context, 'Por favor, preencha todos os campos corretamente.');
    }
  }

  bool _validateInputs(String name, int age, double distance, int minutes, int seconds) {
    return name.isNotEmpty && age > 0 && distance > 0 &&
        minutes >= 0 && minutes < 60 && seconds >= 0 && seconds < 60;
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
