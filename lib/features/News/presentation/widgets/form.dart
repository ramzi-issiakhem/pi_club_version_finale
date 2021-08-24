import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/add_news_usecase.dart';
import 'package:project_initiative_club_app/features/News/presentation/blocs/news/newsbloc_bloc.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';

class FormWidget extends StatefulWidget {
  FormWidget({Key? key}) : super(key: key);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  late File coverImage = File("null");
  late File imageone = File("null");
  late File imagetwo = File("null");
  late File imagethree = File("null");
  List<File> images = [];

  double maxHeight = 1800;

  double maxWidth = 1800;

  List<Map<String, dynamic>> entries = [
    {'value': "club", 'label': "News de club", 'icon': Icon(Icons.lightbulb)},
    {'value': "usthb", 'label': "News de l'USTHB", 'icon': Icon(Icons.school)}
  ];

  final _formKey = GlobalKey<FormState>();
  int type = 0;
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  int ind = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: mainColor,
        title: Row(
          children: [
            Text(
              "Add news",
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
                                width: MediaQuery.of(context).size.width * 0.3,
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
                                        borderRadius: BorderRadius.circular(20),
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
                                                    size: 40, color: mainColor),
                                                Text("Cover image"),
                                              ],
                                            )
                                          : Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: FittedBox(
                                                      fit: BoxFit.fill,
                                                      child:
                                                          Image.file(imageone)),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
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
                                        borderRadius: BorderRadius.circular(20),
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
                                                    size: 40, color: mainColor),
                                                Text("Cover image"),
                                              ],
                                            )
                                          : Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: FittedBox(
                                                      fit: BoxFit.fill,
                                                      child:
                                                          Image.file(imagetwo)),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
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
                                        borderRadius: BorderRadius.circular(20),
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
                                                    size: 40, color: mainColor),
                                                Text("Cover image"),
                                              ],
                                            )
                                          : Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
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
                        type: SelectFormFieldType.dropdown, // or can be dialog
                        initialValue: "club",
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
                        controller: titleController,
                        decoration: InputDecoration(
                            icon: Icon(Icons.title), labelText: "Titre"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Veuillez écrire une donnée valide";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                            icon: Icon(Icons.description_outlined),
                            labelText: "Description"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Veuillez écrire une donnée valide";
                          }
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
                              /*ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          duration: Duration(seconds: 2),
                                          content: Text('posting news')),
                                    );*/

                              Navigator.of(context).pop();
                              AddNewsParam param = AddNewsParam(
                                type: type,
                                coverImage: coverImage,
                                lastModification: DateTime.now(),
                                images: [imageone, imagetwo, imagethree],
                                title: titleController.text,
                                description: titleController.text,
                                likes: 0,
                              );
                              BlocProvider.of<NewsblocBloc>(context)
                                  .add(FormEvent(param: param));
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

  _getListImageFromGallery() async {
    List<File> _images = [];
    List<XFile>? pickedFiles = [];
    pickedFiles = await ImagePicker().pickMultiImage(
      imageQuality: 75,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
    );

    if (pickedFiles != null) {
      pickedFiles.forEach((element) {
        setState(() {
          ind++;
        });

        _images.add(File(element.path));
      });

      setState(() {
        images = _images;
      });
    }
  }
/*
  _getListImageFromGallery() async {
    List<File> _images = [];
    List<XFile>? pickedFiles = [];
    pickedFiles = await ImagePicker().pickMultiImage(
      imageQuality: 75,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
    );

    if (pickedFiles != null) {
      pickedFiles.forEach((element) {
        setState(() {
          ind++;
        });

        _images.add(File(element.path));
      });

      setState(() {
        images = _images;
      });
    }
  }*/
}
