import 'package:flutter/material.dart';

class ChatBlob extends StatelessWidget {
  const ChatBlob(
      {super.key,
      required this.sentByMe,
      required this.message,
      required this.time});
  final bool sentByMe;
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        decoration: BoxDecoration(
            color: sentByMe ? Colors.deepPurple[400] : Colors.white,
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.baseline,
          // textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message,
              style: TextStyle(
                  color: (sentByMe ? Colors.white : Colors.deepPurple[400])!
                      .withOpacity(0.7),
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(width: 5),
            Text(
              time,
              style: const TextStyle(fontSize: 9, color: Colors.black45),
            ),
          ],
        ),
      ),
    );
  }
}
