import 'package:flutter/material.dart';
import 'package:meals_app/data/category_dummy_data.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

  final CategoryDummyData categoryDummyData = CategoryDummyData();

  void _selectCategory(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MealsScreen(title: 'title', meals: [],);
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
                _selectCategory(context);
              },
            )
          // categoryDummyData.avaialableCategories.map((category) => CategoryGridItem(category: category)).toList();
        ],
      ),
    );
  }
}
