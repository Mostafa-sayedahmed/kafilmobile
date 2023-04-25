import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kafilmobile/pages/portofolio/portofolio.dart';

class SingalPortofolio extends StatefulWidget {
  final Map<String, dynamic> data;

  SingalPortofolio({required this.data});

  @override
  _SingalPortofolioState createState() => _SingalPortofolioState();
}

class _SingalPortofolioState extends State<SingalPortofolio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data['protfoloiName']),
        backgroundColor: HexColor('#1dbf73'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 8.0),
              Expanded(
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.data['ownerimg']),
                    radius: 50,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Expanded(
                  child: Column(
                children: [
                  Text(
                    widget.data['name'],
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Chip(
                    label: Text(widget.data['category']),
                    backgroundColor: Colors.grey[300],
                  ),
                ],
              )),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("المشاهدات"),
                    Icon(Icons.remove_red_eye, size: 16.0),
                    SizedBox(width: 4.0),
                    Text(widget.data['watch'].toString()),
                    SizedBox(width: 16.0),
                    Text("المفضلة"),
                    Icon(Icons.favorite, size: 16.0),
                    SizedBox(width: 4.0),
                    Text(widget.data['like'].toString()),
                  ],
                ),
              ),
              Expanded(
                  child: Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    widget.data['titel'],
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              )),
              Text("عرض الصور"),
              Image.network(
                widget.data['img'],
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}




// Row(
//                 children: [
//                   Icon(Icons.person, size: 16.0),
//                   Text("حساب المستخدم"),
//                 ],
//               ),
//               Container(
//                 height: 2,
//                 width: double.infinity,
//                 color: Colors.grey[400],
//               ),