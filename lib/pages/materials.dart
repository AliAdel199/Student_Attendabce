import 'package:flutter/material.dart';
import '../components/rounded_button.dart';
import '../constants.dart';
import '../pages/qr_scanner.dart';

class Materials extends StatelessWidget {
  const Materials({Key? key, this.studentName, this.email, this.stage, this.department, this.timestamp}) : super(key: key);

  final studentName;
  final email;
  final stage;
  final department;
  final timestamp;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedButton(
              title: 'انكليزي',
              colour: gColor,
              widthSize: 0,
              heightSize: 0,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => QrScanner(
                  studentName: studentName,
                  email: email,
                  department: department,
                  stage: stage,
                  timestamp: timestamp,
                  material: 'english',
                )));
              },
            ),
            RoundedButton(
              title: 'ادارة مشاريع',
              colour: gColor,
              widthSize: 0,
              heightSize: 0,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => QrScanner(
                  studentName: studentName,
                  email: email,
                  department: department,
                  stage: stage,
                  timestamp: timestamp,
                  material: 'projects_managemant',
                )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
