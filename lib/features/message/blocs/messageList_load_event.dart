import 'package:equatable/equatable.dart';

abstract class MessageListLoadEvent extends Equatable{
  const MessageListLoadEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends MessageListLoadEvent{
  @override
  String toString() => 'Fetch';
}

class Reload extends MessageListLoadEvent{
  @override
  String toString() => 'Reload';
}

class AddMore extends MessageListLoadEvent{
  @override
  String toString() => 'AddMore';
}