import 'package:flutter/material.dart';
import '/screens/home_page.dart';

void main() {
  runApp(const RunnersApp());
}

class RunnersApp extends StatelessWidget {
  const RunnersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Runners App',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}
