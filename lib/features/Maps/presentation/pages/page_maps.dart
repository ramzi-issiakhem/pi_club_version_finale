import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_initiative_club_app/features/Maps/presentation/blocs/maps_data/mapsdata_bloc.dart';

import 'package:project_initiative_club_app/features/Maps/presentation/widgets/maps_widget.dart';
import 'package:project_initiative_club_app/injections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_initiative_club_app/ressources/widgets/error.dart';
import 'package:project_initiative_club_app/ressources/widgets/loading.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> currentFiltringCode = [];
    Polyline polyline = Polyline(polylineId: PolylineId("test"));

    return BlocProvider<MapsdataBloc>(
        create: (_context) => sl<MapsdataBloc>(),
        child: BlocBuilder<MapsdataBloc, MapsdataState>(
          builder: (context, state) {
            if (state is EmptyData) {
              BlocProvider.of<MapsdataBloc>(context).add(GetMapsDataEvent());

              return Container();
            } else if (state is Loading) {
              return LoadingWidget();
            } else if (state is MapsDataLoaded) {
              return MapsWidget(
                currentFiltringCode: currentFiltringCode,
                polyline: polyline,
              );
            } else if (state is ItineraryLoaded) {
              polyline = state.routes;
              return MapsWidget(
                  polyline: polyline, currentFiltringCode: currentFiltringCode);
            } else if (state is Error) {
              return ErrorPage(message: state.message);
            }
            return Container();
          },
        ));
  }
}
