import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:green_town/pages/home_page.dart';


void main() {
  runApp(const GreenTown());
}

class GreenTown extends StatelessWidget {
  const GreenTown({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}
