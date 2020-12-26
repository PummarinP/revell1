import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:revell/database/databaseHelper.dart';
import 'package:revell/helpers/ads.dart';
import 'package:revell/models/scanner_data.dart';
import 'package:revell/models/settings.model.dart';
import 'package:revell/scanner/results.dart';
import 'package:revell/shared/constants.dart';
import 'package:revell/widgets/loader.dart';

class HistoryPage extends StatefulWidget {
  final Function callback;
  final Settings settings;

  const HistoryPage(this.callback, this.settings, {Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<ScannerData> currentData;

  bool isLoading = false;
  bool isTodayDataLoaded = false;

  @override
  void initState() {
    super.initState();
    currentData = [];
    _getTodayData();
  }

  @override
  void dispose() {
    Ads.interstitialDispose();
    super.dispose();
  }

  Future<bool> _willPopCallback() async {
    Ads.interstitialShow();
    widget.callback();
    Navigator.of(context).pop();
    return true; // return true if the route to be popped
  }

  Future<void> share(ScannerData scannerData) async {
    await FlutterShare.share(
        title: scannerData.name,
        text: scannerData.data,
        chooserTitle: Constants.appTitle);
  }

  _getAllData() async {
    List<ScannerData> data = [];
    isLoading = true;
    var dbHelper = DatabaseHelper();
    await dbHelper.getAllData().then((values) {
      for (var i = 0; i < values.length; i++) {
        print(values[i]);
        data.add(values[i]);
      }
    });

    setState(() {
      isLoading = false;
      currentData = [];
      currentData = data;
      isTodayDataLoaded = false;
    });
  }


  _getTodayData() async {
    List<ScannerData> data = [];
    isLoading = true;
    var dbHelper = DatabaseHelper();
    await dbHelper.getTodayData().then((values) {
      for (var i = 0; i < values.length; i++) {
        print(values[i]);
        data.add(values[i]);
      }
    });

    setState(() {
      isLoading = false;
      currentData = [];
      currentData = data;
      isTodayDataLoaded = true;
    });
  }

  void reLoadData() {
    if (isTodayDataLoaded) {
      _getTodayData();
    } else {
      _getAllData();
    }
  }

  _deleteData(id) async {
    var dbHelper = DatabaseHelper();
    await dbHelper.deleteData(id).then((values) {

      (isTodayDataLoaded) ? _getTodayData() : _getAllData();
    });

  }


  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    if (widget.settings.adShowAdmob) {
      Ads.interstitialLoad(context, widget.settings);
    }

    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 100),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Stack(
                  children: [
                    Positioned(
                        top: 10,
                        right: -5,
                        child: Container(
                          margin: EdgeInsets.symmetric(
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
                      margin: EdgeInsets.symmetric(
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
                        child: Icon(Icons.skip_previous, color: Constants.primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {
                          Ads.interstitialShow();
                          widget.callback();
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              height: double.maxFinite,
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height:  mediaQuery.size.height * .07,
                    ),
                    historyHeader(mediaQuery),
                    historyButtons(mediaQuery),
                    SizedBox(
                      height:  mediaQuery.size.height * .02,
                    ),
                    (isLoading) ? CircularProgressLoader() : historyData(mediaQuery, currentData)
                  ],
                ),
              ),
            ),
            Ads.responsive(context, widget.settings)
          ],
        ),
      ),
    );
  }

  Widget historyData(MediaQueryData mediaQuery, List<ScannerData> scannerDatas) {
    return Container(
      height: mediaQuery.size.height * .60,
      child: (scannerDatas.length == 0 )? Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline, color: Constants.primaryColor, size: 80,),
          Text('All scanned data are listed here')
        ],
      )    :ListView.builder(
        itemCount: scannerDatas.length,
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.only(top: 2),
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final scannerData = scannerDatas[index];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: mediaQuery.size.width * .9,
                  decoration: BoxDecoration(
                      color: Constants.greyColor.withOpacity(.3),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      listTileIcon(scannerData.scanType),
                      InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute
                          (builder: (context) => ResultPage(
                          reLoadData,
                          result: scannerData.data,
                          id: scannerData.id,
                          name: scannerData.name,
                          scanType: scannerData.scanType,
                        )),),
                        child: Container(
                          width: mediaQuery.size.width * .47,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(scannerData.name,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Constants.textColor
                                ),
                              ),
                              Text(scannerData.data,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Constants.greyColor
                                ),)
                            ],
                          ),
                        ),
                      ),
                      listTileActionButtons(mediaQuery, scannerData)
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget listTileActionButtons(MediaQueryData mediaQuery, ScannerData scannerData) {
    return Container(
      width: mediaQuery.size.width * .23,
      child: Row(
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              color: Colors.white.withOpacity(0.3),
              child: Icon(Icons.delete_outline, color: Constants.textColor),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
              onPressed: () {
                _deleteData(scannerData.id);
              },
            ),
          ),
          SizedBox(
            height: 40,
            width: 10,
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              color: Colors.white.withOpacity(0.3),
              child: Icon(Icons.share, color: Constants.textColor),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
              onPressed: () {
                share(scannerData);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget listTileIcon(String iconData) {
    return Stack(
      children: [
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
          child: Icon(_getIcon(iconData), color: Constants.primaryColor),
        ),
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
            ))
      ],
    );
  }

  Widget historyButtons(MediaQueryData mediaQuery) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          child: FlatButton(
            padding: EdgeInsets.all(0),
            color: (isTodayDataLoaded) ? Constants.primaryColor : Constants.greyColor.withOpacity(.3),
            child: Text('Today', style: TextStyle(
                color: (isTodayDataLoaded) ? Colors.white : Constants.textColor
            ),),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(50.0),
            ),
            onPressed: () {
              _getTodayData();
            },
          ),
        ),
        SizedBox(
          width:  mediaQuery.size.height * .03,
        ),
        Container(
          height: 50,
          width: 100,
          child: FlatButton(
            padding: EdgeInsets.all(0),
            color: (!isTodayDataLoaded) ? Constants.primaryColor : Constants.greyColor.withOpacity(.3),
            child: Text('All', style: TextStyle(
                color: (isTodayDataLoaded) ? Constants.textColor : Colors.white
            ),),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(50.0),
            ),
            onPressed: () {
              _getAllData();
            },
          ),
        ),
      ],
    );
  }

  Widget historyHeader(MediaQueryData mediaQuery) {
    return Container(
      height: mediaQuery.size.height * .12,
      margin: EdgeInsets.only(left: 25, right: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Scanning History',
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
            style: TextStyle(
                color: Constants.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          Text(
            'Scanner will keep your last 14 days history,'
                ' Pro version of the app is on the way.'
                ' Be patient good stuff is comming',
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

  IconData _getIcon(String iconData) {
    IconData  data = Icons.filter_center_focus;

    if (iconData == 'contacts') {
      data =  Icons.contacts;
    } else if (iconData == 'email') {
      data =  Icons.email;
    } else if (iconData == 'phone') {
      data =  Icons.phone;
    } else if (iconData == 'credit_card') {
      data =  Icons.credit_card;
    } else if (iconData == 'shopping_cart') {
      data =  Icons.shopping_cart;
    } else if (iconData == 'web') {
      data =  Icons.web;
    } else if (iconData == 'wifi') {
      data =  Icons.wifi;
    }
    return data;
  }
}
