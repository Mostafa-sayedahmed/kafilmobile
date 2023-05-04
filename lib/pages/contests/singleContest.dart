import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:kafilmobile/services/ContestService/ContestService.dart';
import 'package:kafilmobile/model/ContestModel/ContestModel.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class singleContestPage extends StatelessWidget {
  const singleContestPage(
      {super.key,
      required this.Posts,
      required this.Views,
      required this.accepted,
      required this.comment,
      required this.contestDuration,
      required this.completed,
      required this.contestants,
      required this.deliveryDuration,
      required this.description,
      required this.firstWinner,
      required this.sectionId,
      required this.conditions,
      required this.skills,
      required this.title,
      required this.userId,
      required this.userImg,
      required this.userName,
      required this.winnersNum,
      required this.id});
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
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('تفاصيل المسابقة'),
          centerTitle: true,
          backgroundColor: HexColor('#1dbf73')),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      userName,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 16),
                    CircleAvatar(
                      backgroundImage: NetworkImage(userImg),
                      radius: 30,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('التفاصيل',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                    SizedBox(width: 8),
                    Icon(Icons.list, color: Colors.grey),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(description),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('الشروط',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                    SizedBox(width: 8),
                    Icon(Icons.list, color: Colors.grey),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(conditions),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('التعليقات',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                    SizedBox(width: 8),
                    Icon(Icons.chat, color: Colors.grey),
                  ],
                ),
                SizedBox(height: 20),
                SingleComment(contestId: id),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class SingleComment extends StatelessWidget {
  SingleComment({super.key, required this.contestId});

  String? contestId;

  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final docRef = firestore
        .collection('contestsComments')
        .where('contestId', isEqualTo: contestId);

    return FutureBuilder<List<dynamic>>(
      future: docRef
          .get()
          .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          Map<String, dynamic> data = querySnapshot.docs[0].data();

          var comment =
              data['comment'] == null ? 'no comment' : data['comment'];
          var userImg =
              data['userImg'] == null ? 'no comment' : data['userImg'];
          var userName =
              data['userName'] == null ? 'no comment' : data['userName'];
          return [
            comment,
            userImg,
            userName,
          ];
        } else {
          return ['no comment'];
        }
      }),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData && snapshot.data!.length >= 2) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    snapshot.data![2],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 16),
                  CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data![1]),
                    radius: 30,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(snapshot.data![0]),
            ],
          );
        } else {
          return Text('لا يوجد تعليقات');
        }
      },
    );
  }
}
