import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practice/model/voterlist.dart';

class BoothShow extends StatefulWidget {
  // String? name;
  BoothShow({Key? key}) : super(key: key);

  @override
  State<BoothShow> createState() => _BoothShowState();
}

bool loading = false;
bool loadingvote = false;
int? count;
List<VoterList> voterList = [];
List<PartyList> partyList = [];

class _BoothShowState extends State<BoothShow> {
  Future<void> voterUser() async {
    var url = Uri.parse('https://polar-beach-17297.herokuapp.com/api/voter');
    loading = true;

    setState(() {});
    var response = await http.get(url);
    dynamic result = json.decode(response.body);
    if (response.statusCode == 200) {
      count = result['results'];
      for (int i = 0; i < result['results']; i++) {
        dynamic data = result['data']['voterList'][i];
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
                      padding: const EdgeInsets.only(top: 11.0, left: 8.0),
                      child: Text(
                        "Party List",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 85,
                                  childAspectRatio: 2 / 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: partyList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 55,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(11.0))),
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
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
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
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                tileColor: Colors.blue.withOpacity(0.8),
                                trailing: IconButton(
                                  icon: Icon(Icons.view_agenda_outlined),
                                  onPressed: () {},
                                ),
                                title: Text(
                                  voterList[index].name.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                )
        ],
      ),
    ));
  }
}
