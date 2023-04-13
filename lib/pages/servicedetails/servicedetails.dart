import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';

final firestore = FirebaseFirestore.instance;

class Servicedetails extends StatefulWidget {
  Servicedetails({super.key, this.serviceid});
  String? serviceid;

  @override
  State<Servicedetails> createState() => _ServicedetailsState();
}

class _ServicedetailsState extends State<Servicedetails> {
  @override
  Widget build(BuildContext context) {
    final docRef =
        firestore.collection("services").doc(widget.serviceid).get().then(
      (DocumentSnapshot doc) {
        Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
        print(doc.data());
      },
      onError: (e) => print("Error getting document: $e"),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#1dbf73'),
        title: Text('service'),
        centerTitle: true,
      ),
      body: FutureBuilder<Object>(
          future:
              firestore.collection("services").doc(widget.serviceid).get().then(
            (DocumentSnapshot doc) {
              Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
              print(doc.data());
              return {doc.data()!};
            },
            onError: (e) => print("Error getting document: $e"),
          ),
          builder: (context, AsyncSnapshot<Object> snapshot) {
            final servicedetails = snapshot.data;
            if (snapshot.hasData) {
              return (Text('${servicedetails}'));
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
