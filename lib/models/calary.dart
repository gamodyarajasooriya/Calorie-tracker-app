//create a unique id usig uuid
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

part 'calary.g.dart';

final uuid = const Uuid().v4();

final formattedDate = DateFormat('yyyy-MM-dd'); // Formats as "2024-02-08"

//enum for Category
enum Category { breakfast, lunch, dinner, snacks }

//category icons
final categoryIcons = {
  Category.breakfast: Icons.breakfast_dining,
  Category.lunch: Icons.lunch_dining,
  Category.snacks: Icons.cookie,
  Category.dinner: Icons.dinner_dining
};

@HiveType(typeId: 1)
class CalaryModel {
//constructor
  CalaryModel({
    required this.calaryAmount,
    required this.date,
    required this.foodName,
    required this.category,
    required this.carbs,
    required this.protien,
    required this.fats,
    required this.sugar,
  }) : id = uuid;

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String foodName;
  @HiveField(2)
  final double calaryAmount;
  @HiveField(3)
  final DateTime date;
  @HiveField(4)
  final Category category;
  @HiveField(5)
  final double carbs;
  @HiveField(6)
  final double protien;
  @HiveField(7)
  final double fats;
  @HiveField(8)
  final double sugar;

//getter > formatted date
  String get getFormatedDate {
    return formattedDate.format(date);
  }
}
