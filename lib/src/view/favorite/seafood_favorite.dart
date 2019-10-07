import 'package:flutter/material.dart';
import 'package:meals_catalogue_submission4_fl/src/models/meals.dart';
import 'package:meals_catalogue_submission4_fl/src/resources/local/favorite_provider.dart';
import 'package:meals_catalogue_submission4_fl/src/hero/hero_animation.dart';
import 'package:toast/toast.dart';
import '../../app.dart';
import 'package:meals_catalogue_submission4_fl/src/view/detail_screen.dart';
import 'package:meals_catalogue_submission4_fl/src/common/meals_key.dart';

class SeafoodFavorite extends StatefulWidget {
  @override
  _SeafoodFavoriteState createState() => _SeafoodFavoriteState();
}

class _SeafoodFavoriteState extends State<SeafoodFavorite> {

  Future<List<Meals>> _seafoodFavoriteFoods;

  @override
  void initState() {
    super.initState();
    _seafoodFavoriteFoods = FavoriteProvider.db.getFavoriteMealsByType("Seafood");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder(
        initialData: <Meals>[],
        future: _seafoodFavoriteFoods,
        builder:
            (BuildContext context, AsyncSnapshot<List<Meals>> snapshot) {
          if (snapshot.hasError) {
            showToast(context, snapshot.error.toString(), duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            return Center(
              child: Text("Something wrong"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Meals> favoriteFoods = snapshot.data;
            if (favoriteFoods.isEmpty) {
              return Center(
                child: Text(
                  "Seafood Favorite not available",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return _showListFavoriteSeafood(favoriteFoods);
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _showListFavoriteSeafood(List<Meals> favoriteFoods) {
    return GridView.builder(
      key: Key(KEY_GRID_VIEW_FAVORITE_SEAFOOD),
      itemCount: favoriteFoods.length,
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Card(
            key: Key("tap_meals_favorite_" + favoriteFoods[index].idMeal),
            elevation: 2.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            margin: EdgeInsets.all(5),
            child: GridTile(
              child: PhotoHero(
                tag: favoriteFoods[index].strMeal,
                onTap: () {
                  showToast(context, favoriteFoods[index].strMeal, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 777),
                        pageBuilder: (BuildContext context, Animation<double> animation,
                            Animation<double> secondaryAnimation) =>
                            DetailScreen(
                                idMeal: favoriteFoods[index].idMeal,
                                strMeal: favoriteFoods[index].strMeal,
                                strMealThumb: favoriteFoods[index].strMealThumb,
                                type: favoriteFoods[index].strCategory),
                      ));
                },
                photo: favoriteFoods[index].strMealThumb,
              ),
              footer: Container(
                color: Colors.white70,
                padding: EdgeInsets.all(5.0),
                child: Text(
                  favoriteFoods[index].strMeal,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}