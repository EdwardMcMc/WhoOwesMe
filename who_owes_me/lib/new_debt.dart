import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';


class NewDebt extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return new NewDebtState();
  }
}

class NewDebtState extends State<NewDebt>{
  bool loading=true;
  Map<dynamic, dynamic> map;
  DateTime _debtDate=DateTime.now();
  String _debtTitle;
  String _debtCost;
  String _debtPerson;
  String _dateLabelText="Select a Date";
  bool _debtpaid=false;
  final _formKey = GlobalKey<FormState>();
  DateFormat dateFormat = DateFormat("MMMM d y");
  final databaseReference = FirebaseDatabase.instance.reference();
  var uuid = new Uuid();
  List<DropdownMenuItem> memberslist;
  // int initialValue=null;


  @override
  void initState() {
    databaseReference.child("Members/").once().then((DataSnapshot snapshot){
    setState(() {
      map=snapshot.value;
      memberslist=map.values.toList().map((item)=>DropdownMenuItem(child:Row(children:<Widget>[Text(item['name'])]),value: item['name'],)).toList();
      // memberslist.add(DropdownMenuItem(child: GestureDetector(onTap:(){Navigator.push(context,MaterialPageRoute<void>(builder: (context) => NewMember()),);   } ,child: Text("+ Add New Member"),),));
      // for(int i=0;i<map.values.toList().length;i++)
      // {
      //   if (map.values.toList()[i]['name']==name)
      //   {initialValue=i;}
      // }
      loading=false;
    });  
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Debt"),),
      body: SingleChildScrollView(child:Center(child:Column(children: <Widget>[
          Form(key:_formKey,
          child:
          Column(
            children: <Widget>[
              TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Title',
                        icon: Icon(Icons.title)
                        ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a Venue';
                        }
                      else if(value.length>100) {
                        return 'Please enter no more than 10 characters';
                        }
                      _debtTitle=value;
                      return null;
                      },
                    onFieldSubmitted: (value) {
                      _debtTitle=value;
                      }, 
                    ),
                    TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Cost',
                        icon: Icon(Icons.attach_money)
                        ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a Venue';
                        }
                      else if(value.length>100) {
                        return 'Please enter no more than 10 characters';
                        }
                      _debtCost=value;
                      return null;
                      },
                    onFieldSubmitted: (value) {
                      _debtCost=value;
                      },
                      keyboardType: TextInputType.phone, 
                    ),
                    personDropdown(),
                    // TextFormField(
                    // decoration: const InputDecoration(
                    //     labelText: 'Person',
                    //     icon: Icon(Icons.supervised_user_circle)
                    //     ),
                    // validator: (value) {
                    //   if (value.isEmpty) {
                    //     return 'Please enter a Venue';
                    //     }
                    //   else if(value.length>100) {
                    //     return 'Please enter no more than 10 characters';
                    //     }
                    //   _debtPerson=value;
                    //   return null;
                    //   },
                    // onFieldSubmitted: (value) {
                    //   _debtPerson=value;
                    //   }, 
                    // ),
                    CheckboxListTile(
                        title: Text("Paid?"),
                      value:_debtpaid,
                      onChanged: (bool value) {
                        setState(() {
                          _debtpaid=value;    
                        });
                      },
                    )
                    
            ],
          )
          ),
          RaisedButton.icon(
          icon:Icon(Icons.calendar_today),
          onPressed: () {
            DatePicker.showDateTimePicker(
              context, 
              showTitleActions: true, 
              minTime: DateTime(2019,1,1),//.now(),
              maxTime: DateTime(2021, 1, 1),
              onChanged: (date) {
              print('change $date');
              },
              onConfirm: (date) {
                setState(() {
                  _debtDate=date;
                _dateLabelText=dateFormat.format(date);
                });
                print('confirm $date');
              },
              currentTime: DateTime.now(),
              locale: LocaleType.en
              );
            },
          label: Text(_dateLabelText),
          ),
                    RaisedButton(child: Text('Submit'),onPressed: (){
                      if(_formKey.currentState.validate()){

                        String newid=uuid.v4();
                      databaseReference.child("Debts/"+newid).set(
                        {
                          'id':newid,
                         'date':_debtDate.toIso8601String(),
                         'title':_debtTitle,
                         'person':_debtPerson,
                         'cost':_debtCost,
                         'paid':_debtpaid.toString()
                        }).then((onValue){
                          Navigator.pop(context,"posted");
                        });
                      }
                    },)
      ],),))
    );
  }

  personDropdown() {
    if(loading)
    {
      return CircularProgressIndicator();
    }
    else{
      return     DropdownFormField(
      validator:(value){
        if(value==null)
        {
          return "Please Select Member";
        }
        setState(() {
          _debtPerson=value;
        });
        return null;
      },
      onSaved:(value){
        setState(() {
          _debtPerson=value;
        });
      },
      decoration:InputDecoration(
        icon: Icon(Icons.person_outline),
        labelText: 'Person',  
      ),
      initialValue: DropdownMenuItem(child:Row(children:<Widget>[Text('Matt')]),value: 'Matt',),
      items:memberslist
      
    );
    }
  }
}



class DropdownFormField<T> extends FormField<T> {
  DropdownFormField({
    Key key,
    InputDecoration decoration,
    T initialValue,
    List<DropdownMenuItem<T>> items,
    bool autovalidate = false,
    FormFieldSetter<T> onSaved,
    FormFieldValidator<T> validator,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          autovalidate: autovalidate,
          initialValue: items.contains(initialValue) ? initialValue : null,
          builder: (FormFieldState<T> field) {
            final InputDecoration effectiveDecoration = (decoration ?? const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return InputDecorator(
              decoration:
                  effectiveDecoration.copyWith(errorText: field.hasError ? field.errorText : null),
              isEmpty: field.value == '' || field.value == null,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<T>(
                  value: field.value,
                  isDense: true,
                  onChanged: field.didChange,
                  items: items.toList(),
                ),
              ),
            );
          },
        );
}