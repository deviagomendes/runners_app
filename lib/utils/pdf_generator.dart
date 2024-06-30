import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class PDFGenerator {
  Future<void> generatePDF(String name, int age, double distance, int timeMinutes, int timeSeconds) async {
    final pdf = pw.Document();

    final font = await rootBundle.load('assets/fonts/OpenSans-Regular.ttf');
    final ttf = pw.Font.ttf(font.buffer.asByteData());

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => _buildPDFContent(name, age, distance, timeMinutes, timeSeconds, ttf),
      ),
    );

    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/resultados_$name.pdf';
    final file = File(path);
    await file.writeAsBytes(await pdf.save());
    print('PDF salvo em $path');
  }

  pw.Widget _buildPDFContent(String name, int age, double distance, int timeMinutes, int timeSeconds, pw.Font ttf) {
    return pw.Center(
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          _buildTitle('RELATÓRIO DE ZONAS DE TREINO', ttf),
          _buildSubtitle('PROFESSOR: EDMIR DE SOUZA', ttf),
          _buildSubtitle('ALUNO(A): $name', ttf),
          _buildSubtitle('IDADE: $age', ttf),
          _buildSubtitle('DISTÂNCIA DO TESTE: $distance m', ttf),
          _buildSubtitle('TEMPO TOTAL: $timeMinutes:${timeSeconds.toString().padLeft(2, '0')} mins', ttf),
          _buildSubtitle('PACE: ${_formatPace(_calculatePace(distance, timeMinutes, timeSeconds))} min/km', ttf),
          _buildSubtitle('RITMOS DE TREINO SUGERIDOS:', ttf),
          _buildTrainingZone('ZONA 1 (Recuperação)', _calculateZonePace(distance, timeMinutes, timeSeconds, 90), 'Corrida muito leve ou caminhada rápida. Promove a recuperação ativa.', ttf),
          _buildTrainingZone('ZONA 2 (Aeróbica Leve)', _calculateZonePace(distance, timeMinutes, timeSeconds, 60), 'Corrida confortável e fácil. Melhora a resistência aeróbica básica.', ttf),
          _buildTrainingZone('ZONA 3 (Aeróbica Moderada)', _calculateZonePace(distance, timeMinutes, timeSeconds, 30), 'Corrida moderadamente fácil. Aumenta a capacidade aeróbica e a resistência.', ttf),
          _buildTrainingZone('ZONA 4 (Limiar Anaeróbico)', _calculateZonePace(distance, timeMinutes, timeSeconds, 10), 'Corrida moderada a difícil. Melhora a capacidade de sustentar esforços intensos.', ttf),
          _buildTrainingZone('ZONA 5 (VO2 Máximo)', _calculateZonePace(distance, timeMinutes, timeSeconds, -10), 'Corrida muito difícil. Melhora a capacidade máxima de oxigenação e o desempenho em competições.', ttf),
        ],
      ),
    );
  }

  pw.Widget _buildTitle(String text, pw.Font ttf) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 12.0),
      child: pw.Text(
        text.toUpperCase(),
        style: pw.TextStyle(font: ttf, fontSize: 18),
      ),
    );
  }

  pw.Widget _buildSubtitle(String text, pw.Font ttf) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 6.0),
      child: pw.Text(
        text,
        style: pw.TextStyle(font: ttf, fontSize: 12),
      ),
    );
  }

  pw.Widget _buildTrainingZone(String title, double pace, String description, pw.Font ttf) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 6.0),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title.toUpperCase(),
            style: pw.TextStyle(font: ttf, fontSize: 14, fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            'Pace: ${_formatPace(pace)} min/km',
            style: pw.TextStyle(font: ttf, fontSize: 12),
          ),
          pw.Text(
            description,
            style: pw.TextStyle(font: ttf, fontSize: 12),
          ),
        ],
      ),
    );
  }

  double _calculatePace(double distanceInMeters, int minutes, int seconds) {
    int totalTimeInSeconds = (minutes * 60) + seconds;
    double distanceInKilometers = distanceInMeters / 1000.0;
    double paceInSecondsPerKm = totalTimeInSeconds / distanceInKilometers;
    return paceInSecondsPerKm;
  }

  double _calculateZonePace(double distanceInMeters, int minutes, int seconds, double paceModifier) {
    double pace = _calculatePace(distanceInMeters, minutes, seconds);
    return pace + paceModifier;
  }

  String _formatPace(double paceInSecondsPerKm) {
    int minutes = paceInSecondsPerKm ~/ 60;
    int seconds = (paceInSecondsPerKm % 60).round();
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
