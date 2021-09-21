import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/auth/login.dart';
import 'package:practice/database/database.dart';
import 'package:practice/model/token.dart';
import 'package:practice/widget/bootwidget.dart';

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
                padding: const EdgeInsets.only(left: 8.0),
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
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0, top: 11.0),
                child: Text(
                  "District:                         " +
                      userAsignedLists[index].district,
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0, top: 11.0),
                child: Text(
                  "Fed Constituency        " +
                      userAsignedLists[index].fedConstituency,
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0, top: 11.0),
                child: Text(
                  "Prov Consitituency:    " +
                      userAsignedLists[index].provConstituency,
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0, top: 11.0),
                child: Text(
                  "Local Body:                  " +
                      userAsignedLists[index].localBody,
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0, top: 11.0),
                child: Text(
                  "Ward:                              " +
                      userAsignedLists[index].ward,
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0, top: 29),
                child: Text("Booth:  ",
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 44.0, top: 5.0),
                child: SizedBox(
                  height: 333,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: userAsignedLists[index].booth.length,
                      itemBuilder: (context, count) {
                        return BoothWidget(
                            name: userAsignedLists[index].booth[count]);
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
            decoration: BoxDecoration(
                color: Color(0xffF1EBEB),
                borderRadius: BorderRadius.all(Radius.circular(22.0))),
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Column(
                children: [
                  Expanded(child: boothWidth()),
                ],
              ),
            ),
          ),
        )
      ]),
    ));
  }
}
