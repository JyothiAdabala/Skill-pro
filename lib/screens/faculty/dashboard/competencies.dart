import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:firstskillpro/screens/faculty/dashboard/id.dart';
import 'package:firstskillpro/screens/faculty/evaluationForm/eval_form.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:firstskillpro/screens/faculty/dashboard/get_details.dart';
import '../../../styling.dart';
import '../../login/login_controller.dart';
import 'package:get/get.dart';
import 'package:firstskillpro/screens/faculty/dashboard/competencydata.dart';
import 'package:firstskillpro/styling.dart';
import 'my_globals.dart' as globals;

Future<CompetencyId> fetchIds()  async{
  final response = await http.get(Uri.parse(
      'https://api421.herokuapp.com/fdashboard/competencydetails/${globals.tmp}'));
  final parsed = jsonDecode(response.body).cast<String, dynamic>();
  return parsed;
}

class CompetencyId {
  final String competencyname;
  final int competencyid;

  CompetencyId({required this.competencyid, required this.competencyname});

  factory CompetencyId.fromJson(Map<String, dynamic> json) {
    return CompetencyId(
        competencyname: json['competencyname'],
        competencyid: json['competencyid']);
  }
}


Future<List<Competencies>> fetchCompetencies(http.Client client,int i,String s) async {
  final response = await client.get(Uri.parse(
      'https://api421.herokuapp.com/fdashboard/competencydetails/speciality/surgeon/competencyid/${i}'));
  // Use the compute function to run parsePhotos in a separate isolate.
  // print(s);
  return parseCompetencies(response.body);

}


Future<CompetenciesDataGridSource> getCompetenciesGridSource(int i,String s) async {
  var competencieslist = await fetchCompetencies(http.Client(),i,s);
  return CompetenciesDataGridSource(competencieslist);
}

var id = [4,14,24,34,44];
class CompetenciesList extends StatefulWidget {

  TextEditingController textFieldController = TextEditingController();

  CompetenciesList({Key? key}) : super(key: key);
  @override

  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<CompetenciesList> {

  @override
  void initState(){
    fetchIds();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Expanded(
        child: Column(
          children: <Widget>[
            DetailWidget(controller: controller,),
            const Divider(
              height: 20.00,
              thickness: 2.00,
              color: Colors.black,
            ),
            Expanded(
                child: ListView(
                  children: <Widget>[
                    for(int i=0;i<id.length;i++)
                      ElevatedButton(
                          onPressed: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context) => Extra(key:ObjectKey("extraScreen"),i:id[i],s:globals.tmp)));
                          },
                          child: Text('Competency ${id[i]}',
                              style: GoogleFonts.poppins(color: Colors.white))),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
