import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:orario/presentation/home/main/current_widget/current_widget.dart';
import 'package:orario/domain/bloc/home/current_tile/current_tile_domain.dart';

class LessonCardContainer extends StatefulWidget {
  const LessonCardContainer({Key key}) : super(key: key);

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
            itemBuilder: (BuildContext context, int index) {
              return LessonCard(
                lesson: state.lessons[index],
              );
            },
          );
        }
        if (state is CurrentTileLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CurrentTileNoLessons) {
          return const Center(child: Text('Пар нет!'));
        }
        return const Center(child: Text('Произошла ошибка'));
      }),
    );
  }
}
