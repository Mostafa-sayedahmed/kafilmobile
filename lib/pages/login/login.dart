import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kafilmobile/pages/home/home.dart';
import '../register/register.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final auth = FirebaseAuth.instance;

class _LoginPageState extends State<LoginPage> {
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
                child: SvgPicture.asset(
                  "./lib/assets/images/login.svg",
                  width: 300,
                ),
              ),

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
              TextFormField(
                key: _passwordfield,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      tooltip: 'show password',
                      onPressed: () {
                        setState(() {
                          _isobcured = !_isobcured;
                        });
                      },
                      icon: Icon(_isobcured
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined),
                    ),
                    icon: Icon(Icons.lock_outlined),
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your Password'),
                obscureText: _isobcured,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter a password';
                  } else if (value.length < 6) {
                    return 'too short password';
                  }
                },
              ),

              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 30,
              ),

              TextButton(
                onLongPress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => (Homepage()))));
                },
                onPressed: () async {
                  print(_emailfield.currentState?.value +
                      _passwordfield.currentState?.value);
                  if (_formfield.currentState!.validate()) {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _emailfield.currentState!.value,
                          password: _passwordfield.currentState!.value);
                      final user = FirebaseAuth.instance.currentUser;
                      if (user!.emailVerified != true) {
                        const snackBar = SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text('Login Faild,User is not Verified..!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        // await FirebaseAuth.instance.currentUser
                        //     ?.sendEmailVerification();
                        auth.signOut();
                      } else if (user.emailVerified) {
                        const snackBar = SnackBar(
                          backgroundColor: Colors.greenAccent,
                          content: Text(
                              'Login sucess, You can now Start using the App!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Get.to(Homepage());
                      }
                      print(auth.currentUser);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                        const snackBar = SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text(
                              'Login Faild,No user found for that email..!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                        const snackBar = SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text(
                              'Login Faild,Wrong password provided for that user..!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
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
                child: Text('Login'),
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
              TextButton(onPressed: () {}, child: Text('Forgot password?')),
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