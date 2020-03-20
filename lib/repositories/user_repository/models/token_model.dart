import 'package:json_annotation/json_annotation.dart';

part 'token_model.g.dart';

@JsonSerializable()
class Token {
  String accessToken;
  int expiredsIn;
  String refreshToken;
  String tokenType;
  String usid;

  Token(
      {this.accessToken,
      this.expiredsIn,
      this.refreshToken,
      this.tokenType,
      this.usid});

  Token.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    expiredsIn = json['expiredsIn'];
    refreshToken = json['refreshToken'];
    tokenType = json['tokenType'];
    usid = json['usid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['expiredsIn'] = this.expiredsIn;
    data['refreshToken'] = this.refreshToken;
    data['tokenType'] = this.tokenType;
    data['usid'] = this.usid;
    return data;
  }
}
