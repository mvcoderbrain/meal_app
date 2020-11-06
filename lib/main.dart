import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/screens/filter_screen.dart';

import './screens/category_meals_screen.dart';
import './screens/meal_deatails_screen.dart';
import './screens/tab_screen.dart';
import 'Models/meals.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where(
        (meal) {
          if (_filters['gluten'] && meal.isGlutenFree) {
            return false;
          }

          if (_filters['lactose'] && meal.isLactoseFree) {
            return false;
          }

          if (_filters['vegetarian'] && meal.isVegetarian) {
            return false;
          }

          if (_filters['vegan'] && meal.isVegan) {
            return false;
          }
          return true;
        },
      ).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingItem = _favoriteMeals.indexWhere(
      (meal) => meal.id == mealId,
    );

    if (existingItem >= 0) {
      setState(
        () {
          _favoriteMeals.removeWhere(
            (meal) => meal.id == mealId,
          );
        },
      );
    } else {
      setState(
        () {
          _favoriteMeals.add(
            DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
          );
        },
      );
    }
  }

  bool _isFavorite(String id) {
    return _favoriteMeals.any(
      (meal) => meal.id == id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline1: TextStyle(
                fontFamily: 'RobotoCondesed',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
      ),
      // bottomNavigationBar: BottomNavigationBar(backgroundColor: Theme.of(context).primaryColor, items: [BottomNavigationBarItem(icon: Icon(Icons.category,), label: 'Categories',), BottomNavigationBarItem(icon: Icon(Icons.star,), label: 'Favorites',),],),
      // home: TabsScreen(),
      initialRoute: '/', //default is'/'
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
    );
  }
}
