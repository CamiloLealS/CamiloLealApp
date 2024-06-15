import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camilolealev2_app/services/http_service.dart';
import 'package:intl/intl.dart';

class PartidoForm extends StatefulWidget {
  const PartidoForm({super.key});

  @override
  State<PartidoForm> createState() => _PartidoFormState();
}

class _PartidoFormState extends State<PartidoForm> {
  final _formKey = GlobalKey<FormState>();
  bool isCompleted = false;
  final _torneoIdController = TextEditingController();
  final _equipoId1Controller = TextEditingController();
  final _equipoId2Controller = TextEditingController();
  final _fechaController = TextEditingController();
  int? equipo1Select;
  int? equipo2Select;
  int? torneoSelected;
  int? _puntosEquipo1;
  int? _puntosEquipo2;

  final HttpService httpService = HttpService();
  final AssetImage fondo = AssetImage('assets/img/calendar_fondo.jpg');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Partido', style: GoogleFonts.oxanium(textStyle: TextStyle(color: Colors.white),)),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: fondo, opacity: 0.8, fit: BoxFit.cover)
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CheckboxListTile(
                  title: Text('¿Partido Finalizado?', style: TextStyle(color: Colors.white),),
                  value:isCompleted, 
                  onChanged: (bool? value){
                  setState(() {
                    isCompleted = value!;
                  });
                }),
                FutureBuilder(
                  future: httpService.equipos(), 
                  builder: (context, AsyncSnapshot snapshot){
                    if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
                      return Text('Cargando Equipos');
                    }
                    List<dynamic> equipos = snapshot.data;
                    return DropdownButtonFormField(
                      items: equipos.map<DropdownMenuItem<int>>((equipo){
                        return DropdownMenuItem<int>(
                          child: Text(equipo['name'], style: TextStyle(color: Colors.white),),
                          value: equipo['id'],);
                      }).toList(), 
                      decoration: InputDecoration(labelText: 'Equipo', border: OutlineInputBorder(), labelStyle: TextStyle(color: Colors.white)),
                      dropdownColor: Colors.grey,
                      onChanged: (opSelect){
                        equipo1Select = opSelect!;
                        _equipoId1Controller.text = equipo1Select.toString();
                      });
                  }),
                FutureBuilder(
                  future: httpService.equipos(), 
                  builder: (context, AsyncSnapshot snapshot){
                    if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
                      return Text('Cargando Equipos');
                    }
                    List<dynamic> equipos = snapshot.data;
                    return DropdownButtonFormField(
                      items: equipos.map<DropdownMenuItem<int>>((equipo){
                        return DropdownMenuItem<int>(
                          child: Text(equipo['name'], style: TextStyle(color: Colors.white),),
                          value: equipo['id'],);
                      }).toList(), 
                      decoration: InputDecoration(labelText: 'Equipo', border: OutlineInputBorder(), labelStyle: TextStyle(color: Colors.white)),
                      dropdownColor: Colors.grey,
                      onChanged: (opSelect){
                        equipo2Select = opSelect!;
                        _equipoId2Controller.text = equipo2Select.toString();
                      });
                  }),
                FutureBuilder(
                  future: httpService.torneos(), 
                  builder: (context, AsyncSnapshot snapshot){
                    if(!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting){
                      return Text('Cargando Torneos');
                    }
                    List<dynamic> torneos = snapshot.data;
                    return DropdownButtonFormField(
                      items: torneos.map<DropdownMenuItem<int>>((torneo){
                        return DropdownMenuItem<int>(
                          child: Text(torneo['name'], style: TextStyle(color: Colors.white),),
                          value: torneo['id'],);
                      }).toList(), 
                      decoration: InputDecoration(labelText: 'Torneo', border: OutlineInputBorder(), labelStyle: TextStyle(color: Colors.white)),
                      dropdownColor: Colors.grey,
                      onChanged: (opSelect){
                        torneoSelected = opSelect!;
                        _torneoIdController.text = torneoSelected.toString();
                      });
                }),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.red,
                  controller: _fechaController,
                  decoration: InputDecoration(labelText: 'Fecha Partido dd/mm/yyyy', labelStyle: GoogleFonts.oxanium(textStyle:  TextStyle(color: Colors.white))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la Fecha del Partido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                if (isCompleted)
                  Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Puntos Equipo 1', labelStyle: TextStyle(color: Colors.white)),
                            onChanged: (value) {
                              _puntosEquipo1 = int.parse(value);
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Puntos Equipo 2', labelStyle: TextStyle(color: Colors.white)),
                            onChanged: (value) {
                              _puntosEquipo2 = int.parse(value);
                            },
                          ),
                        ),
                      ],
                    ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      DateTime fecha = DateFormat('dd/MM/yyyy').parse(_fechaController.text);
                      int equipo1Id = int.parse(_equipoId1Controller.text);
                      print(equipo1Id);
                      int equipo2Id = int.parse(_equipoId2Controller.text);
                      print(equipo2Id);
                      int torneoId = int.parse(_torneoIdController.text);
                      int? puntosEquipo1Value = _puntosEquipo1 != null ? _puntosEquipo1 : 0;
                      int? puntosEquipo2Value = _puntosEquipo2 != null ? _puntosEquipo2 : 0;
                      print(puntosEquipo2Value);
                      print(puntosEquipo1Value);

                      httpService.crearPartido(equipo1Id, equipo2Id, fecha, puntosEquipo1Value, puntosEquipo2Value, torneoId, isCompleted).then((response) {
                        if (response.statusCode == 201) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Partido creado con éxito'),
                          ));
                          Navigator.pop(context, true);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Error al crear el partido: ${response.body}'),
                          ));
                        }
                      });
                    }
                  },
                  child: Text('Crear Partido'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}