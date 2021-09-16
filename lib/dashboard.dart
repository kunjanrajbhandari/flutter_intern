//import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'auth/login.dart';
import 'database/database.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<dynamic> userListdash = [];

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
  }

  getUser() async {
    var res = await DB.query();
    setState(() {
      userListdash = res;
    });

    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        floating: true,
        backgroundColor: Color(0xffEE2E35),
        expandedHeight: 160.0,
        flexibleSpace: FlexibleSpaceBar(
          title: const Text(
            'Dashboard',
            style: TextStyle(
              color: Colors.black,
              fontSize: 40.0,
            ),
          ),
          background: Padding(
            padding: EdgeInsets.all(3),
            child: Stack(
              children: [
                const Image(
                  image: AssetImage('assets/madman.jpg'),
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 66.0, left: 355.0),
                  child: GestureDetector(
                    onTap: () async {
                      await DB.delete();
                      var res = await DB.query();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Login(
                                    loading: false,
                                  )));
                      print(res);
                    },
                    child: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          //Image(image: AssetImage('assets/madman.jpg'),fit: BoxFit.cover,),
        ),
      ),
      SliverFillRemaining(
          hasScrollBody: true,
          child: ListView.builder(
              itemCount: userListdash.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text("id: " + userListdash[index].id),
                    Text("token:" + userListdash[index].token),
                    Text("name:" + userListdash[index].name),
                    Text("email:" + userListdash[index].email),
                  ],
                );
              })),
      //Image(image: AssetImage("assets/1537431702.jpg"))
    ]));
  }
}
