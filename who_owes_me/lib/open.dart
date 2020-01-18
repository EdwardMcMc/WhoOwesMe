import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'new_debt.dart';


class Open extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new OpenState();
  }
}

class OpenState extends State<Open>{
  bool loading=true;
  final databaseReference = FirebaseDatabase.instance.reference();
  Map<dynamic, dynamic> map;
  List<Widget> allCardList;
  DateFormat dateFormat = DateFormat("MMMM d y");
  List<Widget>openCardList;
  List<Widget>closedCardList;
  int _filter=0;
  List<List<Widget>> allLists;
  
  getData(){
    databaseReference.child("Debts/").once().then((DataSnapshot snapshot){
      setState(() {
        map=snapshot.value;
        loading=false;
        allCardList=map.values.toList().map((item)=>
        Card(child: 
          Row(children: <Widget>[
            Expanded(
              flex:1,
              child:IconButton(
                icon: Icon(Icons.info),
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute<void>(builder: (context) => NewDebt()),);    
                },
              )
            ),
            Expanded(flex: 8,
            child:
            Column(
            children: <Widget>[
            
            Text(item['title'],style: TextStyle(fontSize:28),),
            Column(children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(flex:1,
                child:Container(
                  decoration:BoxDecoration(border: 
                    Border(
                      // left: BorderSide(color: Colors.black38,width: 1.0,),
                      // right: BorderSide(color: Colors.black38,width: 1.0,),
                    )) ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.attach_money,color: Colors.green,),Text(item['cost']+' ',style: TextStyle(fontSize: 16),)
                    ],),
                ),),
                Expanded(flex:1,
                child:Container(
                  decoration:BoxDecoration(border: 
                    Border(
                      left: BorderSide(color: Colors.black38,width: 1.0,),
                      right: BorderSide(color: Colors.black38,width: 1.0,),
                    )) ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Icon(Icons.person_outline,color: Colors.blueAccent,),Text(item['person']+' ',style: TextStyle(fontSize: 16)),],),
                )),      
            ],),
            Expanded(
                  flex:0,
                  child: Container(
                  decoration:BoxDecoration(border: 
                    Border(
                      // left: BorderSide(color: Colors.black38,width: 1.0,),
                      // right: BorderSide(color: Colors.black38,width: 1.0,),
                    )) ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Icon(Icons.date_range,color:Colors.red),Text(dateFormat.format(DateTime.parse(item['date']))+' ',style: TextStyle(fontSize: 16))],),
                ),
                )
            ],)
            

          ],)
            ),
            Expanded(flex: 2,
            child:getButton(item))
          
          
          ]),)).toList();


        openCardList=map.values.toList().where((e)=>e['paid'].toString()=="false").map((item)=>
        Card(child: 
          Row(children: <Widget>[
            Expanded(flex: 8,
            child:
            Column(
            children: <Widget>[
            
            Text(item['title'],style: TextStyle(fontSize:28),),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(flex:1,
                child:Container(
                  decoration:BoxDecoration(border: 
                    Border(
                      // left: BorderSide(color: Colors.black38,width: 1.0,),
                      // right: BorderSide(color: Colors.black38,width: 1.0,),
                    )) ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.attach_money,color: Colors.green,),Text(item['cost']+' ',style: TextStyle(fontSize: 16),)
                    ],),
                ),),
                Expanded(flex:1,
                child:Container(
                  decoration:BoxDecoration(border: 
                    Border(
                      left: BorderSide(color: Colors.black38,width: 1.0,),
                      right: BorderSide(color: Colors.black38,width: 1.0,),
                    )) ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Icon(Icons.person_outline,color: Colors.blueAccent,),Text(item['person']+' ',style: TextStyle(fontSize: 16)),],),
                )),
                Expanded(
                  flex:2,
                  child: Container(
                  decoration:BoxDecoration(border: 
                    Border(
                      // left: BorderSide(color: Colors.black38,width: 1.0,),
                      // right: BorderSide(color: Colors.black38,width: 1.0,),
                    )) ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Icon(Icons.date_range,color:Colors.red),Text(dateFormat.format(DateTime.parse(item['date']))+' ',style: TextStyle(fontSize: 16))],),
                ),
                )
                ,
            ],)
          ],)
            ),
            Expanded(flex: 1,
            child:getButton(item))
          
          
          ]),)).toList();

          closedCardList=map.values.toList().where((e)=>e['paid'].toString()=="true").map((item)=>
        Card(child: 
          Row(children: <Widget>[
            Expanded(flex: 8,
            child:
            Column(
            children: <Widget>[
            
            Text(item['title'],style: TextStyle(fontSize:28),),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(flex:1,
                child:Container(
                  decoration:BoxDecoration(border: 
                    Border(
                      // left: BorderSide(color: Colors.black38,width: 1.0,),
                      // right: BorderSide(color: Colors.black38,width: 1.0,),
                    )) ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.attach_money,color: Colors.green,),Text(item['cost']+' ',style: TextStyle(fontSize: 16),)
                    ],),
                ),),
                Expanded(flex:1,
                child:Container(
                  decoration:BoxDecoration(border: 
                    Border(
                      left: BorderSide(color: Colors.black38,width: 1.0,),
                      right: BorderSide(color: Colors.black38,width: 1.0,),
                    )) ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Icon(Icons.person_outline,color: Colors.blueAccent,),Text(item['person']+' ',style: TextStyle(fontSize: 16)),],),
                )),
                Expanded(
                  flex:2,
                  child: Container(
                  decoration:BoxDecoration(border: 
                    Border(
                      // left: BorderSide(color: Colors.black38,width: 1.0,),
                      // right: BorderSide(color: Colors.black38,width: 1.0,),
                    )) ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Icon(Icons.date_range,color:Colors.red),Text(dateFormat.format(DateTime.parse(item['date']))+' ',style: TextStyle(fontSize: 16))],),
                ),
                )
                ,
            ],)
          ],)
            ),
            Expanded(flex: 1,
            child:getButton(item))
          
          
          ]),)).toList();
  
  
      allLists=[allCardList,openCardList,closedCardList];

      try{
        setState(() {
          loading=false;
        });
      }
      catch(e){

      }

      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
        



    return 
      SingleChildScrollView(child: 
        Center(child:
          Column(children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(children: <Widget>[
                  Text("All"),
                  Radio(
                    value: 0,
                    groupValue: _filter,
                    onChanged: radioPressed,
                    ),
                  ],),
                Row(children: <Widget>[
                  Text("Open"),
                  Radio(
                    value: 1,
                    groupValue: _filter,
                    onChanged: radioPressed,
                    ),
                  ],),
                Row(children: <Widget>[
                  Text("Closed"),
                  Radio(
                    value: 2,
                    groupValue: _filter,
                    onChanged: radioPressed,
                  )
            ],),
                ],),
              
              
              
            showCards()
    ],),));
  }

  showCards(){
    if(loading)
    {
      return CircularProgressIndicator();
    }
    else{
      return Column(children: allLists[_filter],);
    }
  }

  radioPressed(value){
    setState(() {
      _filter=value;
    });
  }


getButton(item){
  if(item['paid']=='true')
{
  return RaisedButton(child:Icon(Icons.check_box),onPressed: (){
            databaseReference.child('Debts/'+item['id']+'/').set({
              'id':item['id'],
              'date':item['date'],
              'title':item['title'],
              'person':item['person'],
              'cost':item['cost'],
              'paid':'false'
            }).then((onvalue){});
            getData();
          },);
}
else return RaisedButton(child:Icon(Icons.check_box_outline_blank),onPressed: (){
            databaseReference.child('Debts/'+item['id']+'/').set({
              'id':item['id'],
              'date':item['date'],
              'title':item['title'],
              'person':item['person'],
              'cost':item['cost'],
              'paid':'true'
            }).then((onvalue){});
            getData();
          },);


} 

}

