import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs_ia/Constraint.dart';
import 'package:cs_ia/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cs_ia/screens/register.dart';

class Detail extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final firestoreInstance = FirebaseFirestore.instance;
  final Choice ch;

  Detail({Key? key, required this.ch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String email = "";
    TextEditingController descController = new TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: primarycolor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header_image(),
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                      text: '\$99 ',
                      style: TextStyle(color: Color(0xff8f53ea), fontSize: 30)),
                  TextSpan(
                      text: 'Starting price',
                      style: TextStyle(
                          color: Color(0xff8f53ea),
                          fontFeatures: [FontFeature.subscripts()])),
                ])),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Description",
                    style: TextStyle(
                      fontFamily: 'Roboto-Thin',
                      fontSize: 28,
                      color: Color(0xff8f53ea),
                    ),
                  ),
                ),
                TextFormField(
                  controller: descController,
                  style: TextStyle(
                    fontFamily: 'Roboto-Thin',
                    color: primarycolor,
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    labelText: "Write the Fault description",
                    border: OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  minLines:
                      6, // any number you need (It works as the rows for the textarea)
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: ElevatedButton(
                        onPressed: () {
                          var firebaseUser = FirebaseAuth.instance.currentUser;
                          var rng = Random();
                          var code = rng.nextInt(900000) + 100000;

                          firestoreInstance
                              .collection("users")
                              .doc(firebaseUser!.uid)
                              .collection("order")
                              .doc("$code")
                              .set({
                            "order number": code,
                            "Time": DateTime.now(),
                            "item name": ch.title,
                            "description ": descController.text,
                            "order status": "pending",
                          }).then((value) {
                            Fluttertoast.showToast(
                                msg:
                                    "Order succesfully your order no is  $code",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.white,
                                textColor: primarycolor,
                                fontSize: 16.0);
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
                            width: 350,
                            child: const Center(
                              child: Text(
                                "Order",
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _header_image() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: const Color(0xffe0e0e0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                ch.title,
                style: const TextStyle(
                  fontFamily: 'Roboto-Thin',
                  fontSize: 42,
                  color: Color(0xff8f53ea),
                ),
              ),
            ),
            Expanded(
              flex: 20,
              child: Image(
                image: ch.icon,
                width: 200,
                height: 230,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
