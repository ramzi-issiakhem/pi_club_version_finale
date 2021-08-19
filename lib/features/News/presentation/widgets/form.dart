import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_initiative_club_app/features/News/domain/usecases/add_news_usecase.dart';
import 'package:project_initiative_club_app/features/News/presentation/blocs/news/newsbloc_bloc.dart';
import 'package:select_form_field/select_form_field.dart';

class FormWidget extends StatefulWidget {
  FormWidget({Key? key}) : super(key: key);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  late File coverImage = File("null");

  List<File> images = [];

  double maxHeight = 1800;

  double maxWidth = 1800;

  List<Map<String, dynamic>> entries = [
    {'value': "club", 'label': "News de club", 'icon': Icon(Icons.ac_unit)},
    {'value': "usthb", 'label': "News de l'USTHB", 'icon': Icon(Icons.ac_unit)}
  ];

  final _formKey = GlobalKey<FormState>();
  int type = 0;
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SelectFormField(
            type: SelectFormFieldType.dropdown, // or can be dialog
            initialValue: "club",
            icon: Icon(Icons.format_shapes),
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
            decoration:
                InputDecoration(icon: Icon(Icons.title), labelText: "Titre"),
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
                icon: Icon(Icons.title), labelText: "Description"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Veuillez écrire une donnée valide";
              }
              return null;
            },
          ),
          coverImage.path == "null"
              ? Container()
              : Image.file(
                  coverImage,
                  width: 100,
                  height: 100,
                ),
          TextButton(
              onPressed: () {
                _getCoverImageFromGallery();
              },
              child: Text("Image de couverture (obligatoire)")),
          images.length == 0
              ? Container()
              : Image.file(
                  images[0],
                  width: 100,
                  height: 100,
                ),
          TextButton(
              onPressed: () {
                _getListImageFromGallery();
              },
              child: Text("Images (Non-Obligatoire)")),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text('Envoie du formulaire')),
                );
                AddNewsParam param = AddNewsParam(
                    type: type,
                    coverImage: coverImage,
                    lastModification: DateTime.now(),
                    images: images,
                    title: titleController.text,
                    description: titleController.text,
                    likes: 0);
                BlocProvider.of<NewsblocBloc>(context)
                    .add(FormEvent(param: param));
              }
            },
            child: const Text('Ajouter !'),
          ),
        ],
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
        _images.add(File(element.path));
      });

      setState(() {
        images = _images;
      });
    }
  }
}
