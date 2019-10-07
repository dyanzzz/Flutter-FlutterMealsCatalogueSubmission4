import 'dart:async';
import 'package:meals_catalogue_submission4_fl/src/resources/api/meals_api_provider.dart';
import 'package:meals_catalogue_submission4_fl/src/models/meals.dart';

class Repository {

  final mealsApiProvider = MealsApiProvider();

  Future<MealsResult> fetchAllMeals(String mealsType) => mealsApiProvider.fetchMealsList(mealsType);

  Future<MealsResult> fetchDetailMeals(String mealsId) => mealsApiProvider.fetchDetailMeals(mealsId);

  Future<MealsResult> searchMeals(String mealsName) => mealsApiProvider.searchMeals(mealsName);

}