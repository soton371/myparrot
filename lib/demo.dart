// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:myparrot/db/db_helper.dart';
// import 'package:unique_identifier/unique_identifier.dart';

// class DemoScreen extends StatefulWidget {
//   const DemoScreen({super.key});

//   @override
//   State<DemoScreen> createState() => _DemoScreenState();
// }

// class _DemoScreenState extends State<DemoScreen> {
//   String _identifier = 'Unknown';

//   @override
//   void initState() {
//     super.initState();
//     initUniqueIdentifierState();
//   }

//   Future<void> initUniqueIdentifierState() async {
//     String identifier;
//     try {
//       identifier = (await UniqueIdentifier.serial)!;
//       debugPrint("identifier: $identifier");
//       await DatabaseHelper.instance.insertSerialNumber(identifier);
//     } on PlatformException {
//       identifier = 'Failed to get Unique Identifier';
//     }

//     if (!mounted) return;

//     setState(() {
//       _identifier = identifier;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Plugin example app'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Text('Running on device with id: $_identifier\n'),
//             ElevatedButton(
//                 onPressed: () async {
//                   final ser = await DatabaseHelper.instance.fetchSerialNumber();
//                   debugPrint("ser: $ser");
//                 },
//                 child: const Text("Get Serial Number"))
//           ],
//         ),
//       ),
//     );
//   }
// }
