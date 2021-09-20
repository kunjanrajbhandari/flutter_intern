//import 'package:carousel_slider/carousel_slider.dart';
import 'dart:core';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practice/assigned_booth.dart';
import 'package:practice/model/token.dart';
import 'package:practice/profile.dart';
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

  Widget boothWidth() {
    return ListView.builder(
      itemCount: userAsignedList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Expanded(child: Text(userAsignedList[index].district)),
            Expanded(child: Text(userAsignedList[index].fedConstituency)),
            ListView.builder(
                itemCount: userAsignedList[index].booth.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [Text(userAsignedList[index].booth[index])],
                  );
                })
          ],
        );
      },
    );
  }

  Widget boothAllicted() {
    if (userAsignedList.length == 0) {
      return Center(
          child: Text(
        'Not Assigned Any Booth',
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ));
    } else {
      return ListView.builder(
        itemCount: userAsignedList.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.blue,
            child: Container(
              height: 44.0,
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AssignedBooth(
                                userAsignedLists: userAsignedList)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 11.0, top: 11.0),
                    child: Text(
                      "Provision: " + userAsignedList[index].provision,
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  )),
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
        backgroundColor: Colors.red.withOpacity(0.9),
        expandedHeight: 188.0,
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
                padding: const EdgeInsets.only(left: 11.0, top: 202.0),
                child: SizedBox(
                  width: 44.0,
                  height: 44.0,
                  child: Image(
                    image: AssetImage('assets/flag.jpg'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 122.0, top: 211.0),
                child: Text(
                  myuser.name != null ? (myuser.name).toString() : '',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 344.0, top: 202.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile(
                                  name: myuser.name,
                                  address: myuser.address,
                                  phone: myuser.phone,
                                  dob: myuser.dob,
                                  sex: myuser.sex,
                                  email: myuser.email,
                                )));
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.black,
                    backgroundImage: NetworkImage(
                        'https://img.favpng.com/17/1/20/user-interface-design-computer-icons-default-png-favpng-A0tt8aVzdqP30RjwFGhjNABpm.jpg'),
                  ),
                ),
              ),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 11.0, left: 8.0),
                      child: Text("Booth Assigned",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          )),
                    ),
                    Expanded(child: boothAllicted())
                  ],
                )),
    ]));
  }
}


// Padding(
//             padding: const EdgeInsets.only(left: 11.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Provision: " + userAsignedList[index].provision,
//                   style: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                 ),

//                 Text(
//                   "District: " + userAsignedList[index].district,
//                   style: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   "Fed Constituency: " + userAsignedList[index].fedConstituency,
//                   style: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   "Prov Constituency: " +
//                       userAsignedList[index].provConstituency,
//                   style: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   "localBody: " + userAsignedList[index].localBody,
//                   style: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                 ),
//                 // ListTile(
//                 //   onTap: boothWidth,
//                 //   title: Text(
//                 //     "District: " + userAsignedList[index].district,
//                 //     style: TextStyle(
//                 //         color: Colors.white, fontWeight: FontWeight.bold),
//                 //   ),
//                 // ),
//               ],
//             ),
//           );