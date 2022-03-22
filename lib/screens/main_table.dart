import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:firstskillpro/styling.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'UserModel.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class MainT extends StatelessWidget {
  // This widget is the root of your application.
  const MainT({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Add Rows',
      home: MainTable(),
    );
  }
}

Future createUser(String opnum) async {
  var url = Uri.parse(
      'https://api421.herokuapp.com/competencyevaluations/competencyid/4/studentid/18pa1a05b7/opnum');
  final response = await http.post(url, body:jsonEncode({"opnum":opnum,"fmail":"jyothiadabala@gmail.com"}));
  print("FirstUri");
  // print('Response status: ${response.statusCode}');
  // print('Response body: ${response.body}');
  var data = jsonDecode(response.body);
}


class MainTable extends StatefulWidget {

  @override
  _MainTableState createState() => _MainTableState();
}
class _MainTableState extends State<MainTable> {


  final TextEditingController opController = TextEditingController();

  DateTime dateToday =new DateTime.now();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Table'),
      ),
      body:Column(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: opController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    FloatingActionButton.extended(
                      onPressed: () async{
                        final String name = opController.text;
                        createUser(opController.text);
                        Get.to(()=>DemoTable());
                        // setState(() {
                        //   _user = user;
                        // });
                      },
                      label: Text('Add Row'),
                      backgroundColor: primaryColor,
                    )]),
            ]));
  }
}
