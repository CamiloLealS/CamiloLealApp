import 'package:camilolealev2_app/pages/torneo_form.dart';
import 'package:camilolealev2_app/widgets/titulo_sec.dart';
import 'package:camilolealev2_app/widgets/torneo_tile.dart';
import 'package:flutter/material.dart';
import 'package:camilolealev2_app/services/http_service.dart';

class TorneosTab extends StatefulWidget {
  const TorneosTab({super.key});

  @override
  State<TorneosTab> createState() => _TorneosTabState();
}

class _TorneosTabState extends State<TorneosTab> {
  final AssetImage  fondo = AssetImage('assets/img/torneos_fondo.jpg');

  Future<void> _refreshTorneos() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: fondo, fit : BoxFit.cover, opacity: 0.8)
        ),
        child: Column(
          children: [
            TituloSec(titulo: 'Torneos', subtitulo: 'Valorant'),
            Expanded(
              child: FutureBuilder(
                future: HttpService().torneos(), 
                builder: (context, AsyncSnapshot snapshot){
                  if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
                    print('No entra al if');
                    print(snapshot.connectionState);
                    return Center(child: CircularProgressIndicator());
                  }
                  else{
                    return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      var torneo = snapshot.data[index];
                      return TorneoTile(
                        nombreTorneo: torneo['name'],
                        logo: torneo['logo'],
                        prizepool: torneo['prizepool'],
                        ubicacion: torneo['ubicacion'],
                        reglas: torneo['reglas'],
                        id: torneo['id'],
                      );
                    },
                  );
                  }
                } 
              ))
          ],
        ),
      ),
    floatingActionButton: FloatingActionButton(onPressed: (){
      MaterialPageRoute ruta = MaterialPageRoute(builder: (context)=>TorneoForm());
      Navigator.push(context, ruta).then((value){
        setState(() {});
      });

    },
    tooltip: 'Agregar',
    child: Icon(Icons.add),),
    );
  }
}