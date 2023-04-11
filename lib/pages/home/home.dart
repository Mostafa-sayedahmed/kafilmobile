import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hexcolor/hexcolor.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
        backgroundColor: HexColor('#1dbf73'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    icon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter your email address'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter your email address';
                  }
                  bool vlidemail = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                      .hasMatch(value);

                  if (!vlidemail) {
                    return 'please enter a vlid email address';
                  }
                }),
          ],
        ),
      ),
    );
  }
}
