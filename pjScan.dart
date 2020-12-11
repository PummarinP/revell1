import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'pjNoti.dart';
import 'pjHome.dart';
import 'pjRank.dart';
import 'lib/pjAccount.dart';

class PjScan extends StatefulWidget {
  static String tag = 'PjScan';
  @override
  _PjScanState createState() => _PjScanState();
}

class _PjScanState extends State<PjScan> {
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
            { Navigator.of(context).pushNamed(PjHome.tag);}
            ),
            Spacer(),
            IconButton(icon: Icon(Icons.stars), onPressed: ()
             { Navigator.of(context).pushNamed(PjRank.tag);}),
             Spacer(),
             IconButton(icon: Icon(Icons.star), onPressed: ()
             { Navigator.of(context).pushNamed(PjNoti.tag);}),
            Spacer(),
             IconButton(icon: Icon(Icons.settings), onPressed: ()
             { Navigator.of(context).pushNamed(PjAccount.tag);}),
          
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.center_focus_weak),
          onPressed: () {Navigator.of(context).pushNamed(PjScan.tag);},
          backgroundColor: Colors.red[100]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
  

  //its quite simple as that you can use try and catch staatements too for platform exception

