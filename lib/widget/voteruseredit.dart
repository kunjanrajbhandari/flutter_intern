// import 'package:flutter/material.dart';

// class EditVoterUser extends StatefulWidget {
//   EditVoterUser({Key? key}) : super(key: key);

//   @override
//   State<EditVoterUser> createState() => _EditVoterUserState();
// }

// class _EditVoterUserState extends State<EditVoterUser> {
//   GlobalKey<FormState> formkey = GlobalKey<FormState>();

//   List<String> gender = ["Male", "Female", "Other"];

//   String? selectedParty;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("abcd")),
//       body: Column(
//         children: [
//           Form(
//               child: Form(
//                   key: formkey,
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   child: Padding(
//                     padding: const EdgeInsets.all(25.0),
//                     child: Column(
//                       children: [
//                         Padding(padding: EdgeInsets.only(top: 10.0)),
//                         TextFormField(
//                           decoration: InputDecoration(
//                               hintText: "Enter Your Full Name",
//                               border: OutlineInputBorder(),
//                               labelText: "Full Name"),
//                           //validator: RequiredValidator(errorText: "Required *"),
//                           onChanged: (value) {},
//                         ),
//                         Padding(padding: EdgeInsets.only(top: 10.0)),
//                         //Gender dropdown
//                         //code copy from stackoverflow
//                         //url: https://stackoverflow.com/questions/55369732/how-to-add-flutter-dropdownbuttonformfield
//                         DropdownButtonFormField(
//                           value: sex,
//                           hint: Text(
//                             'Choose Your Gender',
//                           ),
//                           onChanged: (value) {
                            
//                             setState(() {
//                               selectedParty = value.toString();
//                             });
//                           },
//                           onSaved: (value) {
//                             sex = value.toString();
//                           },
//                           decoration:
//                               InputDecoration(border: OutlineInputBorder()),
//                           items: gender.map((String value) {
//                             return DropdownMenuItem(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                         ),

//                         // end dropdownbutton form field

//                         Padding(padding: EdgeInsets.only(top: 10.0)),

//                         //start
//                         //Date and time for Textform field
//                         //copy form https://stackoverflow.com/questions/54127847/flutter-how-to-display-datepicker-when-textformfield-is-clicked
//                         TextFormField(
//                           // focusNode: _focusNode,
//                           keyboardType: TextInputType.phone,
//                           autocorrect: false,

//                           onSaved: (value) {},
//                           onTap: () {
//                             ;
//                             // FocusScope.of(context).requestFocus(new FocusNode());
//                           },

//                           maxLines: 1,
//                           //initialValue: 'Aseem Wangoo',
//                           validator: (value) {
//                             if (value == null) {
//                               return 'Choose Date';
//                             }
//                           },
//                           decoration: InputDecoration(
//                             labelText: 'Date of Birth.',
//                             hintText: 'Write Your Date of Birth',
//                             border: OutlineInputBorder(),
//                             //filled: true,
//                             suffixIcon: const Icon(Icons.calendar_today),

//                             //icon: const Icon(Icons.calendar_today),
//                             labelStyle: TextStyle(
//                                 decorationStyle: TextDecorationStyle.solid),
//                           ),
//                         ),

//                         //End datatime picker

//                         Padding(padding: EdgeInsets.only(top: 10.0)),
//                         TextFormField(
//                           decoration: InputDecoration(
//                               hintText: "Enter your phone number",
//                               border: OutlineInputBorder(),
//                               labelText: "Phone Number"),
//                           //validator: RequiredValidator(errorText: "Required *"),
//                           onChanged: (value) {},
//                         ),
//                         Padding(padding: EdgeInsets.only(top: 10.0)),
//                         TextFormField(
//                           decoration: InputDecoration(
//                               hintText: "Enter your Address",
//                               border: OutlineInputBorder(),
//                               labelText: "Address"),
//                           //validator: RequiredValidator(errorText: "Required *"),
//                           onChanged: (value) {},
//                         ),
//                         Padding(padding: EdgeInsets.only(top: 10.0)),
//                         TextFormField(
//                           decoration: InputDecoration(
//                               hintText: "Enter Your Email",
//                               border: OutlineInputBorder(),
//                               labelText: "Email"),
//                           // validator: MultiValidator([
//                           //   RequiredValidator(errorText: "Required *"),
//                           //   EmailValidator(
//                           //       errorText: "Enter a valid email address"),
//                           // ]),
//                           onChanged: (value) {},
//                         ),

//                         Padding(padding: EdgeInsets.only(top: 10.0)),
//                         TextFormField(
//                           decoration: InputDecoration(
//                               hintText: "Enter Your Password",
//                               border: OutlineInputBorder(),
//                               labelText: "Password"),
//                           //validator: RequiredValidator(errorText: "Required *"),
//                           onChanged: (value) {},
//                         ),
//                       ],
//                     ),
//                   ))),
//         ],
//       ),
//     );
//   }
// }
