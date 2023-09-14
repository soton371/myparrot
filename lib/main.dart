import 'package:flutter/material.dart';
import 'package:myparrot/configs/my_colors.dart';
import 'package:myparrot/screens/recipient/recipient_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parrot',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.seed),
        useMaterial3: true,
      ),
      // home: const DemoScreen(),
      home: const RecipientScreen(),
    );
  }
}
