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
          "Gurren Laggan",
          descriptionText: "omg bro who the hell do u think Kanima and Simon are? Row row fight to power",
          imageUrl: "https://i.pinimg.com/1200x/5f/f2/40/5ff240b0b79e342d1729a058190ad206.jpg"
      ),

      CardData(
          "Cowboy Bebop",
          descriptionText: "cowboys in the space? smth like that. if u wannna listen to space jazz, u r welcome",
          icon: Icons.account_box,
          imageUrl: "https://i.pinimg.com/1200x/ce/26/74/ce267476fbbe391d72f0c091c27c7071.jpg"
      ),

      CardData(
          "Akira",
          descriptionText: "cool boy on the bike. and experiments on children in the neo-tokyo",
          icon: Icons.account_box,
          imageUrl: "https://i.pinimg.com/736x/3c/f3/da/3cf3da42abdef05e075cdebe52e48068.jpg"
      ),

      CardData(
          "Neon Genesis Evangelion",
          descriptionText: "hedgehog's dillema and many many many other problems",
          imageUrl: "https://i.pinimg.com/736x/0d/ee/db/0deedb6bbbbd2b17b2ab4495ca02f9c2.jpg"
      ),

      CardData(
          "Jojo's Bizarre Adventure",
          descriptionText: "new season, new some jojo's relative",
          imageUrl: "https://i.pinimg.com/1200x/3d/18/98/3d18985ce820ee790fbfeaf422a81e3c.jpg"
      ),

      CardData(
          "Grand blue",
          descriptionText: "men just chilling and vibing and drinking without sobering up and sometimes diving and rarely studying",
          imageUrl: "https://i.pinimg.com/736x/e6/56/36/e65636fe7c241dcf163d16f3c574caad.jpg"
      ),
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
