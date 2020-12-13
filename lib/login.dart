import 'package:flutter/material.dart';
import 'home.dart';

class Login extends StatefulWidget {
  static String tag = 'Login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final TextField _txtUserName = TextField(
      decoration: InputDecoration(
          hintText: 'Enter your Username',
          contentPadding: EdgeInsets.all(10.0),
          border: InputBorder.none),
      keyboardType: TextInputType.text,
    );
    final TextField _txtPassWord = TextField(
      decoration: InputDecoration(
          hintText: 'Enter your Password',
          contentPadding: EdgeInsets.all(10.0),
          border: InputBorder.none),
      keyboardType: TextInputType.text,
      obscureText: true,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.red[200],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300.0,
            height: 300.0,
            child: Image.asset('assets/images/Untitled_Artwork.png'),
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 240, 240, 240),
              border: Border.all(width: 1.2, color: Colors.black12),
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
            child: _txtUserName,
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 240, 240, 240),
              border: Border.all(width: 1.2, color: Colors.black12),
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
            child: _txtPassWord,
          ),
          SizedBox(
            child: Text(
              'Forgotpassword?',
              style: TextStyle(
                color: Colors.black38,
                fontSize: 14.0,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
            width: 20.0,
          ),
          RaisedButton(
              child: Text('Login'),
              textColor: Colors.white,
              color: Colors.red[300],
              onPressed: () {
                Navigator.of(context).pushNamed(Home.tag);
              }),
        ],
      ),
    );
  }
}
