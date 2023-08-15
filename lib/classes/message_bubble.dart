import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.sender,
    required this.loggedInUser,
  });

  final String message, sender, loggedInUser;

  @override
  Widget build(BuildContext context) {
    final bool isMe = sender == loggedInUser;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black38,
            ),
          ),
          Material(
            elevation: 7.0,
            borderRadius: BorderRadius.only(
              topLeft: !isMe
                  ? const Radius.circular(0.0)
                  : const Radius.circular(10.0),
              topRight: isMe
                  ? const Radius.circular(0.0)
                  : const Radius.circular(10.0),
              bottomLeft: const Radius.circular(10.0),
              bottomRight: const Radius.circular(10.0),
            ),
            color: isMe ? Colors.lightBlueAccent : Colors.lightGreen.shade100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 15.0,
                  color: isMe ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
