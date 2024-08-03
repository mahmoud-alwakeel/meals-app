import 'package:flutter/material.dart';
import 'package:meals_app/data/category_dummy_data.dart';
import 'package:meals_app/data/meals_dummy_data.dart';
import 'package:meals_app/models/category_model.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

  final CategoryDummyData categoryDummyData = CategoryDummyData();

  void _selectCategory(BuildContext context, CategoryModel category) {
    final filteredMeals = MealsDummyData()
        .dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MealsScreen(
            title: category.title,
            meals: filteredMeals,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Categories',
        ),
      ),
      body: GridView(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
        ),
        children: [
          for (final category in categoryDummyData.avaialableCategories)
            CategoryGridItem(
              category: category,
              onCategorySelected: () {
                _selectCategory(context, category);
              },
            ),
          // categoryDummyData.avaialableCategories.map((category) => CategoryGridItem(category: category)).toList();
        ],
      ),
    );
  }
}
