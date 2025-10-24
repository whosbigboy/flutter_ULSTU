import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_app/presentation/details_page/details_page.dart';
part '../../domain/models/card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Color darkblue = Color.fromRGBO(26, 0, 137, 100);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkblue,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {

    final data = [
      CardData(
          "text",
          descriptionText: "descriptionText",
          imageUrl: "https://i.pinimg.com/736x/1a/a4/8c/1aa48c0e918d8da9d90d26cc89914e2b.jpg"
      ),

      CardData(
          "text",
          descriptionText: "descriptionText",
          icon: Icons.account_box,
          imageUrl: "https://i.pinimg.com/736x/56/0c/6f/560c6f7a19db891e243185fec48737e3.jpg"
      ),

      CardData(
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
          children: data.map((data) {
            return _Card.fromData(
              data,
              onLike: (String title, bool isLiked)
              => _showSnackBar(context, title, isLiked),
              onTap: () => _navToDetails(context, data)
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String title, bool isLiked){
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(
          child: Text(
            'goddam u ${isLiked ? "liked this $title" : "disliked this $title :("}',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(26, 0, 137, 100),
        duration: const Duration(milliseconds: 1500),
      ));
    });
  }

  void _navToDetails(BuildContext context, CardData data){
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => DetailsPage(data)),
    );
  }
}
