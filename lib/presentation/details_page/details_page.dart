import 'package:flutter/material.dart';

import '../home_page/home_page.dart';
import 'package:flutter_app/domain/models/card.dart';

class DetailsPage extends StatelessWidget {
  final CardData data;
  const DetailsPage(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(26, 0, 137, 100),
        iconTheme: IconThemeData(color: Colors.white),
        title: Center(
          child: Text(
            data.text,
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Image.network(data.imageUrl ?? '',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Image.network(
                'https://i.pinimg.com/736x/09/72/f1/0972f1465684046cc884eca70fdde096.jpg',
              ),
            ),

          ),
          Center(
            child: Text(data.descriptionText, style: TextStyle(fontSize: 25)),
          ),
        ],
      ),
    );
  }
}
