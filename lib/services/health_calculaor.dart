class HealthCalculator {
  static double _parseDouble(dynamic value) {
    if (value == null || value.toString().trim().isEmpty) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }

  static int _parseInt(dynamic value) {
    if (value == null || value.toString().trim().isEmpty) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }

  // 1. Calculate BMI
  static String calculateBMI(dynamic weightStr, dynamic heightCmStr) {
    double weight = _parseDouble(weightStr);
    double heightCm = _parseDouble(heightCmStr);

    if (weight <= 0 || heightCm <= 0) return "0.0";

    double heightMeters = heightCm / 100;
    double bmi = weight / (heightMeters * heightMeters);
    return bmi.toStringAsFixed(1);
  }

  // BMI Category
  static String getBMICategory(String bmiStr) {
    double bmi = _parseDouble(bmiStr);
    if (bmi <= 0) return "N/A";
    if (bmi < 18.5) return "Underweight";
    if (bmi >= 18.5 && bmi <= 24.9) return "Normal";
    if (bmi >= 25 && bmi <= 29.9) return "Overweight";
    return "Obese";
  }

  // 2. Daily Water Intake
  static String calculateWaterIntake(dynamic weightStr) {
    double weight = _parseDouble(weightStr);
    if (weight <= 0) return "0.0";

    double waterLiters = weight * 0.033;
    return waterLiters.toStringAsFixed(1);
  }

  // 3. Daily Protein Intake
  static String calculateProteinIntake(dynamic weightStr) {
    double weight = _parseDouble(weightStr);
    if (weight <= 0) return "0";

    double protein = weight * 0.8;
    return protein.toStringAsFixed(0);
  }

  // 4. Daily Calories
  static String calculateDailyCalories(
    dynamic weightStr,
    dynamic heightCmStr,
    dynamic ageStr,
    String? gender,
  ) {
    double weight = _parseDouble(weightStr);
    double heightCm = _parseDouble(heightCmStr);
    int age = _parseInt(ageStr);

    if (weight <= 0 || heightCm <= 0 || age <= 0 || gender == null) return "0";

    double bmr;

    if (gender.toLowerCase() == 'male') {
      bmr = (10 * weight) + (6.25 * heightCm) - (5 * age) + 5;
    } else if (gender.toLowerCase() == 'female') {
      bmr = (10 * weight) + (6.25 * heightCm) - (5 * age) - 161;
    } else {
      bmr = (10 * weight) + (6.25 * heightCm) - (5 * age) - 78;
    }

    double dailyCalories = bmr * 1.2;
    return dailyCalories.toStringAsFixed(0);
  }
}
