import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'Noti.dart';
import 'Home.dart';
import 'profile.dart';

class Scan extends StatefulWidget {
  static String tag = 'Scan';
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
            width: 100,
            height: 40,
            child: Image.asset('assets/images/Untitled_Artwork.png'),
          ),
            
            SizedBox(
              height: 20.0,
            ),
            FlatButton(
              padding: EdgeInsets.all(15.0),
              onPressed: () async {


                

                // try{
                //   BarcodeScanner.scan()    this method is used to scan the QR code
                // }catch (e){
                //   BarcodeScanner.CameraAccessDenied;   we can print that user has denied for the permisions
                //   BarcodeScanner.UserCanceled;   we can print on the page that user has cancelled
                // }


              },
              child: Text(
                "SCAN",
                style:
                    TextStyle(color: Colors.red[200], fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.red[200], width: 3.0),
                  borderRadius: BorderRadius.circular(10.0)),
            )
          ],
        ),
      ),
   bottomNavigationBar: BottomAppBar(
        color: Colors.red[200],
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.of(context).pushNamed(Home.tag);
                }),
            Spacer(),
            IconButton(
                icon: Icon(Icons.filter_center_focus),
                onPressed: () {
                  Navigator.of(context).pushNamed(Scan.tag);
                }),
            Spacer(),
            IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.of(context).pushNamed(Noti.tag);
                }),
            Spacer(),
            IconButton(
                icon: Icon(Icons.person_outline),
                onPressed: () {
                  Navigator.of(context).pushNamed(Profile.tag);
                }),


          ],
        ),
      ),
    );
  }
}
  

  //its quite simple as that you can use try and catch staatements too for platform exception

