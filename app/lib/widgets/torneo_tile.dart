import 'package:camilolealev2_app/pages/torneo_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TorneoTile extends StatefulWidget {
  final String nombreTorneo;
  final String reglas;
  final String logo;
  final int prizepool;
  final String ubicacion;
  final int id;

  TorneoTile({this.nombreTorneo = 'No Torneo', this.reglas = 'No Reglas', this.logo = 'No Logo', this.prizepool = 0, this.ubicacion = 'No Ubicacion', required this.id});

  @override
  State<TorneoTile> createState() => _TorneoTileState();
}

class _TorneoTileState extends State<TorneoTile> {
  @override
  Widget build(BuildContext context) {
    final String ima = 'assets/img/';

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>TorneoPage(id: this.widget.id)));
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
                Container(
                  height: 50,
                  width: 50,
                  child: Image(image: AssetImage(ima+this.widget.logo), fit: BoxFit.contain,)),
                Spacer(),
                Text(
                  this.widget.nombreTorneo,
                  style: GoogleFonts.oxanium(textStyle: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                Spacer()
              ],
            )
          ],
        ),
      ),
    );
  }
}