import 'package:meta/meta.dart';
import 'dart:ui';
import 'package:redbook/Settings/registry.dart';
import 'package:redbook/data/storage/storage.dart';
import 'package:redbook/repositories/user_repository/user_repository.dart';
// import 'package:redbook/data/file_system/file_system.dart';


class Init {
  static Registry _reposRegistry = Registry();
  // static VoidCallback _authenticationRevoked;

  static final _instance = Init._();

  Init._();

  static Init get instance => _instance;

  static Future<void> init({
    @required VoidCallback authenticationRevoked
  }) async {
    _initRepos();
  }

  static void _initRepos() async {
    // final fileSyetem = FileSystem();
    final storage = Storage();
    _reposRegistry
      ..registry(
        Record<UserRepostory>(
          builder: () => UserRepostory(storage: storage)
        )
      );
  }

  static UserRepostory get userRepostory => _reposRegistry.resolve<UserRepostory>();

}