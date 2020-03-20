// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) {
  return Token(
    accessToken: json['accessToken'] as String,
    expiredsIn: json['expiredsIn'] as int,
    refreshToken: json['refreshToken'] as String,
    tokenType: json['tokenType'] as String,
    usid: json['usid'] as String,
  );
}

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'expiredsIn': instance.expiredsIn,
      'refreshToken': instance.refreshToken,
      'tokenType': instance.tokenType,
      'usid': instance.usid,
    };
