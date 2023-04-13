import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:kafilmobile/services/ContestService/ContestService.dart';
import 'package:kafilmobile/model/ContestModel/ContestModel.dart';

import 'package:kafilmobile/pages/contests/singleContest';


// import 'package:kafilmobile/model/ContestModel/constModel.dart';

import 'package:hexcolor/hexcolor.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// final firestore = FirebaseFirestore.instance;
// import 'package:app1/view/pages/contestpage/singlecontestPage.dart';

class contestPage extends StatefulWidget {
  const contestPage({super.key});

  @override
  State<contestPage> createState() => _contestPageState();
}

class _contestPageState extends State<contestPage> {



   List<Map<String, dynamic>> contestEle = [];


  //  List<Contestnetworkmodel> contest = [];
  
  //   getdata() async {


  //   await firestore.collection('contests').get().then((e) {
      
  //     for (var doc in e.docs) {
  //       // print("${doc.id} => ${doc.data()}");
  //        contest.add(doc.data() as Contestnetworkmodel);
        
  //     }
  //     print(contest);
  //   });

  // }

  getcontestData() async {
    contestEle = await contestServices().getAllContests();

    print(contestEle);

    setState(() {});
  }



  @override
  void initState() {
    super.initState();

    getcontestData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: Text('المسابقات'),
          centerTitle: true,
          backgroundColor: HexColor('#1dbf73')
      ),
      body: Padding(
          padding: const EdgeInsets.all(12.0),
          child:
          Container(
              child:ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    print(contestEle[index]);
                    return SingleContest(contest:contestEle[index]);
                  },
                    itemCount: contestEle.length-1)
                  )
          ),
    );
  }
}

class SingleContest extends StatelessWidget {
  const SingleContest({super.key , required this.contest});
  // final ConstModel contest ;
  final contest ;
  @override
  Widget build(BuildContext context) {
    return 
        Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.white70, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "contest.userName",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 16),
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://images.rawpixel.com/image_png_1000/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvcGQxMDMtbWlzY3RoZW1ldDAwMTQ4YS1pbWFnZS5wbmc.png"),
                        radius: 30,
                      
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Design',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          SizedBox(height: 4),
                          // 
                            InkWell( onTap :(){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => singleContestPage(contest:contest)));
                            },
                              child: Text(
                                  'This design is very important, I like it',
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                            ),
                          // Text(
                          //   'This design is very important, I like it',
                          //   style: TextStyle(
                          //       fontSize: 14, fontWeight: FontWeight.bold),
                          // ),
                        ],
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            
                            Icon(Icons.attach_money , color: Colors.green),
                            SizedBox(width: 2),
                            Text('150', style: TextStyle(color: Colors.grey)),
                            SizedBox(width: 8),
                            Icon(Icons.emoji_events, color: Colors.green),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Text("First Text",
                                style: TextStyle(color: Colors.white)),
                            SizedBox(width: 5),
                            Icon(Icons.check, color: Colors.white),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.grey)),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Text('12', style: TextStyle(color: Colors.grey)),
                            SizedBox(width: 8),
                            Icon(Icons.chat, color: Colors.grey),
                          ],
                        ),
                        Row(
                          children: [
                            Text('', style: TextStyle(color: Colors.grey)),
                            SizedBox(width: 8),
                            Icon(Icons.remove_red_eye, color: Colors.grey),
                          ],
                        ),
                        Row(
                          children: [
                            Text('24', style: TextStyle(color: Colors.grey)),
                            SizedBox(width: 8),
                            Icon(Icons.cloud_upload, color: Colors.grey),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
