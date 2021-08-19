import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_initiative_club_app/features/Maps/domain/entities/maps_data.dart';
import 'package:project_initiative_club_app/features/Maps/presentation/blocs/maps_data/mapsdata_bloc.dart';
import 'package:project_initiative_club_app/features/Maps/presentation/widgets/filter_button.dart';
import 'package:project_initiative_club_app/features/Maps/presentation/widgets/info_widget.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';

// ignore: must_be_immutable
class MapsWidget extends StatefulWidget {
  List<int> currentFiltringCode;
  final Polyline polyline;
  MapsWidget(
      {Key? key, required this.polyline, required this.currentFiltringCode})
      : super(key: key);

  @override
  _MapsWidgetState createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  late PageController _pageController;
  late GoogleMapController _controller;
  int prevPage = 1;
  List<MapsDataEntity> currentFiltredList = [];
  CameraPosition _initialPosition =
      CameraPosition(zoom: 14.5, target: LatLng(36.7121668, 3.1802495));
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  String departValue = "";
  String destinationValue = "";

  List<MapsDataEntity> getFiltredList() {
    List<MapsDataEntity> list = [];
    markers.clear();

    listMapData.forEach((element) {
      if (widget.currentFiltringCode.contains(element.type)) {
        MarkerId id = MarkerId(element.title);
        InfoWindow info =
            InfoWindow(snippet: element.title, title: element.title);

        BitmapDescriptor icon = iconOther;
        print(element.type.toString());
        switch (element.type) {
          case 0:
            icon = iconFood;
            break;
          case 1:
            icon = iconEntry;
            break;
          case 2:
            icon = iconFaculty;
            break;
          case 3:
            icon = iconAdminsitration;
            break;
          case 4:
            icon = iconOther;
            break;
        }

        markers[id] = Marker(
            icon: icon,
            infoWindow: info,
            markerId: id,
            position: element.position);

        list.add(element);
      }
    });

    currentFiltredList = list;
    return list;
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  void _onScroll() {
    if (_pageController.page!.toInt() != prevPage) {
      prevPage = _pageController.page!.toInt();
      moveCamera();
    }
  }

  void _onMapCreated(controller) async {
    setState(() async {
      _controller = controller;
      await _controller.setMapStyle(mapStyle);
    });
  }

  void moveCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: currentFiltredList[_pageController.page!.toInt()].position,
        zoom: 17.0,
        bearing: 45.0,
        tilt: 45.0)));

    setState(() {
      MarkerId id = MarkerId("marker");
      InfoWindow info = InfoWindow(
          snippet: currentFiltredList[_pageController.page!.toInt()].title);
      markers[id] = Marker(
          consumeTapEvents: false,
          infoWindow: info,
          markerId: id,
          position: currentFiltredList[_pageController.page!.toInt()].position);
    });
  }

  Widget _buildingList(int index) {
    return AnimatedBuilder(
        animation: _pageController,
        builder: (BuildContext context, Widget? widget) {
          double value = 1;
          if (_pageController.position.haveDimensions) {
            value = _pageController.page! - index;
            value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
          }

          return Center(
            child: SizedBox(
              height: Curves.easeInOut.transform(value) * 125.0,
              width: Curves.easeInOut.transform(value) * 350.0,
              child: widget,
            ),
          );
        },
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          InfoWidget(entity: currentFiltredList[index])));
            },
            child: Stack(children: [
              Center(
                  child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 20.0,
                      ),
                      height: 125.0,
                      width: 275.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              offset: Offset(0.0, 4.0),
                              blurRadius: 10.0,
                            ),
                          ]),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white),
                          child: Row(children: [
                            // Image Container
                            Container(
                                height: 90.0,
                                width: 90.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10.0),
                                        topLeft: Radius.circular(10.0)),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            currentFiltredList[index]
                                                .images[0]),
                                        fit: BoxFit.cover))),
                            SizedBox(width: 5.0),
                            Flexible(
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentFiltredList[index].title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 12.5,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      width: 170.0,
                                      child: Text(
                                        currentFiltredList[index].description,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    )
                                  ]),
                            )
                          ]))))
            ])));
  }

  @override
  Widget build(BuildContext context) {
    Map<String, MapsDataEntity> mapsData = {};
    currentFiltredList = getFiltredList();

    if (currentFiltredList.isNotEmpty) {
      mapsData = Map.fromIterable(
        currentFiltredList,
        key: (element) => element.title,
        value: (element) => element,
      );
    } else {
      mapsData = {
        "Activer le fitre voulu": MapsDataEntity(
            type: 9,
            description: "d",
            title: "r",
            position: LatLng(0, 0),
            images: [""])
      };
    }

    departValue =
        mapsData.isNotEmpty ? mapsData.keys.first : "Activer le fitre voulu";
    destinationValue =
        mapsData.isNotEmpty ? mapsData.keys.last : "Activer le fitre voulu";

    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    return Stack(alignment: Alignment.center, children: [
      Container(
        height: screenH - 50,
        width: screenW,
        child: GoogleMap(
          markers: Set<Marker>.of(markers.values),
          onMapCreated: _onMapCreated,
          initialCameraPosition: _initialPosition,
          myLocationEnabled: true,
          mapType: MapType.hybrid,
          polylines: Set<Polyline>.of([widget.polyline]),
        ),
      ),

      // List des Batiments
      Positioned(
        bottom: 20.0,
        child: Container(
          height: 200.0,
          width: MediaQuery.of(context).size.width,
          child: PageView.builder(
            controller: _pageController,
            itemCount: currentFiltredList.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildingList(index);
            },
          ),
        ),
      ),
      // Filtre des Informations

      Positioned(
          top: 60,
          child: FilterButtonWidget(
            filterFunction: modifyFilter,
          )),

      //Boutton des itineéraires
      Positioned(
        top: 20,
        height: 30,
        child: ElevatedButton(
          onPressed: () => showDialog<String>(
              context: context,
              builder: (falseContext) {
                return StatefulBuilder(builder: (falseContext, setState) {
                  return AlertDialog(
                    title: const Text('Choisissez votre itinéraire'),
                    content: Column(
                      children: [
                        DropdownButton<String>(
                          value: departValue,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              departValue = newValue!;
                            });
                          },
                          items: mapsData.keys
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        DropdownButton<String>(
                          value: destinationValue,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              destinationValue = newValue!;
                            });
                          },
                          items: mapsData.keys
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, "Cancel");
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, "Let's Go");
                          BlocProvider.of<MapsdataBloc>(context)
                              .add(ItineraryEvent(positionList: {
                            departValue + destinationValue: [
                              mapsData[departValue]!.position,
                              mapsData[destinationValue]!.position
                            ]
                          }));
                        },
                        child: const Text("Let's Go"),
                      ),
                    ],
                  );
                });
              }),
          child: Text('Créer un itinéraire'),
        ),
      )
    ]);
  }

  void modifyFilter(int index) {
    setState(() {
      if (widget.currentFiltringCode.contains(index)) {
        widget.currentFiltringCode.remove(index);
      } else {
        widget.currentFiltringCode.add(index);
      }
    });
  }

  Widget dropDownMenu(
      Map<String, MapsDataEntity> mapsData, bool first, Function _function) {
    first
        ? departValue = mapsData.keys.first
        : destinationValue = mapsData.keys.last;
    return DropdownButton<String>(
      value: first ? departValue : destinationValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        _function(() {
          first ? departValue = newValue! : destinationValue = newValue!;
        });
      },
      items: mapsData.keys.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
