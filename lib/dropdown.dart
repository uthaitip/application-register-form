// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_register/modal/province.dart';
// import 'package:flutter_register/data/province.dart';

// class MyDropdownWidget extends StatefulWidget {
//   @override
//   _MyDropdownWidgetState createState() => _MyDropdownWidgetState();
// }

// class _MyDropdownWidgetState extends State<MyDropdownWidget> {
//   late Future<List<Location>> locations;

//   @override
//   void initState() {
//     super.initState();
//     locations = fetchData(); // Fetch data from your source
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Location>>(
//       future: locations,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator(); // Display a loading indicator while fetching data
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return Text('No data available'); // Display if there's no data
//         } else {
//           return DropdownButtonFormField<Location>(
//             items: snapshot.data!
//                 .map((location) => DropdownMenuItem<Location>(
//                       value: location,
//                       child: Text(location.nameTh), // Display name in Thai
//                     ))
//                 .toList(),
//             onChanged: (Location? value) {
//               if (value != null) {
//                 // Handle the selected value
//                 print('Selected: ${value.nameEn}');
//               }
//             },
//           );
//         }
//       },
//     );
//   }

//   List<Location> parseLocations(Map<String, dynamic> data) {
//     final List<Map<String, dynamic>> records =
//         List<Map<String, dynamic>>.from(data['RECORDS']);
//     return records.map((record) => Location.fromJson(record)).toList();
//   }

//   Future<List<Location>> fetchData() async {
//     // Replace this with your logic to fetch JSON data from a file or network
//     // For example, if you have a JSON string, load it using rootBundle
//     // String jsonString = await rootBundle.loadString('locations.json');

//     // final Map<String, dynamic> data = jsonDecode(jsonString);
//     final List<Location> locations = parseLocations(province);
//     return locations;
//   }
// }
