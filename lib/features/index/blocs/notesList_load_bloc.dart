import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:redbook/features/index/blocs/notesList_load_state.dart';
import 'package:redbook/features/index/blocs/notesList_load_event.dart';
import 'package:redbook/repositories/notes_repository/notes_repository.dart';

class NotesListLoadBloc extends Bloc<NotesListLoadEvent,NotesListLoadState>{
  NotesListRepostory notesListRepostory;
  NotesListLoadBloc({@required this.notesListRepostory});

  @override
  Stream<NotesListLoadState> transformEvents(
    Stream<NotesListLoadEvent> events,
    Stream<NotesListLoadState>Function(NotesListLoadEvent event) next,
  ){
    return super.transformEvents(
      events,
      next,);
  }

  @override
  NotesListLoadState get initialState => NotesListEmpty();

  @override
  Stream<NotesListLoadState> mapEventToState(NotesListLoadEvent event) async* {
    final currentState = state;
    if(event is Fetch && !_hasReachedMax(currentState)) {
      yield* _mapFetchEventToState(event);
    }
    if(event is Reload && !_hasReachedMax(currentState)) {
      yield* _mapReLoadEventToState(event);
    }
  }

  Stream<NotesListLoadState> _mapFetchEventToState(Fetch event) async* {
    try{
      if(state is NotesListEmpty) {
        final notes = await notesListRepostory.getNotesList();
        yield NotesListSuccess(noteslist: notes, hasReachedMax: false);
        return;
      }
      if(state is NotesListSuccess){
        NotesListSuccess successState = state;
        final notes = await notesListRepostory.getNotesList();
        if(notes.isEmpty) {
          yield successState.copyWith(hasReachedMax: true);
        }else{
          yield NotesListSuccess(noteslist: successState.noteslist + notes, hasReachedMax: false);
        }
      }
    }catch(e){
      yield NotesListError(e);
    }
  }

  Stream<NotesListLoadState> _mapReLoadEventToState(Reload event) async* {
    final notes = await notesListRepostory.getNotesList();
    yield NotesListSuccess(noteslist: notes, hasReachedMax: false);
  }

  bool _hasReachedMax(NotesListLoadState state) => state is NotesListSuccess && state.hasReachedMax;


}
