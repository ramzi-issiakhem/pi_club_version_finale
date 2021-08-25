import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_initiative_club_app/features/News/domain/entities/newsEntity.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/edit_news_usecase.dart';
import 'package:project_initiative_club_app/features/News/presentation/blocs/news/newsbloc_bloc.dart';
import 'package:project_initiative_club_app/injections.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';
import 'package:project_initiative_club_app/ressources/widgets/error.dart';
import 'package:project_initiative_club_app/ressources/widgets/loading.dart';
import 'package:select_form_field/select_form_field.dart';

class EditPage extends StatelessWidget {
  final int type;
  final NewsEntity news;
  const EditPage({Key? key, required this.news, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsblocBloc>(
        create: (_context) => sl<NewsblocBloc>(),
        child:
            BlocBuilder<NewsblocBloc, NewsblocState>(builder: (context, state) {
          if (state is Loading) {
            return LoadingWidget();
          } else if (state is LoadedEditForm) {
            Navigator.of(context).pop();
          } else if (state is Error) {
            return ErrorPage(message: state.message);
          }
          return EditPageWidget(news: news, type: type);
        }));
  }
}

// ignore: must_be_immutable
class EditPageWidget extends StatefulWidget {
  int type;
  final NewsEntity news;
  EditPageWidget({Key? key, required this.news, required this.type})
      : super(key: key);

  @override
  _EditPageWidgetState createState() => _EditPageWidgetState();
}

class _EditPageWidgetState extends State<EditPageWidget> {
  File coverImage = File("null");
  File imageone = File("null");
  File imagetwo = File("null");
  File imagethree = File("null");

  String valueDropDown = "club";
  bool isDone = false;
  @override
  void initState() {
    if (widget.type == 0) {
      valueDropDown = "club";
    } else {
      valueDropDown = "usthb";
    }
    _getImage();

    super.initState();
  }

  List<File> images = [];

  double maxHeight = 1800;

  double maxWidth = 1800;

  List<Map<String, dynamic>> entries = [
    {'value': "club", 'label': "News de club", 'icon': Icon(Icons.lightbulb)},
    {'value': "usthb", 'label': "News de l'USTHB", 'icon': Icon(Icons.school)}
  ];

  final _formKey = GlobalKey<FormState>();
  int type = 0;
  String title = "";

