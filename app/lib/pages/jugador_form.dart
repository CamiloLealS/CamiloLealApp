import 'package:flutter/material.dart';
import 'package:camilolealev2_app/services/http_service.dart';
import 'package:google_fonts/google_fonts.dart';

class JugadorForm extends StatefulWidget {
  const JugadorForm({super.key});

  @override
  State<JugadorForm> createState() => _JugadorFormState();
}

class _JugadorFormState extends State<JugadorForm> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  final _equipoIdController = TextEditingController();
  final HttpService httpService = HttpService();
  final AssetImage fondo = AssetImage('assets/img/forms_fondo.jpg');
  int? equipoSelect;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Jugador', style: GoogleFonts.oxanium(textStyle: TextStyle(color: Colors.white),)),
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
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.red,
                  controller: _nicknameController,
                  decoration: InputDecoration(labelText: 'Nickname del Jugador', labelStyle: GoogleFonts.oxanium(textStyle:  TextStyle(color: Colors.white))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre del Equipo';
                    }
                    return null;
                  },
                ),
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
                        equipoSelect = opSelect!;
                        _equipoIdController.text = equipoSelect.toString();
                      });
                  }),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> data = {
                        'nickname': _nicknameController.text,
                        'fk_equipo_id': int.parse(_equipoIdController.text),
                      };
                      httpService.agregarJugador(data).then((response) {
                        if (response.statusCode == 201) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Jugador creado con éxito'),
                          ));
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Error al crear el jugador: ${response.body}'),
                          ));
                        }
                      });
                    }
                  },
                  child: Text('Crear Jugador'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}