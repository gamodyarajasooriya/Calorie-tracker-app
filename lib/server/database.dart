import 'package:flutter_advance1/models/calary.dart';
import 'package:hive/hive.dart';

class Database {
  final _myBox = Hive.box("foodDatabase"); // Database reference

  List<CalaryModel> calaryList = [];

  // Create initial data in the database
  void createInitialDatabase() {
    calaryList = [
      CalaryModel(
        calaryAmount: 500,
        date: DateTime.now(),
        foodName: "Rice",
        category: Category.dinner,
        carbs: 5,
        protien: 2,
        fats: 2,
        sugar: 1,
      ),
      CalaryModel(
        calaryAmount: 1200,
        date: DateTime.now(),
        foodName: "boiled vegetables",
        category: Category.breakfast,
        carbs: 5,
        protien: 2,
        fats: 2,
        sugar: 1,
      ),
      CalaryModel(
        calaryAmount: 800,
        date: DateTime.now(),
        foodName: "oily foods",
        category: Category.lunch,
        carbs: 5,
        protien: 2,
        fats: 2,
        sugar: 1,
      ),
    ];
    update(); // Save initial data
  }

  // Load data from the database
  void loadData() {
    final dynamic data = _myBox.get("CAL_DATA");
    if (data != null && data is List) {
      calaryList = List<CalaryModel>.from(data.map((e) => e as CalaryModel));
    }
  }

  // Update the database with the current data
  Future<void> update() async {
    await _myBox.put("CAL_DATA", calaryList);
  }
}
