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

List<MapsDataEntity> listMapData = [];
String currentTitle = "Project Initiative";
Map<String, dynamic> jsonData = {};
double barHeight = 60;

List<bool> statesFilters = [false, false, false, false, false];
List<dynamic> scolarityData = [
  [
    "Math&Info",
    "MI: la spécialité sert à approfondir les connaissances des étudiants en mathématiques et informatiques  , le programme en 1ére annnée: Semestre 1:/  les modules fondamentaux   : Algo1 ,Analyse1 ,Algèbre 1 / Decouverte:MP(Mécanique de point),CRI(codification et représentation de l'information),Transversale :TCE, langue étrangère (Français) / Semestre 2:  les modules fondamentaux  : Algo2, Analyse2, Algèbre2 /  Decouverte: électricité / Secondaire: Stat,OPM(outils programmation mathématiques ),strm (structure machine)/ Transversale: Bureautique , histoire des sciences ",
    "GEn L2: vous allez choisir une spécialité parmi les 7 choix:  ISIL:Licence Ingénierie des Systèmes d’Information et des Logiciels / ACAD:Licence Informatique Académique /GTR :Licence Génie des Télécommunications et Réseaux  / RO:Licence Recherche Opérationnelle / Stat:Licence Ingénierie Statistique / Alg,crypt:Licence d’Algèbre etCryptographie / MATH:Licence Mathématiques",
    "Faculté d'Informatiques"
  ],
  [
    "ST",
    "ST: une spécialité qui tourne au tour de la science exacte et la technologie elle-meme,  le programme en 1ére année: Semestre1/les modules fondamentaux : Math 1,PHYS 1 ,CHIM 1 /METHODOLOGIQUE :TP PHYS1 ,TP CHIM1 ,BUREAUTIQUE1 ,TRANSVERSAL:TCE1 , langue étrangère  ,Decouverte: Dec1 / Semestre2: /les modules fondamentaux:MATH 2,PHYS 2,CHIM 2 /METHODOLOGIQUE:TP PHYS2,TP CHIM2,TP bureautique 2/TRANSVERSAL:TCE2,DECOUVERTE:Dec2",
    "En l2:vous allez choisir une spécialité parmi les 11 choix:Licence Electronique Licence Télécommunication Licence Automatisme Licence Electrotechnique Licence Mécanique Energétique Licence Ingénieries des Systèmes de Mécaniques (Faculté de Génie Mécanique et Génie de Procédés ) Licence Mécanique de Construction (Faculté de Génie Mécanique et Génie de Procédés) Licence Génie des Matériaux (Faculté de Génie Mécanique et Génie de Procédés Licence Analyse Physico-chimique et Mécanique des Matériaux  (Faculté de Génie Mécanique et Génie de Procédés ) Licence Mécanique et Énergétique Licence Génie Alimentaire Licence Génie d’Environnement  Licence Génie Pharmaceutique Licence Raffinage et Pétrochimie (Faculté de Génie Mécanique et Génie de Procédés) Licence de Génie Chimique (Faculté de Génie Mécanique et Génie de Procédés ) Licence Froid et Cryogénie (Faculté de Génie Mécanique et Génie de Procédés)  Licence en Génie Civil (Faculté de Génie Civil) Licence en Hydraulique (Faculté de Génie Civil)",
    "Faculté ..."
  ],
  [
    "Biologie",
    "SNV: ''séance de nature et vie ''  est la science qui étudie et taxonomise tous les genres d' organismes vivants basés sur la chimie , la génétique , la cytologie , et les sciences de la microbiologie et bien plus encoreLe but de toutes ces études est d'entourer la discipline des organismes vivants dans des environnements écologiques, elle appartient à la faculté de la biologie, le programme en 1ére année: /Semestre1: les modules fondamentaux:BIOLOGIE CELLULAIRE ,CHIMIE 1, M.S.I(math statistiques informatique) /TRANSVERSAL:METHODE TRAVAIL TERMINOLOGIE 1,HISTOIRE UNIV.  SCIENCES. EXPER./DECOUVERTE,GEOLOGIE / PHYSIQUE , TCE1/  Semestre2: les modules fondamentaux:BIOLOGIE ANIMALE GENERALE ,BIOLOGIE VEGETALE GENERALE,CHIMIE 2  /TRANSVERSAL:METHODE TRAVAIL TERMINOLOGIE 2/DECOUVERTE:GEOLOGIE / PHYSIQUE TCE2",
    "En L2 vous allez choisir une spécialité parmi les 12: Licence Biologie, Physiologie et Génétique Végétales (BPGV) Licence Biologie du Développement (BD) Licence Ecologie et Environnement Marin (EEM) Licence Ecologie Végétale et Environnement (EVE) Licence de Biotechnologie et Santé (BS) Licence de Biochimie Fondamentale et Appliquée (BFA) Licence de Génétique Fondamentale et Appliquée (GFA) Licence de Microbiologie Fondamentale et Appliquée (MFA) Licence de Nutrition et Contrôle de Qualité et Analyse (NCA) Licence de Parasitologie et Microbiologie (PM)  Licence de Physiologie Intégrative Animale et Humaine (PIAH) Licence d'Ecologie Animale (EA)",
    "Faculté de Biologie FSB"
  ],
  [
    "SM",
    "SM: science de la matière ou encore physique-chimie c'est une spécialitée qui se base comme l'indique son appelation sur ''la matière'' ,la chimie étudie la composition de la matière et  la physique étudie les états de la matière.  La licence en SM apporte une solide formation en physique et en chimie qui permet à son titulaire d’intégrer de nombreux secteurs: (environnement, industrie, matériaux, énergie.)  la  spécialité appartient à les faculté de physique et chimie , le programme en 1ére année/ Semestre1les modules fondamentaux : Math 1,PHYS 1 ,CHIM 1 /METHODOLOGIQUE :TP PHYS1 ,TP CHIM1 ,BUREAUTIQUE1 ,TRANSVERSAL:TCE1 , langue étrangère  ,Decouverte: Dec1 / Semestre2: /les modules fondamentaux:MATH 2,PHYS 2,CHIM 2 /METHODOLOGIQUE:TP PHYS2,TP CHIM2,TP bureautique 2/TRANSVERSAL:TCE2,DECOUVERTE:Dec2",
    "En L2 vous allez choisir une spécialité parmi les 4 choix:Licence de Physique (Faculté de Physique) Licence de Physique Appliquée : Energétique  (Faculté de Physique) Licence Chimie Fondamentale (Faculté de Chimie) Licence Géophysique (faculté des Science de la Terre, Géographie et Aménagement du Territoire).",
    "Faculté de SM"
  ],
];

