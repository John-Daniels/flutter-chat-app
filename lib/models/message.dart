class Message {
  final String message;
  final String username;
  final String? time;

  Message({
    required this.message,
    required this.username,
    this.time,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'],
      time: json['time'],
      username: json['username'],
    );
  }
}
