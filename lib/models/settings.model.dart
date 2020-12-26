import 'dart:convert';
import 'package:revell/helpers/parse.dart';

Settings settingsFromJson(String str) => Settings.fromMap(json.decode(str));

class Settings {
  String adAppId;
  bool adBanner;
  String adUnitIdBanner;
  bool adInterstitial;
  String adUnitIdInterstitial;
  bool adShowAdmob;

  Settings({
    this.adAppId,
    this.adBanner,
    this.adUnitIdBanner,
    this.adInterstitial,
    this.adUnitIdInterstitial,
    this.adShowAdmob
  });

  factory Settings.fromMap(Map<String, dynamic> json) => new Settings(
    adAppId: json["ad_app_id"],
    adBanner: Parse.toBool(json["ad_banner"]),
    adUnitIdBanner: json["ad_unit_id_banner"],
    adInterstitial: Parse.toBool(json["ad_interstitial"]),
    adUnitIdInterstitial: json["ad_unit_id_interstitial"],
    adShowAdmob: Parse.toBool(json["ad_show_admob"]),
  );
}