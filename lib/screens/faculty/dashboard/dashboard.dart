import 'package:firstskillpro/screens/faculty/dashboard/id.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firstskillpro/styling.dart';
import 'package:http/http.dart' as http;
import 'competencies.dart';
import 'competencydata.dart';
import 'my_globals.dart' as globals;
class FacultyDashBoard extends StatefulWidget {
  const FacultyDashBoard({
    Key? key,
  }) : super(key: key);

  @override
  State<FacultyDashBoard> createState() => _FacultyDashBoardState();
}

class _FacultyDashBoardState extends State<FacultyDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          "SKILLPRO",
          style: GoogleFonts.baloo(
            letterSpacing: 5,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),

      body: Center(
        child: CompetenciesList(),
      )
    );
  }
}
