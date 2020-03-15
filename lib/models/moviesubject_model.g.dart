// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moviesubject_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieSubjects _$MovieSubjectsFromJson(Map<String, dynamic> json) {
  return MovieSubjects(
    subjects: (json['subjects'] as List)
        ?.map((e) =>
            e == null ? null : Subjects.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$MovieSubjectsToJson(MovieSubjects instance) =>
    <String, dynamic>{
      'subjects': instance.subjects,
      'title': instance.title,
    };
