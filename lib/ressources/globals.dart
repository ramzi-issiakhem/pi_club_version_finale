import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_initiative_club_app/features/About%20Us/presentation/pages/about_us_page_1.dart';
import 'package:project_initiative_club_app/features/Maps/domain/entities/maps_data.dart';
import 'package:project_initiative_club_app/features/Maps/presentation/pages/page_maps.dart';
import 'package:project_initiative_club_app/features/News/presentation/pages/add_news_page.dart';
import 'package:project_initiative_club_app/features/News/presentation/pages/news_page.dart';
import 'package:project_initiative_club_app/features/News/presentation/widgets/pi_news.dart';
import 'package:project_initiative_club_app/features/News/presentation/widgets/usthb_news.dart';
import 'package:project_initiative_club_app/features/Scolarity/presentation/pages/scolarity_page.dart';
import 'package:project_initiative_club_app/main_class.dart';
import 'package:project_initiative_club_app/features/Contact/pages/Contact.dart';

List<MapsDataEntity> listMapData = [];
String currentTitle = "Project Initiative";
Map<String, dynamic> jsonData = {};
double barHeight = 60;

List<bool> statesFilters = [false, false, false, false, false, false];
List<dynamic> scolarityData = [
  [
    "Math&Info",
    "La spécialité sert à approfondir les connaissances des étudiants en mathématiques et informatiques ",
    " Algo1 | Analyse1 | Algèbre 1 ",
    "- MP(Mécanique de point) | -CRI(codification et représentation de l'information)",
    "TCE, langue étrangère (Français) ",
    "Algo2, Analyse2, Algèbre2 ",
    "électricité ",
    "Transversale: Bureautique , histoire des sciences ",
    "Secondaire: Stat,OPM(outils programmation mathématiques ),strm (structure machine)/ ",
    " ISIL\n\n:\n\nLicence Ingénierie des Systèmes d’Information et des Logiciels / \n\nACAD:\n\nLicence Informatique Académique /\n\nGTR \n\n:Licence Génie des Télécommunications et Réseaux  / \n\nRO:\n\nLicence Recherche Opérationnelle / \n\nStat:\n\nLicence Ingénierie Statistique / \n\nAlg,crypt:\n\nLicence d’Algèbre etCryptographie /\n\nMATH:\n\nLicence Mathématiques",
    "Faculté d'Informatiques"
  ],
  [
    "ST",
    "Une spécialité qui tourne au tour de la science exacte et la technologie elle-meme",
    "Math 1,PHYS 1 ,CHIM 1",
    "Dec1",
    "TCE1 , langue étrangère",
    "TP PHYS1 ,TP CHIM1 ,BUREAUTIQUE1",
    "MATH 2,PHYS 2,CHIM 2",
    "Dec2",
    "TCE2",
    " TP PHYS2,TP CHIM2,TP bureautique",
    "\n\nLicence Electronique \n\nLicence Télécommunication \n\nLicence Automatisme \n\nLicence Electrotechnique \n\nLicence Mécanique Energétique \n\nLicence Ingénieries des Systèmes de Mécaniques (Faculté de Génie Mécanique et Génie de Procédés ) \n\nLicence Mécanique de Construction (Faculté de Génie Mécanique et Génie de Procédés)\n\nLicence Génie des Matériaux (Faculté de Génie Mécanique et Génie de Procédés \n\nLicence Analyse Physico-chimique et Mécanique des Matériaux  (Faculté de Génie Mécanique et Génie de Procédés ) \n\nLicence Mécanique et Énergétique \n\nLicence Génie Alimentaire \n\nLicence Génie d’Environnement  \n\nLicence Génie Pharmaceutique \n\nLicence Raffinage et Pétrochimie (Faculté de Génie Mécanique et Génie de Procédés) \n\nLicence de Génie Chimique (Faculté de Génie Mécanique et Génie de Procédés ) \n\nLicence Froid et Cryogénie (Faculté de Génie Mécanique et Génie de Procédés)  \n\nLicence en Génie Civil (Faculté de Génie Civil) \n\nLicence en Hydraulique (Faculté de Génie Civil)",
    "Faculté ..."
  ],
  [
    "Biologie",
    "séance de nature et vie est la science qui étudie et taxonomise tous les genres d' organismes vivants basés sur la chimie , la génétique , la cytologie , et les sciences de la microbiologie et bien plus encoreLe but de toutes ces études est d'entourer la discipline des organismes vivants dans des environnements écologiques, elle appartient à la faculté de la biologie",
    "BIOLOGIE CELLULAIRE | CHIMIE 1 | M.S.I(math statistiques informatique)",
    "DECOUVERTE(GEOLOGIE / PHYSIQUE) , TCE1 ",
    "METHODE TRAVAIL TERMINOLOGIE 1 | HISTOIRE UNIV | SCIENCES EXPER.",
    "BIOLOGIE ANIMALE GENERALE ,BIOLOGIE VEGETALE GENERALE,CHIMIE 2",
    "DECOUVERTE:GEOLOGIE / PHYSIQUE TCE2",
    "  /TRANSVERSAL:METHODE TRAVAIL TERMINOLOGIE ",
    "\n\nLicence Biologie, Physiologie et Génétique Végétales (BPGV) \n\nLicence Biologie du Développement (BD) \n\nLicence Ecologie et Environnement Marin (EEM) \n\nLicence Ecologie Végétale et Environnement (EVE) \n\nLicence de Biotechnologie et Santé (BS) \n\nLicence de Biochimie Fondamentale et Appliquée (BFA) \n\nLicence de Génétique Fondamentale et Appliquée (GFA) \n\nLicence de Microbiologie Fondamentale et Appliquée (MFA) \n\nLicence de Nutrition et Contrôle de Qualité et Analyse (NCA) \n\nLicence de Parasitologie et Microbiologie (PM)  \n\nLicence de Physiologie Intégrative Animale et Humaine (PIAH) \n\nLicence d'Ecologie Animale (EA)",
    "Faculté de Biologie FSB"
  ],
  [
    "SM",
    "science de la matière ou encore physique-chimie c'est une spécialitée qui se base comme l'indique son appelation sur ''la matière'' ,la chimie étudie la composition de la matière et  la physique étudie les états de la matière.  La licence en SM apporte une solide formation en physique et en chimie qui permet à son titulaire d’intégrer de nombreux secteurs: (environnement, industrie, matériaux, énergie.)  la  spécialité appartient à les faculté de physique et chimie ",
    " Math 1,PHYS 1 ,CHIM 1",
    " Dec1 ",
    "TCE1 , langue étrangère  ",
    " TP PHYS1 ,TP CHIM1 ,BUREAUTIQUE1 ",
    "MATH 2,PHYS 2,CHIM 2",
    "Dec2",
    "TCE2,",
    "TP PHYS2,TP CHIM2,TP bureautique ",
    "\n\nLicence de Physique (Faculté de Physique) \n\nLicence de Physique Appliquée : Energétique  (Faculté de Physique) \n\nLicence Chimie Fondamentale (Faculté de Chimie) \n\nLicence Géophysique (faculté des Science de la Terre, Géographie et Aménagement du Territoire).",
    "Faculté de SM"
  ],
];

