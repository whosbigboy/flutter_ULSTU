import 'package:flutter/material.dart';

import '../home_page/home_page.dart';

class DetailsPage extends StatelessWidget{
  final CardData data;
  const DetailsPage(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Image.network(data.imageUrl ?? '',),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                data.text,
                style: TextStyle(
                  fontSize: 30,
                )
              ),
            ),
          ),
          Center(
            child: Text(
              data.descriptionText,
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          )
        ],
      ),
    );
  }
}