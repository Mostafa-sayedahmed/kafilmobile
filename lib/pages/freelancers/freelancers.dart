import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kafilmobile/Services%20for%20us/freelancerService.dart';
import 'package:kafilmobile/model/freelancermodel.dart';
import 'package:kafilmobile/pages/freelancers/singleFreelancer.dart';
import 'package:kafilmobile/pages/home/home.dart';
import 'package:kafilmobile/pages/register/register.dart';

class Freelancers extends StatefulWidget {
  const Freelancers({super.key});

  @override
  State<Freelancers> createState() => _FreelancersState();
}

class _FreelancersState extends State<Freelancers> {
  bool isLoad = true;
  List<FreelancerModel> freelancersBody = [];
  late Map<String, dynamic> test;
  List itemList = [];
  final _firestore = FirebaseFirestore.instance;
  Future<void> getDataFreelancers() async {
    final Freelancers = await _firestore.collection('Freelancers').get();
    for (var freelancer in Freelancers.docs) {
      itemList.add(freelancer.data());
    }
    //  print(itemList[1]['name']);
  }

  List DATA = [];
  getFreelancersData() async {
    DATA = await FreelancerService().FreelancerData();
    if (DATA != []) {
      isLoad = false;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getFreelancersData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   backgroundColor: HexColor('#1dbf73'),
        //   title: Row(
        //     children: [
        //       Icon(
        //         Icons.people,
        //       ),
        //       SizedBox(width: 25),
        //       Text(
        //         "Freelancers",
        //       )
        //     ],
        //   ),
        //   elevation: 0,
        // ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: isLoad
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.lightGreen,
                      ),
                    )
                  : ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return FREELANCER(
                          name: DATA[index]['name'],
                          title: DATA[index]['title'],
                          img: DATA[index]['img'],
                        );
                      },
                      itemCount: DATA.length,
                    ),
            )));
  }
}

class ActiveOne extends StatelessWidget {
  const ActiveOne({super.key, required this.img, required this.data});
  final String img;
  final String data;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      child: Column(
        children: [
          InkWell(child: CircleAvatar(backgroundImage: NetworkImage(img))),
          Text(
            data,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// class MyWidget extends StatelessWidget {
//   const MyWidget(
//       {super.key,
//       required this.name,
//       required this.text,
//       required this.time,
//       required this.img});
//   final String name;
//   final String text;
//   final String time;
//   final String img;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         InkWell(onTap: (){
//            Navigator.push(context,MaterialPageRoute(builder: (context) => SingleFreelancer(freelancerName: name,)));
//           },
//           child: CircleAvatar(
//             backgroundImage: NetworkImage(img),
//           ),
//         ),
//         SizedBox(width: 10),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(name, style: TextStyle(fontSize: 14)),
//             SizedBox(
//               height: 2,
//             ),
//             Row(
//               children: [
//                 Container(
//                     width: MediaQuery.of(context).size.width * 0.6,
//                     child: Text(
//                       text,
//                       style: TextStyle(fontSize: 10),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     )),
//                 SizedBox(width: 10),
//                 Container(
//                   width: 5,
//                   height: 5,
//                   decoration:
//                       BoxDecoration(shape: BoxShape.circle, color: Colors.red),
//                 ),
//                 SizedBox(width: 3),
//                 Text(
//                   time,
//                   style: TextStyle(fontSize: 10),
//                 )
//               ],
//             ),
//             SizedBox(height: 25),
//           ],
//         )
//       ],
//     );
//   }
// }
class FREELANCER extends StatelessWidget {
  const FREELANCER({
    super.key,
    required this.name,
    required this.title,
    required this.img,
  });
  final String name;
  final String title;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(img),
              ),
              title: Text(name),
              subtitle: Text(title),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('SEE MORE DETAILS !'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SingleFreelancer(
                                  freelancerName: name,
                                  freelancerImg: img,
                                  freelancerTitle: title,
                                )));
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
