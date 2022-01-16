import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legend_app/models/gameModel.dart';
import 'package:legend_app/server/appProvider.dart';
import 'package:legend_app/vues/game/controller/controllerHome.dart';
import 'package:legend_app/vues/game/gamePage.dart';
import 'package:legend_app/vues/game/monitor/monitorHome.dart';

class PlayHome extends StatefulWidget {
  const PlayHome({Key? key}) : super(key: key);

  @override
  _PlayHomeState createState() => _PlayHomeState();
}

class _PlayHomeState extends State<PlayHome> {
  late List<Row> rows;
  late Column RowsList;
  final double iconsSize = 70;
  final double iconsPadding = 10;

  setupGamesList() {

  }
  Widget gameIcon(GameModel game) {
    print(game.getBannerUrl);
    return Container(
      child: 
      InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return GamePage(game: game);
          }));
        },
        child:
    Padding(
      padding:  EdgeInsets.all(iconsPadding),
      child: Column(
        children: [
        Image(image: NetworkImage(game.getIconUrl), width: iconsSize,),
        Text(game.getName)
      ],
      
      ),
    ),),);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rows =[];
    AppProvider appProvider = AppProvider();
    appProvider.getGamesList()!.then( (gamesList) {
      //checking the screen width
      double width = MediaQuery.of(context).size.width;
      //desired icon width
      double iconWidth = iconsSize + 2*iconsPadding;
      //icons per row
      num perRow = width ~/ iconWidth;
      //icon index
      int i = 0;
      List<Widget> row = [];
      //temp rows
      List<Row> tempRows = []; 
      for(GameModel game in gamesList){
        row.add(gameIcon(game));
        
         i++;
        if(i%perRow==0) {
          tempRows.add(Row(children: row,));
          row =[];
        }
       setState(() {
         rows = [Row(children: [gameIcon(gamesList[0])],)];
       });

      }
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(child: Column(children: rows,));
  }
}
