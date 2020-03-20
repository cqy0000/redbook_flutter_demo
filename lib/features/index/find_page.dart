import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:redbook/features/index/blocs/bloc.dart';
import 'package:redbook/features/index/notes_details_page.dart';
import 'package:redbook/widgets/notes_card.dart';
import 'package:redbook/repositories/notes_repository/models/notes_model.dart';

class FindPage extends StatefulWidget {
  final String labelId;
  const FindPage({Key key, this.labelId}): super(key: key);

  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> with AutomaticKeepAliveClientMixin {
  List notesList;
  NotesListLoadBloc _notesListLoadBloc;
  EasyRefreshController _controller;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _notesListLoadBloc = BlocProvider.of<NotesListLoadBloc>(context);
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<NotesListLoadBloc, NotesListLoadState>(
      bloc:_notesListLoadBloc,
      builder: (context, state) {
        if(state is NotesListError) {
          return Center(child: Text('加载失败，请稍后再试！'));
        }
        if(state is NotesListSuccess){
          if(state.noteslist.isEmpty){
            return Center(child: Text('没有数据'));
          }
          notesList = state.noteslist;
          _controller.finishLoad();
          return _buildContent();
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildContent(){
    return EasyRefresh(
        enableControlFinishRefresh: false,
        enableControlFinishLoad: true,
        controller: _controller,
        header: ClassicalHeader(),
        footer: ClassicalFooter(),
        onRefresh: () async {
          _notesListLoadBloc.add(Reload());
          _controller.resetLoadState();
        },
        onLoad: () async {
          _notesListLoadBloc.add(Fetch());
        },
        child: new StaggeredGridView.countBuilder(
          primary: false,
          itemCount: (this.notesList != null && this.notesList.length > 0) ? this.notesList.length : 0,
          crossAxisCount: 4,
          itemBuilder: (BuildContext context, int index) => _buildItem(notesList[index]),
          staggeredTileBuilder: (int index) =>
              new StaggeredTile.fit(2),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
      );
  }

  Widget _buildItem(Notes item) {
    return new GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NotesDetailsPage(noteId: item.notesId.toString())
          )
        );
      },
      child: NotesCard(note: item)
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
}