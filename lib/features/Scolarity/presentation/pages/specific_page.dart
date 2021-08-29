import 'package:flutter/material.dart';
import 'package:project_initiative_club_app/main.dart';
import 'package:project_initiative_club_app/ressources/globals.dart';

@override
// ignore: non_constant_identifier_names
Widget SpecificScolarityPage(
    {required String value, required double screenH, required double screenW}) {
  List<String> listData = [];

  void getListData() {
    List<String> list = [];
    scolarityData.forEach((element) {
      if (element[0] == value) {
        list = element;
      }
    });
    listData = list;
  }

  getListData();

  return Container(
    height: screenH*0.65,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
    ),
    padding: EdgeInsets.only(right: 10,left: 10),
    child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10,),
          if (value=="Math&Info") Column(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/quoimi.png"),
                  ),
                ),
              ),
              Container(
                width: 320,
                height: 250,
               decoration: BoxDecoration(
                 image: DecorationImage(
                   image: AssetImage("images/prog.png"),
                 ),
               ),
                ),
              Container(
                width: 350,
                height: 900,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/module.png"),
                  ),
                ),
              ),
              Container(
                width: 300,
                height: 700,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/spec.png"),
                  ),
                ),
              ),
              Container(
                width: 350,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/laptop.png"),
                  ),
                ),
              ),
            ],
          ) else Container(),
          if (value=="Biologie") Column(
            children:[
              Container(
                width: 350,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/bio.png"),
                  ),
                ),
              ),
              Container(
                width: 350,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/biot.png"),
                  ),
                ),
              ),
              Container(
                width: 350,
                height: 700,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/biomod.png"),
                  ),
                ),
              ),
              Container(
                width: 350,
                height: 900,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/biospec.png"),
                  ),
                ),
              ),
              Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/biofin.png"),
                  ),
                ),
              ),
            ],
          ) else Container(),
          if (value=="SM") Column(
            children: [
              Container(
                width: 350,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/smdeb.png"),
                  ),
                ),
              ),
              Container(
                width: 350,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/smt.png"),
                  ),
                ),
              ),
              Container(
                width: 350,
                height: 700,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/smmod.png"),
                  ),
                ),
              ),
              Container(
                width: 350,
                height: 500,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/smspec.png"),
                  ),
                ),
              ),
              Container(
                width: 350,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/smfin.png"),
                  ),
                ),
              ),
            ],

          ) else Container(),
          if (value=="ST") Column(
            children: [
              Container(
                width: 350,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/stdeb.png"),
                  ),
                ),
              ),
              Container(
                width: 350,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/stt.png"),
                  ),
                ),
              ),
              Container(
                width: 350,
                height: 700,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/stmod.png"),
                  ),
                ),
              ),
              Container(
                width: 400,
                height: 1100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/stspec.png"),
                  ),
                ),
              ),
              Container(
                width: 350,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/stfin.png"),
                  ),
                ),
              ),
            ],


          ) else Container(),
         /* Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: secondColor.withOpacity(1),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),

                ),
                child: Text("C'est quoi "+value+" ?",style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Roboto Slab')),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(listData[1],style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Roboto Slab'),textAlign: TextAlign.left,),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: secondColor.withOpacity(1),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                ),
                child: Text("Les module de la 1ére annnée",style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Roboto Slab')),
              ),
            ],
          ),
          Container(
              padding: EdgeInsets.all(14),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: secondColor.withOpacity(1),
                          borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                        ),
                        child: Text("Semestre 1",style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: 'Roboto Slab')),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("# Les modules fondamentaux : ",style: TextStyle(decoration: TextDecoration.underline,decorationStyle: TextDecorationStyle.solid,color: Colors.white,fontSize: 17,fontFamily: 'Roboto Slab')),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text(listData[2],style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Roboto Slab')),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("# Decouverte :",style: TextStyle(decoration: TextDecoration.underline,decorationStyle: TextDecorationStyle.solid,color: Colors.white,fontSize: 17,fontFamily: 'Roboto Slab')),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Text(listData[3],style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Roboto Slab')),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("# Transversale :",style: TextStyle(color: Colors.white,fontSize: 17,fontFamily: 'Roboto Slab')),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text(listData[4],style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Roboto Slab')),
                  SizedBox(height: 10,),
                  value=="ST" || value=="SM"?  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("# Methodologique :",style: TextStyle(decoration: TextDecoration.underline,decorationStyle: TextDecorationStyle.solid,color: Colors.white,fontSize: 17,fontFamily: 'Roboto Slab')),
                    ],
                  ): Container(),
                  value=="ST" || value=="SM"? SizedBox(height: 10,):Container(),
                  value=="ST" || value=="SM"? Text(listData[5],style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Roboto Slab')):Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: secondColor.withOpacity(1),
                          borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                        ),
                        child: Text("Semestre 2",style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: 'Roboto Slab')),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("# Les modules fondamentaux : ",style: TextStyle(decoration: TextDecoration.underline,decorationStyle: TextDecorationStyle.solid,color: Colors.white,fontSize: 17,fontFamily: 'Roboto Slab')),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text(listData[5],style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Roboto Slab')),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("# Decouverte :",style: TextStyle(decoration: TextDecoration.underline,decorationStyle: TextDecorationStyle.solid,color: Colors.white,fontSize: 17,fontFamily: 'Roboto Slab')),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Text(listData[6],style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Roboto Slab')),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("# Transversale :",style: TextStyle(color: Colors.white,fontSize: 17,fontFamily: 'Roboto Slab')),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text(listData[7],style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Roboto Slab')),
                  SizedBox(height: 10,),
                  value=="ST" || value=="SM"?  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("# Methodologique :",style: TextStyle(decoration: TextDecoration.underline,decorationStyle: TextDecorationStyle.solid,color: Colors.white,fontSize: 17,fontFamily: 'Roboto Slab')),
                    ],
                  ): Container(),
                  value=="ST" || value=="SM"? SizedBox(height: 10,):Container(),
                  value=="ST" || value=="SM"? Text(listData[8],style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Roboto Slab')):Container(),
                  value=="Math&Info" ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("# Secondaire :",style: TextStyle(decoration: TextDecoration.underline,decorationStyle: TextDecorationStyle.solid,color: Colors.white,fontSize: 17,fontFamily: 'Roboto Slab')),
                    ],
                  ): Container(),
                  value=="Math&Info" ? SizedBox(height: 10,):Container(),
                  value=="Math&Info" ? Text(listData[7],style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: 'Roboto Slab')):Container(),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: secondColor.withOpacity(1),
                          borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                        ),
                        child: Text("Specialité de L2",style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: 'Roboto Slab')),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  value=="Math&Info"?Text(listData[9],style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Roboto Slab')):Container(),
                  value=="ST" || value=="SM"? Text(listData[10],style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Roboto Slab')):Container(),
                  value=="Biologie"?Text(listData[8],style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Roboto Slab')):Container(),
                ],
              )

          ),

          SizedBox(
            height: 50,
          ),
          Text("Facultés : ",style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Roboto Slab')),
          value=="Math&Info"? Text(listData[10],style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Roboto Slab')):Container(),
          value=="ST" || value=="SM"?Text(listData[11],style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Roboto Slab')):Container(),
          value=="Biologie"?Text(listData[9],style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'Roboto Slab')):Container(),
          SizedBox(
            height: 50,
          ),*/
              ],
      ),
    ),
  );
}
