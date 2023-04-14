import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:carousel_slider/carousel_slider.dart';

final firestore = FirebaseFirestore.instance;

class Servicedetails extends StatefulWidget {
  Servicedetails({super.key, this.service});
  Map<String, dynamic>? service;

  @override
  State<Servicedetails> createState() => _ServicedetailsState();
}

class _ServicedetailsState extends State<Servicedetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor('#1dbf73'),
          title: Text('${widget.service!['title']}'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  CarouselSlider(
                      items: [
                        Image.network(
                          '${widget.service!['mainImg']}',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                        ),
                        for (var i in widget.service!['imgs']!)
                          Image.network(
                            i,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          )
                      ],
                      options: CarouselOptions(
                        autoPlay: true,
                        enableInfiniteScroll: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        scrollDirection: Axis.horizontal,
                        viewportFraction: 0.95,
                      )),
                  Divider(),
                  Text('الوصف'),
                  Text('${widget.service!['description']}')
                ],
              ),
            )
          ],
        ));
  }
}
