import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';

final auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('الملف الشخصي'),
          centerTitle: true,
          backgroundColor: HexColor('#1dbf73')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Card(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(auth.currentUser!.photoURL!),
                  radius: 40,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  auth.currentUser!.displayName!,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  auth.currentUser!.email!,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    print("signed out");
                    Navigator.pop(context);
                    Navigator.pop(context);
                    const snackBar = SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text('User loggedout.! '),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Text('تسجيل خروج'),
                  style: TextButton.styleFrom(
                      backgroundColor: HexColor('#00bf8b'),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.only(
                          left: 50, right: 50, top: 20, bottom: 20),
                      minimumSize: Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerLeft),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
