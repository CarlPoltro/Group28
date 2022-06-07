import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _autovalidate = false;
  String _email, _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
  }

  void _handleSubmitted() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      showInSnackBar('Please enter your credentials.');
    } else {
      form.save();
      if ( _password == "password" && _email == "Alessandro") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("username", _email);
        Navigator.pushNamedAndRemoveUntil(
            context, '/home', ModalRoute.withName('/home'));
      } else {
        showInSnackBar('Incorrect credentials');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('LoginPage'),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[       
                       Center(
                              child: Icon(
                              Icons.account_circle,
                              color: Colors.purple,
                              size: 100.0,
                              ),                          
                      ),
                        const SizedBox(height: 100.0),
                       TextFormField(
                        key: Key("_mobile"),
                        decoration: InputDecoration(labelText: "Email", icon: Icon(Icons.person),border: OutlineInputBorder(),contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),),
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (String value) {
                          _email = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Email is required';
                          }
                        },
                      ),
                     const SizedBox(height: 15.0),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Password", icon: Icon(Icons.password),border: OutlineInputBorder(),contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),),
                      obscureText: true,
                      onSaved: (String value) {
                        _password = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Password is required';
                        }
                      },
                    ),
                    const SizedBox(height: 20.0),
            Center(
              child: new Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              onPressed:  _handleSubmitted,
              padding: EdgeInsets.all(12),
              color: Colors.purpleAccent,
              child: Text('Log In', style: TextStyle(color: Colors.white)),
          ),
        ),
            ),
            
            const SizedBox(height: 30.0),
          Center(
            child: Text(
              'Forgot password?',
              style: TextStyle(color: Colors.black54),
            ),
          ),
        
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}