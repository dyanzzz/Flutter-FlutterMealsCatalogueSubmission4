import 'package:flutter/material.dart';
import '../models/meals.dart';
import '../blocs/meals_list_bloc.dart';
import '../hero/hero_animation.dart';
import '../app.dart';
import 'detail_screen.dart';
import 'package:toast/toast.dart';
import 'package:meals_catalogue_submission4_fl/src/common/meals_key.dart';

class DessertScreen extends StatefulWidget {
  @override
  DessertState createState() => new DessertState();
}

class DessertState extends State<DessertScreen> {

  final bloc = MealsBloc();

  @override
  void initState() {
    super.initState();
    bloc.fetchAllMeals('Dessert');
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getListDesert()
    );
  }

  getListDesert() {
    return Container(
      color: Colors.white,
      child: Center(
        child: StreamBuilder(
          stream: bloc.allMeals,
          builder: (context, AsyncSnapshot<MealsResult> snapshot) {
            if (snapshot.hasData) {
              return _showListDessert(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)
            ));
          },
        ),
      ),
    );
  }

  Widget _showListDessert(AsyncSnapshot<MealsResult> snapshot) => GridView.builder(
    key: Key(KEY_GRID_VIEW_DESSERT),
    itemCount: snapshot == null ? 0 : snapshot.data.meals.length,
    gridDelegate:
    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        child: Card(
          key: Key("tap_meals_" + snapshot.data.meals[index].idMeal),
          elevation: 2.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          margin: EdgeInsets.all(5),
          child: GridTile(
            child: PhotoHero(
              tag: snapshot.data.meals[index].strMeal,
              onTap: () {
                showToast(context, snapshot.data.meals[index].strMeal, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 777),
                      pageBuilder: (BuildContext context, Animation<double> animation,
                          Animation<double> secondaryAnimation) =>
                          DetailScreen(
                              idMeal: snapshot.data.meals[index].idMeal,
                              strMeal: snapshot.data.meals[index].strMeal,
                              strMealThumb: snapshot.data.meals[index].strMealThumb,
                              type: "Dessert"),
                    ));
              },
              photo: snapshot.data.meals[index].strMealThumb,
            ),
            footer: Container(
              color: Colors.white70,
              padding: EdgeInsets.all(5.0),
              child: Text(
                snapshot.data.meals[index].strMeal,
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