import 'package:equatable/equatable.dart';
import 'package:redbook/repositories/message_repository/models/message_model.dart';

abstract class MessageListLoadState extends Equatable {
  const MessageListLoadState();

  @override
  List<Object> get props => [];
}

class MessageListEmpty extends MessageListLoadState {
  @override
  String toString() => 'MessageListEmpty';
}

class MessageListLoading extends MessageListLoadState {
  @override
  String toString() => 'MessageListLoading';
}

class MessageListSuccess extends MessageListLoadState {
  final List<Message> msglist;
  final bool hasReachedMax;

  const MessageListSuccess({
    this.msglist,
    this.hasReachedMax
  });

  MessageListSuccess copyWith({
    List<Message> msglist,
    bool hasReachedMax
  }) {
    print('MessageListSuccess copyWith');
    return MessageListSuccess(
      msglist: msglist ?? this.msglist,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax
    );
  }
  
  @override
  List<Object> get props => [msglist, hasReachedMax];

  @override
  String toString() => 'MessageListSuccess {msglist: ${msglist.length}, hasReachedMax: $hasReachedMax}';
}

class MessageListError extends MessageListLoadState {
  final String error;

  MessageListError(this.error): super();

  @override
  String toString() => 'MessageListError {error: $error}';
}

class MessageListReload extends MessageListLoadState {
  @override
  String toString() => 'MessageListReload';
}

class MessageListAddMore extends MessageListLoadState {
  @override
  String toString() => 'MessageListAddMore';
}
