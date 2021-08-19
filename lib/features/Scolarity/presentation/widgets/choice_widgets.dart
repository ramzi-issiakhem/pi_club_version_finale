import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:project_initiative_club_app/features/Scolarity/domain/entities/scolarity_entity.dart';
import 'package:project_initiative_club_app/features/Scolarity/presentation/blocs/scolarity_bloc.dart';
import 'package:project_initiative_club_app/injections.dart';
import 'package:project_initiative_club_app/ressources/widgets/error.dart';
import 'package:project_initiative_club_app/ressources/widgets/loading.dart';

class ScolarityChoiceWidget extends StatefulWidget {
  const ScolarityChoiceWidget({Key? key}) : super(key: key);

  @override
  _ScolarityChoiceWidgetState createState() => _ScolarityChoiceWidgetState();
}

late ScolarityEntity currentEntity;
late Map<String, ScolarityEntity> scolarityEntities;

class _ScolarityChoiceWidgetState extends State<ScolarityChoiceWidget> {
  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;

    return BlocProvider<ScolarityBloc>(
        create: (_context) => sl<ScolarityBloc>(),
        child: BlocBuilder<ScolarityBloc, ScolarityState>(
          builder: (context, state) {
            if (state is Empty) {
              BlocProvider.of<ScolarityBloc>(context).add(InitEvent());

              return Container();
            } else if (state is Loading) {
              return LoadingWidget();
            } else if (state is Loaded) {
              scolarityEntities = state.scolarityEntities;
              ScolarityEntity? temp = scolarityEntities["MI"];
              if (temp != null) {
                currentEntity = temp;
              }
              return body(screenW);
            } else if (state is Error) {
              return ErrorPage(message: state.message);
            }
            return Container();
          },
        ));
  }

  Widget body(double screenW) {
    return SizedBox(
      width: screenW,
      height: 75,
      child: Column(
        children: [
          Row(
            children: [
              _btn("MI"),
              _btn("ST"),
              _btn("GAT"),
              _btn("SMV"),
              _btn("Biologie")
            ],
          ),
          Container(
            child: Center(
              child: _containerWidget(currentEntity),
            ),
          )
        ],
      ),
    );
  }

  String _getMarkDown(ScolarityEntity scolarityEntity) {
    return (scolarityEntity.specialities.map((e) => "<li> $e </li>")).join();
  }

  Widget _containerWidget(ScolarityEntity scolarityEntity) {
    return Column(children: [
      Text(scolarityEntity.title),
      Text(scolarityEntity.description),
      Markdown(
        data: _getMarkDown(scolarityEntity),
      )
    ]);
  }

  Widget _btn(String title) {
    return TextButton(
      onPressed: () {
        setState(() {
          ScolarityEntity? temp = scolarityEntities[title];
          if (temp != null) {
            currentEntity = temp;
          }
        });
      },
      child: Text(title),
    );
  }
}
