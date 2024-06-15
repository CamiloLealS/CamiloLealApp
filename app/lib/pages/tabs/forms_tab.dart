import 'package:camilolealev2_app/pages/equipo_form.dart';
import 'package:camilolealev2_app/pages/jugador_form.dart';
import 'package:camilolealev2_app/widgets/titulo_sec.dart';
import 'package:flutter/material.dart';

class FormsTab extends StatelessWidget {
  const FormsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final AssetImage fondo = AssetImage('assets/img/forms_fondo.jpg');
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: fondo, fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            TituloSec(titulo: 'Formularios', subtitulo: 'Equipos/Jugadores'),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>EquipoForm()));
            }, child: Text('Formulario de Equipo.')),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>JugadorForm()));
            }, child: Text('Formulario de Jugador.'))
          ],
        ),
      ),
    );
  }
}