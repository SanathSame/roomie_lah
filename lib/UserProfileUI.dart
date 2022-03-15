// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class UserProfileUI extends StatefulWidget {
//   @override
//   _UserProfileUIState createState() => _UserProfileUIState();
// }
//
// class _UserProfileUIState extends State<UserProfileUI> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     return Scaffold(
//         body: SafeArea(
//             child: SingleChildScrollView(
//       child: Column(children: <Widget>[
//         Container(
//           height: size.height * 0.1,
//
//           margin: const EdgeInsets.all(20.0),
//           decoration: BoxDecoration(
//               color: Color(0xFF479055),
//               borderRadius: BorderRadius.all(Radius.circular(30))),
//           // height: size.height / 8,
//           width: size.width,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Image(
//                 image: AssetImage(imgPath),
//                 height: size.height * 0.08,
//                 width: size.width * 0.19,
//               ),
//               Text(name,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20.0,
//                       color: Colors.white)),
// //              SizedBox(width: 70.0),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => EditProfileUI()),
//                   );
//                 },
//                 child: Icon(
//                   Icons.edit_sharp,
//                   size: 35.0,
//                   color: Colors.white,
//                 ),
//               )
//             ],
//           ),
//         ),
//         SizedBox(height: 50.0),
//         Container(
//           height: 420,
//           child: ListView.separated(
//             padding: const EdgeInsets.all(8),
//             itemCount: attributes.length,
//             itemBuilder: (BuildContext context, int i) {
//               return Container(
//                   height: 50,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: Color(0xFF479055),
//                   ),
//                   child: Center(
//                       child: Text('${attributes[i]} ${test[i]}',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15.0,
//                               fontFamily: 'FjallaOne',
//                               color: Colors.white))));
//             },
//             separatorBuilder: (BuildContext context, int i) => const Divider(),
//           ),
//         )
//       ]),
//     )));
//   }
// }
