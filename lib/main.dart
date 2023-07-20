//import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:legend_app/server/userConnection.dart';
import 'package:legend_app/vues/Client.dart';
import 'package:legend_app/vues/game/monitor/monitorHome.dart';
import 'package:legend_app/vues/signIn.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  /*SystemChrome.setPreferredOrientations([DeviceOrzerfdeientation.landscapeRight])
      .then((_) {
    */
  runApp(const MyApp()); /*
  });*/
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   
    UserConnection userConnection = UserConnection();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lagend',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 222, 76, 76),
        primaryColorDark: Color.fromARGB(255, 0, 31, 61),
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 222, 76, 76),
        ),
      ),
      home: StreamBuilder(
        stream: userConnection.userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              //if a user is connected show the client page
              return Client();
            } else {
              //if not shoing sign in page
              return SignInPage();
            }
          }
          return Container();
        },
      ),
    );
  }
}
