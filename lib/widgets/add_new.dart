import 'package:flutter/material.dart';
import 'package:flutter_advance1/models/calary.dart';

class AddNewFood extends StatefulWidget {
  final void Function(CalaryModel calary) onAddFood; //to sa
  const AddNewFood({super.key, required this.onAddFood});

  @override
  State<AddNewFood> createState() => _AddNewFoodState();
}

class _AddNewFoodState extends State<AddNewFood> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  Category _selectedCategory = Category.dinner;
  double sugar = 0;
  double carbs = 0;
  double protein = 0;
  double fats = 0;

//date variables
  final DateTime initialDate = DateTime.now();
  final DateTime firstDate = DateTime(
      DateTime.now().year - 1, DateTime.now().month, DateTime.now().day);
  final DateTime lastDate = DateTime(
      DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);

  DateTime _selecteddate = DateTime.now();

//datepicker

  Future<void> _openDateModal() async {
    try {
      //trying to show the date model then store the user selected date

      final pickdate = await showDatePicker(
          context: context, firstDate: firstDate, lastDate: lastDate);
      setState(() {
        _selecteddate = pickdate!;
      });
    } catch (err) {
      print(err.toString());
    }
  }

  //handle form submit
  void _handleFormsubmit() {
    //convert amount into double
    final userAmount = double.tryParse(_amountController.text.trim()) ??
        0.0; //The ?? 0.0 ensures that if tryParse returns null, userAmount is set to 0.0.

    if (_titleController.text.trim().isEmpty || userAmount <= 0) {
      showDialog(
        context: (context),
        builder: (context) {
          return AlertDialog(
            title: const Text('Enter Valid Data'),
            content: const Text(
              'Please enter valid data for the Meal Name and the  Calarie amount here the Meal Name can not be empty and the Calarie amount can not be less than zero',
            ),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
      //create new food
    } else {
      CalaryModel newFood = CalaryModel(
          calaryAmount: userAmount,
          date: _selecteddate,
          foodName: _titleController.text.trim(),
          category: _selectedCategory,
          carbs: carbs,
          protien: protein,
          fats: fats,
          sugar: sugar);

      //save the data
      widget.onAddFood(newFood);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Title Input
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: "Enter The Meal You Got",
                label: Text("Meal Name"),
              ),
              keyboardType: TextInputType.text,
              maxLength: 50,
            ),
          ),

          // Amount & Date Picker Row
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _amountController,
                    decoration: const InputDecoration(
                      helperText: "Enter The Total Amount",
                      label: Text("Calorie Amount"),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(formattedDate.format(_selecteddate)),
                    IconButton(
                      onPressed: _openDateModal,
                      icon: const Icon(Icons.date_range_outlined),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // Dropdown for Meal Type
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton(
              value: _selectedCategory,
              items: Category.values
                  .map(
                    (category) => DropdownMenuItem(
                      value: category,
                      child: Text(category.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
          ),

          const SizedBox(height: 10),

          // Apply SliderTheme once for all sliders
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbColor: const Color.fromARGB(255, 105, 32, 117),
              activeTrackColor: const Color.fromARGB(255, 157, 53, 173),
              inactiveTrackColor: Colors.grey,
            ),
            child: Column(
              children: [
                // Carbs Slider
                Text("Carbs: ${carbs.toStringAsFixed(1)}g"),
                Slider(
                  min: 0,
                  max: 10,
                  value: carbs,
                  onChanged: (value) => setState(() => carbs = value),
                ),

                // Protein Slider
                Text("Protein: ${protein.toStringAsFixed(1)}g"),
                Slider(
                  min: 0,
                  max: 10,
                  value: protein,
                  onChanged: (value) => setState(() => protein = value),
                ),

                // Fats Slider
                Text("Fats: ${fats.toStringAsFixed(1)}g"),
                Slider(
                  min: 0,
                  max: 10,
                  value: fats,
                  onChanged: (value) => setState(() => fats = value),
                ),

                // Sugar Slider
                Text("Sugar: ${sugar.toStringAsFixed(1)}g"),
                Slider(
                  min: 0,
                  max: 50,
                  value: sugar,
                  onChanged: (value) => setState(() => sugar = value),
                ),
              ],
            ),
          ),

          // Buttons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: _handleFormsubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 13, 44, 69),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text(
                  "Close",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
