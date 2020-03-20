import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:redbook/blocs/authentication/token_authentication_bloc/token_authentication_event.dart';
import 'package:redbook/blocs/authentication/token_authentication_bloc/token_authentication_state.dart';
import 'package:redbook/repositories/user_repository/user_repository.dart';

class TokenAuthenticationBloc extends Bloc<TokenAuthenticationEvent, TokenAuthenticationState>{
  final UserRepostory userRepostory;

  TokenAuthenticationBloc({@required this.userRepostory});
  // TokenAuthenticationBloc({@required this.userRepostory}): assert(userRepostory != null);

  @override
  TokenAuthenticationState get initialState => TokenInitial();

  Stream<TokenAuthenticationState> mapEventToState(
    TokenAuthenticationEvent event
  ) async* {
    if(event is AppStarted){
      yield* _mapAppStartedToState(event);
    }else if(event is LoggedIn){
      yield* _mapLoggedInToState(event);
    }else if(event is LoggedOut){
      yield* _mapLoggedOutToState(event);
    }else if(event is TokenRevoked){
      yield* _mapTokenRevokedToState(event);
    }
  }

  Stream<TokenAuthenticationState> _mapAppStartedToState(AppStarted event) async*{
    yield await _hasUsid() ? TokenVaildateSuccess() : TokenVaildateFailed();
  }

  Stream<TokenAuthenticationState> _mapLoggedInToState(LoggedIn event) async*{
    yield TokenVaildateSuccess();
  }

  Stream<TokenAuthenticationState> _mapLoggedOutToState(LoggedOut event) async*{
    yield TokenVaildateFailed();
  }

  Stream<TokenAuthenticationState> _mapTokenRevokedToState(TokenRevoked event) async*{
    yield TokenRevokedSuccess();
  }

  Future<bool> _hasUsid() async{
    try{
      final usid = await userRepostory.getUsid();
      return usid != null;
    } on Object catch(_){
      return false;
    }
  }
}