  String description = "";
  int ind = 0;
  @override
  Widget build(BuildContext context) {
    if (isDone) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: mainColor,
          title: Row(
            children: [
              Text(
                "Edit news",
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.90,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _getCoverImageFromGallery();
                          },
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            padding: EdgeInsets.only(right: 10),
                            foregroundDecoration: BoxDecoration(),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border(
                                top: BorderSide(width: 2, color: mainColor),
                                left: BorderSide(width: 2, color: mainColor),
                                right: BorderSide(width: 2, color: mainColor),
                                bottom: BorderSide(width: 2, color: mainColor),
                              ),
                            ),
                            child: coverImage.path == "null"
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.image,
                                          size: 40, color: mainColor),
                                      Text("Cover image"),
                                    ],
                                  )
                                : Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: FittedBox(
                                            fit: BoxFit.fill,
                                            child: Image.file(coverImage)),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 110,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    child: GestureDetector(
                                      onTap: () {
                                        _getImageOneFromGallery();
                                      },
                                      child: Container(
                                        foregroundDecoration: BoxDecoration(),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border(
                                            top: BorderSide(
                                                width: 2, color: mainColor),
                                            left: BorderSide(
                                                width: 2, color: mainColor),
                                            right: BorderSide(
                                                width: 2, color: mainColor),
                                            bottom: BorderSide(
                                                width: 2, color: mainColor),
                                          ),
                                        ),
                                        child: imageone.path == "null"
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.image,
                                                      size: 40,
                                                      color: mainColor),
                                                  Text("Cover image"),
                                                ],
                                              )
                                            : Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: FittedBox(
                                                        fit: BoxFit.fill,
                                                        child: Image.file(
                                                            imageone)),
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    child: GestureDetector(
                                      onTap: () {
                                        _getImageTwoFromGallery();
                                      },
                                      child: Container(
                                        foregroundDecoration: BoxDecoration(),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border(
                                            top: BorderSide(
                                                width: 2, color: mainColor),
                                            left: BorderSide(
                                                width: 2, color: mainColor),
                                            right: BorderSide(
                                                width: 2, color: mainColor),
                                            bottom: BorderSide(
                                                width: 2, color: mainColor),
                                          ),
                                        ),
                                        child: imagetwo.path == "null"
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.image,
                                                      size: 40,
                                                      color: mainColor),
                                                  Text("Cover image"),
                                                ],
                                              )
                                            : Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: FittedBox(
                                                        fit: BoxFit.fill,
                                                        child: Image.file(
                                                            imagetwo)),
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    child: GestureDetector(
                                      onTap: () {
                                        _getImageThreeFromGallery();
                                      },
                                      child: Container(
                                        foregroundDecoration: BoxDecoration(),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border(
                                            top: BorderSide(
                                                width: 2, color: mainColor),
                                            left: BorderSide(
                                                width: 2, color: mainColor),
                                            right: BorderSide(
                                                width: 2, color: mainColor),
                                            bottom: BorderSide(
                                                width: 2, color: mainColor),
                                          ),
                                        ),
                                        child: imagethree.path == "null"
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.image,
                                                      size: 40,
                                                      color: mainColor),
                                                  Text("Cover image"),
                                                ],
                                              )
                                            : Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: FittedBox(
                                                        fit: BoxFit.fill,
                                                        child: Image.file(
                                                            imagethree)),
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        SelectFormField(
                          type:
                              SelectFormFieldType.dropdown, // or can be dialog
                          initialValue: valueDropDown,
                          icon: Icon(Icons.new_releases_sharp),
                          labelText: 'Type de News',
                          items: entries,
                          onChanged: (val) {
                            setState(() {
                              if (val == "club") {
                                type = 0;
                              } else if (val == "usthb") {
                                type = 1;
                              }
                            });
                          },
                        ),
                        TextFormField(
                          initialValue: widget.news.title,
                          decoration: InputDecoration(
                              icon: Icon(Icons.title), labelText: "Titre"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Veuillez écrire une donnée valide";
                            }
                            title = value;
                            return null;
                          },
                        ),
                        TextFormField(
                          initialValue: widget.news.description,
                          decoration: InputDecoration(
                              icon: Icon(Icons.description_outlined),
                              labelText: "Description"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Veuillez écrire une donnée valide";
                            }
                            description = value;
                            return null;
                          },
                        ),
                        Container(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: FloatingActionButton(
                            backgroundColor: mainColor,
                            onPressed: () {
                              // Validate returns true if the form is valid, or false otherwise.

                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      duration: Duration(seconds: 2),
                                      content: Text('Editing News ...')),
                                );

                                BlocProvider.of<NewsblocBloc>(context).add(
                                    EditForm(
                                        params: EditNewsParam(
                                            ancientType: widget.type,
                                            uid: widget.news.uid,
                                            likes: widget.news.likes,
                                            title: title,
                                            description: description,
                                            coverImage: coverImage,
                                            images: [
                                              imageone,
                                              imagetwo,
                                              imagethree
                                            ],
                                            type: type)));
                              }
                            },
                            child: const Icon(Icons.send),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return LoadingWidget();
    }
  }

  _getCoverImageFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: 75);

    if (pickedFile != null) {
      setState(() {
        coverImage = File(pickedFile.path);
      });
    }
  }

  _getImageOneFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: 75);

    if (pickedFile != null) {
      setState(() {
        imageone = File(pickedFile.path);
      });
    }
  }

  _getImageTwoFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: 75);

    if (pickedFile != null) {
      setState(() {
        imagetwo = File(pickedFile.path);
      });
    }
  }

  _getImageThreeFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: 75);

    if (pickedFile != null) {
      setState(() {
        imagethree = File(pickedFile.path);
      });
    }
  }

  Future<File> _getFileFromUrl(String path, String filename) async {
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(path));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  Future<bool> _getImage() async {
    coverImage = await _getFileFromUrl(
        widget.news.coverImage, 'cover' + widget.news.uid + widget.news.title);
    if (widget.news.images.length > 0) {
      imageone = await _getFileFromUrl(widget.news.images[0],
          'image 1' + widget.news.uid + widget.news.title);
    } else if (widget.news.images.length > 1) {
      imagetwo = await _getFileFromUrl(widget.news.images[1],
          'image 2' + widget.news.uid + widget.news.title);
    } else if (widget.news.images.length > 2) {
      imagethree = await _getFileFromUrl(widget.news.images[2],
          'image 3' + widget.news.uid + widget.news.title);
    }

    setState(() {
      isDone = true;
    });
    return true;
  }
}
