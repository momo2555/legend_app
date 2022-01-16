import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:legend_app/models/userModel.dart';
import 'package:legend_app/server/userConnection.dart';
import 'package:legend_app/vues/Client.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String _password = '';
  String _email = '';

  Widget _passwordEntry() {
    return TextFormField(
      obscureText: true,
      onChanged: (value) => setState(() {
        _password = value;
      }),
    );
  }

  Widget _emailEntry() {
    return TextFormField(
      onChanged: (value) => setState(() {
        _email = value;
      }),
    );
  }

  Widget _submitButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () async {
          UserConnection userConnection = UserConnection();
          UserModel newUser;
          userConnection.Authentification(_email, _password).then((value) {
            newUser = value;
            //if the user is connected
            if (newUser.isConnected()) {
              //page des utilisateurs connecté
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Client();
                },
              ));
            } else {
              //message d'erreur
            }
          });
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            )),
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero)),
        child: Container(
          height: 50,
          width: 50,
          child: const Icon(
            Icons.arrow_forward_rounded,
            color: null,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background/test.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    Text(
                      'Connexion',
                      style: TextStyle(
                        fontSize: 50,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    const Text(
                      "Legend",
                      style: TextStyle(
                          fontFamily: 'Tangerine',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 35),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    _emailEntry(),
                    const SizedBox(
                      height: 20,
                    ),
                    _passwordEntry(),
                    const SizedBox(
                      height: 30.0,
                    ),
                    _submitButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
