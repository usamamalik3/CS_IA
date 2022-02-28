import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_ia/Constraint.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  TextEditingController emailController = new TextEditingController();

  String email = " ";

  String address = " ";
  String username = " ";
  String role = " ";
  String password = " ";

  bool ableToEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 90, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome Admin",
                style: TextStyle(
                  fontFamily: 'Roboto-Thin',
                  color: primarycolor,
                  fontSize: 28,
                ),
              ),
              SizedBox(
                height: 50,
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return "please enter email address";
                  } else {}
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    String userEmail = emailController.text.trim();
                    var firebaseUser = FirebaseAuth.instance.currentUser;

                    final QuerySnapshot snap = await FirebaseFirestore.instance
                        .collection("users")
                        .where("email", isEqualTo: userEmail)
                        .get();

                    setState(() {
                      email = userEmail;

                      role = snap.docs[0]['role'];
                      password = snap.docs[0]['password'];
                      address = snap.docs[0]['address'];
                      username = snap.docs[0]['user name'];

                      ableToEdit = true;
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
                          colors: [Color(0xff8f53ea), Color(0xff6268e8)],
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      height: 60,
                      width: 170,
                      child: const Center(
                        child: Text(
                          "Get user data",
                          style: TextStyle(
                            fontFamily: 'Roboto-Thin',
                            fontWeight: FontWeight.w300,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: 50,
              ),
              Text(
                'User Data :',
                style: TextStyle(
                  fontFamily: 'Roboto-Thin',
                  color: primarycolor,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Email : ' + email,
                style: TextStyle(
                  fontFamily: 'Roboto-Thin',
                  color: primarycolor,
                  fontSize: 16,
                ),
              ),
              Text(
                'address : ' + address,
                style: TextStyle(
                  fontFamily: 'Roboto-Thin',
                  color: primarycolor,
                  fontSize: 16,
                ),
              ),
              Text(
                'Role : ' + role,
                style: TextStyle(
                  fontFamily: 'Roboto-Thin',
                  color: primarycolor,
                  fontSize: 16,
                ),
              ),
              Text(
                'Password : ' + password,
                style: TextStyle(
                  fontFamily: 'Roboto-Thin',
                  color: primarycolor,
                  fontSize: 16,
                ),
              ),
              // ableToEdit
              //     ? ElevatedButton(
              //         onPressed: () {},
              //         style: ElevatedButton.styleFrom(
              //           padding: EdgeInsets.zero,
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(80),
              //           ),
              //         ),
              //         child: Ink(
              //           decoration: BoxDecoration(
              //               gradient: const LinearGradient(
              //                 colors: [Color(0xff8f53ea), Color(0xff6268e8)],
              //               ),
              //               borderRadius: BorderRadius.circular(30.0)),
              //           child: Container(
              //             height: 60,
              //             width: 170,
              //             child: const Center(
              //               child: Text(
              //                 "Edit user data",
              //                 style: TextStyle(
              //                   fontFamily: 'Roboto-Thin',
              //                   fontWeight: FontWeight.w300,
              //                   fontSize: 24,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ))
              //     : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
