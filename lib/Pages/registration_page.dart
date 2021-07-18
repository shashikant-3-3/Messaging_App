

import 'package:flutter/material.dart';
import 'package:messaging_app/Providers/Auth_Provider.dart';
import 'package:messaging_app/services/database.dart';
import 'package:messaging_app/services/navigation.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage>{
  late double _deviceHeight;
  late double _deviceWidth;
  late GlobalKey<FormState> _formKey;
  late AuthProvider _auth;

  String ? _name;

  String ? _email;
  String ? _password ;

  _RegistrationPageState(){
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context){
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        alignment : Alignment.center,
        child: ChangeNotifierProvider<AuthProvider>.value(
          value: AuthProvider.instance,
          child: _registrationPageUI(),
        ),
      ),
    );
  }

   Widget _registrationPageUI(){
    return Builder(
      builder:  (BuildContext _context) {
        _auth = Provider.of<AuthProvider>(_context);
        return Container(
          padding: EdgeInsets.symmetric(horizontal : _deviceWidth * 0.10),
          alignment: Alignment.center,
          child : Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _heading(),
              _inputForm(),
              _registerButton(),
              _backToLoginPage(),
            ],
          ),
        );
      },
    );
  }
  Widget _heading(){
    return Container(
      height: _deviceHeight * 0.12,
      child : Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Please enter your details",
            style : TextStyle(fontSize : 25, fontWeight : FontWeight.w300 )
          ),
        ],
        )
    );
  }

  Widget _inputForm(){
    return Container(
      height: _deviceHeight * 0.35,
      child : Form(
        key: _formKey,
        onChanged: () {
          _formKey.currentState!.save();
        },
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _nameTextField(),
          _emailTextField(),
          _pswTextField(),
        ],
        ),
      ),
    );
  }

  Widget _nameTextField(){
    return TextFormField(
      autocorrect: false,
      style: TextStyle(color: Colors.white),
      validator: (_input) {
        return _input!.length != 0 
          ? null 
          : "Please enter your full name";
      },
      onSaved: (_input) {
        setState(() {
          _name = _input;
        });
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: "Name",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _emailTextField(){
    return TextFormField(
      autocorrect: false,
      style: TextStyle(color: Colors.white),
      validator: (_input) {
        return _input!.length != 0 && _input.contains("@") 
          ? null 
          : "Please enter a valid email";
      },
      onSaved: (_input) {
        setState(() {
          _email = _input;
        });
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: "Email Address",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _pswTextField(){
    return TextFormField(
      autocorrect: false,
      obscureText: true,
      style: TextStyle(color: Colors.white),
      validator: (_input) {
        return _input!.length != 0
          ? null 
          : "Please enter a password";
      },
      onSaved: (_input) {
        setState(() {
          _password = _input;
        });
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: "Password",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _registerButton(){
    return  _auth.status != AuthStatus.Authenticating 
        ? Container(
            height: _deviceHeight * 0.06,
            width: _deviceWidth,
            child: ElevatedButton(
              onPressed: () {
                if(_formKey.currentState!.validate()) {
                  _auth.registerUserWithEmailAndPassword(
                  _email!, _password!, (String _uid) async {
                    await DBService.instance.createUserInDB(_uid, _name!, _email!);
                });
              }
            },
            child: Text(
              "REGISTER",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
        ) 
      : Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        );
  }

  Widget _backToLoginPage(){
    return GestureDetector(
      onTap: (){
        NavigationService.instance.goBack();
      },
      child: Container(
        height: _deviceHeight * 0.06, 
        width: _deviceWidth, 
        child: Icon(Icons.arrow_back, size: 40),
      ),
    );
  }
}