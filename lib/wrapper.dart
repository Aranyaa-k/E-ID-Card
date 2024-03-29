// ignore_for_file: prefer_const_constructors

import 'package:dbms_project/models/user_model.dart';
import 'package:dbms_project/screens/home.dart';
import 'package:dbms_project/screens/login_signup.dart';
import 'package:dbms_project/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        if(snapshot.connectionState == ConnectionState.active)
        {
          final User? user = snapshot.data;
          return user == null? LoginSignup() : Home();
        }
        else
        {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      }
      );
  }
}