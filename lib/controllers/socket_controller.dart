import 'package:chat_app/constants/constants.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketController extends GetxController {
  final Socket _socket = io(socketUri, socketSettings);
  Socket get socket => _socket;

  @override
  onReady() {
    initSocket();
    super.onReady();
  }

  initSocket() {
    try {
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
}
