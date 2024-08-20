import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/meals_dummy_data.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';
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

  void _selectScreen(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  

  void _setScreen(String identifier) async {
    if (identifier == "filters") {
      Navigator.pop(context);
      await Navigator.push<Map<Filters, bool>>(
        context,
        MaterialPageRoute(
          builder: (context) => const FiltersScreen(),
        ),
      );
     
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);    

    Widget activeScreen = CategoriesScreen(
      avaialbleMeals: availableMeals,
    );
    var activeScreenTitle = "Categories";
    if (selectedIndex == 1) {
      final favMeals = ref.watch(favoriteMealsProvider);
      activeScreen = MealsScreen(
        meals: favMeals,
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
