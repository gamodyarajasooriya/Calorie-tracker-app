import 'package:flutter/material.dart';
import 'package:flutter_advance1/models/calary.dart';

class FoodTile extends StatelessWidget {
  const FoodTile({super.key, required this.food});

  final CalaryModel food;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.purple.shade100, // Light purple shade
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              food.foodName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  "${food.calaryAmount.toStringAsFixed(0)} Calories",
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[food.category]),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(food.getFormatedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
