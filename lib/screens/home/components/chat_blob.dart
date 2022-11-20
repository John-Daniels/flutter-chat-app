import 'package:flutter/material.dart';

class ChatBlob extends StatelessWidget {
  const ChatBlob({
    super.key,
    required this.sentByMe,
    required this.message,
    required this.time,
    required this.username,
  });
  final bool sentByMe;
  final String username;
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3),
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:
              sentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 10,
                left: 10,
              ),
              child: Row(
                mainAxisAlignment:
                    sentByMe ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  Text(username),
                  const Text(' - '),
                  Text(
                    time,
                    style: const TextStyle(fontSize: 9, color: Colors.black45),
                  ),
                ],
              ),
            ),
            Container(
              // padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              padding: EdgeInsets.only(
                right: sentByMe ? 30 : 20,
                left: 10,
                top: 6,
                bottom: 5,
              ),
              margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              decoration: BoxDecoration(
                  color: sentByMe ? Colors.deepPurple[400] : Colors.white,
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                // mainAxisSize: MainAxisSize.max,
                // crossAxisAlignment: CrossAxisAlignment.baseline,
                // textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message,
                    style: TextStyle(
                        color:
                            (sentByMe ? Colors.white : Colors.deepPurple[400])!
                                .withOpacity(0.7),
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis),
                  ),
                  // SizedBox(width: sentByMe ? 30 : ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
