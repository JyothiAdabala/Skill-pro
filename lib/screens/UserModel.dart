import 'dart:convert';
import 'package:firstskillpro/screens/Main_Table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../styling.dart';
import 'package:get/get.dart';
// import 'package:firstskillpro/screens/competencies.dart';
import 'package:firstskillpro/styling.dart';
// import 'package:firstskillpro/screens/Main_table.dart';
import 'package:http/http.dart' as http;


Future<List<TableDetails>> fetchTableDetails() async {
  final response = await http.get(Uri.parse(
      'https://api421.herokuapp.com/competencyevaluations/competencyid/4/studentid/18pa1a05b7'));
  // Use the compute function to run parsePhotos in a separate isolate.
  // print(s);
  return parseTableDetails(response.body);

}


Future<TableDetailsDataGridSource> getTableDetailsGridSource() async {
  var competencieslist = await fetchTableDetails();
  return TableDetailsDataGridSource(competencieslist);
}


class TableDetails {
  String compentencyevaluationid;
  String patientop;
  String date;
  String time;
  int self;
  int faculty;

  TableDetails(
      {
        required this.compentencyevaluationid,
        required this.patientop,
        required this.date,
        required this.time,
        required this.self,
        required this.faculty,
        });

  factory TableDetails.fromJson(Map<String, dynamic> json) {
    return TableDetails(
      compentencyevaluationid : json['compentencyevaluationid'] as String,
        patientop: json['patientop'] as String,
        date: json['date'] as String,
        time: json['time'] as String,
        self: json['self'] as int,
        faculty: json['faculty'] as int,
        );
  }
}

List<TableDetails> parseTableDetails(String responseBody) {
  final parsedata = jsonDecode(responseBody);
  // print(parsedata);
  List<TableDetails> patientsList =
  parsedata.map<TableDetails>((json) => TableDetails.fromJson(json)).toList();
  return patientsList;
}


//GridView to display the data as table
List<GridColumn> getColumn() {
  return <GridColumn>[
    GridColumn(
      columnWidthMode: ColumnWidthMode.auto,
      columnName: 'Opnum',
      label: Container(
        color: primaryColor,
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text('Opnum',
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


class TableDetailsDataGridSource extends DataGridSource {
  TableDetailsDataGridSource(this.competenciesList) {
    buildDataGridRow();
  }
  late List<TableDetails> competenciesList;
  late List<DataGridRow> dataGridRows;
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    // TODO: implement buildRow
    return DataGridRowAdapter(color: Colors.white, cells: [
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
        DataGridCell<String>(columnName: 'Opnum', value: dataGridRow.patientop),
        // DataGridCell<String>(columnName: 'Name', value: dataGridRow.name),
        DataGridCell<int>(columnName: 'Self', value: dataGridRow.self),
        DataGridCell<int>(columnName: 'Faculty', value: dataGridRow.faculty),
      ]);
    }).toList(growable: true);
  }
}

class DemoTable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar : AppBar(
          title : Text("CompetencyTable"),
          backgroundColor: primaryColor,
        ),
        body :Padding(
          padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
          child:Expanded(
              child:Column(
                children:<Widget>[
                  FutureBuilder(
                    future: getTableDetailsGridSource(),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      print(snapshot.data);
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