import 'package:flutter/material.dart';
import 'seafood_favorite.dart';
import 'dessert_favorite.dart';
import 'package:meals_catalogue_submission4_fl/src/common/meals_key.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Colors.white,
            child: TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.blueGrey,
              indicatorColor: Colors.lightBlueAccent,
              tabs: [
                Tab(
                  key: Key(KEY_TAB_ITEM_FAVORITE_DESSERT),
                  text: "Dessert Favorite",
                ),
                Tab(
                  key: Key(KEY_TAB_ITEM_FAVORITE_SEAFOOD),
                  text: "Seafood Favorite",
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            DessertFavorite(),
            SeafoodFavorite(),
          ],
        ),
      ),
    );
  }

}