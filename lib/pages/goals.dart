import 'package:flutter/material.dart';
import 'package:flutter_advance1/models/calary.dart';
import 'package:flutter_advance1/server/database.dart';
import 'package:flutter_advance1/widgets/add_new.dart';
import 'package:flutter_advance1/widgets/foodlist.dart';
import 'package:hive/hive.dart';
import 'package:pie_chart/pie_chart.dart';

class goals extends StatefulWidget {
  const goals({super.key});

  @override
  State<goals> createState() => _goalsState();
}

class _goalsState extends State<goals> {
  late Box _myBox;
  Database db = Database();

  Map<String, double> dataMap = {
    "Carbs": 0,
    "Protien": 0,
    "Fats": 0,
    "Sugar": 0,
  };

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

  // Initialize Hive and load the data
  Future<void> _initializeHive() async {
    _myBox = await Hive.openBox("foodDatabase"); // Open the Hive box
    if (_myBox.get("CAL_DATA") == null) {
      db.createInitialDatabase(); // Create initial data if not present
    } else {
      db.loadData(); // Load existing data
    }
    calculatecategoryValues();
  }

  void calculatecategoryValues() {
    double carbsvalTotal = 0;
    double pvalTotal = 0;
    double fvalTotal = 0;
    double sgvalTotal = 0;

    for (final food in db.calaryList) {
      carbsvalTotal += food.carbs;
      pvalTotal += food.protien;
      fvalTotal += food.fats;
      sgvalTotal += food.sugar;
    }

    setState(() {
      dataMap = {
        "Carbs": carbsvalTotal,
        "Protien": pvalTotal,
        "Fats": fvalTotal,
        "Sugar": sgvalTotal,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 105, 32, 117),
        title: const Text(
          'Calary Tracker',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: _openAddFoodOverlay,
            icon: Icon(Icons.add, color: Colors.white), // Dark-themed plus icon
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: PieChart(
                dataMap: dataMap,
                colorList: [
                  Color(0xFF7B1FA2),
                  Color(0xFF9575CD),
                  Color(0xFFD1C4E9),
                  Color(0xFFB39DDB),
                ],
                chartValuesOptions: ChartValuesOptions(
                  showChartValuesInPercentage: true,
                  chartValueStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                legendOptions: LegendOptions(
                  showLegends: true,
                  legendTextStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Expanded(
              child: foodlist(
                foodList: db.calaryList,
                onDeleteTile: onDeleteTile,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onNewAddFood(CalaryModel calary) {
    setState(() {
      db.calaryList.add(calary);
      db.update(); // Save data after adding
      calculatecategoryValues();
    });
  }

  void onDeleteTile(CalaryModel calary) {
    CalaryModel deletingTile = calary;
    final removingIndex = db.calaryList.indexOf(calary);
    setState(() {
      db.calaryList.remove(calary);
      db.update(); // Save data after deleting
      calculatecategoryValues();
    });

    // Undo functionality
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Delete Successful"),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          setState(() {
            db.calaryList.insert(removingIndex, deletingTile);
            db.update(); // Save after undoing
            calculatecategoryValues();
          });
        },
      ),
    ));
  }

  void _openAddFoodOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AddNewFood(onAddFood: onNewAddFood);
      },
    );
  }
}
