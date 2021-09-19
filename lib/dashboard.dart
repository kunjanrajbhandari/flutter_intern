//import 'package:carousel_slider/carousel_slider.dart';
import 'dart:core';
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
  bool? loading = false;
  List<dynamic> userListdash = [];
  List<UserAsigned> userAsignedList = [];

  @override
  String? token;
  void initState() {
    // TODO: implement initState
    userData();
    super.initState();
  }

  UserData myuser = UserData();
  Future<void> userData() async {
    userAsignedList = [];
    var res = await DB.query();
    setState(() {
      userListdash = res;
      token = userListdash[0].token.toString().trim();
      print("Bearer $token");
    });

    var url = Uri.parse(
        'https://polar-beach-17297.herokuapp.com/api/user/user/profile');
    loading = true;

    setState(() {});
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    loading = false;
    setState(() {});
    print(response.body);

    setState(() {});
    dynamic result = json.decode(response.body);

    if (response.statusCode == 200) {
      myuser.name = result['name'];
      myuser.phone = result['phone'].toString();
      myuser.sex = result['sex'];
      myuser.address = result['address'];
      myuser.email = result['email'];
      myuser.dob = result['dob'];

      for (int i = 0; i < result['assined'].length; i++) {
        userAsignedList.add(UserAsigned(
            provision: result['assined'][i]['provision'].toString(),
            district: result['assined'][i]['district'].toString(),
            fedConstituency: result['assined'][i]['fedConstituency'].toString(),
            provConstituency:
                result['assined'][i]['provConstituency'].toString(),
            localBody: result['assined'][i]['localBody'].toString(),
            ward: result['assined'][i]['ward'].toString(),
            booth: result['assined'][i]['booth']));
      }
    }
  }

  Widget boothAllicted() {
    if (userAsignedList.length == 0) {
      return Text('Not Assigned any bot');
    } else {
      return ListView.builder(
        itemCount: userAsignedList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {},
              title: Text(userAsignedList[index].provision),
              subtitle: Text(userAsignedList[index].district),
            ),
          );
        },
      );
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
          child: loading == true
              ? Center(
                  child: Container(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator()),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${myuser.name}",
                      style: TextStyle(fontSize: 33.0),
                    ),
                    Text("${myuser.phone}", style: TextStyle(fontSize: 33.0)),
                    Text(
                      "Address:${myuser.address}",
                      style: TextStyle(fontSize: 33.0),
                    ),
                    Text(
                      "name:${myuser.sex}",
                      style: TextStyle(fontSize: 33.0),
                    ),
                    Expanded(child: boothAllicted())
                    //Text("Booth: ${user.booth}"),
                  ],
                )),

      //Image(image: AssetImage("assets/1537431702.jpg"))
    ]));
  }
}
