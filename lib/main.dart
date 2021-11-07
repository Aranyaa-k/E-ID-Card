// ignore_for_file: prefer_const_constructors

import 'package:dbms_project/services/auth_services.dart';
import 'package:dbms_project/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      Provider<AuthService>(
        create: (_) => AuthService(),
        ),
    ],
    child: MaterialApp(
      title: 'dbmsProject',
      home: Wrapper(),
    ),
  ));
}


