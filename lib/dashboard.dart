//import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practice/model/token.dart';
import 'auth/login.dart';
import 'database/database.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<dynamic> userListdash = [];

  @override
  String? token;
  void initState() {
    // TODO: implement initState
    userData();
    super.initState();
  }

  Future<void> userData() async {
    var res = await DB.query();
    setState(() {
      userListdash = res;
      token = userListdash[0].token.toString().trim();
      print("Bearer $token");
    });

    var url = Uri.parse(
        'https://polar-beach-17297.herokuapp.com/api/user/user/profile');

    setState(() {});
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    print(response.body);

    setState(() {});
    dynamic result = json.decode(response.body);

    if (response.statusCode == 200) {
      print(result);
      UserData(
          name: result['name'],
          phone: result['phone'],
          sex: result['sex'],
          address: result['address'],
          email: result['email'],
          dob: result['dob'],
          provision: result['assined'][0]['provision'],
          provConstituency: result['assined'][0]['provConstituency'],
          fedConstituency: result['assined'][0]['fedConstituency'],
          localBody: result['assined'][0]['localBody'],
          ward: result['assined'][0]['ward'],
          booth: result['assined'][0]['booth'],
          district: result['assined'][0]['district']);
    } else {
      CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        floating: true,
        backgroundColor: Color(0xffEE2E35),
        expandedHeight: 134.0,
        flexibleSpace: FlexibleSpaceBar(
          background: Stack(
            children: [
              Row(
                children: const [
                  Expanded(
                    child: Image(
                      image: AssetImage('assets/1537431702.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Expanded(
                    child: Image(
                      image: AssetImage('assets/madman.jpg'),
                    ),
                  ),
                ],
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
                    color: Colors.black,
                  ),
                ),
              )
            ],
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
