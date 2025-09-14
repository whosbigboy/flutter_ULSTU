import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
      ),
      home: const MyHomePage(title: 'Baryshev Dima PIbd-33'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

      
        
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Color _color = Colors.deepOrange;

  void _incrementCounter() {
    setState(() {
      _counter++;
      _color=Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
                                                                                                                                            mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                'сколько у тебя долгов?',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            if (_counter>10)
              Text(
                'УДАЧИ!)',
                style: Theme.of(context).textTheme.headlineLarge,
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        backgroundColor: _color,
        tooltip: 'Increment',
        child: const Icon(Icons.ac_unit),
      ),     );
  }
}
