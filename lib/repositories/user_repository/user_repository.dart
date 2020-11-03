import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import 'dart:async';

import 'package:redbook/data/storage/storage.dart';
import 'package:redbook/constant/storage_constant.dart';
import 'package:redbook/repositories/user_repository/models/userprofile_model.dart';

class UserRepostory {
  final Storage _storage;

  const UserRepostory({@required Storage storage}): assert(storage != null ),
  _storage = storage;

  Future<String> authenticate({@required phoneNum, @required String pwd}) async{
    // tokenInfo;
    var url = 'http://localhost:3000/userStatus?phoneNum=$phoneNum&pwd=$pwd';
    try{
      Response res = await Dio().get(url);

      await saveTokenInfo(
        accessToken: res.data['accessToken'],
        refreshToken: res.data['refreshToken'],
        tokenType: res.data['tokenType']
      );

      await saveUsid(usid: res.data['usid']);

      return res.data['usid'];
    } on Object catch (error) {
      print(error);
      throw error;
    }
  }

  Future getUsid() async{
    await _storage.read(key: usidStorageKey);
  }

  Future<void> saveTokenInfo({
    String accessToken,
    String refreshToken,
    String tokenType
  }) async{
    await _storage.write(key: accessTokenStorageKey, value: accessToken);
    await _storage.write(key: refreshStorageKey, value: refreshToken);
    await _storage.write(key: tokenTypeStorageKey, value: tokenType);
  }

  Future<void> saveUsid({
    String usid,
  }) async{
    await _storage.write(key: usidStorageKey, value: usid);
  }

  Future deleteStorage() async{
    await Future.wait([
      _storage.delete(key:accessTokenStorageKey),
      _storage.delete(key:refreshStorageKey),
      _storage.delete(key:tokenTypeStorageKey),
      _storage.delete(key:usidStorageKey),
    ]);
  }

  Future<UserProfile> getUserInfo() async{
    var url = 'http://localhost:3000/userProfile/1';
    try{
      Response res = await Dio().get(url);

      return UserProfile.fromJson(res.data);
    }catch (error) {
      throw error;
    }
  }
}