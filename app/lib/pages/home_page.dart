import 'package:camilolealev2_app/pages/tabs/calendar_tab.dart';
import 'package:camilolealev2_app/pages/tabs/forms_tab.dart';
import 'package:camilolealev2_app/pages/tabs/torneos_tab.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Container(
            color: Colors.black,
            height: 40,
            child: Row(
              children: [
                Image(image: AssetImage('assets/img/valorant.png'),),
                SizedBox(width: 10,),
                Text('Valorant Esports', style: GoogleFonts.oxanium(textStyle: TextStyle(color: Colors.white),),)
              ],
            ),
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            indicatorColor: Colors.red,
            tabs: [Tab(icon: Icon(MdiIcons.trophy)), Tab(icon: Icon(MdiIcons.calendar)),Tab(icon: Icon(MdiIcons.plus),)]
        ),
      ),
      body: TabBarView(
        children: [TorneosTab(), CalendarTab(), FormsTab()]),
    ));
  }
}