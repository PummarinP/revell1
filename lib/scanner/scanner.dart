import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/qrcode.dart';
import 'package:revell/models/settings.model.dart';
import 'package:revell/scanner/history.dart';
import 'package:revell/scanner/results.dart';
import 'package:revell/scanner/settings.dart';
import 'package:revell/helpers/ads.dart';
import 'package:revell/shared/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScannerPage extends StatefulWidget {
  static String tag = 'ScannerPage';
  final Settings settings;
 

  const ScannerPage(this.settings, {Key key}) : super(key: key);

  @override
  _ScannerPageState createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {

  QRCaptureController _controller = QRCaptureController();
  AudioCache _audioCache;
  bool _isTorchOn = false;
  bool _isPaused = false;
  bool disAbleTone = false;

  bool showAds = false;

  SharedPreferences prefs;



  @override
  void initState() {
    super.initState();

    showBannerAfterSeconds(15);

    _audioCache = AudioCache(prefix: "assets/tones/", fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));

    _controller.onCapture((data) {
      setSharedPref();
      if (!disAbleTone) {
        _audioCache.play('beep.mp3');
      }
      _controller.pause();
      _isPaused = true;
      Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPage(resumeScanner,result: data)),);
    });
  }


  void showIntestineAd() {
     try { Ads.interstitialShow();
     } catch (error) {
       print('error');
       print(error);
     }
  }
  @override
  void dispose() {
    _controller.pause();
    Ads.interstitialDispose();
    super.dispose();
  }


  //check if table exists if not screate new ones to avoid miss behaviours

  void showBannerAfterSeconds(int period) {
    Timer(Duration(seconds: period), () {
      setState(() {
        showAds = true;
      });
    });
  }


  void resumeScanner() {
    setState(() {
      _isPaused = false;
      _controller.resume();
    });
  }

  setSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    disAbleTone = prefs.getBool('scannerSound');

    disAbleTone = (disAbleTone != null) ? disAbleTone : false;

  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    if (widget.settings.adShowAdmob) {
      Ads.interstitialLoad(context, widget.settings);
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () => showIntestineAd(),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        "assets/box.gif",
                        height: 35.0,
                        width: 35.0,
                      ),
                    ),
                    Positioned(
                        top: 10,
                        right: 1,
                        child: Text('Ads', style: TextStyle(fontSize: 10),)),
                  ],
                ),
              ),
              Stack(
                children: [
                  Positioned(
                      top: 10,
                      right: -5,
                      child: Container(
                        margin: new EdgeInsets.symmetric(
                            horizontal: Constants.mainPadding,
                            vertical: Constants.mainPadding),
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: Constants.primaryColor.withOpacity(.2),
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                      )),
                  Container(
                    margin: new EdgeInsets.symmetric(
                        horizontal: Constants.mainPadding,
                        vertical: Constants.mainPadding),
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        border: Border.all(
                            color: Constants.primaryColor,
                            width: 2,
                            style: BorderStyle.solid)),
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      color: Colors.white.withOpacity(0.3),
                      child: Icon(Icons.sort, color: Constants.primaryColor),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      onPressed: () {
                        _controller.pause();
                        _isPaused = true;
                        Ads.interstitialLoad(context,widget.settings);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryPage(resumeScanner, widget.settings)),);
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        padding: EdgeInsets.only(top: 18),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height:  mediaQuery.size.height * .02,
              ),
              scannerDescription(mediaQuery),
              SizedBox(
                height:  mediaQuery.size.height * .04,
              ),
              scannerArea(mediaQuery),
              SizedBox(
                height:  mediaQuery.size.height * .07,
              ),
              actionButtons(mediaQuery),
              SizedBox(
                height:  mediaQuery.size.height * .02,
              ),
//              descriptionButton(mediaQuery),
              Ads.responsive(context, widget.settings)
            ],
          ),
        ),
      ),
    );
  }

  Widget scannerDescription(MediaQueryData mediaQuery) {
    return Container(
      height: mediaQuery.size.height * .11,
      margin: EdgeInsets.only(left: 25, right: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Scan QR code',
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
            style: TextStyle(
                color: Constants.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          Text(
            'Place qr code inside the'
                ' frame to scan please avoid shake'
                ' to get results quickly',
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
            style: TextStyle(
                color: Constants.greyColor,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget descriptionButton(MediaQueryData mediaQuery) {
    return Container(
      height: 60,
      width: mediaQuery.size.width * .8,
      decoration: BoxDecoration(
        color: Constants.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Center(
        child: Text(
          'Place Item on scanner zone',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }

  Widget scannerArea(MediaQueryData mediaQuery) {
    return Column(
      children: [
        (_isPaused) ?  Padding(
          padding: EdgeInsets.symmetric(horizontal: 56),
          child: AspectRatio(
            aspectRatio: 264 / 258.0,
            child: Image.asset(
              'assets/logo.png',
            ),
          ),
        ) : Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: mediaQuery.size.width * .68,
              height: mediaQuery.size.height * .39,
              child: QRCaptureView(
                controller: _controller,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 56),
              child: AspectRatio(
                aspectRatio: 264 / 258.0,
                child: Image.asset(
                  'assets/scan_area.png',
                  color: Constants.primaryColor,
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Scanner: ' + (_isPaused ? 'Paused' : 'Active'),
                style: TextStyle(color: Constants.greyColor, fontSize: 12)),
            Text('Flashlight:   ' + ((_isTorchOn) ? 'On' : 'Off'),
                style: TextStyle(color: Constants.greyColor,fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget actionButtons(MediaQueryData mediaQuery) {
    return Container(
      height: 60,
      width: mediaQuery.size.width * .6,
      margin: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              icon: Icon(
                (_isTorchOn) ? Icons.flash_on : Icons.flash_off,
                color: (_isTorchOn) ? Constants.primaryColor.withOpacity(0.5) : Colors.black.withOpacity(0.3),
                size: 50,
              ),
              onPressed: () {
                setState(() {
                  if (_isTorchOn) {
                    _controller.torchMode = CaptureTorchMode.off;
                  } else {
                    _controller.torchMode = CaptureTorchMode.on;
                  }
                  _isTorchOn = !_isTorchOn;
                });
              }),
          IconButton(
              icon: Icon(
                (!_isPaused) ? Icons.pause : Icons.play_circle_filled,
                color: (!_isPaused) ? Constants.primaryColor.withOpacity(0.5) : Colors.black.withOpacity(0.3),
                size: 50,
              ),
              onPressed: () {
                setState(() {
                  if (_isPaused) {
                    _controller.resume();
                  } else {
                    _controller.pause();
                  }

                  _isPaused = !_isPaused;
                });
              }),
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Constants.greyColor,
                size: 50,
              ),
              onPressed: () {
                _controller.pause();
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(resumeScanner)),);
              }),
        ],
      ),
    );
  }
}
