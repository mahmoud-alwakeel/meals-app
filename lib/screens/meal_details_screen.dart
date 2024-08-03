import 'package:flutter/material.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({
    super.key,
    required this.title,
    required this.meal,
  });

  final String title;
  final MealModel meal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(meal.isGlutenFree ?  "gluten free" : "not gluten free", style: const TextStyle(color: Colors.white),),
            FadeInImage(
              height: 280,
              width: double.infinity,
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(
                meal.imageUrl,
              ),
              fit: BoxFit.cover,
            ),
            Text('data'),
          ],
        ),
      ),
    );
  }
}
