import 'package:flutter/material.dart';
import 'package:legend_app/models/gameModel.dart';
import 'package:legend_app/models/monitorModel.dart';
import 'package:legend_app/server/deviceDetection.dart';
import 'package:legend_app/server/gameClient.dart';
import 'package:legend_app/server/profileServer.dart';
import 'package:legend_app/server/userProfileModel.dart';
import 'package:webview_flutter/webview_flutter.dart';

/**
 * Une simple liste de serveurs
 */
class ControllerHome extends StatefulWidget {
  final MonitorModel monitor;
  final GameModel game;
  const ControllerHome({Key? key, required this.game, required this.monitor}) : super(key: key);

  @override
  _ControllerHomeState createState() => _ControllerHomeState();
}

class _ControllerHomeState extends State<ControllerHome> {
  List<ListTile> _monitorsTile = [];
  Stream<List<MonitorModel>>? _monitorModelsList;

  @override
  void initState() {
    //create the stream;
    DeviceDetection monitorDetection = DeviceDetection();
    monitorDetection.runDeviceClient();
    _monitorModelsList = monitorDetection.monitorListStream;

    // TODO: implement initState
    super.initState();
    //launch the game: the client is the controller and the server is the monitor !
    GameClient gameClient = GameClient(monitor: widget.monitor);
    gameClient.run();
    gameClient.launcheGame(widget.game);
  }

  @override
  Widget build(BuildContext context) {
    print("http://" + widget.monitor.getIp + ":2226/"+widget.game.getControllerPage);
    return SafeArea(
      child: Scaffold(
          body: WebView(
            initialUrl: "http://" + widget.monitor.getIp + ":2226/"+widget.game.getControllerPage,
          ),
          
          ),
    );
  }
}
