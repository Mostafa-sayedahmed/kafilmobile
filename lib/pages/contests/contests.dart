import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:kafilmobile/services/ContestService/ContestService.dart';
// import 'package:kafilmobile/model/ContestModel/ContestModel.dart';


import 'package:kafilmobile/pages/contests/singleContest';
import 'package:kafilmobile/model/ContestModel/constModel.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';

class contestPage extends StatefulWidget {
  const contestPage({super.key});

  @override
  State<contestPage> createState() => _contestPageState();
}

class _contestPageState extends State<contestPage> {


  // bool isLoad = true;
  // List<ConstModel> freelancersBody = [];
  // late Map<String, dynamic> test;
  // List itemList = [];
  // final _firestore = FirebaseFirestore.instance;
  // Future<void> getDataContestData() async {
  //   final Freelancers = await _firestore.collection('Freelancers').get();
  //   for (var freelancer in Freelancers.docs) {
  //     itemList.add(freelancer.data());
  //   }
  //   //  print(itemList[1]['name']);
  // }

  // List DATA = [];
  // getFreelancersData() async {
  //   DATA = await FreelancerService().FreelancerData();
  //   if (DATA != []) {
  //     isLoad = false;
  //   }
  //   setState(() {});
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getFreelancersData();
  // }

   List<Map<String, dynamic>> contestEle = [];


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
                    // return SingleContest(contest:contestEle[index]);
                    return SingleContest(
                        Posts: contestEle[index]["Posts"],
                        Views: contestEle[index]["Views"],
                        accepted: contestEle[index]["accepted"],
                        comment: contestEle[index]["comment"],
                        completed: contestEle[index]["completed"],
                        conditions: contestEle[index]["conditions"],
                        contestDuration: contestEle[index]["contestDuration"],
                        contestants: contestEle[index]["contestants"],
                        deliveryDuration: contestEle[index]["deliveryDuration"],
                        description: contestEle[index]["description"],
                        firstWinner: contestEle[index]["firstWinner"],
                        sectionId: contestEle[index]["sectionId"],
                        skills: contestEle[index]["skills"],
                        title: contestEle[index]["title"],
                        userId: contestEle[index]["userId"],
                        userImg: contestEle[index]["userImg"],
                        userName: contestEle[index]["userName"],
                        winnersNum: contestEle[index]["winnersNum"],
                    );
                  },
                    itemCount: contestEle.length-1)
                  )
          ),
    );
  }
}

class SingleContest extends StatelessWidget {

  const SingleContest({super.key , required this.Posts ,required this.Views ,required this.accepted ,required this.comment ,required this.contestDuration, required this.completed ,
   required this.contestants , required this.deliveryDuration , required this.description , required this.firstWinner ,required this.sectionId , required this.conditions ,
   required this.skills , required this.title ,required this.userId , required this.userImg , required this.userName , required this.winnersNum});

    final int Posts;
    final int Views;
    final bool accepted;
    final int comment;
    final bool completed;
    final String conditions;
    final String contestDuration;
    final int contestants;
    final String deliveryDuration;
    final String description;
    final String firstWinner;
    final String sectionId;
    final String skills;
    final String title;
    final String userId;
    final String userImg;
    final String userName;
    final String winnersNum;
    
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
                        userName,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 16),
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          userImg),
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
                            sectionId,
        
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          SizedBox(height: 4),
                          // 
                            InkWell( onTap :(){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => singleContestPage(
                                  Posts: Posts,
                                  Views: Views,
                                  accepted: accepted,
                                  comment: comment,
                                  completed: completed,
                                  conditions: conditions,
                                  contestDuration: contestDuration,
                                  contestants: contestants,
                                  deliveryDuration: deliveryDuration,
                                  description: description,
                                  firstWinner: firstWinner,
                                  sectionId: sectionId,
                                  skills: skills,
                                  title: title,
                                  userId: userId,
                                  userImg: userImg,
                                  userName: userName,
                                  winnersNum: winnersNum,
                              )));
                            },
                              child: Text(
                                  title,
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                            ),
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
                            Text(firstWinner , style: TextStyle(color: Colors.grey)),
                            SizedBox(width: 8),
                            Icon(Icons.emoji_events, color: Colors.green),
                          ],
                        ),
                      ),
                      completed!
                              ? Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  Text("مكتمل",
                                      style: TextStyle(color: Colors.white)),
                                  SizedBox(width: 5),
                                  Icon(Icons.check, color: Colors.white),
                                ],
                              ),
                            )
                              : (
                              Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.orangeAccent,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  Text("بإنتظار إختيار الفائز",
                                  style: TextStyle(color: Colors.white)),
                                  SizedBox(width: 5),
                                  Icon(Icons.mic, color: Colors.white),
                                ],
                              ),
                            )
                           )
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
                            Text(
                              '${comment}',
                              style: TextStyle(color: Colors.grey)),
                            SizedBox(width: 8),
                            Icon(Icons.chat, color: Colors.grey),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                             '${Views}',
                              style: TextStyle(color: Colors.grey)),
                            SizedBox(width: 8),
                            Icon(Icons.remove_red_eye, color: Colors.grey),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${Posts}',
                              style: TextStyle(color: Colors.grey)),
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
