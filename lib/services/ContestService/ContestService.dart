
import 'dart:html';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kafilmobile/model/ContestModel/ContestModel.dart';

class contestServices {
  Future<List<Map<String, dynamic>>> getAllContests() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot contestQuerySnapshot = await firestore.collection('contests').get();

    List<Map<String, dynamic>> contests = contestQuerySnapshot.docs.map((document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      Contestnetworkmodel contest = Contestnetworkmodel.fromJson(data);
      return contest.toJson();
    }).toList();

    return contests;
  }
}

