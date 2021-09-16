import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice/dashboard.dart';
import 'package:practice/database/database.dart';
import 'package:practice/model/model.dart';
import 'package:practice/auth/signup.dart';
import 'package:practice/validation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  bool? loading;
  Login({this.loading = false});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  void showToast(BuildContext context, String message, Color resColor) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: resColor,
      ),
    );
  }

  bool? loading = false;
  String? exception;
  String? username;
  String? password;
  bool validate = false;
  addUser(Users user) async {
    var result = await DB.insert(user);
    print(result);
  }

  Future<void> userData() async {
    var url =
        Uri.parse('https://polar-beach-17297.herokuapp.com/api/user/login');
    loading = true;
    setState(() {});
    var response = await http
        .post(url, body: {'email': '$username', 'password': '$password'});

    loading = false;
    setState(() {});
    dynamic result = json.decode(response.body);
    if (response.statusCode == 200) {
      Users user = Users(
          id: result['_id'],
          token: result['token'],
          name: result['name'],
          email: result['email']);
      await addUser(user);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
      print(result);
    } else if (username == null || password == null) {
      Color resColor = Colors.red;
      var message = "Cannot insert Null value.";
      showToast(context, message, resColor);
    } else {
      Color resColor = Colors.red;
      var message = "Incorrect Username or password.";
      showToast(context, message, resColor);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      loading = widget.loading;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.yellow,
      //resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: const Text("abac"),
      //   backgroundColor: const Color(0xffED3237),
      // ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 69.0),
            child: Center(
              child: Container(
                height: 199.0,
                width: 199.0,
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
                color: Colors.black,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
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
          Padding(
            padding: EdgeInsets.all(15.0),
            child: TextField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Email",
                  hintText: "Enter your email"),
              onChanged: (value) {
                username = value;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: TextField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Password",
                  hintText: "Enter your Password"),
              onChanged: (value) {
                password = value;
              },
            ),
          ),
          Column(
            children: [
              const Padding(
                  padding: EdgeInsets.only(left: 255.0, top: 3.0, bottom: 15.0),
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.red),
                  )),
              loading == true
                  ? const CircularProgressIndicator()
                  : GestureDetector(
                      onTap: () async {
                        setState(() {
                          password == null ? validate = true : validate = false;
                        });
                        await userData();
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
                            "LOGIN",
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
                        "Don't have an account?",
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUp()));
                          },
                          child: const Text("Register",
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
