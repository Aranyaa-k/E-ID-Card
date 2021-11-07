// ignore_for_file: prefer_const_constructors

import 'package:barcode_widget/barcode_widget.dart';
import 'package:dbms_project/screens/scan_qr.dart';
import 'package:dbms_project/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final FirebaseAuth auth = FirebaseAuth.instance;
    String uid = ' '; 

    String getData() {
      final User? user = auth.currentUser;
      uid = user!.uid;
      return uid;
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Home')),
      ),
      body: Center(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 100),
              child: BarcodeWidget(
                data: getData(),//data from database current user, 
                barcode: Barcode.qrCode(),
                color: Colors.black,
                width: 250,
                height: 250,
                ),
            ),

            ElevatedButton(
              onPressed: () {
                //navigate to scanner
                 Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => QRscanner()),
                );
              }, 
              child: Text(
                'Scan QR',
                style: TextStyle(
                  fontSize: 20,
                ),
                ),
              style: ElevatedButton.styleFrom(fixedSize: const Size(200, 50)),
              ),

            SizedBox(
              height: 20,
            ),

            ElevatedButton(
              onPressed: () async {
                await authService.logOut();
              }, 
              child: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 20,
                ),
                ),
              style: ElevatedButton.styleFrom(fixedSize: const Size(200, 50)),
              ),
              
          ],
        ),
      ),
    );
  }
}