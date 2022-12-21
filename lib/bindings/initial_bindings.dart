import 'package:chat_app/controllers/chat_controller.dart';
import 'package:chat_app/controllers/socket_controller.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  dependencies() {
    Get.put(SocketController(), permanent: true);
    Get.put(ChatController());
  }
}
