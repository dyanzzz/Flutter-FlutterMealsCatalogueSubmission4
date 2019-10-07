import 'package:meals_catalogue_submission4_fl/src/resources/api/meals_api_provider.dart';
import 'package:meals_catalogue_submission4_fl/src/models/meals.dart';
import 'package:test_api/test_api.dart';
import 'package:mockito/mockito.dart';

import 'package:http/http.dart' as http;

class ApiTest extends Mock implements http.Client {}

main() {
  MealsApiProvider mealsApiProvider = MealsApiProvider();
  final client = ApiTest();

  group("Request Seafood test", () {
    test("should request complete", () async {
      when(client.get("https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood"))
          .thenAnswer((_) async => http.Response(Meals().toString(), 200),
      );

      expect(await mealsApiProvider.fetchMealsList("Seafood"), isA<MealsResult>());
    });

    test("should request failed", () async {
      when(client.get("https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood"))
          .thenAnswer((_) async => http.Response(Meals().toString(), 404),
      );

      expect(await mealsApiProvider.fetchMealsList("Seafood"), isA<MealsResult>());
    });
  });

  group("Request Dessert test", () {
    test("should request complete", () async {
      when(client.get("https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"))
          .thenAnswer((_) async => http.Response(Meals().toString(), 200),
      );

      expect(await mealsApiProvider.fetchMealsList("Dessert"), isA<MealsResult>());
    });

    test("should request failed", () async {
      when(client.get("https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"))
          .thenAnswer((_) async => http.Response(Meals().toString(), 404),
      );

      expect(await mealsApiProvider.fetchMealsList("Dessert"), isA<MealsResult>());
    });
  });

  group("Request detail meal test", () {
    test("should request complete", () async {
      when(client.get("https://www.themealdb.com/api/json/v1/1/lookup.php?i=52893"))
          .thenAnswer(
            (_) async => http.Response(Meals().toString(), 200),
      );

      expect(await mealsApiProvider.fetchDetailMeals("52893"), isA<MealsResult>());
    });

    test("should request failed", () async {
      when(client.get("https://www.themealdb.com/api/json/v1/1/lookup.php?i=56789"))
          .thenAnswer((_) async => http.Response(Meals().toString(), 404),
      );

      expect(await mealsApiProvider.fetchDetailMeals("56789"), isA<MealsResult>());
    });
  });

  group("Request search meal test", () {
    test("should request complete", () async {
      when(client.get("https://www.themealdb.com/api/json/v1/1/search.php?s=apple"))
          .thenAnswer((_) async => http.Response(Meals().toString(), 200),
      );

      expect(await mealsApiProvider.searchMeals("apple"), isA<MealsResult>());
    });

    test("should request failed", () async {
      when(client.get("https://www.themealdb.com/api/json/v1/1/search.php?s=Betmen"))
          .thenAnswer((_) async => http.Response(Meals().toString(), 404),
      );

      expect(await mealsApiProvider.searchMeals("Betmen"), isA<MealsResult>());
    });
  });
}
