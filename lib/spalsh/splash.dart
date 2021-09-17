import 'package:flutter/material.dart';
import 'package:practice/auth/login.dart';
import 'package:practice/dashboard.dart';
import 'package:practice/database/database.dart';
import 'package:practice/model/token.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    navigateHome();
  }

  navigateHome() async {
    var res = await DB.query();

    if (res == [] || res.isEmpty) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      print(res);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 200.0,
          width: 200.0,
          child: Column(
            children: [
              Image(image: AssetImage('assets/935px-Logo_of_CPN_(UML).png')),
              Text(
                "splash screen",
                style: TextStyle(fontSize: 20.0, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
