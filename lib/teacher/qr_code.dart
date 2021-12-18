import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../constants.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';



class QRCode extends StatelessWidget {
  static const String id = 'qr_code';
  QRCode({Key? key, this.currentTeacherId}) : super(key: key);

  String qrId = const Uuid().v4();
  final currentTeacherId;



  @override
  Widget build(BuildContext context) {
    var map = <String, dynamic>{};
    FirebaseFirestore.instance.collection(currentTeacherId == 'FKkkPtXNaSSl3Xaa24mXxXxVZD92' ? 'teacher1': 'teacher2').doc(getFormattedDate(DateTime.now().toString())).set({
      'attendance': FieldValue.arrayUnion([
        map['Students'] =  {
          'Name': '',
          'email': '',
          'department': '',
          'stage': '',
          'timestamp': '',
          'materials': ''
        }
      ])
    },SetOptions(merge: true));


    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          QrImage(
            data: getFormattedDate(DateTime.now().toString()),
            version: QrVersions.auto,
            size: 200.0,
            foregroundColor: gColor,
          ),
          const SizedBox(height: 20.0,),
          const Center(child: Text('شارك هذا الرمز مع الطلاب', style: TextStyle(fontSize: 22, color: kColor),)),
        ],
      ),
    );
  }

  String getFormattedDate(String date) {
    var localDate = DateTime.parse(date).toLocal();
    var inputFormat = DateFormat('yyyy-MM-dd hh:mm');
    var inputDate = inputFormat.parse(localDate.toString());
    var outputFormat = DateFormat('yyyy-MM-dd hh:mm');
    var outputDate = outputFormat.format(inputDate);
    return outputDate.toString();
  }

}

