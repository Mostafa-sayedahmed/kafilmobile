import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kafilmobile/pages/servicedetails/servicedetails.dart';

final firestore = FirebaseFirestore.instance;
final servicesRef = firestore.collection('services');

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  List serviceslist = [];
  final Stream<QuerySnapshot> _servicesStream = servicesRef.snapshots();

  getdata() async {
    await firestore.collection('services').get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    servicesRef.get().then(
        (snapshot) => {
              print("Successfully completed"),
              for (var docSnapshot in snapshot.docs)
                {serviceslist.add(docSnapshot.data())}
            },
        onError: (e) => {
              print("Error : $e"),
            });
    return Scaffold(
      backgroundColor: HexColor('#f1f2f2'),
      floatingActionButton: FloatingActionButton(onPressed: () {
        getdata();
      }),
      appBar: AppBar(
          title: Text('الخدمات'),
          centerTitle: true,
          backgroundColor: HexColor('#1dbf73')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: StreamBuilder<QuerySnapshot>(
                  stream: _servicesStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }
                    if (snapshot.data!.docs.length == 0) {
                      return Text('no data available');
                    } else {
                      return Column(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;

                          return (ServiceCard(
                            uid: document.id,
                            title: data['title'],
                            mainImg: data['mainImg'],
                            price: data['price'],
                            rating: data['rating'],
                            orderscount: data['orderscount'],
                            isFeatured: data['isfeatured']!,
                            userid: data['userid'],
                          ));
                        }).toList(),
                      );
                    }
                  },
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  ServiceCard({
    super.key,
    String? this.uid,
    String? this.userid,
    String? this.title,
    String? this.mainImg,
    int? this.rating,
    int? this.price,
    int? this.orderscount = 0,
    bool? this.isFeatured = false,
  });
  String? uid;
  String? userid;
  String? title;
  String? mainImg;
  int? rating;
  int? price;
  int? orderscount;
  bool? isFeatured;
  String? username;
  String? userimg;
  @override
  Widget build(BuildContext context) {
    final docRef = firestore.collection("users").doc(userid);

    return FutureBuilder<List>(
        future: docRef.get().then(
          (DocumentSnapshot doc) {
            Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
            username = data['fullname'] == null ? 'no user' : data['fullname'];
            userimg = data['imgUrl'] == null ? 'no user' : data['imgUrl'];
            // print(data['fullname']);
            return [
              data['fullname'] == null ? 'no username' : data['fullname'],
              data['imgUrl'] == null ? 'no image' : data['imgUrl'],
            ];
            // return data['fullname'];
          },
          onError: (e) => print("Error getting document: $e"),
        ),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            String cardusername = snapshot.data![0];
            String carduserimg = snapshot.data![1];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Servicedetails(
                                serviceid: uid,
                              )));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(70, 0, 0, 0),
                        blurRadius: 10,
                        // spreadRadius: 5,
                        blurStyle: BlurStyle.outer,
                        // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Image.network(
                        '${mainImg}',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      ),
                      Text(
                        '$title',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amberAccent,
                                ),
                                Text('$rating'),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 1,
                                  height: 20,
                                  padding: EdgeInsets.all(30),
                                  decoration: BoxDecoration(
                                      border: BorderDirectional(
                                          start: BorderSide(
                                              color: Colors.black38))),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.shopping_cart,
                                  color: Colors.black38,
                                ),
                                Text(
                                    '${orderscount != null ? '$orderscount' : '0'}'),
                              ],
                            ),
                          ),
                          isFeatured!
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Chip(
                                    label: Text(
                                      'موصي به',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: HexColor('#1dbf73'),
                                  ),
                                )
                              : (SizedBox(
                                  width: 1,
                                ))
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: BorderDirectional(
                                top: BorderSide(color: Colors.black38))),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage('$carduserimg'),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    '$cardusername',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Text(
                                '$price \$',
                                style: TextStyle(
                                    fontSize: 18, color: HexColor('#1dbf73')),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
