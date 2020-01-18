import 'package:flutter/material.dart';
import 'package:who_owes_me/members.dart';
import 'package:who_owes_me/open.dart';

import 'new_debt.dart';
import 'new_member.dart';

class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage>{
  int _currentIndex = 0;
  
  
  @override
  Widget build(BuildContext context) {

    

    List<FloatingActionButton> buttons=[
      FloatingActionButton(          
        child: Icon(Icons.attach_money),
        onPressed: () {
          Navigator.push(context,MaterialPageRoute<void>(builder: (context) => NewDebt()),);    
          },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        ),
      FloatingActionButton(          
      child: Icon(Icons.person_add),
      onPressed: () {
      Navigator.push(context,MaterialPageRoute<void>(builder: (context) => NewMember()),);    
      },
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      ),
  ];
    return Scaffold(
      appBar: AppBar(title: Text("whoowesme"),),
      body: [
        // Closed(),
        Open(),
        Members()]
        [_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.check),
                //   title: Text('Closed')
                // ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.attach_money),
                  title: Text('Debts')
                  ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.supervised_user_circle),
                  title:Text('Members')
                ),
              ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        ),
        floatingActionButton:buttons[_currentIndex],
      );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}


