// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:tailor/HttpServices/RegisterModel.dart';
//
// Future<Register> fetchAlbum() async {
//   final response = await http.get(
//     Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
//   );
//
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Register.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }
//
// Future<Register> updateAlbum(String tailorName, String studioName,
//     String userEmail, String userAddress, String userPhone) async {
//   final response = await http.put(
//     Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'tailorName': tailorName,
//       'studioName': studioName,
//       'userEmail': userEmail,
//       'userAddress': userAddress,
//       'userPhone': userPhone,
//     }),
//   );
//
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Register.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to update album.');
//   }
// }
//
// class EditProfile extends StatefulWidget {
//   const EditProfile({Key key}) : super(key: key);
//
//   @override
//   _EditProfileState createState() => _EditProfileState();
// }
//
// class _EditProfileState extends State<EditProfile> {
//   final TextEditingController _tName = TextEditingController();
//   final TextEditingController _sName = TextEditingController();
//   final TextEditingController _address = TextEditingController();
//   final TextEditingController _email = TextEditingController();
//   final TextEditingController _phone = TextEditingController();
//
//   Future<Register> _futureAlbum;
//
//   @override
//   void initState() {
//     super.initState();
//     _futureAlbum = fetchAlbum();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Update Data Example'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           TextField(
//             controller: _tName,
//             decoration: InputDecoration(hintText: 'first name'),
//           ),
//           TextField(
//             controller: _sName,
//             decoration: InputDecoration(hintText: 'tailor name'),
//           ),
//           TextField(
//             controller: _email,
//             decoration: InputDecoration(hintText: 'Email'),
//           ),
//           TextField(
//             controller: _address,
//             decoration: InputDecoration(hintText: 'Address'),
//           ),
//           TextField(
//             controller: _phone,
//             decoration: InputDecoration(hintText: 'Phone'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 _futureAlbum = updateAlbum(
//                   _tName.text,
//                   _sName.text,
//                   _address.text,
//                   _email.text,
//                   _phone.text,
//                 );
//               });
//             },
//             child: Text('Update Data'),
//           ),
//         ],
//       ),
//     );
//   }
// }
