import 'package:flutter/material.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int selectedIndex = 0;
  final List<MealModel> favMealsList = [];
  void _selectScreen(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
      ),
    );
  }

  void _toggleFavoriteMealStatus(MealModel meal) {
    final isExisting = favMealsList.contains(meal);
    if (isExisting) {
      setState(() {
        favMealsList.remove(meal);
        _showSnackBar('Meal removed from favorites');
      });
    } else {
      setState(() {
        favMealsList.add(meal);
        _showSnackBar('Meal added to Favorites');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoriesScreen(
      toggleFavorite: _toggleFavoriteMealStatus,
    );
    var activeScreenTitle = "Categories";
    if (selectedIndex == 1) {
      activeScreen = MealsScreen(
        meals: favMealsList,
        toggleFavorite: _toggleFavoriteMealStatus,
      );
      activeScreenTitle = "Favorites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activeScreenTitle),
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: _selectScreen,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.set_meal),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favorites',
            ),
          ]),
    );
  }
}
