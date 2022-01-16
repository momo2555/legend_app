import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legend_app/server/deviceDetection.dart';
import 'package:legend_app/server/gameLauncher.dart';
import 'package:legend_app/vues/game/elements/homeCard.dart';
import 'package:webview_flutter/webview_flutter.dart';

class monitorHome extends StatefulWidget {
  const monitorHome({Key? key}) : super(key: key);

  @override
  _monitorHomeState createState() => _monitorHomeState();
}

class _monitorHomeState extends State<monitorHome> {
  late WebViewController _webViewController;


  void openMOnitorDetection() async {
    DeviceDetection monitorServer = DeviceDetection();
    //make the controllers can detect the monitor
    monitorServer.runDeviceServer();


    GameLauncher webPageProvider = GameLauncher();
    webPageProvider.runServer();
  }

  @override
  void initState() {
    // TODO: implement initState

    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight])
        .then((_) {
      //open the udp server
      openMOnitorDetection();
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: WebView(
        initialUrl: 'https://flutter.dev',
        onWebViewCreated:(controller) {
          _webViewController = controller;
          
        },
        

      )
    );
  }
}
