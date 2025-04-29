import 'package:flutter/material.dart';
import 'package:green_town/pages/home_page.dart';

void main() {
  runApp(const GreenTown());
}

class GreenTown extends StatelessWidget {
  const GreenTown({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green town',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}
