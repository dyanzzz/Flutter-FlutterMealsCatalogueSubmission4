import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meals_catalogue_submission4_fl/src/launcher/meals_config.dart';
import 'package:meals_catalogue_submission4_fl/src/view/meals_search.dart';
import 'package:toast/toast.dart';

import 'package:meals_catalogue_submission4_fl/src/view/seafood_screen.dart';
import 'package:meals_catalogue_submission4_fl/src/view/dessert_screen.dart';
import 'package:meals_catalogue_submission4_fl/src/view/favorite/home_favorite.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Config.appString,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: HomePage(),
    );
  }
}




class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  final List<Widget> _children = [
    DessertScreen(),
    SeafoodScreen(),
    FavoriteScreen()
  ];

  @override
  Widget build(BuildContext context) {



    final bottomNavBar = BottomNavigationBar(
      onTap: onTabTapped,
      currentIndex: _page,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.blueGrey.withOpacity(0.6),
      elevation: 0.0,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.free_breakfast),
          title: Text(
            'Dessert',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant),
          title: Text(
            'Seafood',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          title: Text(
            'Favorite',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          ),
        ),

      ],
    );

    return Scaffold(
      appBar: AppBar(
        leading: Config.appIcon,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: Text(
          Config.appString,
          style: TextStyle(color: Colors.blue),
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search, color: Colors.blue),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MealsSearch()));
            },
          ),
        ],
      ),

      bottomNavigationBar: bottomNavBar,
      body: _children[_page],

    );
  }

  void onTabTapped(int index) {
    setState(() {
      _page = index;
    });
  }

}

void showToast(BuildContext context, String mealsName,
    {int duration, int gravity}) {
  Toast.show(mealsName, context, duration: duration, gravity: gravity);
}
