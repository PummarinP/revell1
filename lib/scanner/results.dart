import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:revell/database/databaseHelper.dart';
import 'package:revell/models/scanner_data.dart';
import 'package:revell/shared/constants.dart';
import 'package:revell/widgets/rounded_input_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultPage extends StatefulWidget {
  final Function callback;
  final String result;
  final String name;
  final String scanType;
  final int id;

  const ResultPage(this.callback, {Key key, this.result, this.name, this.scanType, this.id}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  String _name;
  String _type = 'filter_center_focus';
  String _contentType = 'Default Item';
  int saveDataInt;
  SharedPreferences prefs;
  bool saveOptionDisabled = true;

  final RoundedLoadingButtonController _btnController = new RoundedLoadingButtonController();
  final textFieldController = TextEditingController();


  @override
  void initState() {
    super.initState();
    saveScannedData(widget.result);

    if (widget.scanType != null ) {
      _type =  widget.scanType;
      _name =  widget.name;
      textFieldController.text = _name;
    }
    setSharedPref();
  }

  @override
  void dispose() {
    super.dispose();
  }

  setSharedPref() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      saveOptionDisabled = prefs.getBool('saveOption');
      saveOptionDisabled = (saveOptionDisabled != null) ? saveOptionDisabled : true;
    });
  }

  Future<bool> _willPopCallback() async {
    widget.callback();
    Navigator.of(context).pop();
    return true;
  }

  Future<void> saveScannedData(data) async {
    var db = DatabaseHelper();
    ScannerData scannedData = new ScannerData.map({
      "id": null,
      "scanType":'filter_center_focus',
      'data':'data',
      'name':'',
      'createdDate':'createdDate'
    });

    var now = new DateTime.now();
    var dateDat = now.toLocal().toString();

    scannedData.id = (widget.id == null) ? null : widget.id;
    scannedData.scanType = (widget.scanType == null) ? 'scanner' : widget.scanType;
    scannedData.data = data;
    scannedData.name = (widget.name == null) ? dateDat.substring(0,10) : widget.name;
    scannedData.createdDate = dateDat;
    saveDataInt = await db.saveData(scannedData);
  }



  Future<void> saveData() async {
    var db = DatabaseHelper();
    saveDataInt = await db.updateData(saveDataInt, _name, _type);

    setState(() {
      _btnController.success();

      Timer(Duration(seconds: 3), () {
        _btnController.reset();

        widget.callback();
        Navigator.of(context).pop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: WillPopScope(
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
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height:  mediaQuery.size.height * .07,
                  ),
                  scannerResults(mediaQuery),
                  SizedBox(
                    height:  mediaQuery.size.height * .03,
                  ),
                  resultDetail(mediaQuery)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget resultDetail(MediaQueryData mediaQuery) {
    return (!saveOptionDisabled) ? Column(
      children: [
        RoundedInputField(
          hintText: "Enter description",
          icon: Icons.info_outline,
          onChanged: (value) => _name = value,
          controller: textFieldController,
        ),
        actionButtons(mediaQuery)
      ],
    ) : Container();
  }
  Widget scannerResults(MediaQueryData mediaQuery) {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Scan Results',
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              style: TextStyle(
                  color: Constants.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Container(
            child: Text(
              widget.result,
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
              style: TextStyle(
                  color: Constants.greyColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget actionButtons(MediaQueryData mediaQuery) {
    return Column(
      children: [
        Container(
          height: 60,
          width: mediaQuery.size.width * .6,
          margin: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: Icon(
                    Icons.filter_center_focus,
                    color: (_type == 'filter_center_focus') ? Constants.primaryColor.withOpacity(0.5) : Colors.black.withOpacity(0.3),
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      _type = 'filter_center_focus';
                      _contentType = 'Default Item';
                    });
                  }),

              IconButton(
                  icon: Icon(
                    Icons.contacts,
                    color: (_type == 'contacts') ? Constants.primaryColor.withOpacity(0.5) : Colors.black.withOpacity(0.3),
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      _type = 'contacts';
                      _contentType = 'Contact';

                    });
                  }),
              IconButton(
                  icon: Icon(
                    Icons.email,
                    color: (_type == 'email') ? Constants.primaryColor.withOpacity(0.5) : Colors.black.withOpacity(0.3),
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      _type = 'email';
                      _contentType = 'Email';

                    });
                  }),
              IconButton(
                  icon: Icon(
                    Icons.phone,
                    color: (_type == 'phone') ? Constants.primaryColor.withOpacity(0.5) : Colors.black.withOpacity(0.3),
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      _type = 'phone';
                      _contentType = 'Phone number';
                    });
                  }),
            ],
          ),
        ),
        Container(
          height: 60,
          width: mediaQuery.size.width * .6,
          margin: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: Icon(
                    Icons.credit_card,
                    color: (_type == 'credit_card') ? Constants.primaryColor.withOpacity(0.5) : Colors.black.withOpacity(0.3),
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      _type = 'credit_card';
                      _contentType = 'Card';

                    });
                  }),
              IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: (_type == 'shopping_cart') ? Constants.primaryColor.withOpacity(0.5) : Colors.black.withOpacity(0.3),
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      _type = 'shopping_cart';
                      _contentType = 'Product';

                    });
                  }),
              IconButton(
                  icon: Icon(
                    Icons.web,
                    color: (_type == 'web') ? Constants.primaryColor.withOpacity(0.5) : Colors.black.withOpacity(0.3),
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      _type = 'web';
                      _contentType = 'Website';
                    });
                  }),
              IconButton(
                  icon: Icon(
                    Icons.wifi,
                    color: (_type == 'wifi') ? Constants.primaryColor.withOpacity(0.5) : Colors.black.withOpacity(0.3),
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      _type = 'wifi';
                      _contentType = 'Wifi';
                    });
                  }),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Content Type: '+ _contentType, style: TextStyle(color: Constants.primaryColor),),
        ),
        Container(
          height: 50,
          width: 100,
          child: RoundedLoadingButton(
            child: Text('Save', style: TextStyle(color: Colors.white)),
            onPressed: () => (checkFields()) ?  saveData()   : _btnController.reset(),
            controller: _btnController,
            width: mediaQuery.size.width * 0.8,
            color: Constants.primaryColor.withOpacity(.8),
            elevation: 0,
            borderRadius: 10,
          ),
        )
      ],
    );
  }

  checkFields(){
    return (_name != '' && _type != '');
  }

}
