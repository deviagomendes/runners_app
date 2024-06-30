class TrainingCalculator {
  double calculatePace(double distanceInMeters, int minutes, int seconds) {
    double totalTimeInMinutes = ((minutes * 60) + seconds) / 60.0;
    return totalTimeInMinutes / (distanceInMeters / 1000); // Convertendo metros para quilômetros
  }

  double calculateZonePace(double distanceInMeters, int minutes, int seconds, int paceModifier) {
    double pace = calculatePace(distanceInMeters, minutes, seconds);
    return pace + (paceModifier / 60.0);
  }
}
