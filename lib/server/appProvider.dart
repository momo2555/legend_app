
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:legend_app/models/gameModel.dart';
import 'package:path_provider/path_provider.dart';

/**
 * get available application on the server
 */
class AppProvider {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  AppProvider() {

  }
  Future<List<GameModel>>? getGamesList() async {
    //set the temporary folder
     Directory tempFolder = await getTemporaryDirectory();
     List<GameModel> gameslist = [];
     Random rnd = Random();
     String fileSuffix = "";
     String fullPath = "";
     Map<String, dynamic> jsonData;
    //get the games list
    ListResult result =  await firebaseStorage.ref("games").listAll();
    

    
    
   for (var element in result.prefixes){
      print(element);
      GameModel game = GameModel();
      fullPath = element.fullPath;
      game.setNameid = element.name;
      //reade the game.json file ------
      //first : creating a temp file in data cache folder
      fileSuffix =  rnd.nextInt(1000000).toRadixString(16);
      File jsonDataFile = File('${tempFolder.path}/games/${element.name}-${fileSuffix}.json');
      jsonDataFile.create(recursive:  true);
      //then: downloading the game.json file
      await firebaseStorage.ref('$fullPath/game.json').writeToFile(jsonDataFile);
      //finnally: reading and parsing the file
      jsonData = jsonDecode( await jsonDataFile.readAsString());
      //get the name of the game
      if(jsonData.containsKey('name')) {
        game.setName = jsonData['name'];
      }
      if(jsonData.containsKey('icon')) {
        game.setIconUrl = await firebaseStorage.ref('${fullPath}/${jsonData['icon']}').getDownloadURL();
      }
      if(jsonData.containsKey('banner')) {
        game.setBannerUrl = await firebaseStorage.ref('${fullPath}/${jsonData['banner']}').getDownloadURL();
      }
      if(jsonData.containsKey('description')) {
        game.setDescription = jsonData['description'];
      }
       if(jsonData.containsKey('monitor')) {
        game.setMonitorPage = jsonData['monitor'];
      }
       if(jsonData.containsKey('controller')) {
        game.setControllerPage = jsonData['controller'];
      }
      gameslist.add(game);
    }
    return gameslist;
  }

}