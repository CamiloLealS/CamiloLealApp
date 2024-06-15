import 'package:flutter/material.dart';
import 'package:camilolealev2_app/services/http_service.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PartidoPage extends StatelessWidget {
  final int id;

  PartidoPage({required this.id});

  final AssetImage fondo = AssetImage('assets/img/calendar_fondo.jpg');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles Partido',
          style: GoogleFonts.oxanium(textStyle: TextStyle(color: Colors.white)),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
          future: HttpService().partido($id: this.id),
          builder: (context, snapshot) {
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data found.'));
            } else {
              var partido = snapshot.data!;
              var equipo1 = partido['equipos'][0];
              var equipo2 = partido['equipos'][1];
              var jugadores1 = equipo1['jugadores'];
              var jugadores2 = equipo2['jugadores'];
              var torneoId = partido['torneo_id'];

              return FutureBuilder<Map<String, dynamic>>(
                  future: HttpService().torneo($id: torneoId),
                  builder: (context, AsyncSnapshot torneoSnapshot) {
                    if (!torneoSnapshot.hasData ||
                        torneoSnapshot.connectionState ==
                            ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (torneoSnapshot.hasError) {
                      return Center(child: Text('No data found.'));
                    } else {
                      var torneo = torneoSnapshot.data!;
                      var torneoNombre = torneo['name'];
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: fondo, opacity: 0.8, fit: BoxFit.cover),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 140,
                                width: double.infinity,
                                color: Color.fromARGB(64, 218, 217, 217),
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Image(
                                      image: AssetImage(
                                          'assets/img/' + equipo1['logo']),
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      equipo1['puntos'].toString(),
                                      style: GoogleFonts.oxanium(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 36,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text('-',
                                        style: GoogleFonts.oxanium(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 36,
                                                fontWeight: FontWeight.bold))),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(equipo2['puntos'].toString(),
                                        style: GoogleFonts.oxanium(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 36,
                                                fontWeight: FontWeight.bold))),
                                    Image(
                                      image: AssetImage(
                                          'assets/img/' + equipo2['logo']),
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.contain,
                                    ),
                                    Spacer(),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Spacer(),
                                  Text(torneoNombre, style: TextStyle(color: Colors.white, fontSize: 18),),
                                  Spacer()
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(equipo1['name'],
                                              style: GoogleFonts.oxanium(
                                                  textStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                          Expanded(
                                            child: ListView.builder(
                                                itemCount: jugadores1.length,
                                                itemBuilder: (context, index) {
                                                  var jugador =
                                                      jugadores1[index];
                                                  return Container(
                                                    margin: EdgeInsets.all(5),
                                                    padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        jugador['nickname'],
                                                        style: GoogleFonts.oxanium(
                                                            textStyle: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            equipo2['name'],
                                            style: GoogleFonts.oxanium(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          Expanded(
                                            child: ListView.builder(
                                                itemCount: jugadores2.length,
                                                itemBuilder: (context, index) {
                                                  var jugador =
                                                      jugadores2[index];
                                                  return Container(
                                                    margin: EdgeInsets.all(5),
                                                    padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        jugador['nickname'],
                                                        style: GoogleFonts.oxanium(
                                                            textStyle: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 40,
                                width: double.infinity,
                                child: Text(
                                  DateFormat("dd/MM/yyyy")
                                      .format(DateTime.parse(partido['fecha'])),
                                  style: GoogleFonts.oxanium(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  });
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HttpService().eliminarPartido(id);
          Navigator.pop(context, true);
        },
        child: Icon(
          MdiIcons.trashCan,
          color: Colors.black,
        ),
      ),
    );
  }
}
