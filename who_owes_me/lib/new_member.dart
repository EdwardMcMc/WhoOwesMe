import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class NewMember extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new NewMemberState();
  }
}

class NewMemberState extends State<NewMember>{
  String _memberName;
  final _formKey = GlobalKey<FormState>();
  final databaseReference = FirebaseDatabase.instance.reference();
  var uuid = new Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Member"),),
      body: Center(child:Column(children: <Widget>[
          Form(key:_formKey,
          child:
          Column(
            children: <Widget>[
              TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Name',
                        icon: Icon(Icons.person_outline)
                        ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a Venue';
                        }
                      else if(value.length>100) {
                        return 'Please enter no more than 10 characters';
                        }
                      _memberName=value;
                      return null;
                      },
                    onFieldSubmitted: (value) {
                      _memberName=value;
                      }, 
                    ),    
            ],
          )
          ),
                    RaisedButton(child: Text('Submit'),onPressed: (){
                      if(_formKey.currentState.validate()){

                        String newid=uuid.v4();
                      databaseReference.child("Members/"+newid).set(
                        {
                          'id':newid,
                          'name':_memberName
                        }).then((onValue){
                          Navigator.pop(context,"posted");
                        });
                      }
                    },)
      ],),)
    );
  }
}