import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';

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
      floatingActionButton: FloatingActionButton(onPressed: () {
        getdata();
      }),
      appBar: AppBar(
          title: Text('الخدمات'),
          centerTitle: true,
          backgroundColor: HexColor('#1dbf73')),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Expanded(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Column(children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _servicesStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      } else {
                        return Column(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;

                            return (Text(data['title']));
                          }).toList(),
                        );
                      }
                    },
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('object');
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black38),
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Image.asset('lib/assets/images/3275434.jpg'),
            ),
            Text(
              'Titljfjhg jhg jhgjhgjhg jhgjhg jhjh gjhg jhgj hgj hjhgj h jhe',
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amberAccent,
                    ),
                    Text('5.0'),
                    SizedBox(width: 10),
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.black38,
                    ),
                    Text('50'),
                  ],
                ),
                Chip(
                  label: Text(
                    'موصي به',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: HexColor('#1dbf73'),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  border: BorderDirectional(
                      top: BorderSide(color: Colors.black38))),
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('lib/assets/images/236832.png'),
                        ),
                        SizedBox(width: 20),
                        Text(
                          'username',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Text('25'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
