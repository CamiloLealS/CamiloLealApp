import 'package:camilolealev2_app/pages/equipo_page.dart';
import 'package:camilolealev2_app/pages/partido_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class PartidoTile extends StatefulWidget {
  final String equipo1;
  final String logo1;
  final String equipo2;
  final String logo2;
  final DateTime fecha;
  final int id1;
  final int id2;
  final int puntos1;
  final int puntos2;
  final int id;

  PartidoTile({required this.id, required this.puntos1, required this.puntos2, required this.id1, required this.id2, required this.equipo1, required this.logo1, required this.logo2, required this.equipo2, required this.fecha});

  @override
  State<PartidoTile> createState() => _PartidoTileState();
}

class _PartidoTileState extends State<PartidoTile> {
  @override
  Widget build(BuildContext context) {
    String ima = "assets/img/";
    String fechaFormat = DateFormat("dd/MM/yyyy").format(widget.fecha);


    String eq1 = this.widget.equipo1;
    String vs = ' vs ';
    String space = ' ';
    String eq2 = this.widget.equipo2;
    String puntos1 = this.widget.puntos1.toString();
    String puntos2 = this.widget.puntos2.toString();

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PartidoPage(id: this.widget.id)));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EquipoPage(id: this.widget.id1)));
                  },
                  child: Image(image: AssetImage(ima+this.widget.logo1), fit: BoxFit.contain, height: 50, width: 50,),
                ),
                Spacer(),
                Column(
                  children: [
                    RichText(text: TextSpan(
                      text: eq1,
                      style: GoogleFonts.oxanium(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,)),
                      children: <TextSpan>[
                        TextSpan(
                          text: space
                        ),
                        TextSpan(
                          text: puntos1,
                          style: GoogleFonts.oxanium(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                        ),
                        TextSpan(
                          text: vs
                        ),
                        TextSpan(
                          text: puntos2,
                          style: GoogleFonts.oxanium(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                        ),
                        TextSpan(
                          text: space
                        ),
                        TextSpan(
                          text: eq2,
                          style: GoogleFonts.oxanium(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,)),
                        )
                      ]
                    )),
                    SizedBox(height: 4,),
                    if(widget.fecha.isBefore(DateTime.now()))
                      Row(
                        children: [
                          Icon(MdiIcons.dotsCircle, color: Colors.green,),
                          Text(fechaFormat, style: GoogleFonts.oxanium(textStyle: TextStyle(fontWeight: FontWeight.bold))),
                        ],
                      ),
                    if(widget.fecha.isAfter(DateTime.now()))
                      Row(children: [
                        Icon(MdiIcons.dotsCircle, color: Colors.red,),
                        Text(fechaFormat, style: GoogleFonts.oxanium(textStyle: TextStyle(fontWeight: FontWeight.bold))),
                      ])
                    ]),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    MaterialPageRoute ruta = MaterialPageRoute(builder: (context) => EquipoPage(id: this.widget.id2),);
                    Navigator.push(context, ruta).then((value){
                      setState(() {});
                    });
                  },
                  child: Image(image: AssetImage(ima+this.widget.logo2), fit: BoxFit.contain, height: 50, width: 50,),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}