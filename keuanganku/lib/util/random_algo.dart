import 'dart:math';

double generateRandomNumber(double min, double max) {
  if (min >= max) {
    // Handle case when min is greater than or equal to max
    throw ArgumentError('Nilai min harus kurang dari nilai max');
  }

  Random random = Random();
  double randomNumber = min + random.nextDouble() * (max - min);

  return randomNumber;
}