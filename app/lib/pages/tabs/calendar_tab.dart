import 'package:camilolealev2_app/pages/partido_form.dart';
import 'package:camilolealev2_app/services/http_service.dart';
import 'package:camilolealev2_app/widgets/partido_tile.dart';
import 'package:camilolealev2_app/widgets/titulo_sec.dart';
import 'package:flutter/material.dart';

class CalendarTab extends StatefulWidget {
  const CalendarTab({super.key});

  @override
  State<CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  late Future<List<dynamic>> partidosFuture;

  String? orden;
  final AssetImage fondo = AssetImage('assets/img/calendar_fondo.jpg');

  @override 
  void initState(){
    super.initState();
    partidosFuture = HttpService().partidos(orden: orden);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: fondo, opacity: 0.8, fit: BoxFit.cover)
        ),
        child: Column(
          children: [
            TituloSec(titulo: 'Calendario', subtitulo: 'de Partidos'),
            Row(
              children: [
                Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: (){
                    MaterialPageRoute ruta = MaterialPageRoute(builder: (context)=>PartidoForm());
                    Navigator.push(context, ruta).then((value){
                      setState(() {});
                    });
                  }, 
                  child: Text('Añadir Partido', style: TextStyle(color: Colors.white),)
                ),
                Spacer(),
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.black),onPressed: (){
                  setState(() {
                    orden = 'asc';
                    partidosFuture = HttpService().partidos(orden:orden);
                  });
                }, 
                child: Icon(Icons.arrow_circle_up, color: Colors.white)),
                Spacer(),
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.black), onPressed: (){
                  setState(() {
                    orden = 'desc';
                    partidosFuture = HttpService().partidos(orden:orden);
                  });
                }, 
                child: Icon(Icons.arrow_circle_down,color: Colors.white)),
              ],
            ),
            
            Expanded(
              child: FutureBuilder(
                future: partidosFuture, 
                builder: (context, AsyncSnapshot snapshot){
                  if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }
                  else{
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index){
                        var partido = snapshot.data[index];
                        return PartidoTile(
                          id: partido['id'],
                          equipo1: partido['equipos'][0]['name'],
                          logo1: partido['equipos'][0]['logo'],
                          id1: partido['equipos'][0]['id'],
                          puntos1: partido['equipos'][0]['puntos'],
                          equipo2: partido['equipos'][1]['name'],
                          logo2: partido['equipos'][1]['logo'],
                          id2: partido['equipos'][1]['id'],
                          puntos2: partido['equipos'][1]['puntos'],
                          fecha: DateTime.parse(partido['fecha']),
                        );
                      },
                    );
                  }
                }),
            ),
          ],
        ),
      ),
    );
  }
}