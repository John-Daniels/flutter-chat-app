import 'package:chat_app/models/message.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  var chatMessages = <Message>[].obs;
  var typeing = false.obs;
  var userData = <String, dynamic>{}.obs;
  var roomData = <String, dynamic>{}.obs;

  String get username => userData['username'] ?? '';
  String get room => roomData['room'] ?? 'loading';
  int get connectedUsers => roomData['users']?.length ?? 0;

  generateMessage(String message) {
    var date = DateTime.now();
    var hour = date.hour.toString().padLeft(2, "0");
    var mins = date.minute.toString().padLeft(2, "0");
    var time = '$hour:$mins ${double.parse(hour) > 12 ? "pm" : "am"}';

    var messageJson = {
      'message': message,
      "time": time,
      "username": userData['username'] ?? "",
    };

    return messageJson;
  }
}
