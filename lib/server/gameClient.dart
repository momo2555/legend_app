import 'package:legend_app/models/gameModel.dart';
import 'package:legend_app/models/gameRequestModel.dart';
import 'package:legend_app/models/monitorModel.dart';
import 'dart:io';
import 'package:web_socket_channel/web_socket_channel.dart';

class GameClient {
  late WebSocketChannel client;
  final MonitorModel monitor;

  GameClient({required this.monitor}) {

  }
  run () {
    client = WebSocketChannel.connect(
      Uri.parse('ws://' + monitor.getIp + ':2225'),
    );

    
  }
  launcheGame(GameModel game) {
    GameRequestModel gameLaunchRequest = GameRequestModel(request: "launchGame", from: "client", to: "server");
    gameLaunchRequest.addParameter("game", game.toObject());
    print(gameLaunchRequest.toString());
    client.sink.add(gameLaunchRequest.toString());
  }
}