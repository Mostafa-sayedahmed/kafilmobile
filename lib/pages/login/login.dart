import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kafilmobile/pages/forgotpassword/forgotpassword.dart';
import 'package:kafilmobile/pages/home/home.dart';
import 'package:kafilmobile/pages/navbar/navbar.dart';
import '../register/register.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/foundation.dart';

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
        title: Text('تسجيل الدخول'),
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
                      labelText: 'البريد الالكتروني',
                      hintText: 'ادخل البريد الالكتروني'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'من فضلك ادخل البريد الالكتروني';
                    }
                    bool vlidemail = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                        .hasMatch(value);

                    if (!vlidemail) {
                      return 'البريد الالكتروني خاطئ';
                    }
                  }),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                key: _passwordfield,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      tooltip: 'اظهار كلمة السر',
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
                    labelText: 'كلمة السر',
                    hintText: 'ادخل كلمة السر'),
                obscureText: _isobcured,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'من فضلك ادخل كلمة سر';
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
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: ((context) => (Homepage()))));
                  Get.to(Navbar());
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
                        _formfield.currentState!.reset();
                        const snackBar = SnackBar(
                          backgroundColor: Colors.greenAccent,
                          content: Text(
                              'Login sucess, You can now Start using the App!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Get.to(Navbar());
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
                child: Text('تسجيل الدخول'),
              ),
              /////////
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                      onPressed: () async {
                        // print('twitter login');

                        // Future<void> _signInWithTwitter() async {
                        TwitterAuthProvider twitterProvider =
                            TwitterAuthProvider();

                        if (kIsWeb) {
                          await FirebaseAuth.instance
                              .signInWithPopup(twitterProvider)
                              .then((value) => {
                                    print('login success'),
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.greenAccent,
                                        content: Text('Login sucess!'),
                                      ),
                                    ),
                                    Get.to(Navbar())
                                  })
                              .catchError((error) => {
                                    print(error.message),
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      content: Text('${error.message}'),
                                    ))
                                  });
                        } else {
                          await FirebaseAuth.instance
                              .signInWithProvider(twitterProvider)
                              .then((value) => {
                                    print('login success'),
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.greenAccent,
                                        content: Text('Login sucess!'),
                                      ),
                                    ),
                                    Get.to(Navbar())
                                  })
                              .catchError((error) => {
                                    print(error.message),
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      content: Text('${error.message}'),
                                    ))
                                  });
                          // }
                        }
                      },
                      icon: Icon(FontAwesomeIcons.twitter),
                      label: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text('سجل دخول عن طريق تويتر'),
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton.icon(
                      onPressed: () async {
                        GoogleAuthProvider googleProvider =
                            GoogleAuthProvider();

                        googleProvider.addScope(
                            'https://www.googleapis.com/auth/contacts.readonly');
                        googleProvider.setCustomParameters(
                            {'login_hint': 'user@example.com'});

                        // Once signed in, return the UserCredential
                        await FirebaseAuth.instance
                            .signInWithPopup(googleProvider)
                            .then((value) => {
                                  print('login success'),
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.greenAccent,
                                      content: Text('Login sucess!'),
                                    ),
                                  ),
                                  Get.to(Navbar())
                                })
                            .catchError((error) => {
                                  print(error.message),
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: Colors.redAccent,
                                    content: Text('${error.message}'),
                                  ))
                                });

                        // Or use signInWithRedirect
                        // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
                      },
                      style: ButtonStyle(backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                        return Colors.redAccent;
                      })),
                      icon: Icon(FontAwesomeIcons.google),
                      label: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text('سجل دخول عن طريق جوجل'),
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ليس لديك حساب .؟!",
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
                        'حساب جديد',
                        overflow: TextOverflow.ellipsis,
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Forgotpassword()));
                  },
                  child: Text('نسيت كلمة السر؟')),
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