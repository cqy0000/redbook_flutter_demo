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
  String noteFirstImageUrl;
  String isLiked;

  Notes(
      {this.notesId,
      this.notesTitle,
      this.ownerId,
      this.ownerName,
      this.ownerIcon,
      this.notesLikedNum,
      this.noteFirstImageUrl,
      this.isLiked});

  Notes.fromJson(Map<String, dynamic> json) {
    notesId = json['notesId'];
    notesTitle = json['notesTitle'];
    ownerId = json['ownerId'];
    ownerName = json['ownerName'];
    ownerIcon = json['ownerIcon'];
    notesLikedNum = json['notesLikedNum'];
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
    data['noteFirstImageUrl'] = this.noteFirstImageUrl;
    data['isLiked'] = this.isLiked;
    return data;
  }
}

