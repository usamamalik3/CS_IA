import 'package:cs_ia/Constraint.dart';
import 'package:cs_ia/model/cardchoicedetail.dart';
import 'package:cs_ia/screens/detail.dart';
import 'package:cs_ia/screens/edit_profile.dart';
import 'package:cs_ia/screens/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: navigationDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Text(
                "Our Services",
                style: TextStyle(
                  fontFamily: 'Roboto-Thin',
                  fontSize: 32,
                  color: Color(0xff8f53ea),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: choices.length,
                    scrollDirection: Axis.vertical,
                    physics: const ScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 30.0,
                      crossAxisSpacing: 30.0,
                    ),
                    itemBuilder: (context, index) {
                      return Center(child: SelectCard(choice: choices[index]));
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xff8f53ea),
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/search.svg",
            // By default our  icon color is white
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Laptop', icon: AssetImage("assets/images/laptop.png")),
  const Choice(title: 'Desktop', icon: AssetImage("assets/images/desktop.png")),
  const Choice(title: 'mobile', icon: AssetImage("assets/images/mobile.png")),
  const Choice(title: 'Printer', icon: AssetImage("assets/images/printer.png")),
  const Choice(title: 'Camera', icon: AssetImage("assets/images/camera.png")),
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, required this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Detail(
                      ch: choice,
                    )));
      },
      child: Card(
          shadowColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Color(0xffe0e0e0),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: choice.icon,
                    height: 110,
                    width: 110,
                  ),
                  Text(
                    choice.title,
                    style: const TextStyle(
                      fontFamily: 'Roboto-Thin',
                      fontSize: 18,
                      color: Color(0xff8f53ea),
                    ),
                  ),
                ]),
          )),
    );
  }
}
