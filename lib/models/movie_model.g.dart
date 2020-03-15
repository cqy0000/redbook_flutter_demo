// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
    rating: json['rating'] == null
        ? null
        : Rating.fromJson(json['rating'] as Map<String, dynamic>),
    genres: (json['genres'] as List)?.map((e) => e as String)?.toList(),
    title: json['title'] as String,
    casts: (json['casts'] as List)
        ?.map(
            (e) => e == null ? null : Casts.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    durations: (json['durations'] as List)?.map((e) => e as String)?.toList(),
    collectCount: json['collectCount'] as int,
    mainlandPubdate: json['mainlandPubdate'] as String,
    hasVideo: json['hasVideo'] as bool,
    originalTitle: json['originalTitle'] as String,
    subtype: json['subtype'] as String,
    directors: (json['directors'] as List)
        ?.map((e) =>
            e == null ? null : Directors.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    pubdates: (json['pubdates'] as List)?.map((e) => e as String)?.toList(),
    year: json['year'] as String,
    images: json['images'] == null
        ? null
        : Avatars.fromJson(json['images'] as Map<String, dynamic>),
    alt: json['alt'] as String,
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'rating': instance.rating,
      'genres': instance.genres,
      'title': instance.title,
      'casts': instance.casts,
      'durations': instance.durations,
      'collectCount': instance.collectCount,
      'mainlandPubdate': instance.mainlandPubdate,
      'hasVideo': instance.hasVideo,
      'originalTitle': instance.originalTitle,
      'subtype': instance.subtype,
      'directors': instance.directors,
      'pubdates': instance.pubdates,
      'year': instance.year,
      'images': instance.images,
      'alt': instance.alt,
      'id': instance.id,
    };
