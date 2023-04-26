import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kafilmobile/pages/contests/contests.dart';
import 'package:kafilmobile/pages/freelancers/freelancers.dart';
import 'package:kafilmobile/pages/home/home.dart';
import 'package:kafilmobile/pages/portofolio/portofolio.dart';
import 'package:kafilmobile/pages/projects/projects.dart';
import 'package:kafilmobile/pages/services/services.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

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
    return Scaffold(
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
