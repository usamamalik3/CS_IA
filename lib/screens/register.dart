import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../Constraint.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final firestoreInstance = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController username = new TextEditingController();
  TextEditingController address = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10.0),
            child: ListView(
              padding: const EdgeInsets.all(15.0),
              shrinkWrap: true,
              children: <Widget>[
                Text(
                  "Sign Up",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: primarycolor,
                      fontFamily: 'Roboto-Thin',
                      fontSize: 28),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: emailController,
                  style: TextStyle(
                    fontFamily: 'Roboto-Thin',
                    color: primarycolor,
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Color(0xff8f53ea),
                    ),
                  ),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Required"),
                    EmailValidator(errorText: "Email is not valid")
                  ]),
                ),
                TextFormField(
                    controller: username,
                    style: TextStyle(
                      fontFamily: 'Roboto-Thin',
                      color: primarycolor,
                      fontSize: 16,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(
                        Icons.alternate_email_outlined,
                        color: Color(0xff8f53ea),
                      ),
                    ),
                    validator: RequiredValidator(errorText: "Required")),
                TextFormField(
                  controller: address,
                  style: TextStyle(
                    fontFamily: 'Roboto-Thin',
                    color: primarycolor,
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Adreess',
                    prefixIcon: Icon(
                      Icons.location_pin,
                      color: Color(0xff8f53ea),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "please enter Your address";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  style: TextStyle(
                    fontFamily: 'Roboto-Thin',
                    color: primarycolor,
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: Color(0xff8f53ea),
                    ),
                  ),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Required"),
                    MinLengthValidator(8,
                        errorText: "Password should b 8 character"),
                    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                        errorText:
                            "Password must have atleast one special character"),
                  ]),
                ),
                TextFormField(
                  style: TextStyle(
                    fontFamily: 'Roboto-Thin',
                    color: primarycolor,
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: Color(0xff8f53ea),
                    ),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Required";
                    }
                    return MatchValidator(errorText: "Passwords don't match")
                        .validateMatch(val, passwordController.text);
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        _signup();
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
                              "Register",
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
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text(
                  "Already have a account ?",
                  style: TextStyle(fontFamily: 'Roboto-Thin', fontSize: 14),
                )),
                Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        "Signin",
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

  _signup() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        if (user != null) {
          var firebaseUser = FirebaseAuth.instance.currentUser;

          firestoreInstance.collection("users").doc(firebaseUser!.uid).set({
            "email": emailController.text,
            "user name": username.text,
            "address": address.text,
            "password": passwordController.text,
            "role": "user",
          }).then((value) {
            print("success!");
          });
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
        }
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "email-already-in-use":
            Fluttertoast.showToast(
                msg: e.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.white,
                textColor: primarycolor,
                fontSize: 18.0);

            break;
            return e.message;
        }
      }
    }
  }
}
