import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:practice/auth/login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practice/validation.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool? error, sending;
  bool success = false;
  bool valildate = false;
  String? message;
  Validation formValidation = Validation();
  @override
  void initState() {
    error = false;
    super.initState();
  }

  void showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text('$message'),
        backgroundColor: Colors.blue,
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController sex = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController userpassword = TextEditingController();

  Future<void> sendData() async {
    var url =
        Uri.parse('https://polar-beach-17297.herokuapp.com/api/user/register');
    var res = await http.post(url, body: {
      "name": name.text,
      "sex": sex.text,
      "dob": dob.text,
      "phone": phone.text,
      "address": address.text,
      "email": email.text,
      "password": userpassword.text,
    }); //sending post request with header data

    if (res.statusCode == 200) {
      success = true;
      message = "successfully create account.";
      setState(() {});
      print(res.body); //print raw response on console
      var data = json.decode(res.body); //decoding json to array

      //mark error and refresh UI with setState

    } else {
      success = false;
      setState(() {});
      message = "Error during register data.";

      //mark error and refresh UI with setState

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: const Text("abac"),
      //   backgroundColor: const Color(0xffED3237),
      // ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 22.0),
            child: Center(
              child: Container(
                height: 155.0,
                width: 177.0,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/935px-Logo_of_CPN_(UML).png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 29.0)),
          const Center(
            child: Text(
              "Volunter Management",
              style: TextStyle(
                  //color: Colors.red,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 29.0)),
          const Center(
            child: Text(
              "Booth Data Collection",
              style: TextStyle(
                  color: Color(0xffEE2E35),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Form(
              child: Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: "Name"),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: "Sex"),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "PhoneNumber"),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: "Name"),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Address"),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: "Email"),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Password"),
                        )
                      ],
                    ),
                  ))),
          // Padding(
          //   padding: EdgeInsets.all(10.0),
          //   child: TextField(
          //     controller: name,
          //     decoration: InputDecoration(
          //         border: UnderlineInputBorder(),
          //         labelText: "Name",
          //         errorText: valildate == false ? 'Name cannot be empty' : null,
          //         hintText: "Enter your Name"),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: TextField(
          //     controller: sex,
          //     decoration: InputDecoration(
          //         border: UnderlineInputBorder(),
          //         errorText: ,
          //         labelText: "Sex",
          //         hintText: "Male/Female"),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: TextField(
          //     controller: dob,
          //     decoration: InputDecoration(
          //         border: UnderlineInputBorder(),
          //         errorText: valildate == false ? 'DOB cannot be empty' : null,
          //         labelText: "Date of Birth",
          //         hintText: "2021/5/5"),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: TextField(
          //     controller: phone,
          //     decoration: InputDecoration(
          //         border: UnderlineInputBorder(),
          //         errorText:
          //             valildate == false ? 'Phone cannot be empty' : null,
          //         labelText: "phone",
          //         hintText: "98123456"),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: TextField(
          //     controller: address,
          //     decoration: InputDecoration(
          //         border: UnderlineInputBorder(),
          //         errorText:
          //             valildate == false ? 'address cannot be empty' : null,
          //         labelText: "Address",
          //         hintText: "Kathmandu"),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: TextField(
          //     controller: email,
          //     decoration: InputDecoration(
          //         border: UnderlineInputBorder(),
          //         errorText: MultiValidator()
          //         labelText: "Email",
          //         hintText: "example@example.com"),
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.all(10.0),
          //   child: TextField(
          //     controller: userpassword,
          //     decoration: InputDecoration(
          //         border: UnderlineInputBorder(),
          //         errorText: formValidation.validatePassword(userpassword.text),
          //         labelText: "Password",
          //         hintText: "write your password"),
          //   ),
          // ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  sendData();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                  showToast(context);
                },
                child: Container(
                  height: 55.0,
                  width: 333.9,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(11.0)),
                    color: Colors.red,
                  ),
                  child: const Center(
                    child: Text(
                      "Create an Account",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 22.0, left: 88.0),
                child: Center(
                  child: Row(
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: const Text("Sign In",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)))
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
