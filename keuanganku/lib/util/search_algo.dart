double findLargestValue(List<double> numbers) {
  if (numbers.isEmpty) {
    // Handle case when the list is empty
    throw Exception("empty list.");
  }

  double largestValue = numbers[0];

  for (int i = 1; i < numbers.length; i++) {
    if (numbers[i] > largestValue) {
      largestValue = numbers[i];
    }
  }

  return largestValue;
}