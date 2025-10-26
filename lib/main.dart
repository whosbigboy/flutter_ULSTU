import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Color whiteChocolate = Color.fromRGBO(239, 231, 211, 100);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        scaffoldBackgroundColor: whiteChocolate,
      ),
      home: const MyHomePage(title: 'Baryshev Dima PIbd-33'),
    );
  }
}
