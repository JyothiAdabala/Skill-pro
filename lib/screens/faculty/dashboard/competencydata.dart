import 'dart:convert';
import 'package:firstskillpro/screens/Main_Table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../styling.dart';
import 'package:get/get.dart';
import 'competencies.dart';
import 'package:firstskillpro/styling.dart';
// import 'package:firstskillpro/screens/Main_table.dart';
import 'package:http/http.dart' as http;

class Competencies {
  String name;
  String regno;
  int self;
  int faculty;
  int competencynum;
  String competencyname;

  Competencies(
      {required this.name,
        required this.regno,
        required this.self,
        required this.faculty,
        required this.competencynum,
        required this.competencyname});

  factory Competencies.fromJson(Map<String, dynamic> json) {
    // print(json);
    return Competencies(
        name: json['name'] as String,
        regno: json['regno'] as String,
        self: json['self'] as int,
        faculty: json['faculty'] as int,
        competencynum: json['competencynum'] as int,
        competencyname: json['competencyname'] as String);
  }
}

List<Competencies> parseCompetencies(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  List<Competencies> competenciesList =
  parsed.map<Competencies>((json) => Competencies.fromJson(json)).toList();
  return competenciesList;
}


//GridView to display the data as table
List<GridColumn> getColumn() {
  return <GridColumn>[
    GridColumn(
      columnWidthMode: ColumnWidthMode.auto,
      columnName: 'RegNo',
      label: Container(
        color: primaryColor,
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text('RegNo',
            style: GoogleFonts.poppins(color: Colors.white)
        ),
      ),
    ),
    GridColumn(
      columnName: 'Name',
      label: Container(
        color: primaryColor,
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(
            'Name',
            style: GoogleFonts.poppins(color: Colors.white)
        ),
      ),
    ),
    GridColumn(
      columnName: 'Self',
      label: Container(
        color: primaryColor,
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Text(
            'Self',
            style: GoogleFonts.poppins(color: Colors.white)
        ),
      ),
    ),
    GridColumn(
      columnName: 'Faculty',
      label: Container(
        color: primaryColor,
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(
          'Faculty',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
    ),
  ];
}


class CompetenciesDataGridSource extends DataGridSource {
  CompetenciesDataGridSource(this.competenciesList) {
    buildDataGridRow();
  }
  late List<Competencies> competenciesList;
  late List<DataGridRow> dataGridRows;
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    // TODO: implement buildRow
    return DataGridRowAdapter(color: Colors.white, cells: [
      TextButton(
          onPressed:(){
            Get.to(()=>MainTable());
          },
          child:Text(
            row.getCells()[0].value,
            style: poppins,
          )),
      Text(
        row.getCells()[1].value,
        style: poppins,
        // textAlign: TextAlign.center,
      ),
      Text(
        row.getCells()[2].value.toString(),
        style: poppins,
        textAlign: TextAlign.center,
      ),
      Text(
        row.getCells()[3].value.toString(),
        style: poppins,
      ),
    ]);
  }

  @override
  // TODO: implement rows
  List<DataGridRow> get rows => dataGridRows;
  void buildDataGridRow() {
    dataGridRows = competenciesList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'RegNo', value: dataGridRow.regno),
        DataGridCell<String>(columnName: 'Name', value: dataGridRow.name),
        DataGridCell<int>(columnName: 'Self', value: dataGridRow.self),
        DataGridCell<int>(columnName: 'Faculty', value: dataGridRow.faculty),
      ]);
    }).toList(growable: true);
  }
}

class Extra extends StatelessWidget {

  int i;
  String s;
  Extra({required Key key,required this.i,required this.s});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar : AppBar(
          title : Text("Competency - ${this.i}"),
          backgroundColor: primaryColor,
        ),
        body :Padding(
          padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
            child:Expanded(
                child:Column(
                  children:<Widget>[
                    FutureBuilder(
                      future: getCompetenciesGridSource(this.i,this.s),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        print(this.i);
                        print(this.s+"hello");
                        if (snapshot.hasData) {
                          return Flexible(
                              child: SfDataGrid(
                                  columnWidthMode: ColumnWidthMode.fill,
                                  allowSorting: true,
                                  source: snapshot.data,
                                  columns: getColumn()));
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ],
                )),
        ));
  }
}
