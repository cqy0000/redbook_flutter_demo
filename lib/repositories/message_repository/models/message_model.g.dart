// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    json['msgId'] as String,
    json['msgType'] as String,
    json['msgContent'] as String,
    json['msgTime'] as String,
    json['msgSenderName'] as String,
    json['msgSenderImg'] as String,
    json['msgHasNew'] as bool,
    json['msgUnreadNum'] as int,
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'msgId': instance.msgId,
      'msgType': instance.msgType,
      'msgContent': instance.msgContent,
      'msgTime': instance.msgTime,
      'msgSenderName': instance.msgSenderName,
      'msgSenderImg': instance.msgSenderImg,
      'msgHasNew': instance.msgHasNew,
      'msgUnreadNum': instance.msgUnreadNum,
    };
