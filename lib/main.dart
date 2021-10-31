// ignore_for_file: require_trailing_commas
// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';

import 'login.dart';
import 'sign_up_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /// Requires that the Firebase Auth emulator is running locally
  /// e.g via `melos run firebase:emulator`.
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(AuthExampleApp());
}

/// The entry point of the application.
///
/// Returns a [MaterialApp].
class AuthExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BRAM BLUR',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'OpenSans',
      ),
      home: Scaffold(
        body: AuthTypeSelector(),
      ),
    );
  }
}

/// Provides a UI to select a authentication type page
class AuthTypeSelector extends StatelessWidget {
  // Navigates to a new page
  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context) /*!*/ .push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  final _textStyle = TextStyle(
    fontSize: 22.0,
    fontFamily: 'OpenSans',
  );
  final _colorizeColors = [
    Colors.black54,
    Colors.purpleAccent,
    Colors.purple,
    Colors.deepPurple,
    Colors.deepPurple,
    Colors.deepPurpleAccent,
    Colors.deepPurpleAccent,
    Colors.blueAccent,
    Colors.blueAccent,
    Colors.blue,
    Colors.blue,
    Colors.lightBlue,
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.lightBlueAccent,
    Colors.greenAccent,
    Colors.greenAccent,
    Colors.green,
    Colors.green,
    Colors.lightGreenAccent,
    Colors.lightGreenAccent,
    Colors.lime,
    Colors.lime,
    Colors.yellowAccent,
    Colors.yellowAccent,
    Colors.yellow,
    Colors.yellow,
    Colors.orangeAccent,
    Colors.orangeAccent,
    Colors.orange,
    Colors.orange,
    Colors.deepOrange,
    Colors.deepOrange,
    Colors.redAccent,
    Colors.redAccent,
    Colors.red,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    final logo = Container(
      padding: const EdgeInsets.only(top: 16),
      alignment: Alignment.center,
      child: AnimatedTextKit(
        animatedTexts: [
          ColorizeAnimatedText('BRAM BLUR',
              textStyle: _textStyle,
              colors: _colorizeColors,
              speed: const Duration(milliseconds: 1100)),
          //FlickerAnimatedText('BLUR'),
        ],
        repeatForever: true,
      ),
    );

    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black38,
      //primary: Colors.lightGreenAccent,
      //minimumSize: Size(88, 36),
      padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 11),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
    );
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: () => _pushPage(context, RegisterPage()),
        child: Text(
          "Log In",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
    final signUpButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: () => _pushPage(context, SignInPage()),
        child: Text(
          "Sign up",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: logo,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: loginButton,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: signUpButton,
          ),
        ],
      ),
    );
  }
}
