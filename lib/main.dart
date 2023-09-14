import 'package:flutter/material.dart';
import 'package:myparrot/blocs/identifier/identifier_bloc.dart';
import 'package:myparrot/configs/my_colors.dart';
import 'package:myparrot/screens/recipient/recipient_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<IdentifierBloc>(
          create: (BuildContext context) => IdentifierBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Parrot',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: MyColors.seed),
          useMaterial3: true,
        ),
        // home: const DemoScreen(),
        home: const RecipientScreen(),
      ),
    );
  }
}
