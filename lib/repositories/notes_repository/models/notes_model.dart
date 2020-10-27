import 'package:json_annotation/json_annotation.dart';

part 'notes_model.g.dart';

@JsonSerializable()
class Notes {
  int notesId;
  String notesTitle;
  int ownerId;
  String ownerName;
  String ownerIcon;
  String notesLikedNum;
  bool isMP4;
  String mp4Url;
  String noteFirstImageUrl;
  bool isLiked;

  Notes(
      {this.notesId,
      this.notesTitle,
      this.ownerId,
      this.ownerName,
      this.ownerIcon,
      this.notesLikedNum,
      this.isMP4,
      this.mp4Url,
      this.noteFirstImageUrl,
      this.isLiked});

  Notes.fromJson(Map<String, dynamic> json) {
    notesId = json['notesId'];
    notesTitle = json['notesTitle'];
    ownerId = json['ownerId'];
    ownerName = json['ownerName'];
    ownerIcon = json['ownerIcon'];
    notesLikedNum = json['notesLikedNum'];
    isMP4 = json['isMP4'];
    mp4Url = json['mp4Url'];
    noteFirstImageUrl = json['noteFirstImageUrl'];
    isLiked = json['isLiked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notesId'] = this.notesId;
    data['notesTitle'] = this.notesTitle;
    data['ownerId'] = this.ownerId;
    data['ownerName'] = this.ownerName;
    data['ownerIcon'] = this.ownerIcon;
    data['notesLikedNum'] = this.notesLikedNum;
    data['isMP4'] = this.isMP4;
    data['mp4Url'] = this.mp4Url;
    data['noteFirstImageUrl'] = this.noteFirstImageUrl;
    data['isLiked'] = this.isLiked;
    return data;
  }
}
