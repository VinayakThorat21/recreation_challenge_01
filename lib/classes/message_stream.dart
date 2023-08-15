import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class MessageList extends StatelessWidget {
  const MessageList({
    super.key,
    required this.firebaseFirestore,
    required this.loggedInUser,
    required this.collection,
  });

  final FirebaseFirestore firebaseFirestore;
  final String loggedInUser, collection;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firebaseFirestore
          .collection(collection)
          .orderBy('sentAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        List<MessageBubble> messageBubbles = [];

        if (!snapshot.hasData) {
          return const CircularProgressIndicator(
            backgroundColor: Colors.lightBlueAccent,
          );
        } else {
          final messages = snapshot.data?.docs;
          for (var message in messages!) {
            final messageData = message.data() as Map<String, dynamic>;
            final messageText = messageData['message'];
            final messageSender = messageData['sender'];

            messageBubbles.add(
              MessageBubble(
                message: messageText,
                sender: messageSender,
                loggedInUser: loggedInUser,
              ),
            );
          }
        }

        return ListView(
          reverse: true,
          children: messageBubbles,
        );
      },
    );
  }
}
