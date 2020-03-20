import 'package:redbook/repositories/notes_repository/models/notes_model.dart';
import 'package:dio/dio.dart';

class NotesListRepostory {
  Future<List<Notes>> getNotesList() async{
    List<Notes> notes;
    var url = 'http://localhost:3000/notesList';
    try{
      Response res = await Dio().get(url);
      if(res.data != null){
        notes = res.data.map<Notes>((item){
          Notes note = Notes.fromJson(item);
          return note;
        }).toList();
      }
    } catch(e) {
      return new Future.error(e);
    }
    return notes;
  }
}