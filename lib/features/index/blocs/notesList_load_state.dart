import 'package:equatable/equatable.dart';
import 'package:redbook/repositories/notes_repository/models/notes_model.dart';

abstract class NotesListLoadState extends Equatable {
  const NotesListLoadState();

  @override
  List<Object> get props => [];
}

class NotesListEmpty extends NotesListLoadState {
  @override
  String toString() => 'NotesListEmpty';
}

class NotesListLoading extends NotesListLoadState {
  @override
  String toString() => 'NotesListLoading';
}

class NotesListSuccess extends NotesListLoadState {
  final List<Notes> noteslist;
  final bool hasReachedMax;

  const NotesListSuccess({
    this.noteslist,
    this.hasReachedMax
  });

  NotesListSuccess copyWith({
    List<Notes> noteslist,
    bool hasReachedMax
  }) {
    print('NotesListSuccess copyWith');
    return NotesListSuccess(
      noteslist: noteslist ?? this.noteslist,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax
    );
  }

  @override
  List<Object> get props => [noteslist, hasReachedMax];

  @override
  String toString() => 'NotesListSuccess {noteslist: ${noteslist.length}, hasReachedMax: $hasReachedMax}';
}

class NotesListError extends NotesListLoadState {
  final String error;

  NotesListError(this.error): super();

  @override
  String toString() => 'NotesListError {error: $error}';
}

class NotesListReload extends NotesListLoadState {
  @override
  String toString() => 'NotesListReload';
}

class NotesListAddMore extends NotesListLoadState {
  @override
  String toString() => 'NotesListAddMore';
}