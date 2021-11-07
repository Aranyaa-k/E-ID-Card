// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class ResetPwd extends StatefulWidget {
  const ResetPwd({ Key? key }) : super(key: key);

  @override
  _ResetPwdState createState() => _ResetPwdState();
}

class _ResetPwdState extends State<ResetPwd> {
  String _email = 'X';
  String text = 'Enter email to send reset request to';
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Change password')),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.always, 
        child: Column(
          children: [
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              validator: MultiValidator(
                [
                  EmailValidator(errorText: 'Enter valid email'),
                  RequiredValidator(errorText: 'Required')
                ]
              ),
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Email',
              ),
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
            ),
            ),
      
            SizedBox(
              height: 20,
            ),
      
            Center(
              child: ElevatedButton(
                  child: const Text(
                    'Send Reset Request',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    ),
                  onPressed: () async {
                    auth.sendPasswordResetEmail(email: _email);
                    setState(() {
                      text = 'Request sent to email';
                    });
                    await Future.delayed(const Duration(seconds: 1), (){});
                    int c = 0;
                    Navigator.of(context).popUntil((_) => c++ >=2);
                  },
                  style: ElevatedButton.styleFrom(fixedSize: const Size(250, 50)),
                ),
            ),
      
            SizedBox(
              height: 20,
            ),
      
            Text(
              text,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}