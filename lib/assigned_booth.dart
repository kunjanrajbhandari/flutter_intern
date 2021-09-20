import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/auth/login.dart';
import 'package:practice/database/database.dart';
import 'package:practice/model/token.dart';

class AssignedBooth extends StatelessWidget {
  List<UserAsigned> userAsignedLists = [];
  AssignedBooth({Key? key, required this.userAsignedLists}) : super(key: key);

  Widget boothWidth() {
    print(userAsignedLists[0].booth);
    return ListView.builder(
      itemCount: userAsignedLists.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 11.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 11.0),
                child: Text(
                  "Booth Details:                      ",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0, top: 11.0),
                child: Text(
                  "Provision:                      " +
                      userAsignedLists[index].provision,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0, top: 11.0),
                child: Text(
                  "Distrit:                            " +
                      userAsignedLists[index].district,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0, top: 11.0),
                child: Text(
                  "Fed Constituency        " +
                      userAsignedLists[index].fedConstituency,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0, top: 11.0),
                child: Text(
                  "Prov Consitituency:    " +
                      userAsignedLists[index].provConstituency,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0, top: 11.0),
                child: Text(
                  "Local Body:                  " +
                      userAsignedLists[index].localBody,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0, top: 11.0),
                child: Text(
                  "Ward:                              " +
                      userAsignedLists[index].ward,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0, top: 11.0),
                    child: Text(
                      "Booth:  ",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 208.0),
                child: SizedBox(
                  height: 222.0,
                  child: ListView.builder(
                      itemCount: userAsignedLists[index].booth.length,
                      itemBuilder: (context, count) {
                        return Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(userAsignedLists[index].booth[count],
                                    style: TextStyle(fontSize: 18.0))
                              ],
                            ),
                          ],
                        );
                      }),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(children: [
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
                  padding: const EdgeInsets.only(left: 55.0),
                  child: Text(
                    "Assigned Booth",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 77.0),
                  child: SizedBox(
                    width: 44.0,
                    height: 44.0,
                    child: Image(
                      image: AssetImage('assets/flag.jpg'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 222.0, left: 17.0),
          child: Container(
            height: 444.0,
            width: 359,
            color: Color(0xffF1EBEB).withOpacity(0.8),
            child: Column(
              children: [
                Expanded(child: boothWidth()),
              ],
            ),
          ),
        )
      ]),
    ));
  }
}
