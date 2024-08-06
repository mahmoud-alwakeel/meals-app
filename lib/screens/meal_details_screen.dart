import 'package:flutter/material.dart';
import 'package:meals_app/models/meal_model.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final MealModel meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Column(
              children: [
                Image.network(
                  meal.imageUrl,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Ingredients",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12,
                ),
                for (final ingredient in meal.ingredients)
                  Text(
                    ingredient,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                  height: 16,
                ),
                Text(
                  "Steps",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 12,
                ),
                for (final step in meal.steps)
                  Text(
                    step,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
              ],
            ),
          ),
        ));
  }
}
