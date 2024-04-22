import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:score/providers/match_data.dart';
import 'package:score/screens/new_match/new_match.dart';
// ignore: unused_import
import 'package:score/screens/score/score.dart';
import 'package:score/utility/colors.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.grey[900],
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MatchData(),
      child: MaterialApp(
        title: 'Cricket Score App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: greenColor),
          useMaterial3: true,
          
        ),
        home:  NewMatchScreen(),
      ),
    );
  }
}

