import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/meals_dummy_data.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  final MealsDummyData mealsDummyData = MealsDummyData();
  int selectedIndex = 0;
  final List<MealModel> favMealsList = [];
  Map<Filters, bool> _selectedFilters = kInitialFilters;
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

  void _setScreen(String identifier) async {
    if (identifier == "filters") {
      Navigator.pop(context);
      final result = await Navigator.push<Map<Filters, bool>>(
        context,
        MaterialPageRoute(
          builder: (context) => FiltersScreen(currentFilters: _selectedFilters,),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final availableMeals = meals.where((meal) {
      if (_selectedFilters[Filters.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filters.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filters.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filters.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activeScreen = CategoriesScreen(
      toggleFavorite: _toggleFavoriteMealStatus,
      avaialbleMeals: availableMeals,
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
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
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
