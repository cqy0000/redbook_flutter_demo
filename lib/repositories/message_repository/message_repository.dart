import 'package:redbook/repositories/message_repository/models/message_model.dart';
import 'package:dio/dio.dart';

class MessageRepository {
  Future<List<Message>> getMessageList() async {
    List<Message> messages;
    var url = 'http://localhost:3000/msgList';
    try {
      Response res = await Dio().get(url);
      if (res.data != null) {
        messages = res.data.map<Message>((item) {
          Message msg = Message.fromJson(item);
          return msg;
        }).toList();
      }
    } catch(e) {
      return new Future.error(e);
    }
    return messages;
  }
}