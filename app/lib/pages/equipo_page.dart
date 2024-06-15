import 'package:flutter/material.dart';
import 'package:camilolealev2_app/services/http_service.dart';
import 'package:google_fonts/google_fonts.dart';

class EquipoPage extends StatelessWidget {
  final int id;

  EquipoPage({required this.id});

  @override
  Widget build(BuildContext context) {
    final AssetImage fondo = AssetImage('assets/img/equipos_fondo.jpg');
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Detalles Equipo', style: GoogleFonts.oxanium(textStyle:  TextStyle(color: Colors.white),)),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: HttpService().equipo($id: this.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found.'));
          } else {
            var equipo = snapshot.data!;
            var jugadores = equipo['jugadores'];
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: fondo, fit: BoxFit.cover, opacity: 0.8)
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 18, 3, 31),
                              width: 5.0
                            ),
                            color: Colors.white,
                          ),
                          child: Image(
                            image: AssetImage('assets/img/'+equipo['logo']),
                            height: 150,
                            width: 150,  
                          ),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          children: [
                            Text(
                              equipo['name'],
                              style: GoogleFonts.oxanium(textStyle:  TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                            Text('Valorant', style: GoogleFonts.oxanium(textStyle:  TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,)),textAlign: TextAlign.left,)
                          ],
                        ),
                      ],
                    ),
                    Divider(color: Colors.white),
                    SizedBox(height: 20),
                    Text('Jugadores:', style: GoogleFonts.oxanium(textStyle:  TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),)),
                    Expanded(
                      child: ListView.builder(
                        itemCount: jugadores.length,
                        itemBuilder: (context, index){
                          var jugador = jugadores[index];
                          return Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(10),
                            width: 10,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                            child: Row(
                              children: [
                                Text('Nickname: '+ jugador['nickname'], style: GoogleFonts.oxanium(textStyle:  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                              ],
                            ),
                          );
                        }
                        ),
                    )
                    // Puedes añadir más detalles del equipo aquí
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}