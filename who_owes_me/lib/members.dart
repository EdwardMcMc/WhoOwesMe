import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:who_owes_me/user_detail.dart';

class Members extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new MembersState();
  }
}

class MembersState extends State<Members>{
  bool loading=true;
  final databaseReference = FirebaseDatabase.instance.reference();
  Map<dynamic, dynamic> membersMap;
  Map<dynamic, dynamic> debtsMap;
  List<Widget> memberslist=[];

  @override
  void initState() {
    databaseReference
    //.child("Members/")
    .once().then((DataSnapshot snapshot){
    // setState(() {
      membersMap=snapshot.value["Members"];
      debtsMap=snapshot.value["Debts"];
      print("membersmaplength: "+membersMap.values.length.toString());
      print("debtsmaplength: "+debtsMap.values.length.toString());
      for(int i=0;i<membersMap.values.length;i++)
      {

        int outstanding=0;
        double totalOwed=0;
        for(int j=0;j<debtsMap.values.length;j++)
        {
          //print(i.toString()+j.toString());
          if(debtsMap.values.toList()[j]['person']==membersMap.values.toList()[i]['name']&&debtsMap.values.toList()[j]['paid']=='false')
          {
            outstanding+=1;
            totalOwed+=double.parse(debtsMap.values.toList()[j]['cost']);
            
          }

        }

        memberslist.add(
          GestureDetector(
        onTap: (){Navigator.push(context,MaterialPageRoute<void>(builder: (context) => UserDetail(membersMap.values.toList()[i]['name'])),); },
        child:Card(child: 
          Column(children:<Widget>[
            Row(mainAxisSize: MainAxisSize.max,mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[Text(membersMap.values.toList()[i]['name'],style: TextStyle(fontSize: 20),)],),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex:1,
                  child:Container(
                    decoration:BoxDecoration(border: 
                    Border(
                      // left: BorderSide(color: Colors.black38,width: 1.0,),
                      // right: BorderSide(color: Colors.black38,width: 1.0,),
                    )),
                    child:Row(mainAxisAlignment:MainAxisAlignment.center,
                    children: <Widget>[
                Icon(Icons.receipt,color: Colors.blueAccent,),
                Text(outstanding.toString()+" Outstanding")
                ],) ,
                  )
                )
              ,
              Expanded(
                  flex:1,
                  child:Container(
                    decoration:BoxDecoration(border: 
                    Border(
                      // left: BorderSide(color: Colors.black38,width: 1.0,),
                      // right: BorderSide(color: Colors.black38,width: 1.0,),
                    )),
                    child:Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                Icon(Icons.monetization_on,color: Colors.green,),
                Text(totalOwed.toString()+" Owed")
                ],) ,
                  )
                )

            ],)]),))
        );
      }
      // memberslist=membersMap.values.toList().map((item)=>
      // GestureDetector(
      //   onTap: (){Navigator.push(context,MaterialPageRoute<void>(builder: (context) => UserDetail(item['name'])),); },
      //   child:Card(child: 
      //     Column(children:<Widget>[
      //       Row(mainAxisSize: MainAxisSize.max,mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[Text(item['name'],style: TextStyle(fontSize: 20),)],),
      //       Row(children: <Widget>[
              
      //       ],)]),))
      // ).toList();
      setState(() {
        loading=false;
      });
      
    // });  
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Center(child: showMembers(),),);
  }

  showMembers(){
    if(loading)
    {
      return CircularProgressIndicator();
    }
    else
    {
      return Column(children: memberslist,);
    }
  }


}
