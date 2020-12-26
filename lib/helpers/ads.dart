import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:revell/models/settings.model.dart';
import 'package:revell/helpers/screen.dart';

class Ads {

  static MobileAdTargetingInfo _targetingInfo = MobileAdTargetingInfo(
    nonPersonalizedAds: true,
    childDirected: true,
  );

  static InterstitialAd _newInterstitial(Settings settings) {
    return new InterstitialAd(
      adUnitId: _getAdUnitIdInterstitial(settings),
      targetingInfo: _targetingInfo,
      listener: (event) {
        if (event == MobileAdEvent.closed) {

        }
        print('event');
        print(event);
      },
    );
  }

  static InterstitialAd _interstitialAd;

  static init({Settings settings}) {
    FirebaseAdMob.instance
        .initialize(appId: _getAppId(settings));
    Admob.initialize(_getAppId(settings));
  }

  static Widget _banner(Settings settings) {
    if(settings.adBanner){
      return Center(
        child: Container(
          width: double.maxFinite,
          height: 150.0,
          margin: EdgeInsets.only(top: 15.0),
          child: settings.adShowAdmob ?  AdmobBanner(
            adUnitId: _getAdUnitIdBanner(settings),
            adSize: AdmobBannerSize.BANNER,
          ): Container() ,
        ),
      );
    }else{
      return Container();
    }
  }

  static Widget _fullBanner(Settings settings) {
    if(settings.adBanner){
      return Center(
        child: Container(
          width: 468.0,
          height: 60.0,
          margin: EdgeInsets.only(top: 15.0),
          child: settings.adShowAdmob ? AdmobBanner(
            adUnitId: _getAdUnitIdBanner(settings),
            adSize: AdmobBannerSize.FULL_BANNER,
          ): Container(),
        ),
      );
    }else{
      return Container();
    }
  }

  static Widget _leaderBoard(Settings settings) {
    if(settings.adBanner){
      return Center(
        child: Container(
          width: 728.0,
          height: 90.0,
          margin: EdgeInsets.only(top: 15.0),
          child: settings.adShowAdmob ? AdmobBanner(
            adUnitId: _getAdUnitIdBanner(settings),
            adSize: AdmobBannerSize.LEADERBOARD,
          ): Container(),
        ),
      );
    }else{
      return Container();
    }
  }

  static Widget responsive(BuildContext context, settings){
    if (Screen.isMobile(context)) {
      if (Screen.isPortrait(context)) {
        return _banner(settings);
      } else {
        return _fullBanner(settings);
      }
    } else {
      return _leaderBoard(settings);
    }
  }

  static String _getAppId(Settings settings){
    return settings.adAppId;
  }

  static String _getAdUnitIdBanner(Settings settings) {
    return  settings.adUnitIdBanner;
  }

  static String _getAdUnitIdInterstitial(Settings settings){
    return settings.adUnitIdInterstitial;
  }

  static void interstitialLoad(BuildContext context, settings) {
    if(settings.adInterstitial){
      _interstitialAd = _newInterstitial(settings);
      _interstitialAd..load();
    }
  }

  static void interstitialShow() {
    if (_interstitialAd != null) {
      _interstitialAd.isLoaded().then((value) {
        if (value) {
          _interstitialAd..show();
        } else {
          _interstitialAd..load();
          _interstitialAd..show();

        }
      });
    }
  }

  static void interstitialDispose() {
    if (_interstitialAd != null) {
      _interstitialAd.dispose();
    }
  }
}