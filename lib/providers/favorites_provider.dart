import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal_model.dart';

class FavoriteMealsNotifier extends StateNotifier<List<MealModel>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleFavoriteStatus(MealModel meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<MealModel>>((ref) {
  return FavoriteMealsNotifier();
});
