import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:practice/database/database.dart';
import 'package:practice/model/token.dart';

import 'auth/login.dart';

class Profile extends StatelessWidget {
  String? name;
  String? dob;
  String? email;
  String? phone;
  String? address;
  String? sex;

  Profile(
      {Key? key,
      required this.name,
      required this.address,
      required this.dob,
      required this.email,
      required this.phone,
      required this.sex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
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
      Container(
        width: MediaQuery.of(context).size.width,
        height: 199.0,
        color: Colors.black.withOpacity(0.3),
      ),
      Padding(
        padding: EdgeInsets.only(top: 139.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 55.0,
          color: Colors.red.withOpacity(0.6),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 99.0),
                child: Text(
                  "My Profile",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 111.0),
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
                  },
                  child: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Center(
        child: Container(
          height: 333.0,
          width: 355.0,
          color: Color(0xffF1EBEB),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 33.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      backgroundImage: NetworkImage(
                          'https://img.favpng.com/17/1/20/user-interface-design-computer-icons-default-png-favpng-A0tt8aVzdqP30RjwFGhjNABpm.jpg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 22.0),
                      child: Text(
                        name!,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 39.0,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Center(
                  child: Text(email!,
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: 8.0,
                  width: 355,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Personal Information",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0, top: 8.0),
                child: Text(
                  "Address:                  ${address!}",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0, top: 8.0),
                child: Text(
                  "Phone Number:     ${phone!}",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0, top: 8.0),
                child: Text(
                  "Date of Birth:          ${dob!.substring(0, 16)}",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0, top: 8.0),
                child: Text(
                  "Sex:                          ${sex!}",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      )
    ]));
  }
}
