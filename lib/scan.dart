import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'Noti.dart';
import 'Home.dart';
import 'Rank.dart';
import 'profile.dart';

class Scan extends StatefulWidget {
  static String tag = 'Scan';
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  String qrCodeResult = "Not Yet Scanned";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Revell",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              qrCodeResult,
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            FlatButton(
              padding: EdgeInsets.all(15.0),
              onPressed: () async {


                String codeSanner = await BarcodeScanner.scan();    //barcode scnner
                setState(() {
                  qrCodeResult = codeSanner;
                });

                // try{
                //   BarcodeScanner.scan()    this method is used to scan the QR code
                // }catch (e){
                //   BarcodeScanner.CameraAccessDenied;   we can print that user has denied for the permisions
                //   BarcodeScanner.UserCanceled;   we can print on the page that user has cancelled
                // }


              },
              child: Text(
                "Open Your Camera",
                style:
                    TextStyle(color: Colors.red[200], fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.red[200], width: 3.0),
                  borderRadius: BorderRadius.circular(20.0)),
            )
          ],
        ),
      ),
    bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.home), onPressed: () 
            { Navigator.of(context).pushNamed(Home.tag);}
            ),
            Spacer(),
            IconButton(icon: Icon(Icons.stars), onPressed: ()
             { Navigator.of(context).pushNamed(Rank.tag);}),
             Spacer(),
             IconButton(icon: Icon(Icons.star), onPressed: ()
             { Navigator.of(context).pushNamed(Noti.tag);}),
            Spacer(),
             IconButton(icon: Icon(Icons.settings), onPressed: ()
             { Navigator.of(context).pushNamed(Profile.tag);}),
          
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.center_focus_weak),
          onPressed: () {Navigator.of(context).pushNamed(Scan.tag);},
          backgroundColor: Colors.red[100]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
  

  //its quite simple as that you can use try and catch staatements too for platform exception

