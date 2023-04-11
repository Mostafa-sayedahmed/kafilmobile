import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:kafilmobile/services/ContestService/ContestService.dart';
import 'package:kafilmobile/model/ContestModel/ContestModel.dart';

import 'package:flutter/material.dart';
// import 'package:app1/view/pages/contestpage/singlecontestPage.dart';

class contestPage extends StatefulWidget {
  const contestPage({super.key});

  @override
  State<contestPage> createState() => _contestPageState();
}

class _contestPageState extends State<contestPage> {
  List<Contestnetworkmodel> contest = [];
  bool isload = true;

  getcontestData() async {
    contest = await contestServices().albumData();
    if (contest != []) {
      isload = false;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getcontestData();
    // contestServices().contestData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.teal,
        title: const Text(
          "contest",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.white70, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'John Doe',
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
                  // Text(
                  //   'Design',
                  //   style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  // ),

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
                          Text(
                            'This design is very important, I like it',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
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
                            Text('36', style: TextStyle(color: Colors.grey)),
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
          )),
    );
  }
}

// class SingleContest extends StatelessWidget {
//   const SingleContest({super.key , required this.contest});
//   final Contestnetworkmodel contest ;

//   @override
//   Widget build(BuildContext context) {
//     return 
//     Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 30,
//             backgroundColor: Colors.teal,
//             child: Text('${contest.id}',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ),
//           SizedBox(
//               width: 10,
//           ),
//            Expanded(
//              child: Column(
//               crossAxisAlignment:  CrossAxisAlignment.start,
//                 children: [
//                   InkWell( onTap :(){
//                       Navigator.of(context).push(MaterialPageRoute(builder: (context) => singleContestPage(contest:contest)));
//                   },
//                     child: Text(contest.title,
//                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                         maxLines: 1 , overflow: TextOverflow.ellipsis
//                        ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text('${contest.userId}', maxLines:  1 , overflow: TextOverflow.ellipsis),
//                 ],
//               ),
//            ),
//         ],
//       ),
//     );
//   }
// }
