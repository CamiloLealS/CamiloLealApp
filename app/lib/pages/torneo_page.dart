import 'package:flutter/material.dart';
import 'package:camilolealev2_app/services/http_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TorneoPage extends StatelessWidget {
  final int id;

  TorneoPage({required this.id});

  @override
  Widget build(BuildContext context) {
    final AssetImage fondo = AssetImage('assets/img/torneos_fondo.jpg');
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Detalles Torneo', style: TextStyle(color: Colors.white),),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: HttpService().torneo($id: this.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found.'));
          } else {
            var torneo = snapshot.data!;
            var equipos = torneo['equipos'];
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
                            image: AssetImage('assets/img/' + torneo['logo']),
                            height: 150,
                            width: 150,  
                          ),
                        ),
                        SizedBox(width: 10,),
                        Flexible(
                          child: Text(
                            torneo['name'],
                            style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Colors.white),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Reglas: '+torneo['reglas'], style: TextStyle(color: Colors.white, fontSize: 18),),
                        SizedBox(width: 5,),
                        Text("Premio: \$"+torneo['prizepool'].toString(), style: TextStyle(color: Colors.white, fontSize: 18),),
                        Text('Ubicación:'+torneo['ubicacion'], style: TextStyle(color: Colors.white, fontSize: 18),)
                      ],
                    ),
                    SizedBox(height: 10),
                    SizedBox(height: 10),
                    Text('Equipos Integrantes:', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
                    Expanded(
                      child: ListView.builder(
                        itemCount: equipos.length,
                        itemBuilder: (context, index){
                          var equipo = equipos[index];
                          return Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(10),
                            width: 10,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                            child: Row(
                              children: [
                                Text('Equipo: '+ equipo['name'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              ],
                            ),
                          );
                        }
                        ),
                    ),
                    ElevatedButton(onPressed: (){
                      HttpService().eliminarTorneo(id);
                      Navigator.pop(context, true);
                    }, 
                    child: Icon(MdiIcons.trashCan, color: Colors.red,))
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