import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recreation_challenge_01/screens/chat_screen.dart';
import '../classes/action_button.dart';
import '../utilities/constants.dart';

class ConnectWith extends StatefulWidget {
  const ConnectWith({super.key});
  static const String id = 'ConnectWith';

  @override
  State<ConnectWith> createState() => _ConnectWithState();
}

class _ConnectWithState extends State<ConnectWith> {
  late String user;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Out'),
        backgroundColor: Colors.lightBlueAccent,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
              onChanged: (value) {
                user = value;
              },
              decoration:
                  kInputDecoration.copyWith(hintText: 'Connect with...'),
            ),
            const SizedBox(
              height: 24.0,
            ),
            ActionButton(
              color: Colors.lightBlueAccent,
              action: 'Connect',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatScreen(chatWith: user)));
              },
            ),
          ],
        ),
      ),
    );
  }
}
