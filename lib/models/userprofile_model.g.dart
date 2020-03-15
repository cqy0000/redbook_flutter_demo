// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userprofile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return UserProfile(
    id: json['id'] as String,
    userName: json['userName'] as String,
    userIcon: json['userIcon'] as String,
    userCity: json['userCity'] as String,
    userLevel: json['userLevel'] as String,
    isRMember: json['isRMember'] as String,
    userIntr: json['userIntr'] as String,
    fansNum: json['fansNum'] as String,
    followNum: json['followNum'] as String,
    totalLikedNum: json['totalLikedNum'] as String,
    allNoteNum: json['allNoteNum'] as String,
    allVlogNum: json['allVlogNum'] as String,
  );
}

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'userIcon': instance.userIcon,
      'userCity': instance.userCity,
      'userLevel': instance.userLevel,
      'isRMember': instance.isRMember,
      'userIntr': instance.userIntr,
      'fansNum': instance.fansNum,
      'followNum': instance.followNum,
      'totalLikedNum': instance.totalLikedNum,
      'allNoteNum': instance.allNoteNum,
      'allVlogNum': instance.allVlogNum,
    };
