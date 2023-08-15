import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recreation_challenge_01/constants.dart';
import '../classes/message_stream.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.chatWith});
  static const String id = 'ChatScreen';
  final String chatWith;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late dynamic loggedInUser;
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final TextEditingController _textEditingController = TextEditingController();
  late String collection;

  @override
  void initState() {
    super.initState();
    loggedInUser = _auth.currentUser?.email;
    collection = loggedInUser.compareTo(widget.chatWith) < 0
        ? '$loggedInUser&${widget.chatWith}'
        : '${widget.chatWith}&$loggedInUser';
  }

  @override
  Widget build(BuildContext context) {
    late String messageTyped;

    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: MessageList(
                firebaseFirestore: firebaseFirestore,
                loggedInUser: loggedInUser,
                collection: collection,
              ),
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      controller: _textEditingController,
                      onChanged: (value) {
                        messageTyped = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await firebaseFirestore.collection(collection).add(
                        {
                          'message': messageTyped,
                          'sender': loggedInUser,
                          'sentAt': DateTime.now(),
                        },
                      );
                      _textEditingController.clear();
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
