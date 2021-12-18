import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../admin/admin_home.dart';
import '../auth/auth_provider.dart';
import '../auth/login.dart';
import '../components/progress.dart';
import '../constants.dart';
import '../pages/profile.dart';
import '../teacher/teacher_profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    _signOut(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
          var userData=snapshot.data;

          if (!snapshot.hasData){
            return Center(
              child: circularProgress(),
            );
          }

          if (userData!.get('role') == 'student'){
            return Profile(currentUserId: FirebaseAuth.instance.currentUser!.uid);
          }
          else if (userData.get('role') == 'teacher'){
            return TeacherProfile(currentTeacherId: FirebaseAuth.instance.currentUser!.uid);
          }
          else if (userData.get('role') == 'admin'){
            return AdminHome(currentAdminId: FirebaseAuth.instance.currentUser!.uid);
          }

          return _buildWaitingScreen();
        },
      ),
    );
  }

  void _signOut(BuildContext context) async {
    try{
      var auth = AuthProvider.of(context)!.auth;
      await auth.signOut();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Login()),
              (Route<dynamic> route) => false);
    } catch(e){
      print('Error: $e');
    }
  }

  Widget _buildWaitingScreen(){
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(kColor),),
      ),
    );
  }

}
