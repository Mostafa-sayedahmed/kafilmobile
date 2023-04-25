import 'package:cloud_firestore/cloud_firestore.dart';


final _firestore = FirebaseFirestore.instance;

class ProjectsService {
  List itemList = [];
  ProjectsofData () async {

    final response = await _firestore.collection('projects').get();
    for (var project in response.docs) {
      itemList.add(project.data());
    }
  
    return itemList;
  }
}