String mapsStyle = "";

String googleApiKey = "AIzaSyCehlNhIUff2KRlwvc6h1W1NmyfGYjKY5U";

Map<int, String> mapFilter = {
  0: "Buvettes",
  1: "Entrées",
  2: "Facultés",
  3: "Administration",
  4: "Autre"
};

Color mainColor = Colors.orange.shade800;
Color secondColor = Colors.blue.shade600;
BitmapDescriptor iconAdminsitration = BitmapDescriptor.defaultMarkerWithHue(0);
BitmapDescriptor iconEntry = BitmapDescriptor.defaultMarkerWithHue(0);
BitmapDescriptor iconFood = BitmapDescriptor.defaultMarkerWithHue(0);
BitmapDescriptor iconFaculty = BitmapDescriptor.defaultMarkerWithHue(0);
BitmapDescriptor iconOther = BitmapDescriptor.defaultMarkerWithHue(0);
var mapStyle = "";

Map<String, dynamic> polylinesJson = {};
Map<String, Polyline> routingDataBase = {};
late MainClass mainClass;
Map<String, Widget> mapRoutes = {
  "about": AboutUsPageSecondary(),
  "map": MapsPage(),
  "news": NewsPage(),
  "scolarity": ScolarityPage(),
  "addnews": AddNewsPage(),
  "usthbnews": UsthbNews(),
  "pinews": PiNews()
};
