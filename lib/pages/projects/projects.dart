import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kafilmobile/model/ProjectsModel.dart';
import 'package:kafilmobile/pages/projects/singleProjects.dart';

import '../service/projectservice/projectservice.dart';
  final db = FirebaseFirestore.instance;

class Projcets extends StatefulWidget {
  const Projcets({super.key});

  @override
  State<Projcets> createState() => _ProjcetsState();
}

class _ProjcetsState extends State<Projcets> {

  List dataproj = [];
  getProjectssData() async {
    dataproj = await ProjectsService().ProjectsofData();
    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    getProjectssData();
  }

  @override
  Widget build(BuildContext context) {
     
  final Stream<QuerySnapshot> projectData =
      FirebaseFirestore.instance.collection('projects').snapshots();
    return Scaffold(
      
      appBar: AppBar(
        title: Text("المشاريع"),
        centerTitle: true,
        backgroundColor: HexColor('#1dbf73')),
       body: StreamBuilder<QuerySnapshot>(
      stream: projectData,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: const Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: const Text("Loading"));
        }

        return ListView(
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                    print(data['title']!=null?data['title']:"no title" );
                  return   Card(
                 
                    margin: EdgeInsets.symmetric(vertical: 7,horizontal: 7),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10),
                     ),
                    child: ListTile(
                      onTap: ()=>{Navigator.of(context).push(MaterialPageRoute(builder: (context){return  singleproject( data: data,); }))},
                      // leading: ClipOval(child: Image.network(data['img']!=null?data['img']:'no have img',fit: BoxFit.cover,width: 25,height: 40,)),
                      // leading: CircleAvatar(backgroundImage: NetworkImage(data['img']!=null?data['img']:'No img'),radius: 25,),
                      leading: CircleAvatar(backgroundImage:NetworkImage('https://sm.ign.com/ign_nordic/cover/a/avatar-gen/avatar-generations_prsz.jpg'),radius: 25,),
                      title: Text(data['title']!=null?data['title']:'No Title',maxLines: 1,overflow:TextOverflow.fade,),
                      subtitle: Text(data['discription']!=null?data['discription']:'No discption.',maxLines: 2,overflow:TextOverflow.ellipsis,),  
                      trailing: Text(data['budget']!=null?data['budget']:"no budget",),
                    ),
                  );
              
              }
              )
              .toList()
              .cast(),
        );
      },
    ),   

   );
  }
}



// ===========================================

