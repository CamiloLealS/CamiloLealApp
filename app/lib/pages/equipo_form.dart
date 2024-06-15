import 'package:flutter/material.dart';
import 'package:camilolealev2_app/services/http_service.dart';
import 'package:google_fonts/google_fonts.dart';

class EquipoForm extends StatefulWidget {
  @override
  _EquipoFormState createState() => _EquipoFormState();
}

class _EquipoFormState extends State<EquipoForm> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _logoController = TextEditingController();
  final HttpService httpService = HttpService();
  final AssetImage fondo = AssetImage('assets/img/forms_fondo.jpg');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Equipo', style: GoogleFonts.oxanium(textStyle: TextStyle(color: Colors.white),)),
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
                  controller: _nombreController,
                  decoration: InputDecoration(labelText: 'Nombre del Equipo', labelStyle: GoogleFonts.oxanium(textStyle:  TextStyle(color: Colors.white))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el nombre del Equipo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.red,
                  controller: _logoController,
                  decoration: InputDecoration(labelText: 'Logo del Equipo', labelStyle: GoogleFonts.oxanium(textStyle:  TextStyle(color: Colors.white))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese el Logo del equipo';
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
                        'logo': _logoController.text,
                      };
                      httpService.agregarEquipo(data).then((response) {
                        if (response.statusCode == 201) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Equipo creado con éxito'),
                          ));
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Error al crear el equipo: ${response.body}'),
                          ));
                        }
                      });
                    }
                  },
                  child: Text('Crear Equipo'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}