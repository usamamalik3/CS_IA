import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Constraint.dart';
import 'home.dart';

class editprofile extends StatefulWidget {
  editprofile({Key? key}) : super(key: key);

  @override
  _editprofileState createState() => _editprofileState();
}

class _editprofileState extends State<editprofile> {
  final firestoreInstance = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController username = new TextEditingController();
  TextEditingController phoneno = new TextEditingController();
  TextEditingController address = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10),
                child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(15.0),
                    children: [
                      const Text(
                        "Edit Profile",
                        style: TextStyle(
                            fontFamily: 'Roboto-Thin',
                            fontSize: 32,
                            color: Color(0xff8f53ea)),
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
                      ),
                      TextFormField(
                        controller: phoneno,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                          fontFamily: 'Roboto-Thin',
                          color: primarycolor,
                          fontSize: 16,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Phone no',
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Color(0xff8f53ea),
                          ),
                        ),
                        validator: (value) {
                          if (value!.length < 13) {
                            return "please enter correct phone no";
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        controller: address,
                        keyboardType: TextInputType.streetAddress,
                        style: TextStyle(
                          fontFamily: 'Roboto-Thin',
                          color: primarycolor,
                          fontSize: 16,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Enter your address',
                          prefixIcon: Icon(
                            Icons.pin_drop_outlined,
                            color: Color(0xff8f53ea),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              var firebaseUser =
                                  FirebaseAuth.instance.currentUser;
                              firestoreInstance
                                  .collection("users")
                                  .doc(firebaseUser!.uid)
                                  .update({
                                "phone no": phoneno.text.trim(),
                                "username": username.text.trim(),
                                "address": {
                                  "street": address.text.trim(),
                                }
                              }).then((_) {
                                Fluttertoast.showToast(
                                    msg: 'Successfully updated',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: primarycolor,
                                    textColor: Colors.white);
                                ;
                              });
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
                                    colors: [
                                      Color(0xff8f53ea),
                                      Color(0xff6268e8)
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: Container(
                                height: 60,
                                width: 300,
                                child: const Center(
                                  child: Text(
                                    "Update",
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
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: primarycolor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.logout_outlined,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
