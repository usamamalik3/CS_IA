import 'package:flutter/material.dart';

import '../Constraint.dart';

class Forgetpsd extends StatefulWidget {
  Forgetpsd({Key? key}) : super(key: key);

  @override
  _ForgetpsdState createState() => _ForgetpsdState();
}

class _ForgetpsdState extends State<Forgetpsd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(10.0),
        child:
            ListView(padding: EdgeInsets.symmetric(vertical: 60.0), children: [
          Text(
            "Forgot Password",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: primarycolor, fontFamily: 'Roboto-Thin', fontSize: 28),
          ),
          const SizedBox(
            height: 80,
          ),
          TextFormField(
            style: TextStyle(
              fontFamily: 'Roboto-Thin',
              color: primarycolor,
              fontSize: 16,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "please enter emnail address";
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(
                Icons.email_outlined,
                color: Color(0xff8f53ea),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {},
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
                        "Send",
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
    ));
  }
}
