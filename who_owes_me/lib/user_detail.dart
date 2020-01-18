import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'new_debt.dart';

class UserDetail extends StatefulWidget{
  UserDetail(this.name);
  String name;
  
  @override
  State<StatefulWidget> createState() {
    return new UserDetailState(name);
  }
}

class UserDetailState extends State<UserDetail>{
  UserDetailState(this.name);
  String name;
   bool loading=true;
  final databaseReference = FirebaseDatabase.instance.reference();
  Map<dynamic, dynamic> map;
  List<Widget> allCardList;
  DateFormat dateFormat = DateFormat("MMMM d y");
  List<Widget>openCardList;
  List<Widget>closedCardList;
  int _filter=0;
  List<List<Widget>> allLists;
  double totalOwed=0;
  


  getData(){
       databaseReference.child("Debts/").once().then((DataSnapshot snapshot){
                map=snapshot.value;
        loading=false;
        totalOwed=0;
        for(int i=0;i<map.values.toList().where((e)=>e['person'].toString()==name&&e['paid']=='false').length;i++)
        {
          totalOwed+=double.parse(map.values.toList().where((e)=>e['person'].toString()==name&&e['paid']=='false').toList()[i]['cost']);
          
        }
        allCardList=map.values.toList().where((e)=>e['person'].toString()==name).map((item)=>
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
                      // left: BorderSide(color: Colors.black38,width: 1.0,),
                      // right: BorderSide(color: Colors.black38,width: 1.0,),
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


        openCardList=map.values.toList().where((e)=>e['person']==name&&e['paid'].toString()=="false").map((item)=>
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

          closedCardList=map.values.toList().where((e)=>e['person']==name&&e['paid'].toString()=="true").map((item)=>
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
      print("caught error");
    }    
          
        

    
    });
    }
  
  @override
  void initState() {
        getData();  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      print("built usr detail");
      
    return Scaffold(
      appBar: AppBar(
        title: Text("User Detail"),
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(name,style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
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
                showCards(),
                
          ],
        ),
      ),
      Column(children: <Widget>[
        Divider(),
        Text("Total Owed: \$"+totalOwed.toString(),style: TextStyle(fontSize: 28),),
      ],)

      ],),
      floatingActionButton: FloatingActionButton(          
        child: Icon(Icons.attach_money),
        onPressed: () {
          Navigator.push(context,MaterialPageRoute<void>(builder: (context) => NewDebt(),));    
          },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        ), 
      
    );
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