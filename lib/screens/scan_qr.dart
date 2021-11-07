// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbms_project/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QRscanner extends StatefulWidget {
  const QRscanner({ Key? key }) : super(key: key);

  @override
  _QRscannerState createState() => _QRscannerState();
}

class _QRscannerState extends State<QRscanner> {
  String res = 'unknown';

  String fullName = 'nullllll';
  String reg = 'null';
  String email ='null';
  String year = 'null';
  String dob = 'null';
  String course = 'null';
  String docid = 'null';
  String hosteller = 'null';

  Future<void> scanQRcode() async {
    try{
    final res = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',//lineColor 
      'Cancel',//cancelButtonText, 
      true,//isShowFlashIcon, 
      ScanMode.QR//scanMode
      );

    if(!mounted) return;

    setState(() {
      this.res = res;
    });
    } catch (e){
      res = 'Failed';
    }
  }  

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    CollectionReference user = FirebaseFirestore.instance.collection('Students');

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Scan QR Code')),
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            FutureBuilder<DocumentSnapshot>(
              future: user.doc(res).get(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if(snapshot.hasError){
                  return Text("Something went wrong");
                }
                if(snapshot.hasData && !snapshot.data!.exists){
                  return Text(
                    "Scan to get data",
                    style: TextStyle(
                      color: Colors.red
                    ),
                    );
                }
                if(snapshot.connectionState == ConnectionState.done){
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  return Card(
                    color: Colors.blueGrey[100],
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [

                        ListTile(
                          leading: Icon(Icons.account_circle,size: 50,),
                          title: Text(
                            "Full Name: ${data['Full Name']}",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                          subtitle: Text(
                            "Reg. no: ${data['Reg no']}",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: 19,
                              ),
                          ),
                        ),

                        FutureBuilder(
                          future: storage.downloadURL(res,'$res.png'),
                          builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                            if(snapshot.connectionState == ConnectionState.done && snapshot.hasData)
                            {
                              return Center(
                                child: SizedBox(
                                  width: 200,
                                  height: 200,
                                  child: Image.network(snapshot.data!,fit: BoxFit.cover,),
                                ),
                              );
                            }
                            if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData)
                            {
                              return CircularProgressIndicator();
                            }
                            return Container();
                          },
                          ),

                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email:   ${data['Email']}",
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              ),

                              SizedBox(
                                height: 10,
                              ),

                              Text(
                                "Phone:   ${data['Phone']}",
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              ),

                              SizedBox(
                                height: 10,
                              ),

                              Text(
                                "Course:   ${data['Course']}",
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              ),

                              SizedBox(
                                height: 10,
                              ),

                              Text(
                                "DOB:   ${data['Dob']}",
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              ),

                              SizedBox(
                                height: 10,
                              ),

                              Text(
                                "Hosteller:   ${data['Hosteller']}",
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              ),

                              SizedBox(
                                height: 10,
                              ),

                              Text(
                                "Validity:   ${data['Year']}",
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              ),

                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Text('loading');
              }
              ),

              SizedBox(
                height: 20,
              ),

            ElevatedButton(
              onPressed: () => scanQRcode(), 
              child: Text(
                'Start Scan',
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
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: Text(
                'Exit',
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