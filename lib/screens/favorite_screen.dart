import 'package:flutter/material.dart';
import 'package:meal_app/Models/meals.dart';
import 'package:meal_app/widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  List<Meal> favoriteMeals;
  FavoriteScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text(
          'You have no favorites yet - start adding some!',
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          // ignore: missing_required_param
          return MealItem(
            id: favoriteMeals[index].id,
            title: favoriteMeals[index].title,
            duration: favoriteMeals[index].duration,
            imageUrl: favoriteMeals[index].imageUrl,
            complexity: favoriteMeals[index].complexity,
            affordability: favoriteMeals[index].affordability,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}
