import 'package:flutter/material.dart';

class TituloSec extends StatelessWidget {
  const TituloSec({
    super.key,
    required this.titulo,
    required this.subtitulo,
  });

  final String titulo;
  final String subtitulo;
 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
      decoration: BoxDecoration(
        color: Colors.red,
        border: Border(bottom: BorderSide(color: Colors.black, width: 7))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            this.titulo,
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            this.subtitulo,
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          )
        ],
      ),
    );
  }
}