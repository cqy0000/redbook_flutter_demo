import 'package:equatable/equatable.dart';

abstract class NotesListLoadEvent extends Equatable {
  const NotesListLoadEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends NotesListLoadEvent{
  @override
  String toString() => 'Fetch';
}

class Reload extends NotesListLoadEvent{
  @override
  String toString() => 'Reload';
}

class AddMore extends NotesListLoadEvent{
  @override
  String toString() => 'AddMore';
}