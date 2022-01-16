import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_app/models/gameModel.dart';
import 'package:legend_app/vues/game/monitorListDialog.dart';

class GamePage extends StatefulWidget {
  final GameModel game;
  const GamePage({ Key? key , required this.game}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(220),
        child: AppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.game.bannerUrl),
                fit: BoxFit.fill,
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top:  190,
                  right: 50,
                  child: InkWell(
                    onTap: () {
                      //show the screen list (begin) the game
                      showDialog(context: context, builder: (BuildContext context){
                        return MonitorListDialog(game: widget.game);
                      });
                    },
                    child: Container(
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).primaryColor,
                      ),
                     
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          
                          children: [Icon(
                            Icons.play_arrow_rounded, 
                            color: Colors.white,
                            size: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text("Jouer", style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),),
                          )]
                        ),
                      ),
                    ),
                  ),
                )
                ,
                Positioned(
                  left: 40,
                  top: 180,
                  child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.game.getIconUrl),
                      fit: BoxFit.fill
                    ),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(color: Color.fromARGB(50, 0, 0, 0), blurRadius: 10) ],

                  ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ),
      body: Container(
        child: SingleChildScrollView(child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.game.getName, style: TextStyle(
                fontSize: 30,
                color: Theme.of(context).primaryColorDark,
                
              ),),
              Text(widget.game.getDescription),
              
          ],),
        ),)
      ),
    );
  }
}