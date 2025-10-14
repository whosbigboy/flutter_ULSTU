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
      debugShowCheckedModeBanner: false ,
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
  final Color _color = Colors.blueAccent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color,
        title: Text(widget.title),
      ),
      body: MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final data = [
      _CardData(
          "text",
          descriptionText: "descriptionText",
          imageUrl: "https://i.pinimg.com/736x/1a/a4/8c/1aa48c0e918d8da9d90d26cc89914e2b.jpg"
      ),

      _CardData(
          "text",
          descriptionText: "descriptionText",
          icon: Icons.account_box,
          imageUrl: "https://i.pinimg.com/736x/56/0c/6f/560c6f7a19db891e243185fec48737e3.jpg"
      ),

      _CardData(
          "text",
          descriptionText: "descriptionText",
          icon: Icons.account_box,
          imageUrl: "https://i.pinimg.com/736x/a4/d4/05/a4d40513206a5e7785b97a8e067d2eb4.jpg"
      )
    ];

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: data.map((e) => _Card.fromData(e)).toList(),
        ),
      ),
    );
  }
}

class _CardData{
  final String text;
  final String descriptionText;
  final IconData icon;
  final String? imageUrl;

  _CardData(
      this.text,{
        required this.descriptionText,
        this.icon = Icons.abc,
        this.imageUrl,
      });
}

class _Card extends StatefulWidget {

  final String text;
  final String descriptionText;
  final IconData icon;
  final String? imageUrl;

  const _Card(
      this.text, {
        this.icon = Icons.face,
        required this.descriptionText,
        this.imageUrl,
      });

  factory _Card.fromData(_CardData data) => _Card(
    data.text,
    descriptionText: data.descriptionText,
    icon: data.icon,
    imageUrl: data.imageUrl,
  );

  @override
  State<_Card> createState() => _CardState();
}

class _CardState extends State<_Card> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black,
          width: 5,
        ),
        color: Colors.deepOrange,
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    topLeft: Radius.circular(16)

                ),
                child: SizedBox(
                  height: double.infinity,
                  width: 150,
                  child: Image.network(
                    widget.imageUrl ?? "",
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Placeholder(),
                  ),
                )
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.text,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text(
                      widget.descriptionText,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 16,
                  bottom: 16,
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: isLiked
                        ? const Icon(
                        Icons.favorite,
                        color: Colors.blue,
                        key : ValueKey<int>(0)
                    )
                        : const Icon(
                        Icons.favorite_border,
                        key : ValueKey<int>(1)
                    ),

                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

