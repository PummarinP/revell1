import 'package:flutter/material.dart';
import 'package:revell/database/databaseHelper.dart';
import 'package:revell/shared/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  final Function callback;

  const SettingsPage(this.callback, {Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  SharedPreferences prefs;
  bool saveOption = false;
  bool disAbleTone = false;
  bool isDeleting = false;

  @override
  void initState() {
    super.initState();
    setSharedPref();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _willPopCallback() async {
    widget.callback();
    Navigator.of(context).pop();
    return true; // return true if the route to be popped
  }

  setSharedPref() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      if (prefs.getBool('saveOption') != null) {
        saveOption = prefs.getBool('saveOption');
      }
      if (prefs.getBool('scannerSound') != null) {
        disAbleTone = prefs.getBool('scannerSound');
      }
    });
  }

  dropDatabase() async {
    setState(() {
      isDeleting = true;
    });
    var dbHelper = DatabaseHelper();
    await dbHelper.deleteDropDatabase();
    setState(() {
      isDeleting = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        backgroundColor: Colors.white,
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
                        child: Icon(Icons.skip_previous, color: Constants.primaryColor),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        onPressed: () {
                          widget.callback();
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding:  EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Constants.primaryColor.withOpacity(0.9),
                    child: ListTile(
                      onTap: () {
                        //open edit profile
                      },
                      title: Text(
                        "Settings",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: CircleAvatar(
                        child: Icon(Icons.settings, color: Constants.primaryColor,),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Card(
                    elevation: 4.0,
                    margin:  EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.info_outline,
                            color: Constants.primaryColor,
                          ),
                          title: Text("Scanner V.1.0.0"),
                          onTap: () {
                            //open change location
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.storage,
                            color: Constants.primaryColor,
                          ),
                          title: Text("Clear Scanned data"),
                          trailing: (isDeleting) ? Container( height: 20, width: 20, decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          ),) : Icon(Icons.delete_sweep),
                          onTap: () {
                            (isDeleting) ? print('still loading') : dropDatabase();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Scanner Settings",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Constants.primaryColor,
                          ),
                        ),

                        SwitchListTile(
                          activeColor: Constants.primaryColor,
                          contentPadding:  EdgeInsets.all(0),
                          value: saveOption,
                          title: Text("Disable Save Options"),
                          onChanged: (val) {
                            setState(() {
                              saveOption = val;
                              prefs.setBool('saveOption', val);
                            });
                          },
                        ),

                        SwitchListTile(
                          activeColor: Constants.primaryColor,
                          contentPadding:  EdgeInsets.all(0),
                          value: false,
                          title: Text("Switch Dark Mode"),
                          onChanged: null,
                        ),

                        SwitchListTile(
                          activeColor: Constants.primaryColor,
                          contentPadding:  EdgeInsets.all(0),
                          value: disAbleTone,
                          title: Text("Scanner sounds"),
                          onChanged: (val) {
                            setState(() {
                              disAbleTone = val;
                              prefs.setBool('scannerSound', val);
                            });
                          },
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          "Notification Settings",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Constants.primaryColor,
                          ),
                        ),
                        SwitchListTile(
                          activeColor: Constants.primaryColor,
                          contentPadding:  EdgeInsets.all(0),
                          value: true,
                          title: Text("Receive App Updates"),
                          onChanged: null,
                        ),
                        SizedBox(height: 60.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin:  EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}