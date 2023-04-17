

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Portfolios extends StatefulWidget {
  @override
  _PortfoliosState createState() => _PortfoliosState();
}

class _PortfoliosState extends State<Portfolios> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('protfolios').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Scaffold(
          appBar: AppBar(
            title: Text("الأعمال"),
            backgroundColor: HexColor('#1dbf73'),
          ),
          body: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var data =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  // onTap: () => {
                  //   Navigator.of(context).push(MaterialPageRoute(
                  //       builder: (context) => SingalPortofolio(
                  //             data: data,
                  //           )))
                  // },
                  child: Card(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            data['img'],
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['protfoloiName'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 8.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 50,
                                                height: 50,
                                                child: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                    data['ownerimg'],
                                                  ),
                                                  radius: 12.0,
                                                ),
                                              ),
                                              SizedBox(width: 8.0),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data['name'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(data['category']),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Icon(Icons.remove_red_eye,
                                                    size: 16.0),
                                                SizedBox(width: 4.0),
                                                Text(data['watch'].toString()),
                                                SizedBox(width: 16.0),
                                                Icon(Icons.favorite,
                                                    size: 16.0),
                                                SizedBox(width: 4.0),
                                                Text(data['like'].toString()),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8.0),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
