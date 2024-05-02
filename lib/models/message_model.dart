import 'package:chatapp/constant.dart';

class Message {
  final String message;
  final String id;
  Message({required this.message, required this.id});

  factory Message.fromjson(data) {
    return Message(message: data[kMessage], id: data['id']);
  }
}
