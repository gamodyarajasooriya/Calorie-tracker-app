import 'package:flutter/material.dart';
import 'package:flutter_advance1/models/calary.dart';
import 'package:flutter_advance1/widgets/food_tile.dart';

class foodlist extends StatelessWidget {
  final List<CalaryModel> foodList; //constructor
  final void Function(CalaryModel calary) onDeleteTile;
  const foodlist(
      {super.key, required this.foodList, required this.onDeleteTile});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: foodList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: Dismissible(
              direction: DismissDirection.startToEnd,
              key: ValueKey(foodList[index]),
              onDismissed: (direction) {
                onDeleteTile(foodList[index]);
              },
              child: FoodTile(
                food: foodList[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
