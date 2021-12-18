import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class StudentsData extends StatefulWidget {
  static const String id = 'students_data';
  const StudentsData({Key? key}) : super(key: key);

  @override
  _StudentsDataState createState() => _StudentsDataState();
}

class _StudentsDataState extends State<StudentsData> {

  CollectionReference myUsers = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAEAEA),
      body: StreamBuilder<QuerySnapshot>(
          stream: myUsers.where('role', isEqualTo: 'student').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }

            if (!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            var data = snapshot.data!.docs;
            return Column(
              children: [
                Padding(padding: const EdgeInsets.only(top: 50.0), child: Text(
                  'عدد الطلاب: ${data.length.toString()}',
                  style: const TextStyle(fontSize: 22, color: kColor),
                ),),
                Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index){
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.0),
                          child: Card(
                            elevation: 2,
                            child: ListTile(
                              trailing: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 20.0,
                                backgroundImage: AssetImage('assets/student_img.png'),
                              ),
                              title: Text(data[index]['displayName'], style: const TextStyle(fontSize: 20, color: kColor), textDirection: TextDirection.rtl),
                              // leading: Icon(Icons.arrow_back_ios,size: 40, color: Theme.of(context).primaryColor),
                            ),
                          ),
                        );
                      }
                  ),
                ),
              ],
            );
          }
      ),
    );
  }
}