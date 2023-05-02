import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kafilmobile/pages/home/home.dart';
import 'package:kafilmobile/pages/login/login.dart';
import '../register/register.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

final auth = FirebaseAuth.instance;

class _ForgotpasswordState extends State<Forgotpassword> {
  bool _isobcured = true;
  final _formfield = GlobalKey<FormState>();
  final _emailfield = GlobalKey<FormFieldState>();
  final _passwordfield = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login'),
        centerTitle: true,
        backgroundColor: HexColor("#009f8b"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        child: Form(
          key: _formfield,
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: 320,
                    child: Image(
                        image: AssetImage('./lib/assets/images/3275434.jpg')),
                  )),

              SizedBox(
                height: 30,
              ),
              TextFormField(
                  key: _emailfield,
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
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 30,
              ),

              TextButton(
                onPressed: () async {
                  // print(_emailfield.currentState?.value);
                  // print(_formfield.currentState!.validate());
                  if (_formfield.currentState!.validate()) {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(
                            email: _emailfield.currentState?.value)
                        .then((value) => {
                              print('login success'),
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.greenAccent,
                                  content: Text(
                                      'reset password link sent,please check your E-mail.!'),
                                ),
                              ),
                              Get.to(LoginPage())
                            })
                        .catchError((error) => {
                              print(error.message),
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: Colors.redAccent,
                                content: Text('${error.message}'),
                              ))
                            });
                  }
                },
                style: TextButton.styleFrom(
                    backgroundColor: HexColor('#009f8b'),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.only(
                        left: 50, right: 50, top: 20, bottom: 20),
                    minimumSize: Size(50, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.centerLeft),
                child: Text('Reset password'),
              ),
              /////////
              SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account.?..",
                    overflow: TextOverflow.ellipsis,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registerpage()));
                      },
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        'Rigester',
                        overflow: TextOverflow.ellipsis,
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {},
                  child: Text('Rememberd the password?,Back to login..!')),
            ]),
          ),
        ),
      ),
    );
  }
}



  // gradient: LinearGradient(begin:Alignment.topRight,
  //       end:Alignment.bottomLeft,
  //       stops: [.01,.04.06.09],
  //       colors: [Colors.yellow,Colors.red,Colors.indigo,Colors.teal]
  //     ),