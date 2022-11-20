import 'package:chat_app/constants/constants.dart';
import 'package:chat_app/controllers/chat_controller.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/screens/home/components/chat_blob.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController messageInput = TextEditingController();
  late IO.Socket socket;
  ChatController chats = ChatController();

  @override
  void initState() {
    super.initState();

    initSocket();
    setUpSocketListeners();
  }

  @override
  void dispose() {
    socket.emit('logout');

    super.dispose();
  }

  initSocket() {
    try {
      socket = IO.io(socketUri, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });

      print('trying connnection');
      socket.connect();

      socket.onConnect((data) {
        print('Connect: ${socket.id}');
      });
    } catch (e) {
      print('error');
      print(e.toString());
    }
  }

  setUpSocketListeners() {
    socket.on('userData', (data) {
      // chats.room.value = data['room'];
      chats.userData.value = data;
      print('$data');
    });

    socket.on('roomData', (data) {
      // chats.room.value = data['room'];
      chats.roomData.value = data;
      print('$data');
    });

    socket.on('message-recieve', (data) {
      chats.chatMessages.add(Message.fromJson(data));
    });

    socket.on('typeing', (data) {
      chats.typeing.value = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple[50],
        // backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.deepPurple,
          elevation: 0,
          title: Obx(() {
            return Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${chats.username}@${chats.room} -",
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'online users: ${chats.connectedUsers}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 5),
                  if (chats.typeing.isTrue)
                    LoadingAnimationWidget.twistingDots(
                      leftDotColor: Colors.deepPurple.shade100,
                      rightDotColor: const Color(0xFFEA3799).withOpacity(0.8),
                      size: 30,
                    ),
                ],
              ),
            );
          }),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 9,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Obx(
                  () => ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: chats.chatMessages.length,
                    itemBuilder: (context, index) {
                      var currentItem = chats.chatMessages[index];
                      return ChatBlob(
                        username: currentItem.username,
                        message: currentItem.message,
                        sentByMe: currentItem.username == chats.username,
                        time: currentItem.time ?? '',
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              height: 65,
              // padding: const EdgeInsets.all(10),
              // margin: const EdgeInsets.only(bottom: 10),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        if (value.isEmpty) return socket.emit('type', false);
                        socket.emit('type', true);
                      },
                      cursorColor: Colors.purple,
                      style: TextStyle(color: Colors.deepPurple[400]),
                      controller: messageInput,
                      decoration: InputDecoration(
                        hintText: 'write some text...',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.deepPurple,
                    ),
                    child: IconButton(
                      disabledColor: Colors.black26,
                      onPressed: () {
                        if (messageInput.text.isEmpty) return;
                        socket.emit('type', false);
                        sendMessage(messageInput.text);
                        messageInput.text = "";
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
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

  void sendMessage(text) {
    var newMsg = chats.generateMessage(text);
    chats.chatMessages.add(Message.fromJson(newMsg));
    socket.emit('message', newMsg);
  }
}
