import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_ia/screens/adminscreen.dart';
import 'package:cs_ia/screens/edit_profile.dart';
import 'package:cs_ia/screens/forgetpswd.dart';
import 'package:cs_ia/screens/home.dart';
import 'package:cs_ia/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Constraint.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String role = "user";
  FirebaseAuth _auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (Context) => Home()));
      }
    });

    @override
    void initState() {
      super.initState();
      this.checkAuthentification();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10.0),
            child: ListView(
              padding: EdgeInsets.all(15.0),
              shrinkWrap: true,
              children: <Widget>[
                Text(
                  "Sign in",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: primarycolor,
                      fontFamily: 'Roboto-Thin',
                      fontSize: 28),
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  style: TextStyle(
                    fontFamily: 'Roboto-Thin',
                    color: primarycolor,
                    fontSize: 16,
                  ),
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Color(0xff8f53ea),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter email address";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: TextStyle(
                    fontFamily: 'Roboto-Thin',
                    color: primarycolor,
                    fontSize: 16,
                  ),
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: Color(0xff8f53ea),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password must be entered";
                    } else if (value.length < 6) {
                      return "Password should be atleast 6 characters";
                    } else
                      return null;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Forgetpsd()));
                        },
                        child: Text(
                          "Forget password",
                          style: TextStyle(
                              color: primarycolor, fontFamily: 'Roboto-Thin'),
                        ))
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        _login();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                        ),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xff8f53ea), Color(0xff6268e8)],
                            ),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Container(
                          height: 60,
                          width: 300,
                          child: const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontFamily: 'Roboto-Thin',
                                fontWeight: FontWeight.w300,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                    child: Text(
                  "Don't have a account ?",
                  style: TextStyle(fontFamily: 'Roboto-Thin', fontSize: 14),
                )),
                Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: Text(
                        "Signup",
                        style: TextStyle(
                            fontFamily: 'Roboto-Thin',
                            fontSize: 16,
                            color: primarycolor),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _checkRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    setState(() {
      role = snap["role"];
    });
    print(role);
    if (role == "user") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } else if (role == "admin") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AdminScreen()));
    }
  }

  _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        // ignore: deprecated_member_use
        UserCredential user = await _auth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        if (user != null) {
          _checkRole();
        }
      } on FirebaseAuthException catch (e) {
        return e.message;
      }
    }

    showError(errormessage) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Error"),
            content: new Text(errormessage),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new TextButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    // _remember(bool value) {
    //   _ischecked = value;
// SharedPreferences.getInstance().then(
// (prefs) {
// prefs.setBool("remember_me", value);
// prefs.setString('email', _emailController.text);
// prefs.setString('password', _passwordController.text);
// },
// );
// setState(() {
// _ischecked = value;
// });
    // }
  }
}
