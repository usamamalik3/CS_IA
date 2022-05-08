import 'package:cs_ia/screens/login.dart';
import 'package:cs_ia/screens/register.dart';
import 'package:flutter/material.dart';

class welcome extends StatelessWidget {
  const welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                const Image(image: AssetImage("assets/images/logo.jpg")),
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()));
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
                            width: 120,
                            child: const Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
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
                            width: 120,
                            child: const Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
