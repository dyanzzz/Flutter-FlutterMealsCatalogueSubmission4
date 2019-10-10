import 'package:flutter/material.dart';
import 'package:meals_catalogue_submission4_fl/src/blocs/meals_search_bloc.dart';
import 'package:meals_catalogue_submission4_fl/src/launcher/meals_app.dart';
import 'package:meals_catalogue_submission4_fl/src/models/meals.dart';
import 'package:meals_catalogue_submission4_fl/src/hero/hero_animation.dart';
import 'package:toast/toast.dart';
import 'detail_screen.dart';
import 'package:meals_catalogue_submission4_fl/src/common/meals_key.dart';

class MealsSearch extends StatefulWidget {
  @override
  _MealsSearchState createState() => _MealsSearchState();
}

class _MealsSearchState extends State<MealsSearch> {

  final bloc = MealsSearchBloc();

  @override
  void initState() {
    super.initState();
    bloc.searchAllMeals("");
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: IconButton(
                key: Key(KEY_TAP_BACK_BUTTON),
                icon: Icon(Icons.arrow_back, color: Colors.blue,),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    bloc.searchAllMeals("");
                  },
                )
              ],

              centerTitle: true,
              floating: true,
              pinned: true,
              title: TextField(
                key: Key(KEY_FIELD_SEARCH),
                autofocus: true,
                style: TextStyle(fontSize: 17, color: Colors.blue),
                decoration: InputDecoration.collapsed(
                  hintText: "Search...",
                  hintStyle: TextStyle(fontSize: 17, color: Colors.blue),
                ),
                onChanged: bloc.searchAllMeals,
              ),

            )
          ];
        },
        body: getListResult(),
      ),
    );
  }

  getListResult() {
    return Container(
      color: Colors.white,
      child: Center(
        child: StreamBuilder(
          stream: bloc.searchMeals,
          builder: (context, AsyncSnapshot<MealsResult> snapshot) {
            if (snapshot.hasData) {
              return _showListResult(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return Center(child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)
              ));
            }
          },
        ),
      ),
    );
  }

  Widget _showListResult(AsyncSnapshot<MealsResult> snapshot) {
    return GridView.builder(
      key: Key(KEY_GRID_VIEW_SEARCH),
      itemCount: snapshot == null ? 0 : snapshot?.data?.meals?.length ?? 0,
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Card(
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
                                type: snapshot.data.meals[index].strCategory
                            ),
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

}