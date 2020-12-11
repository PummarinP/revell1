import 'package:flutter/material.dart';

class PjHome extends StatelessWidget {
  static String tag = 'PjHome';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Revell'),
          backgroundColor: Colors.red[200],
        ),

        

        bottomNavigationBar: Container(
          color: Colors.red[200],
          child: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: 'Home',
                
              ),
              Tab(
                
                icon:Icon(Icons.event) ,
                text: 'Ranking',
              ),
              Tab(
                icon: Icon(Icons.center_focus_weak),
                text: 'Scan',
              ),
              Tab(
                icon: Icon(Icons.notifications),
                text: 'Notification',
              ),
              Tab(
                icon: Icon(Icons.supervised_user_circle),
                text: 'Account',
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          Container(
            child: Text('Home'),
            color: Colors.white,
          ),
          Container(
            child: Text('Ranking'),
            color: Colors.white,
          ),
          Container(
            child: Text('Scan'),
            color: Colors.white,
          ),
          Container(
            child: Text('Notification'),
            color: Colors.white,
          ),
          Container(
            child: Text('Account'),
            color: Colors.white,
          ),
        ]),
      ),


    );
  }
}
