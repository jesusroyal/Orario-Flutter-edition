import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orario/domain/bloc/home/home_tomorrow_list/home_tomorrow_list_bloc.dart';
import 'package:orario/domain/bloc/home/home_tomorrow_list/home_tomorrow_list_event.dart';
import 'package:orario/domain/bloc/home/home_tomorrow_list/home_tomorrow_list_state.dart';
import 'package:orario/presentation/home/main/tomorrow_widget/tomorrow_tile.dart';

class HomeTomorrowListWidget extends StatefulWidget {
  @override
  _HomeTomorrowListWidgetState createState() => _HomeTomorrowListWidgetState();
}

class _HomeTomorrowListWidgetState extends State<HomeTomorrowListWidget> {
  HomeTomorrowListBloc bloc;
  @override
  void initState() {
    bloc = HomeTomorrowListBloc();
    bloc.add(HomeTomorrowListOpened());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        lazy: false,
        create: (_) => bloc,
        child: BlocBuilder<HomeTomorrowListBloc, HomeTomorrowListState>(
          builder: (context, state) {
            if (state is HomeTomorrowListLoading) {
              return CircularProgressIndicator();
            }
            if (state is HomeTomorrowListNoLessons) {
              return Center(
                child: Text('Завтра выходной!'),
              );
            }
            if (state is HomeTomorrowListLoaded) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.lessons.length,
                  itemBuilder: (context, index) {
                    return TomorrowTile(lessonPair: state.lessons[index]);
                  });
            }
            return Text('Something went wrong');
          },
        ));
  }
}
