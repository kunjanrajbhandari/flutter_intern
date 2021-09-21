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
    await Future.delayed(Duration(milliseconds: 1500), () {});
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
      body: Padding(
        padding: const EdgeInsets.only(left: 111.0, top: 111.0),
        child: Column(
          children: [
            //Image(image: AssetImage('flag.jpg')),

            Container(
                height: 300,
                width: 200,
                child: Image(image: AssetImage('assets/flag.jpg'))),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
