// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:dbms_project/screens/changepwd.dart';
import 'package:dbms_project/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Login')),
      ),
      body: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.always, 
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  validator: MultiValidator(
                    [
                      RequiredValidator(errorText: 'Required'),
                      EmailValidator(errorText: 'Enter valid email')
                    ]
                  ),
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter Email',
                  ),
                ),
              ),
        
              SizedBox(
              height: 20,
              ),
        
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  validator: MultiValidator(
                    [
                      RequiredValidator(errorText: 'Required'),
                      MinLengthValidator(7, errorText: 'Should be atleast 7 characters')
                    ]
                  ),
                  controller: passwordController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter Password',
                  ),
                  obscureText: true,
                ),
              ),
        
              SizedBox(
              height: 20,
              ),
        
              ElevatedButton(
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                    ),
                  ),
                onPressed: () async {
                  authService.signInWithEmailAndPassword(emailController.text, passwordController.text);
                  await Future.delayed(const Duration(seconds: 1), (){});
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(fixedSize: const Size(200, 50)),
              ),
        
              SizedBox(
                height: 5,
              ),
        
              TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResetPwd()),
                  );
                }, 
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}