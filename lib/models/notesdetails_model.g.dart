// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notesdetails_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotesDetails _$NotesDetailsFromJson(Map<String, dynamic> json) {
  return NotesDetails(
    noteId: json['noteId'] as String,
    userName: json['userName'] as String,
    userIcon: json['userIcon'] as String,
    isFollowed: json['isFollowed'] as String,
    imagesUrl: (json['imagesUrl'] as List)?.map((e) => e as String)?.toList(),
    noteTitle: json['noteTitle'] as String,
    noteContent: json['noteContent'] as String,
    notesTags: (json['notesTags'] as List)?.map((e) => e as String)?.toList(),
    publishTime: json['publishTime'] as String,
    isModifiled: json['isModifiled'] as String,
    modifiledTime: json['modifiledTime'] as String,
    idAds: json['idAds'] as String,
    adsName: json['adsName'] as String,
    likedNum: json['likedNum'] as int,
    staredNum: json['staredNum'] as int,
    comments: json['comments'] == null
        ? null
        : Comments.fromJson(json['comments'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NotesDetailsToJson(NotesDetails instance) =>
    <String, dynamic>{
      'noteId': instance.noteId,
      'userName': instance.userName,
      'userIcon': instance.userIcon,
      'isFollowed': instance.isFollowed,
      'imagesUrl': instance.imagesUrl,
      'noteTitle': instance.noteTitle,
      'noteContent': instance.noteContent,
      'notesTags': instance.notesTags,
      'publishTime': instance.publishTime,
      'isModifiled': instance.isModifiled,
      'modifiledTime': instance.modifiledTime,
      'idAds': instance.idAds,
      'adsName': instance.adsName,
      'likedNum': instance.likedNum,
      'staredNum': instance.staredNum,
      'comments': instance.comments,
    };
