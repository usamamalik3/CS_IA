import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_ia/Constraint.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'login.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController ordernoController = new TextEditingController();

  String email = " ";

  String orderno = " ";
  String itemname = " ";
  String descrip = " ";
  String orderstatus = " ";

  bool ableToEdit = false;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 80),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Tooltip(
                    message: "Sign out",
                    child: IconButton(
                        onPressed: () async {
                          await _auth.signOut();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        icon: Icon(
                          Icons.logout_outlined,
                          color: primarycolor,
                        )),
                  ),
                ),
              ),
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
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: ordernoController,
                style: TextStyle(
                  fontFamily: 'Roboto-Thin',
                  color: primarycolor,
                  fontSize: 16,
                ),
                decoration: const InputDecoration(
                  labelText: 'Order no',
                  prefixIcon: Icon(
                    Icons.shop_2_outlined,
                    color: Color(0xff8f53ea),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "please enter email address";
                  } else {}
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    String userEmail = emailController.text.trim().toString();
                    String Orderno = ordernoController.text.trim().toString();
                    var firebaseUser = FirebaseAuth.instance.currentUser;

                    final QuerySnapshot snap = await FirebaseFirestore.instance
                        // .collection("users")
                        // .where("email", isEqualTo: userEmail)
                        .collection("order")
                        .where("order number", isEqualTo: Orderno)
                        .get();

                    setState(() {
                      email = userEmail;
                      orderno = snap.docs[0]['order number'];
                      print(orderno);
                      itemname = snap.docs[0]['item name'];
                      descrip = snap.docs[0]['description '];
                      orderstatus = snap.docs[0]['order status'];

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
                'order number : ' + orderno,
                style: TextStyle(
                  fontFamily: 'Roboto-Thin',
                  color: primarycolor,
                  fontSize: 16,
                ),
              ),
              Text(
                'Item : ' + itemname,
                style: TextStyle(
                  fontFamily: 'Roboto-Thin',
                  color: primarycolor,
                  fontSize: 16,
                ),
              ),
              Text(
                'description : ' + descrip,
                style: TextStyle(
                  fontFamily: 'Roboto-Thin',
                  color: primarycolor,
                  fontSize: 16,
                ),
              ),
              Text(
                'order status : ' + orderstatus,
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
