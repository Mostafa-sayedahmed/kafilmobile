import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';

final firestore = FirebaseFirestore.instance;

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  getdata() async {
    await firestore.collection('services').get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        getdata();
      }),
      appBar: AppBar(
          title: Text('الخدمات'),
          centerTitle: true,
          backgroundColor: HexColor('#1dbf73')),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
