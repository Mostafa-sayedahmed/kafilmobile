import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';

class singleproject extends StatefulWidget {
  final Map<String, dynamic> data;
  const singleproject({required this.data});

  @override
  State<singleproject> createState() => _singleprojectState();
}

class _singleprojectState extends State<singleproject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.data['title']!=null?widget.data['title']:'no have title'),),
      body:  Card(
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          ),
        elevation: 12,
        margin: EdgeInsets.symmetric(vertical: 20,horizontal: 15),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5,),
              // CircleAvatar(radius: 20,),
              SizedBox(width: 20,),
            Expanded (
          child: SingleChildScrollView(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(radius: 20,),
                      TextButton.icon(onPressed: (){}, icon: Icon(Icons.person, color: HexColor('#1dbf73')),label: Text(widget.data['personName']!=null?widget.data['personName']:'No have title',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 22, 22, 22))),),
                    ],
                  ),
                  // Text(widget.data['personName']!=null?widget.data['personName']:'No have title',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start, 
                      children: [
                    Expanded(
                      child: Text(widget.data['discription']!=null?widget.data['discription']:'No have discription',style: TextStyle(color: Colors.blueGrey[500]), ),),
                    ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        TextButton.icon(onPressed: (){}, icon: Icon(Icons.access_time, color: HexColor('#1dbf73')),label:  Text("تاريخ النشر ",style: TextStyle(color: Colors.blueGrey[400]),),), 
                        Spacer(),
                        Text(widget.data['publishData']!=null?widget.data['publishData']:'No have publishData'),
                      ],
                    ),
                     Divider(),
                    Row(
                      children: [
                        TextButton.icon(onPressed: (){}, icon: Icon(Icons.money, color: HexColor('#1dbf73')),label:  Text("الميزانية",style: TextStyle(color:Colors.blueGrey[400] ),),), 
                        Spacer(),
                        Text(widget.data['budget']!=null?widget.data['budget']:'No have budget'),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                       TextButton.icon(onPressed: (){}, icon: Icon(Icons.access_time, color: HexColor('#1dbf73')),label:  Text('مدة المشروع',style: TextStyle(color:Colors.blueGrey[400]),),), 
                        Spacer(),
                        Text(widget.data['durationproject']!=null?widget.data['durationproject']:'No have durationproject'),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                       TextButton.icon(onPressed: (){}, icon: Icon(Icons.amp_stories_sharp, color: HexColor('#1dbf73')),label: Text(' عدد العروض',style: TextStyle(color:Colors.blueGrey[400]), ),),
                        Spacer(),
                       Text(widget.data['offers']!=null?widget.data['offers']:'No have offers'),
                      ],
                    ), 
                   Divider(),
                    Row(
                      children: [
                       TextButton.icon(onPressed: (){}, icon: Icon(Icons.money, color: HexColor('#1dbf73')),label: Text('متوسط العروض',style: TextStyle(color:Colors.blueGrey[400]), ),),
                       
                        Spacer(),
                        Expanded(child: Text(widget.data['Averageproject']!=null?widget.data['Averageproject']:'No have Averageproject')),
                      ],
                    ), 
                ],
              ),
          )
            ),
            ],
          ),
        ),
      )
                  
              
              
       );
  }
}