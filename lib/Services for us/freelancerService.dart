import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

final _firestore = FirebaseFirestore.instance;

class FreelancerService {
  List itemList = [];
  FreelancerData() async {
    

    final dio = Dio();
    final response = await _firestore.collection('Freelancers').get();
    for (var freelancer in response.docs) {
      itemList.add(freelancer.data());
    }
  
    return itemList;
  }
}
