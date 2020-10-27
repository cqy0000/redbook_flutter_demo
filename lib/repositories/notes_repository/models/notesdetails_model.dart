import 'package:json_annotation/json_annotation.dart';

part 'notesdetails_model.g.dart';

@JsonSerializable()
class NotesDetails {
  String noteId;
  String userName;
  String userIcon;
  bool isFollowed;
  bool isMP4;
  String mp4Url;
  List<String> imagesUrl;
  String noteTitle;
  String noteContent;
  List<String> notesTags;
  String publishTime;
  bool isModifiled;
  String modifiledTime;
  bool idAds;
  String adsName;
  int likedNum;
  int staredNum;
  Comments comments;

  NotesDetails(
      {this.noteId,
      this.userName,
      this.userIcon,
      this.isFollowed,
      this.isMP4,
      this.mp4Url,
      this.imagesUrl,
      this.noteTitle,
      this.noteContent,
      this.notesTags,
      this.publishTime,
      this.isModifiled,
      this.modifiledTime,
      this.idAds,
      this.adsName,
      this.likedNum,
      this.staredNum,
      this.comments});

  NotesDetails.fromJson(Map<String, dynamic> json) {
    noteId = json['noteId'];
    userName = json['userName'];
    userIcon = json['userIcon'];
    isFollowed = json['isFollowed'];
    isMP4 = json['isMP4'];
    mp4Url = json['mp4Url'];
    imagesUrl = json['imagesUrl'].cast<String>();
    noteTitle = json['noteTitle'];
    noteContent = json['noteContent'];
    notesTags = json['notesTags'].cast<String>();
    publishTime = json['publishTime'];
    isModifiled = json['isModifiled'];
    modifiledTime = json['modifiledTime'];
    idAds = json['idAds'];
    adsName = json['adsName'];
    likedNum = json['likedNum'];
    staredNum = json['staredNum'];
    comments = json['comments'] != null
        ? new Comments.fromJson(json['comments'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['noteId'] = this.noteId;
    data['userName'] = this.userName;
    data['userIcon'] = this.userIcon;
    data['isFollowed'] = this.isFollowed;
    data['isMP4'] = this.isMP4;
    data['mp4Url'] = this.mp4Url;
    data['imagesUrl'] = this.imagesUrl;
    data['noteTitle'] = this.noteTitle;
    data['noteContent'] = this.noteContent;
    data['notesTags'] = this.notesTags;
    data['publishTime'] = this.publishTime;
    data['isModifiled'] = this.isModifiled;
    data['modifiledTime'] = this.modifiledTime;
    data['idAds'] = this.idAds;
    data['adsName'] = this.adsName;
    data['likedNum'] = this.likedNum;
    data['staredNum'] = this.staredNum;
    if (this.comments != null) {
      data['comments'] = this.comments.toJson();
    }
    return data;
  }
}

class Comments {
  int totalNum;
  List<Results> results;

  Comments({this.totalNum, this.results});

  Comments.fromJson(Map<String, dynamic> json) {
    totalNum = json['totalNum'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalNum'] = this.totalNum;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String userId;
  String userName;
  String userIcon;
  bool isNoteOwner;
  String time;
  String contents;
  int likedNum;
  List<RepliedList> repliedList;

  Results(
      {this.userId,
      this.userName,
      this.userIcon,
      this.isNoteOwner,
      this.time,
      this.contents,
      this.likedNum,
      this.repliedList});

  Results.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    userIcon = json['userIcon'];
    isNoteOwner = json['isNoteOwner'];
    time = json['time'];
    contents = json['contents'];
    likedNum = json['likedNum'];
    if (json['repliedList'] != null) {
      repliedList = new List<RepliedList>();
      json['repliedList'].forEach((v) {
        repliedList.add(new RepliedList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['userIcon'] = this.userIcon;
    data['isNoteOwner'] = this.isNoteOwner;
    data['time'] = this.time;
    data['contents'] = this.contents;
    data['likedNum'] = this.likedNum;
    if (this.repliedList != null) {
      data['repliedList'] = this.repliedList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RepliedList {
  String userId;
  String userName;
  bool isNoteOwner;
  String userIcon;
  String repliedUserName;
  String time;
  String contents;
  int likedNum;

  RepliedList(
      {this.userId,
      this.userName,
      this.isNoteOwner,
      this.userIcon,
      this.repliedUserName,
      this.time,
      this.contents,
      this.likedNum});

  RepliedList.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    isNoteOwner = json['isNoteOwner'];
    userIcon = json['userIcon'];
    repliedUserName = json['repliedUserName'];
    time = json['time'];
    contents = json['contents'];
    likedNum = json['likedNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['isNoteOwner'] = this.isNoteOwner;
    data['userIcon'] = this.userIcon;
    data['repliedUserName'] = this.repliedUserName;
    data['time'] = this.time;
    data['contents'] = this.contents;
    data['likedNum'] = this.likedNum;
    return data;
  }
}
