// ignore_for_file: prefer_const_constructors, unnecessary_new
import 'package:dbms_project/screens/changepwd.dart';
import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';

class EmailVerify extends StatefulWidget {
  const EmailVerify({ Key? key }) : super(key: key);

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  bool submitValid = false;
  String msg = 'Enter details';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  EmailAuth emailAuth=new EmailAuth(sessionName: "Sample session");

  @override
  void initState() {
    super.initState();
    // Initialize the package
    emailAuth = new EmailAuth(
      sessionName: "Sample session",
    );

    /// Configuring the remote server
    emailAuth.config({
      "server": "server url",
      "serverKey": "serverKey"
    });
  }

  void sendOTP() async {
    var res = await emailAuth.sendOtp(recipientMail: _emailController.value.text, otpLength: 5);
    if (res)
    {
      setState (() {
        msg = "OTP Sent";
      });
    }
  }

  void verifyOTP() async {
    var res = emailAuth.validateOtp(recipientMail: _emailController.value.text, userOtp: _otpController.value.text);
    if (res)
    {
      setState (() {
        msg ="OTP verified";
        submitValid = true;
      });
       Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => ResetPwd()),
                );
    }
    else
    {
      setState (() {
        msg = "Invalid OTP - try again";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Email Verification')),
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
                  RequiredValidator(errorText: 'Required'),
                  EmailValidator(errorText: 'Enter valid email')
                ]
              ),
              controller: _emailController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your Email',
                suffixIcon: TextButton(
                  onPressed: () => sendOTP(),
                  child: Text('Send OTP'),
                  )
              ),
            ),
            ),
      
            SizedBox(
              height: 20,
            ),
      
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              validator:MultiValidator(
                    [
                      RequiredValidator(errorText: "Required"),
                      MinLengthValidator(6, errorText: 'Has to be 6 digits')
                    ]
                  ),
              controller: _otpController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter OTP received ',
              ),
            ),
            ),
      
            Center(
              child: SizedBox(
                height: 20,
              ),
            ),
      
            ElevatedButton(
                child: const Text(
                  'Confirm OTP',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  ),
                onPressed: () => verifyOTP(),
                style: ElevatedButton.styleFrom(fixedSize: const Size(200, 50)),
              ),
            
            Center(
              child: SizedBox(
                height: 20,
              ),
            ),
      
            Text(
              msg,
              style: TextStyle(
                color: Colors.red,
                fontSize: 15,
              ),
              )
          ],
        ),
      ),
    );
  }
}