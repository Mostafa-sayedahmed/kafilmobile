import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:kafilmobile/pages/freelancers/freelancers.dart';
import 'package:kafilmobile/pages/home/home.dart';

class SingleFreelancer extends StatelessWidget {
  const SingleFreelancer({super.key, required this.freelancerName,required this.freelancerImg, required this.freelancerTitle,});
  final freelancerName;
  final freelancerImg;
  final freelancerTitle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: Row(
            children: [
              Icon(
                Icons.person,
                color: Colors.black,
              ),
              SizedBox(width: 25),
              Text(
                'Single Freelancer',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              )
            ],
          ),
          actions: [
            CircleAvatar(
              child: IconButton(
                  onPressed: () {
                     Navigator.push(context,MaterialPageRoute(builder: (context) => Homepage()));
                  },
                  icon: Icon(
                    Icons.home_filled,
                    color: Colors.black,
                  )),
              backgroundColor: Colors.grey[100],
            ),
            SizedBox(width: 10),
            CircleAvatar(
                child: IconButton(
                    onPressed: () {},
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
                  return FREELANCER(name: freelancerName, title: freelancerTitle, img: freelancerImg);
                },
                itemCount: 1,
              ),
            )));
  }
}



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
                  child: const Text('  BACK TO OTHER FREELANCERS !'),
                  onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => Freelancers()));},
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
