import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kafilmobile/colors/colors.dart';

final firestore = FirebaseFirestore.instance;

class Servicedetails extends StatefulWidget {
  Servicedetails({super.key, this.service});
  Map<String, dynamic>? service;

  @override
  State<Servicedetails> createState() => _ServicedetailsState();
}

class _ServicedetailsState extends State<Servicedetails> {
  List checked = [
    false,
    false,
    false,
    false,
    false,
  ];

  int counter = 1;
  @override
  Widget build(BuildContext context) {
    int serviceprice = widget.service!['price'];
    int totalprice = widget.service!['price'] * counter;

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
                  Row(
                    children: [
                      Text('القسم:'),
                      Text('${widget.service!['category']}'),
                    ],
                  ),
                  CarouselSlider(
                      items: [
                        Image.network(
                          '${widget.service!['mainImg']}',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                        ),
                        if (widget.service!['imgs'] != null)
                          for (var i in widget.service!['imgs']!)
                            Image.network(
                              i,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200,
                            )
                        else
                          Text('no image'),
                      ],
                      options: CarouselOptions(
                        autoPlay: true,
                        enableInfiniteScroll: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        scrollDirection: Axis.horizontal,
                        viewportFraction: 1,
                      )),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'الوصف',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  Text('${widget.service!['description']}'),
                  Divider(),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 5),
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('شراء'),
                                Row(
                                  children: [
                                    IconButton(
                                        color: HexColor('#1dbf73'),
                                        onPressed: () {
                                          setState(() {
                                            counter >= 10 ? 10 : counter++;
                                          });
                                        },
                                        icon: Icon(Icons.add)),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      '${totalprice} \$',
                                      style: TextStyle(
                                        color: HexColor('#1dbf73'),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    IconButton(
                                        color: HexColor('#1dbf73'),
                                        onPressed: () {
                                          setState(() {
                                            counter <= 1 ? 1 : counter--;
                                          });
                                        },
                                        icon: Icon(Icons.remove)),
                                  ],
                                )
                              ]))),
                  Divider(),
                  if (widget.service!['addons'].length > 0) Text('الإضافات'),
                  for (var i in widget.service!['addons']!)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text((widget.service!['addons']!.indexOf(i) + 1)
                                .toString()),
                            Column(
                              children: [
                                Text('تفاصيل الاضافة',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13)),
                                Text(i['addonTitle']!.toString()),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Text(
                                  'السعر',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                                Text(
                                  i['addonPrice']!.toString() + ' \$',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: HexColor('#1dbf73')),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Text('مدة التوصيل',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13)),
                                Text(i['addonDeliveryDuration']!.toString() +
                                    " يوم اضافي "),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Checkbox(
                                value: checked[
                                    widget.service!['addons']!.indexOf(i)],
                                onChanged: (newvalue) {
                                  setState(() {
                                    checked[widget.service!['addons']!
                                        .indexOf(i)] = newvalue!;
                                    // serviceprice += 5;
                                    totalprice = (serviceprice * counter) + 6;
                                    print(totalprice);
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
