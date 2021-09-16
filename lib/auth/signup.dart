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
  String? message;

  Validation formValidation = Validation();
  @override
  void initState() {
    super.initState();
  }

  void showToast(BuildContext context, String message, Color resColor) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: resColor,
      ),
    );
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool loading = false;
  String? name;
  String? sex;
  String? dob;
  String? phone;
  String? address;
  String? email;
  String? userpassword;
  void validate() {
    if (formkey.currentState!.validate()) {
      print('validate');
    } else {
      print("not validate");
    }
  }

  Future<void> sendData() async {
    final Color resColor;
    var url =
        Uri.parse('https://polar-beach-17297.herokuapp.com/api/user/register');
    loading = true;
    setState(() {});
    var res = await http.post(url, body: {
      "name": name,
      "sex": sex,
      "dob": dob,
      "phone": phone,
      "address": address,
      "email": email,
      "password": userpassword,
    }); //sending post request with header data
    loading = false;
    setState(() {});
    if (res.statusCode == 200 || res.statusCode == 201) {
      var data = json.decode(res.body); //decoding json to array
      message = "Success";
      resColor = Colors.green;
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
      showToast(context, message!, resColor);

      //mark error and refresh UI with setState

    } else {
      resColor = Colors.red;
      message = "Request failed with status: ${res.statusCode}.";
      showToast(context, message!, resColor);
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: "Name"),
                          //validator: RequiredValidator(errorText: "Required *"),
                          onChanged: (value) {
                            name = value;
                          },
                        ),
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: "Sex"),
                          //validator: RequiredValidator(errorText: "Required *"),
                          onChanged: (value) {
                            sex = value;
                          },
                        ),
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Date Of Birth"),
                          //validator: RequiredValidator(errorText: "Required *"),
                          onChanged: (value) {
                            dob = value;
                          },
                        ),
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Phone Number"),
                          //validator: RequiredValidator(errorText: "Required *"),
                          onChanged: (value) {
                            phone = value;
                          },
                        ),
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Address"),
                          //validator: RequiredValidator(errorText: "Required *"),
                          onChanged: (value) {
                            address = value;
                          },
                        ),
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), labelText: "Email"),
                          // validator: MultiValidator([
                          //   RequiredValidator(errorText: "Required *"),
                          //   EmailValidator(
                          //       errorText: "Enter a valid email address"),
                          // ]),
                          onChanged: (value) {
                            email = value;
                          },
                        ),
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        TextFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Password"),
                          //validator: RequiredValidator(errorText: "Required *"),
                          onChanged: (value) {
                            userpassword = value;
                          },
                        )
                      ],
                    ),
                  ))),
          Column(
            children: [
              loading == true
                  ? CircularProgressIndicator()
                  : GestureDetector(
                      onTap: () {
                        if (phone != null &&
                            name != null &&
                            sex != null &&
                            address != null &&
                            email != null &&
                            phone != null &&
                            userpassword != null) {
                          //validate();
                          sendData();
                        } else {
                          Color resColor = Colors.red;
                          message =
                              "Some Field are empty please fill that field.";
                          showToast(context, message!, resColor);
                        }
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
