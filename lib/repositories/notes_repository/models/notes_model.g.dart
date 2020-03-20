// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notes _$NotesFromJson(Map<String, dynamic> json) {
  return Notes(
    notesId: json['notesId'] as int,
    notesTitle: json['notesTitle'] as String,
    ownerId: json['ownerId'] as int,
    ownerName: json['ownerName'] as String,
    ownerIcon: json['ownerIcon'] as String,
    notesLikedNum: json['notesLikedNum'] as String,
    noteFirstImageUrl: json['noteFirstImageUrl'] as String,
    isLiked: json['isLiked'] as bool,
  );
}

Map<String, dynamic> _$NotesToJson(Notes instance) => <String, dynamic>{
      'notesId': instance.notesId,
      'notesTitle': instance.notesTitle,
      'ownerId': instance.ownerId,
      'ownerName': instance.ownerName,
      'ownerIcon': instance.ownerIcon,
      'notesLikedNum': instance.notesLikedNum,
      'noteFirstImageUrl': instance.noteFirstImageUrl,
      'isLiked': instance.isLiked,
    };
