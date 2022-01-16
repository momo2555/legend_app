import 'package:flutter/material.dart';

class MessagesHome extends StatefulWidget {
  const MessagesHome({Key? key}) : super(key: key);

  @override
  _MessagesHomeState createState() => _MessagesHomeState();
}

class _MessagesHomeState extends State<MessagesHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Messagerie"),
            ),
            body: Container()));
  }
}
