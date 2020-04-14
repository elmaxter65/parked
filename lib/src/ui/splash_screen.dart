import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_flutter_2/src/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_firebase_flutter_2/src/bloc/authentication_bloc/authentication_event.dart';
import 'package:flutter_firebase_flutter_2/src/repository/user_repository.dart';

import '../../main.dart';

class Mysplash extends StatelessWidget {
  @override
  Widget build(BuildContext contextP) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen()
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final UserRepository userRepository = UserRepository();

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>
                    BlocProvider(
                      create: (context) =>
                      AuthenticationBloc(userRepository: userRepository)
                        ..add(AppStarted()),
                      child: App(userRepository: userRepository),
                    ))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/logo.png'
            , height: 200
        ),
      ),
    );
  }
}
