// شكل اخر
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// class Portfolios extends StatefulWidget {
//   @override
//   _PortfoliosState createState() => _PortfoliosState();
// }

// class _PortfoliosState extends State<Portfolios> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('protfolios').snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('error');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }

//         return ListView.builder(
//           itemCount: snapshot.data!.docs.length,
//           itemBuilder: (BuildContext context, int index) {
//             var data =
//                 snapshot.data!.docs[index].data() as Map<String, dynamic>;

//             return Card(
//               elevation: 4.0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               margin:
//                   const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Expanded(
//                     flex: 2,
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: CachedNetworkImage(
//                         imageUrl: data['img'],
//                         placeholder: (context, url) =>
//                             CircularProgressIndicator(),
//                         errorWidget: (context, url, error) => Icon(Icons.error),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 3,
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Text(
//                             data['protfoloiName'],
//                             style: TextStyle(
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 10.0),
//                           Text(
//                             data['name'],
//                             style: TextStyle(
//                               fontSize: 16.0,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

// هذا هو الاصلي
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class Portfolios extends StatefulWidget {
//   @override
//   _PortfoliosState createState() => _PortfoliosState();
// }

// class _PortfoliosState extends State<Portfolios> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('protfolios').snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Text("Loading");
//         }

//         return ListView.builder(
//           itemCount: snapshot.data!.docs.length,
//           itemBuilder: (BuildContext context, int index) {
//             var data =
//                 snapshot.data!.docs[index].data() as Map<String, dynamic>;
//             return Card(
//               child: Container(
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: 150,
//                       height: 100,
//                       child: Expanded(
//                         child: Image.network(
//                           // "https://kafiil.s3.eu-central-1.amazonaws.com/media/gallery/8cf0b01ee2bceb4f64cf1f7f4ef1d8f0/c/4789265ba5202f95f6f08d3cf4bc7cc3-large.jpg",
//                           data['ownerimg'],
//                           height: 50,
//                           width: 50,
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(data['protfoloiName'],
//                                 style: TextStyle(fontWeight: FontWeight.bold)),
//                             SizedBox(height: 8.0),
//                             Row(
//                               children: [
//                                 SizedBox(
//                                   width: 15,
//                                   height: 15,
//                                   child: Expanded(
//                                     child: CircleAvatar(
//                                       backgroundImage: NetworkImage(
//                                         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTy5idsFl1zmFDhZJpdGmRRYhf0Nd4erGFgkTtDne7z&s",
//                                       ),
//                                       radius: 12.0,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 8.0),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(data['name'],
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold)),
//                                     Text(data['category']),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 8.0),
//                             Row(
//                               children: [
//                                 Icon(Icons.remove_red_eye, size: 16.0),
//                                 SizedBox(width: 4.0),
//                                 Text(data['watch'].toString()),
//                                 SizedBox(width: 16.0),
//                                 Icon(Icons.favorite, size: 16.0),
//                                 SizedBox(width: 4.0),
//                                 Text(data['like'].toString()),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

// هذا الكود اللى شغال عليه

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Portfolios extends StatefulWidget {
  @override
  _PortfoliosState createState() => _PortfoliosState();
}

class _PortfoliosState extends State<Portfolios> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('protfolios').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            var data =
                snapshot.data!.docs[index].data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        data['img'],
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['protfoloiName'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            data['ownerimg'],
                                          ),
                                          radius: 12.0,
                                        ),
                                      ),
                                      SizedBox(width: 8.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data['name'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(data['category']),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Row(
                                    children: [
                                      Icon(Icons.remove_red_eye, size: 16.0),
                                      SizedBox(width: 4.0),
                                      Text(data['watch'].toString()),
                                      SizedBox(width: 16.0),
                                      Icon(Icons.favorite, size: 16.0),
                                      SizedBox(width: 4.0),
                                      Text(data['like'].toString()),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
