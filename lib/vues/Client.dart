import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legend_app/vues/blog/blogHome.dart';
import 'package:legend_app/vues/game/playHome.dart';
import 'package:legend_app/vues/profile/profileHome.dart';

class Client extends StatefulWidget {
  const Client({Key? key}) : super(key: key);

  @override
  _ClientState createState() => _ClientState();
}

class _ClientState extends State<Client> with TickerProviderStateMixin {
  @override
  int _pageIndex = 1;
  late TabController _tabController;
  late List<Widget> _pages;
  late List<String> _pageName;
  @override
  void initState() {
    _pageName = ["Mon profile", "Jouer", "Blog"];
    _tabController = TabController(length: 3, vsync: this);
    _pages = [
      ProfileHome(),
      PlayHome(),
      BlogHome(tabController: _tabController)
    ];
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      super.initState();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Text(_pageName[_pageIndex]),
          bottom: _pageIndex == 2
              ? TabBar(
                  controller: _tabController,
                  tabs: const <Widget>[
                    Tab(
                      text: "Articles",
                    ),
                    Tab(text: "Vidéos"),
                    Tab(text: "Market"),
                  ],
                )
              : null),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (value) => setState(() {
          _pageIndex = value;
        }),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).primaryColorDark,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad),
            label: 'Jouer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.panorama_fish_eye),
            label: 'Blog',
          ),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
