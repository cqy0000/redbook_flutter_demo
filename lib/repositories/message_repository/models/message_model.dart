import 'package:json_annotation/json_annotation.dart'; 
  
part 'message_model.g.dart';

@JsonSerializable()
  class Message extends Object {

  @JsonKey(name: 'msgId')
  String msgId;

  @JsonKey(name: 'msgType')
  String msgType;

  @JsonKey(name: 'msgContent')
  String msgContent;

  @JsonKey(name: 'msgTime')
  String msgTime;

  @JsonKey(name: 'msgSenderName')
  String msgSenderName;

  @JsonKey(name: 'msgSenderImg')
  String msgSenderImg;

  @JsonKey(name: 'msgHasNew')
  bool msgHasNew;

  @JsonKey(name: 'msgUnreadNum')
  int msgUnreadNum;

  Message(this.msgId,this.msgType,this.msgContent,this.msgTime,this.msgSenderName,this.msgSenderImg,this.msgHasNew,this.msgUnreadNum,);

  factory Message.fromJson(Map<String, dynamic> srcJson) => _$MessageFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

}

  
