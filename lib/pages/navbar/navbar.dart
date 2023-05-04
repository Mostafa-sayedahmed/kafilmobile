import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kafilmobile/pages/contests/contests.dart';
import 'package:kafilmobile/pages/freelancers/freelancers.dart';
import 'package:kafilmobile/pages/home/home.dart';
import 'package:kafilmobile/pages/portofolio/portofolio.dart';
import 'package:kafilmobile/pages/profile/profile.dart';
import 'package:kafilmobile/pages/projects/projects.dart';
import 'package:kafilmobile/pages/services/services.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

final auth = FirebaseAuth.instance;

class _NavbarState extends State<Navbar> {
  int currentindex = 2;
  List<Widget> pages = [
    Portfolios(),
    contestPage(),
    Services(),
    Freelancers(),
    Projcets(),
  ];
  @override
  Widget build(BuildContext context) {
    String iconcolor = '#4a4a4a';
    String? userimg =
        'https://firebasestorage.googleapis.com/v0/b/kafiil-12b6c.appspot.com/o/images%2Fuserimage.png?alt=media&token=e88880bd-c2f9-4562-9a72-5628441ad27a';
    String title = '';
    if (auth.currentUser != null) {
      setState(() {
        userimg = auth.currentUser!.photoURL;
      });
    } else {
      setState(() {
        userimg =
            'https://firebasestorage.googleapis.com/v0/b/kafiil-12b6c.appspot.com/o/images%2Fuserimage.png?alt=media&token=e88880bd-c2f9-4562-9a72-5628441ad27a';
      });
    }

    switch (currentindex) {
      case 0:
        setState(() {
          title = 'الاعمال';
        });
        break;
      case 1:
        setState(() {
          title = 'المسابقات';
        });
        break;
        ;
      case 2:
        setState(() {
          title = 'الخدمات';
        });
        break;
        ;
      case 3:
        setState(() {
          title = 'المستقلين';
        });
        break;
        ;
      case 4:
        setState(() {
          title = 'المشاريع';
        });
        break;
        ;
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor('#1dbf73'),
          title: Text(title),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => (Profile()))));
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(userimg!),
                ),
              ),
            )
          ],
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //     onPressed: () async {
          //       await FirebaseAuth.instance.signOut();
          //       print("signed out");
          //       Navigator.pop(context);
          //       const snackBar = SnackBar(
          //         backgroundColor: Colors.redAccent,
          //         content: Text('User loggedout.! '),
          //       );
          //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //     },
          //     icon: Icon(Icons.logout)),
        ),
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: HexColor('#1dbf73'),
          currentIndex: currentindex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.image, color: HexColor(iconcolor)),
              label: 'الاعمال',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.trophy, color: HexColor(iconcolor)),
              label: 'المسابقات',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                color: HexColor(iconcolor),
              ),
              label: 'الخدمات',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people, color: HexColor(iconcolor)),
              label: 'المستقلين',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.suitcase, color: HexColor(iconcolor)),
              label: 'المشاريع',
            ),
          ],
          onTap: (index) {
            setState(() {
              currentindex = index;
            });
          },
        ),
        body: pages[currentindex]);
  }
}
