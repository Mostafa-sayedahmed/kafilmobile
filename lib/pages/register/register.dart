import 'dart:math';

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
        title: Text('تسجيل'),
        centerTitle: true,
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
                      'من فضلك , ادخل بياناتك هنا لتسجيل حساب جديد!!',
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
                                  labelText: 'الاسم بالكامل',
                                  hintText: 'ادخل الاسم بالكامل هنا'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'من فضلك قم بإدخال الاسم هنا';
                                } else if (value.length < 3) {
                                  return 'من فضلك تأكد من كتابة الاسم كاملا';
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
                                    labelText: 'البريد الالكتروني',
                                    hintText: 'ادخل بريدك الالكتروني'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'من فضلك ادخل البريد الالكتروني';
                                  }
                                  bool vlidemail = RegExp(
                                          r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                                      .hasMatch(value);

                                  if (!vlidemail) {
                                    return 'البريد الالكتروني خاطئ';
                                  }
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
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
                                  return 'من فضلك ادخل كلمة السر';
                                } else if (value.length < 6) {
                                  return 'كلمة السر قصيرة';
                                }
                                bool vlidpassword = RegExp(
                                        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$")
                                    .hasMatch(value);

                                if (!vlidpassword) {
                                  return 'من فضلك ادخل كلمة سر مناسبة ,يجب ان تحتوي علي الاقل علي حرف واحد ورقم واحد و علامة مميزة!';
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
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
                                  labelText: 'تأكيد كلمة السر',
                                  hintText: 'ادخل كلمة السر مرة اخري!'),
                              obscureText: _isobcured,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'من فضلك قم بتأكيد كلمة السر';
                                } else if (value !=
                                    _passwordfield.currentState?.value) {
                                  return 'كلمة السر غير متطابقة!';
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

                                  FirebaseAuth.instance.currentUser!.updatePhotoURL(
                                      "https://firebasestorage.googleapis.com/v0/b/kafiil-12b6c.appspot.com/o/images%2Fuserimage.png?alt=media&token=e88880bd-c2f9-4562-9a72-5628441ad27a");

                                  // .updateDisplayName(
                                  //     _usernamefield.currentState!.value);

                                  await FirebaseAuth.instance.currentUser
                                      ?.sendEmailVerification();

                                  print(
                                      'Register Success!, You can now Login.');
                                  await firestore
                                      .collection("users")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .set({
                                        'uid': FirebaseAuth
                                            .instance.currentUser!.uid,
                                        'fullname':
                                            _usernamefield.currentState!.value,
                                        'email':
                                            _emailfield.currentState!.value,
                                        'isAdmin': false,
                                        'imgUrl':
                                            'https://kafiil.com/modules/user/images/user.svg'
                                      })
                                      .then((value) =>
                                          {print('User added to database.')})
                                      .catchError(
                                          (err) => {print(err.message)});
                                  const snackBar = SnackBar(
                                    backgroundColor: Colors.greenAccent,
                                    content: Text(
                                        'Register sucess, You can now login!'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  _registerform.currentState!.reset();

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
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                    _registerform.currentState!.reset();
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
                            child: Text('تسجيل'),
                          ),
                          /////////
                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "لديك حساب بالفعل.؟",
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
                                    'تسجيل الدخول',
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
