import 'package:flutter/material.dart';
import 'package:camilolealev2_app/services/http_service.dart';
import 'package:google_fonts/google_fonts.dart';


class TorneoForm extends StatefulWidget {
  @override
  _TorneoFormState createState() => _TorneoFormState();
}

class _TorneoFormState extends State<TorneoForm> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _logoController = TextEditingController();
  final _rulesController = TextEditingController();
  final _prizepoolController = TextEditingController();
  final _ubicacionController = TextEditingController();
  final HttpService httpService = HttpService();
  final AssetImage fondo = AssetImage('assets/img/torneos_fondo.jpg');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Torneo', style: GoogleFonts.oxanium(textStyle:  TextStyle(color: Colors.white),)),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: fondo, fit: BoxFit.cover, opacity: 0.8)
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.red,
                  controller: _nombreController,
                  decoration: InputDecoration(labelText: 'Nombre del Torneo', labelStyle: GoogleFonts.oxanium(textStyle: TextStyle(color: Colors.white))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre del torneo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.red,
                  controller: _logoController,
                  decoration: InputDecoration(labelText: 'Logo del Torneo', labelStyle: GoogleFonts.oxanium(textStyle: TextStyle(color: Colors.white))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el Logo del torneo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.red,
                  controller: _rulesController,
                  decoration: InputDecoration(labelText: 'Reglas del Torneo', labelStyle: GoogleFonts.oxanium(textStyle: TextStyle(color: Colors.white))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese las reglas del torneo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.red,
                  controller: _prizepoolController,
                  decoration: InputDecoration(labelText: 'PrizePool del Torneo', labelStyle: GoogleFonts.oxanium(textStyle: TextStyle(color: Colors.white))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el PrizePool del torneo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.red,
                  controller: _ubicacionController,
                  decoration: InputDecoration(labelText: 'Ubicación del Torneo', labelStyle: GoogleFonts.oxanium(textStyle: TextStyle(color: Colors.white))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la ubicación del torneo';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> data = {
                        'name': _nombreController.text,
                        'logo':_logoController.text,
                        'prizepool': int.parse(_prizepoolController.text),
                        'ubicacion': _ubicacionController.text,
                        'reglas': _rulesController.text,
                      };
                      httpService.agregarTorneo(data).then((response) {
                        if (response.statusCode == 201) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Torneo creado con éxito'),
                          ));
                          Navigator.pop(context, true);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Error al crear el torneo: ${response.body}'),
                          ));
                        }
                      });
                    }
                  },
                  child: Text('Crear Torneo'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}