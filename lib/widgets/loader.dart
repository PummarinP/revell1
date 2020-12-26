import 'package:flutter/material.dart';
import 'package:revell/shared/constants.dart';

class CircularProgressLoader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height * .4,
        child: new Center(child: new CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Constants.primaryColor),
        ))
    );
  }
}
