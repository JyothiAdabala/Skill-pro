import 'dart:convert';
import 'package:firstskillpro/screens/UserModel.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../styling.dart';

Future<List<TableDetails>> generateData() async {
  var data = await http
      .get(Uri.parse("https://api421.herokuapp.com/competencyevaluations/competencyid/4/studentid/18pa1a05b7"));
  var jsonData = json.decode(data.body);
  print("SecondUri");
  List<TableDetails> products = [];
  products = TableDetailsFromJson(data.body);

  return products;
}
List<GridColumn> getColumn() {
  return <GridColumn>[
    GridColumn(
      columnWidthMode: ColumnWidthMode.auto,
      columnName: 'PatientOp',
      label: Container(
        color: primaryColor,
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text('PatientOp',
            style: GoogleFonts.poppins(color: Colors.white)
        ),
      ),
    ),
    GridColumn(
      columnName: 'Date',
      label: Container(
        color: primaryColor,
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(
            'Date',
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
  TableDetailsDataGridSource(this.patientsList) {
    buildTableDataGridRow();
  }
  late List<TableDetails> patientsList;
  late List<DataGridRow> dataGridRows;
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    // TODO: implement buildRow
    return DataGridRowAdapter(color: Colors.white, cells: [
      Text(
        row.getCells()[1].value.toString(),
        style: poppins,
        // textAlign: TextAlign.center,
      ),
      Text(
        row.getCells()[1].value.toString(),
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
  void buildTableDataGridRow() {
    dataGridRows = patientsList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'RegNo', value: dataGridRow.patientop),
        DataGridCell<String>(columnName: 'Name', value: dataGridRow.date),
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
          title : Text("Competency Table"),
          backgroundColor: primaryColor,
        ),
        body :Padding(
          padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
          child:Expanded(
              child:Column(
                children:<Widget>[
                  FutureBuilder(
                    future: generateData(),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      print(snapshot.data);
                      if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                        return Flexible(
                            child: SfDataGrid(
                                columnWidthMode: ColumnWidthMode.fill,
                                allowSorting: true,
                                source: snapshot.data,
                                columns: getColumn()));
                      }else {
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