//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practice/model/voterlist.dart';
import 'package:practice/widget/voteruseredit.dart';

class BoothShow extends StatefulWidget {
  // String? name;
  BoothShow({Key? key}) : super(key: key);

  @override
  State<BoothShow> createState() => _BoothShowState();
}

List<String> partyListDropDown = [];
String? selectedParty;

bool loading = false;
bool loadingvote = false;
int? count;
List<VoterList> voterList = [];
List<PartyList> partyList = [];
String? _value = 'abc';
int val = -1;

String voteToWhom(String value) {
  if (value == 'uml') {
    selectedParty = "UML";
  } else {
    selectedParty = "other";
  }

  return selectedParty!;
}

class _BoothShowState extends State<BoothShow> {
  Future<void> voterUser() async {
    var url = Uri.parse('https://polar-beach-17297.herokuapp.com/api/voter');
    loading = true;

    setState(() {});
    var response = await http.get(url);
    dynamic result = json.decode(response.body);
    if (response.statusCode == 200) {
      //count = result['results'];
      for (int i = 0; i < result.length; i++) {
        dynamic data = result[i];
        voterList.add(VoterList(
            name: data['name'],
            voterId: data['voterId'],
            age: data['age'],
            sex: data['sex'],
            relation: data['relation'],
            contact: data['contact'],
            yes: data['yes'],
            no: data['no'],
            maybe: data['maybe'],
            abcParty: data['abcParty'],
            otherparty: data['otherParty']));
        //print(result['data']['voterList'][i]['name']);
        loading = false;

        setState(() {});
      }
    }
  }

  Future<void> listParty() async {
    partyList = [];
    var url =
        Uri.parse('https://polar-beach-17297.herokuapp.com/api/party/list');
    loadingvote = true;

    setState(() {});
    var response = await http.get(url);
    dynamic result = json.decode(response.body);
    if (response.statusCode == 200) {
      for (int i = 0; i < result.length; i++) {
        partyList
            .add(PartyList(name: result[i]['name'], photo: result[i]['photo']));
      }
      loadingvote = false;

      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    voterUser();
    listParty();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // voter party count/....
        body: SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: [
          Stack(children: [
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
                        "Voter List",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 147.0),
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
          ]),
          (loading == true || loadingvote == true)
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 90,
                                  childAspectRatio: 2 / 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: partyList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 10.0,
                              child: Container(
                                height: 170,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(11.0))),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: 77,
                                        child: Image(
                                          image: NetworkImage(
                                              partyList[index].photo),
                                          height: 60,
                                          width: 69,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      partyList[index].name!,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '0',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: voterList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return StatefulBuilder(builder: (context, state) {
                              String selectedRadio = "abc";
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ExpansionTile(
                                  collapsedBackgroundColor:
                                      (voterList[index].yes == 1)
                                          ? Colors.blue.withOpacity(0.8)
                                          : (voterList[index].maybe == 1)
                                              ? Color(0xffEFB701)
                                              : Colors.red.withOpacity(0.8),
                                  backgroundColor: (voterList[index].yes == 1)
                                      ? Colors.blue.withOpacity(0.8)
                                      : (voterList[index].maybe == 1)
                                          ? Color(0xffEFB701)
                                          : Colors.red.withOpacity(0.8),
                                  title: Text(
                                    voterList[index].name.toString(),
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(
                                        "VOTER ID: " +
                                            voterList[index].voterId.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        "Sex: " +
                                            voterList[index].sex.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        "AGE: " +
                                            voterList[index].age.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: ListTile(
                                        title: Text(
                                          "RELATION: " +
                                              voterList[index]
                                                  .relation
                                                  .toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: ListTile(
                                        title: Text(
                                          "CONTACT: " +
                                              voterList[index]
                                                  .contact
                                                  .toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 11.0),
                                          child: Text("MAYBE:  ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700)),
                                        ),
                                        Column(
                                          children: [
                                            Radio(
                                              value: 'green',
                                              groupValue: selectedRadio,
                                              activeColor: Colors.green,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedRadio =
                                                      value.toString();
                                                  voterList[index].yes = 1;
                                                  voterList[index].no = 0;
                                                  voterList[index].maybe = 0;
                                                  //function to vote to dooo...///
                                                  voterList[index].voteTo =
                                                      "UML";

                                                  //to do  vote to uml
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              child: Text(
                                                "Green",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Radio(
                                              value: 'Yellow',
                                              groupValue: selectedRadio,
                                              activeColor: Colors.yellow,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedRadio =
                                                      value.toString();
                                                  voterList[index].yes = 0;
                                                  voterList[index].no = 0;
                                                  voterList[index].maybe = 1;
                                                  voterList[index].voteTo =
                                                      null;
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              child: Text(
                                                "yellow",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Radio(
                                              value: 'Red',
                                              groupValue: selectedRadio,
                                              activeColor: Colors.red,
                                              onChanged: (value) {
                                                setState(() {
                                                  state(() {
                                                    selectedRadio =
                                                        value.toString();
                                                    voterList[index].yes = 0;
                                                    voterList[index].no = 1;
                                                    voterList[index].maybe = 0;
                                                    voterList[index].voteTo =
                                                        null;
                                                  });
                                                });
                                              },
                                            ),
                                            SizedBox(
                                              child: Text(
                                                "Red",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 10),
                                    //voto ui with drop down.
                                    //Gender dropdown
                                    //code copy from stackoverflow
                                    //url: https://stackoverflow.com/questions/55369732/how-to-add-flutter-dropdownbuttonformfield
                                    DropdownButtonFormField(
                                      value: voterList[index].voteTo,
                                      hint: Text(
                                        'VOTE TO',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedParty = value.toString();
                                          print(selectedParty);
                                        });
                                      },
                                      onSaved: (value) {
                                        selectedParty = value.toString();
                                        print(selectedParty);
                                      },
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          label: Text("Vote to")),
                                      items: partyList.map((value) {
                                        return DropdownMenuItem(
                                            value: value.name,
                                            child: Text(value.name.toString()));
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              );
                            });
                          }),
                    ),
                  ],
                )
        ],
      ),
    ));
  }
}
