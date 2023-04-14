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
    print(widget.service);
    List slides = [];
    List<String> imageUrls = [
      'https://example.com/image1.jpg',
      'https://example.com/image2.jpg',
      'https://example.com/image3.jpg'
    ];
    for (var img in widget.service!['imgs']) {
      slides.add(Image.memory(img));
    }
    print(slides);
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
                        Image.network('${widget.service!['mainImg']}'),
                        Image.network('${widget.service!['imgs']![0]!}'),
                        Image.network('${widget.service!['imgs']![1]!}'),
                        Image.network('${widget.service!['imgs']![2]!}'),
                        // for (var i in widget.service!['imgs']) Image.network(i),
                        // Image.network(url),
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
                  ListView.builder(
                    itemCount: widget.service!['imgs'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(widget.service!['imgs'][index].toString());
                    },
                  )
                ],
              ),
            )
          ],
        ));
  }
}
