// ignore_for_file: prefer_const_constructors

import 'package:dbms_project/screens/login.dart';
import 'package:dbms_project/screens/signup.dart';
import 'package:flutter/material.dart';

class LoginSignup extends StatelessWidget {
  const LoginSignup({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('E-ID Card')),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 250,
            ),
            
            ElevatedButton(
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 20,
                ),
                ),
              onPressed: () {
                // Navigate to second route when tapped.
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(fixedSize: const Size(200, 50)),
            ),
            
            const SizedBox(
              height: 20,
            ),

            ElevatedButton(
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 20,
                ),
                ),
              onPressed: () {
                // Navigate to second route when tapped.
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => EmailVerify()),
                );
              },
              style: ElevatedButton.styleFrom(fixedSize: const Size(200, 50)),
            ),
          ],
        ),
      ),
    );
  }
}