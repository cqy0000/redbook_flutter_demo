import 'package:json_annotation/json_annotation.dart';

part 'userprofile_model.g.dart';

@JsonSerializable()
class UserProfile {
  String id;
  String userName;
  String userIcon;
  String userCity;
  String userLevel;
  String isRMember;
  String userIntr;
  String fansNum;
  String followNum;
  String totalLikedNum;
  String allNoteNum;
  String allVlogNum;

  UserProfile(
      {this.id,
      this.userName,
      this.userIcon,
      this.userCity,
      this.userLevel,
      this.isRMember,
      this.userIntr,
      this.fansNum,
      this.followNum,
      this.totalLikedNum,
      this.allNoteNum,
      this.allVlogNum});

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    userIcon = json['userIcon'];
    userCity = json['userCity'];
    userLevel = json['userLevel'];
    isRMember = json['isRMember'];
    userIntr = json['userIntr'];
    fansNum = json['fansNum'];
    followNum = json['followNum'];
    totalLikedNum = json['totalLikedNum'];
    allNoteNum = json['allNoteNum'];
    allVlogNum = json['allVlogNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['userIcon'] = this.userIcon;
    data['userCity'] = this.userCity;
    data['userLevel'] = this.userLevel;
    data['isRMember'] = this.isRMember;
    data['userIntr'] = this.userIntr;
    data['fansNum'] = this.fansNum;
    data['followNum'] = this.followNum;
    data['totalLikedNum'] = this.totalLikedNum;
    data['allNoteNum'] = this.allNoteNum;
    data['allVlogNum'] = this.allVlogNum;
    return data;
  }
}
