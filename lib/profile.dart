
import 'package:flutter/material.dart';
import 'Home.dart';
import 'Noti.dart';
import 'Scan.dart';
import 'Rank.dart';

class Profile extends StatefulWidget {
  static String tag = 'Profile';
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                 Colors.white,
                Colors.red[200],
              ],
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 73),
              child: Column(
                children: [
                
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Container(
                    height: height * 0.43,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double innerHeight = constraints.maxHeight;
                        double innerWidth = constraints.maxWidth;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: innerHeight * 0.72,
                                width: innerWidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 80,
                                    ),
                                    Text(
                                      'Jennie Kim ',
                                      style: TextStyle(
                                        color: Colors.red[200],
                                        fontFamily: 'Nunito',
                                        fontSize: 37,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Review',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                            Text(
                                              '4',
                                              style: TextStyle(
                                                 color: Colors.red[200],
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 25,
                                            vertical: 8,
                                          ),
                                          child: Container(
                                            height: 50,
                                            width: 3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Favorite',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                            Text(
                                              '1',
                                              style: TextStyle(
                                                 color: Colors.red[200],
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 110,
                              right: 20,
                              child: Icon(
                                Icons.settings ,
                                color: Colors.grey[700],
                                size: 30,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  child: Image.asset(
                                    'assets/images/Jennie.png', 
                                    width: innerWidth * 0.35,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: height * 0.5,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'My Revieww',
                            style: TextStyle(
                              color: Colors.red[200],
                              fontSize: 27,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          Divider(
                            thickness: 2.5,
                          ),
              
                          
                          Text(
                            'VitaminC',
                            style: TextStyle(
                              color: Colors.red[200],
                              fontSize: 27,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          
                          Text(
                            'IPhone12',
                            style: TextStyle(
                              color: Colors.red[200],
                              fontSize: 27,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          Text(
                            'Yamaha',
                            style: TextStyle(
                              color: Colors.red[200],
                              fontSize: 27,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          Text(
                            'Lightstick',
                            style: TextStyle(
                              color: Colors.red[200],
                              fontSize: 27,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
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
    )
      ],
    );
  }
}

