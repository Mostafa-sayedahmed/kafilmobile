import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kafilmobile/pages/login/login.dart';

final firestore = FirebaseFirestore.instance;

class Registerpage extends StatefulWidget {
  Registerpage({super.key});
  @override
  State<Registerpage> createState() => _RegisterpageState();
}

final auth = FirebaseAuth.instance;

class _RegisterpageState extends State<Registerpage> {
  bool _isobcured = true;
  final _registerform = GlobalKey<FormState>();
  final _usernamefield = GlobalKey<FormFieldState>();
  final _emailfield = GlobalKey<FormFieldState>();
  final _passwordfield = GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: HexColor("#00bf8b"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SvgPicture.asset(
                      "./lib/assets/images/register-now.svg",
                      width: 300,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Please,Fill your data here to register!',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Form(
                      key: _registerform,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              key: _usernamefield,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.person_outlined),
                                  labelText: 'Name',
                                  hintText: 'Enter your name'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please Enter your name';
                                } else if (value.length < 3) {
                                  return 'Name too short';
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
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
                                  bool vlidemail = RegExp(
                                          r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                                      .hasMatch(value);

                                  if (!vlidemail) {
                                    return 'please enter a vlid email address';
                                  }
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
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
                                bool vlidpassword = RegExp(
                                        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$")
                                    .hasMatch(value);

                                if (!vlidpassword) {
                                  return 'please enter a vlid password that contains at least one number ,one uppercase letter, one lowercase letter and one special character!';
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
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
                                  labelText: 'Confirm Password',
                                  hintText: 'Enter your Password once again!'),
                              obscureText: _isobcured,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please repeat your Password';
                                } else if (value.length < 6) {
                                  return 'too short password';
                                } else if (value !=
                                    _passwordfield.currentState?.value) {
                                  return 'Passwords dose not match!';
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextButton(
                            onLongPress: () {},
                            onPressed: () async {
                              if (_registerform.currentState!.validate()) {
                                try {
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                    email: _emailfield.currentState?.value,
                                    password:
                                        _passwordfield.currentState?.value,
                                  );
                                  FirebaseAuth.instance.currentUser!
                                      .updateDisplayName(
                                          _usernamefield.currentState!.value);
                                  await FirebaseAuth.instance.currentUser
                                      ?.sendEmailVerification();

                                  const snackBar = SnackBar(
                                    backgroundColor: Colors.greenAccent,
                                    content: Text(
                                        'Register sucess, You can now login!'),
                                  );
                                  print(
                                      'Register Success!, You can now Login.');
                                  firestore
                                      .collection("users")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .collection('todolist');
                                  print(FirebaseAuth.instance.currentUser!.uid);
                                  FirebaseAuth.instance.signOut();
                                  print(FirebaseAuth.instance.currentUser!.uid);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    print('The password provided is too weak.');
                                    const snackBar = SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      content: Text(
                                          'Register Faild,The password provided is too weak, Please try again!'),
                                    );
                                  } else if (e.code == 'email-already-in-use') {
                                    print(
                                        'The account already exists for that email.');
                                    const snackBar = SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      content: Text(
                                          'Register Faild,The account already exists for that email..!'),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              }
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: HexColor('#00bf8b'),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.only(
                                    left: 50, right: 50, top: 20, bottom: 20),
                                minimumSize: Size(50, 30),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                alignment: Alignment.centerLeft),
                            child: Text('Register'),
                          ),
                          /////////
                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Have an account.?..",
                                overflow: TextOverflow.ellipsis,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()));
                                  },
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero),
                                  child: Text(
                                    'Login.!',
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
