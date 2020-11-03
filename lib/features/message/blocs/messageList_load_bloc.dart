import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:redbook/features/message/blocs/messageList_load_event.dart';
import 'package:redbook/features/message/blocs/messageList_load_state.dart';
import 'package:redbook/repositories/message_repository/message_repository.dart';

class MessageListLoadBloc extends Bloc<MessageListLoadEvent, MessageListLoadState> {
  MessageRepository msgListRepos;
  MessageListLoadBloc({@required this.msgListRepos});

  @override
  Stream<MessageListLoadState> transformEvents(
    Stream<MessageListLoadEvent> events,
    Stream<MessageListLoadState>Function(MessageListLoadEvent event) next,
  ) {
    return super.transformEvents(
      events,
      next,
    );
  }

  @override
  MessageListLoadState get initialState => MessageListEmpty();

  @override
  Stream<MessageListLoadState> mapEventToState(MessageListLoadEvent event) async* {
    final currentState = state;
    if (event is Fetch && !_hasReachedMax(currentState)) {
      yield* _mapFetchEventToState(event);
    }
    if(event is Reload && !_hasReachedMax(currentState)) {
      yield* _mapReloadEventToState(event);
    }
  }

  Stream<MessageListLoadState> _mapFetchEventToState(Fetch event) async* {
    try{
      if(state is MessageListEmpty) {
        final msgs = await msgListRepos.getMessageList();
        yield MessageListSuccess(msglist: msgs, hasReachedMax: false);
        return;
      }
      if(state is MessageListSuccess){
        MessageListSuccess successState = state;
        final msgs = await msgListRepos.getMessageList();
        if(msgs.isEmpty) {
          yield successState.copyWith(hasReachedMax: true);
        }else{
          yield MessageListSuccess(msglist: successState.msglist + msgs, hasReachedMax: false);
        }
      }
    }catch(e){
      yield MessageListError(e);
    }
  }

  Stream<MessageListLoadState> _mapReloadEventToState(Reload event) async* {
    final msgs = await msgListRepos.getMessageList();
    yield MessageListSuccess(msglist: msgs, hasReachedMax: false);
  }

  bool _hasReachedMax(MessageListLoadState state) => state is MessageListSuccess && state.hasReachedMax;


}