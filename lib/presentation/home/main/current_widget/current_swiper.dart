import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:orario/domain/bloc/home/current_tile/current_tile_bloc.dart';
import 'package:orario/domain/bloc/home/current_tile/current_tile_event.dart';
import 'package:orario/domain/bloc/home/current_tile/current_tile_state.dart';
import 'package:orario/presentation/home/main/current_widget/current_widget.dart';

class LessonCardContainer extends StatefulWidget {
  LessonCardContainer({Key key}) : super(key: key);

  @override
  _LessonCardContainerState createState() => _LessonCardContainerState();
}

class _LessonCardContainerState extends State<LessonCardContainer> {
  CurrentTileBloc bloc;

  @override
  void initState() {
    bloc = CurrentTileBloc();
    bloc.add(CurrentTileOpened());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => bloc,
      child: BlocBuilder<CurrentTileBloc, CurrentTileState>(
          builder: (context, state) {
        if (state is CurrentTileLoaded) {
          return Swiper(
            index: state.currentLesson,
            scrollDirection: Axis.vertical,
            loop: false,
            itemCount: state.lessons.length,
            control: null,
            itemBuilder: (BuildContext context, int index) {
              return LessonCard(
                lesson: state.lessons[index],
              );
            },
          );
        }
        if (state is CurrentTileLoading) {
          return CircularProgressIndicator();
        }
        if (state is CurrentTileNoLessons) {
          return Text('No lessons');
        }
        return Text('error');
      }),
    );
  }
}