String mapsStyle = "";

String googleApiKey = "AIzaSyCehlNhIUff2KRlwvc6h1W1NmyfGYjKY5U";

Map<int, String> mapFilter = {
  0: "Buvettes & Kiosques",
  1: "Entrées & Parkings",
  2: "Facultés & Classes",
  3: "Administration",
  4: "Autre",
  5: "Clubs"
};

//Color mainColor = Color(0xffEB5B25);
Color mainColor = Color(0xffff7e50);
Color secondColor = Color(0xff164C9C);
BitmapDescriptor iconAdminsitration = BitmapDescriptor.defaultMarkerWithHue(0);
BitmapDescriptor iconEntry = BitmapDescriptor.defaultMarkerWithHue(0);
BitmapDescriptor iconFood = BitmapDescriptor.defaultMarkerWithHue(0);
BitmapDescriptor iconFaculty = BitmapDescriptor.defaultMarkerWithHue(0);
BitmapDescriptor iconOther = BitmapDescriptor.defaultMarkerWithHue(0);
BitmapDescriptor iconClub = BitmapDescriptor.defaultMarkerWithHue(0);
var mapStyle = "";

Map<String, dynamic> polylinesJson = {};
Map<String, Polyline> routingDataBase = {};
late MainClass mainClass = MainClass();

Function restartFunction = () {};

Map<String, Widget> mapRoutes = {
  "about": AboutUsPageSecondary(),
  "map": MapsPage(),
  "news": NewsPage(),
  "contact": Contact_page(),
  "scolarity": ScolarityPage(),
  "usthbnews": UsthbNews(),
  "pinews": PiNews()
};
