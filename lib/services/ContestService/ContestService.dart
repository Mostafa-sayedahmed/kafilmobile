
import 'dart:html';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:kafilmobile/model/ContestModel/ContestModel.dart';

// class contestServices{

//   Future<List<Contestnetworkmodel>> getAllContests() async {

//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   QuerySnapshot contestQuerySnapshot = await firestore.collection('contests').get();

//   List<Contestnetworkmodel> contests = contestQuerySnapshot.docs.map(
//     (DocumentSnapshot<Object?> document) {
//       Map<String, dynamic> data = document.data() as Map<String, dynamic>;
//       return Contestnetworkmodel.fromJson(data);
//     }
//   ).toList();


//   return contests;
// }
  
// }

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
      // Contestnetworkmodel contest = Contestnetworkmodel(
      //   posts: data["Posts"],
      //   views: data["Views"],
      //   accepted: data["accepted"],
      //   comment: data["comment"],
      //   completed: data["completed"],
      //   conditions: data["conditions"],
      //   contestDuration: data["contestDuration"],
      //   contestants: data["contestants"],
      //   deliveryDuration: data["deliveryDuration"],
      //   description: data["description"],
      //   firstWinner: data["firstWinner"],
      //   sectionId: data["sectionId"],
      //   skills: data["skills"],
      //   title: data["title"],
      //   userId: data["userId"],
      //   userImg: data["userImg"],
      //   userName: data["userName"],
      //   winnersNum: data["winnersNum"]
      // );
      return contest.toJson();
    }).toList();

    return contests;
  }
}


// class contestServices {
//   Future<List<Contestnetworkmodel>> getAllContests() async {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     QuerySnapshot contestQuerySnapshot = await firestore.collection('contests').get();

//     List<Contestnetworkmodel> contests = contestQuerySnapshot.docs.map((document) {
//       Contestnetworkmodel data = document.data() as Contestnetworkmodel;
//       Contestnetworkmodel contest = Contestnetworkmodel.fromJson(data as Map<String, dynamic>);
//       return contest.toJson();
//     }).cast<Contestnetworkmodel>().toList();

//     return contests;
//   }
// }
