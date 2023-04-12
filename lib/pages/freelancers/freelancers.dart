import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kafilmobile/model/freelancermodel.dart';
import 'package:kafilmobile/pages/home/home.dart';
import 'package:kafilmobile/pages/register/register.dart';

class Freelancers extends StatefulWidget {
  const Freelancers({super.key});

  @override
  State<Freelancers> createState() => _FreelancersState();
}

class _FreelancersState extends State<Freelancers> {
  List<FreelancerModel> freelancersBody = [];
  late Map<String, dynamic> test;
  List itemList = [];
  final _firestore = FirebaseFirestore.instance;
  Future<void> getDataFreelancers() async {
    final Freelancers = await _firestore.collection('Freelancers').get();
    for (var freelancer in Freelancers.docs) {
      itemList.add(freelancer.data());
      print(itemList);
    }
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: Row(
            children: [
              Icon(
                Icons.people,
                color: Colors.black,
              ),
              SizedBox(width: 25),
              Text(
                "Freelancers",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              )
            ],
          ),
          actions: [
            CircleAvatar(
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.home_filled,
                    color: Colors.black,
                  )),
              backgroundColor: Colors.grey[100],
            ),
            SizedBox(width: 10),
            CircleAvatar(
                child: IconButton(
                    onPressed: () {
                      getDataFreelancers();
                    },
                    icon: Icon(
                      Icons.download,
                      color: Colors.black,
                    )),
                backgroundColor: Colors.grey[100]),
            SizedBox(width: 10)
          ],
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return MyWidget(name: 'name', text: 'text', time: 'time', img: 'img');
              },
              itemCount: 5,
            ),
          ),
        ));
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
          CircleAvatar(backgroundImage: NetworkImage(img)),
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

class MyWidget extends StatelessWidget {
  const MyWidget(
      {super.key,
      required this.name,
      required this.text,
      required this.time,
      required this.img});
  final String name;
  final String text;
  final String time;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(img),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: TextStyle(fontSize: 14)),
            SizedBox(
              height: 2,
            ),
            Row(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 10),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                SizedBox(width: 10),
                Container(
                  width: 5,
                  height: 5,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                ),
                SizedBox(width: 3),
                Text(
                  time,
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
            SizedBox(height: 25),
          ],
        )
      ],
    );
  }
}

class SingleUser extends StatelessWidget {
  const SingleUser({super.key});

  @override
  Widget build(BuildContext context) {
    String $;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          CircleAvatar(
            child: Text("user id"),
            radius: 30,
            backgroundColor: Colors.tealAccent,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Homepage()));
                  },
                  child: Text("user.title")),
              SizedBox(
                height: 5,
              ),
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Homepage()));
                  },
                  child: Text("user id"))
            ],
          )
        ],
      ),
    );
  }
}
