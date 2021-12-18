import 'package:flutter/material.dart';
import '../auth/auth.dart';
import '../auth/auth_provider.dart';
import '../auth/login.dart';
import '../constants.dart';
import '../pages/home.dart';


class RootPage extends StatefulWidget {
  static const String id = 'root_page';

  const RootPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

enum AuthStatus {
  login,
  notLogin,
  notKnow
}

class _RootPageState extends State<RootPage> {

  bool isAuth = false;
  late bool isAdmin;
  final String adminId1 = 'H2jAJjx4VYPInfohh6PIPzbVM322';

  AuthStatus checkLogged = AuthStatus.notKnow;
  final DateTime timestamp = DateTime.now();

  AuthStatus authStatus = AuthStatus.notKnow;

  @override
  Widget build(BuildContext context) {
    final BaseAuth auth = AuthProvider.of(context)!.auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot){
        if(snapshot.connectionState == ConnectionState.active){

          if (!snapshot.hasData){
            return const Login();
          }
          final bool isLoggedIn = snapshot.hasData;

          if (isLoggedIn){
            return const Home();

          } else {
            return const Login();
          }

        }
        else if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.none){

          print('Error in network');
        }
        return _buildWaitingScreen();
      },
    );
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