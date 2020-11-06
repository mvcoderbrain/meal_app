import 'package:flutter/material.dart';

import 'package:meal_app/Models/meals.dart';
import 'package:meal_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayMeals;
  var _loadedData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedData) {
      final routArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      final categoryId = routArgs['id'];
      categoryTitle = routArgs['title'];
      displayMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedData = true;
    }
    super.didChangeDependencies();
  }

  // void _removeMeals(String mealId) {
  //   setState(() {
  //     displayMeals.removeWhere((meal) => meal.id == mealId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          // ignore: missing_required_param
          return MealItem(
            id: displayMeals[index].id,
            title: displayMeals[index].title,
            duration: displayMeals[index].duration,
            imageUrl: displayMeals[index].imageUrl,
            complexity: displayMeals[index].complexity,
            affordability: displayMeals[index].affordability,
          );
        },
        itemCount: displayMeals.length,
      ),
    );
  }
}
