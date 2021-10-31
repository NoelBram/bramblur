// ignore_for_file: require_trailing_commas
// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

/// Entrypoint example for registering via Email/Password.
class RegisterPage extends StatefulWidget {
  /// The page title.
  final String title = 'Log In';

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool? _success;
  String _userEmail = '';

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.lightGreenAccent,
    //primary: Colors.lightGreenAccent,
    //minimumSize: Size(88, 36),padding: const EdgeInsets.symmetric(vertical: 16),
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(vertical: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(24)),
    ),
  );

  final _colorizeTextStyle = TextStyle(
    fontSize: 50.0,
    fontFamily: 'OpenSans',
  );
  final _colorizeColors = [
    Colors.black54,
    Colors.purpleAccent,
    Colors.purple,
    Colors.deepPurple,
    Colors.deepPurpleAccent,
    Colors.blueAccent,
    Colors.blue,
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.greenAccent,
    Colors.green,
    Colors.lightGreenAccent,
    Colors.lime,
    Colors.yellowAccent,
    Colors.yellow,
    Colors.orangeAccent,
    Colors.orange,
    Colors.deepOrange,
    Colors.redAccent,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    final logo = Container(
        padding: const EdgeInsets.only(top: 16),
        alignment: Alignment.center,
        child: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              'BRAM BLUR',
              textStyle: _colorizeTextStyle,
              colors: _colorizeColors,
            ),
            //FlickerAnimatedText('BLUR'),
          ],
        ));

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: _emailController,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Please enter email.';
        }
        return null;
      },
    );
    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: _passwordController,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter password.';
        }
        return null;
      },
    );
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await _register();
          }

          //Navigator.of(context).pushNamed(HomePage.tag);
        },
        child: Text(
          "Log In",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
    final forgotLabel = TextButton(
      onPressed: () {},
      child: Text(
        "Forgot password?",
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
    );
    final loginResponse = Text(
      _success == null
          ? ''
          : (_success!
              ? 'Successfully registered $_userEmail'
              : 'Registration failed'),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: logo,
                ),
                SizedBox(height: 48.0),
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: email,
                ),
                SizedBox(height: 8.0),
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: password,
                ),
                SizedBox(height: 24.0),
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: loginButton,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: forgotLabel,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: loginResponse,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Example code for registration.
  Future<void> _register() async {
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email ?? '';
      });
    } else {
      _success = false;
    }
  }
}
