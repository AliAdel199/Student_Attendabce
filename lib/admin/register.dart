import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../admin/admin_home.dart';
import '../auth/auth_provider.dart';
import '../components/rounded_button.dart';
import '../constants.dart';
import '../services/handle_error.dart';


class Register extends StatefulWidget {
  static const String id = 'register';
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late String _name;
  late String _department;
  late String _stage;
  late String _email;
  late String _password;
  bool showSpinner = false;
  final DateTime timestamp = DateTime.now();
  // authProblems errorType;
  ErrorHandler errorHandler = ErrorHandler();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: ModalProgressHUD(
        color: kColor,
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    _showTitle(),
                    const SizedBox(height: 40.0),
                    _showNameInput(),
                    const SizedBox(height: 20.0),
                    _showDeptInput(),
                    const SizedBox(height: 20.0),
                    _showStageInput(),
                    const SizedBox(height: 20.0),
                    _showEmailInput(),
                    const SizedBox(height: 20.0),
                    _showPasswordInput(),
                    const SizedBox(height: 20.0),
                    _showButtons(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _showTitle(){
    return Text('?????????? ????????', style: Theme.of(context).textTheme.headline3);
  }

  Widget _showNameInput(){
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        onSaved: (value) => _name = value!.trim(),
        validator: (value) => value!.isEmpty ? '?????? ?????????? ?????? ????????????' : null,
        keyboardType: TextInputType.text,
        decoration: kTextFieldDecoration.copyWith(
            hintText: '?????? ????????????',
            labelText: '??????????'
        ),
        style: const TextStyle(
            height: 1.0,
            color: kColor
        ),
      ),
    );
  }

  Widget _showDeptInput(){
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        onSaved: (value) => _department = value!.trim(),
        validator: (value) => value!.isEmpty ? '???????? ?????????? ?????? ????????????' : null,
        keyboardType: TextInputType.text,
        decoration: kTextFieldDecoration.copyWith(
            hintText: '??????????',
            labelText: '??????????'
        ),
        style: const TextStyle(
            height: 1.0,
            color: kColor
        ),
      ),
    );
  }

  Widget _showStageInput(){
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        onSaved: (value) => _stage = value!.trim(),
        validator: (value) => value!.isEmpty ? '???????? ?????????? ?????????? ????????????' : null,
        keyboardType: TextInputType.number,
        decoration: kTextFieldDecoration.copyWith(
            hintText: '??????????????',
            labelText: '??????????????'
        ),
        style: const TextStyle(
            height: 1.0,
            color: kColor
        ),
      ),
    );
  }

  Widget _showEmailInput(){
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        onSaved: (value) => _email = value!.trim(),
        validator: (value) => value!.isEmpty ? '???????? ?????????? ?????????? ????????????' : null,
        keyboardType: TextInputType.emailAddress,
        decoration: kTextFieldDecoration.copyWith(
            hintText: '??????????????',
            labelText: '??????????????'
        ),
        style: const TextStyle(
            height: 1.0,
            color: kColor
        ),
      ),
    );
  }

  Widget _showPasswordInput(){
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        onSaved: (value) => _password = value!,
        validator: (value) => value!.isEmpty ? '???????? ?????????? ?????????????? ????????????' : null,
        decoration: kTextFieldDecoration.copyWith(
            hintText: '??????????????????',
            labelText: '??????????????????'
        ),
        obscureText: true,
        style: const TextStyle(
            height: 1.0,
            color: kColor
        ),
      ),
    );
  }

  Widget _showButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: RoundedButton(
        title: '?????????? ????????????',
        colour: kColor,
        onPressed: validateAndSubmit,
        heightSize: 0,
        widthSize: 0,
      ),

    );
  }


  bool validateAndSave(){
    final form = formKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }
    else{
      return false;
    }
  }

  validateAndSubmit() async {
    if(validateAndSave()){
      setState(() {
        showSpinner = true;
      });
      try{
        var auth = AuthProvider.of(context)!.auth;
        auth.displayName = _name;
        auth.studentDepartment = _department;
        auth.studentStage = _stage;
        String user = await auth.createUserWithEmailAndPassword(_email, _password).catchError((e){
          errorHandler.handleLoginError(context, e);
          print(e);
          setState(() {
            showSpinner = false;
          });
        });
        print(user);

        showSnackBar();
        Navigator.of(context).pushNamed(AdminHome.id);

      }catch(e){
        print('Error: $e');
      }
    }
    else{
      print('Fail, email: $_email, password: $_password');
    }
  }

  void showSnackBar(){
    Navigator.of(context, rootNavigator: true).pop('dialog');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content:Text('?????? ?????????? ???????????? ??????????'),
        duration: Duration(seconds: 2),
      ),
    );

  }
}