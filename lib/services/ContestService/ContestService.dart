
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kafilmobile/model/ContestModel/ContestModel.dart';

class contestServices{

  Future<List<Contestnetworkmodel>> getAllContests() async {
  // Retrieve all contest documents from Firebase
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot contestQuerySnapshot = await firestore.collection('contests').get();

  // Convert each contest document to an instance of Contestnetworkmodel and store in a list
  print(contestQuerySnapshot);

  // List<Contestnetworkmodel> contests = contestQuerySnapshot.docs.map(
  //   (DocumentSnapshot document) => Contestnetworkmodel.fromJson(document.data())
  // ).toList();

  List<Contestnetworkmodel> contests = contestQuerySnapshot.docs.map(
    (DocumentSnapshot<Object?> document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      return Contestnetworkmodel.fromJson(data);
    }
  ).toList();


  return contests;

}
  
}


// import 'package:kafilmobile/model/ContestModel/ContestModel.dart';

// const String site = "https://jsonplaceholder.typicode.com/";

// import 'package:cloud_firestore/cloud_firestore.dart';

// class contestServices{
//   // String albumsLink = "albums";

//   Future<List<Contestnetworkmodel>> contestData() async{
//     List<Contestnetworkmodel> contest = [];
//     // final dio = Dio();
//     // try{
//     //   final response = await dio.get('${site}${albumsLink}');
//     //   response.data.forEach((ele){
//     //     Contestnetworkmodel album = Contestnetworkmodel.fromJson(ele);
//     //     albums.add(album);
//     //   });
//     //   print(response.data);
//     // }catch(e){
//     //   print(e);
//     // }



