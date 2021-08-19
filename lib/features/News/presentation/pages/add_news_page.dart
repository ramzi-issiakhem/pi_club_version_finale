import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_initiative_club_app/features/News/presentation/blocs/news/newsbloc_bloc.dart';
import 'package:project_initiative_club_app/features/News/presentation/widgets/form.dart';
import 'package:project_initiative_club_app/injections.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';
import 'package:project_initiative_club_app/ressources/widgets/loading.dart';

class AddNewsPage extends StatelessWidget {
  AddNewsPage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return BlocProvider<NewsblocBloc>(
        create: (_context) => sl<NewsblocBloc>(),
        child:
            BlocBuilder<NewsblocBloc, NewsblocState>(builder: (context, state) {
          if (state is EmptyUsthb) {
            return FormWidget();
          } else if (state is Loading) {
            return LoadingWidget();
          } else if (state is LoadedForm) {
            mainClass.rebuild("news");
            return Container();
          } else if (state is Error) {
            return Center(
              child: Container(
                child: Text("error"),
              ),
            );
          }
          return Container();
        }));
  }
}
