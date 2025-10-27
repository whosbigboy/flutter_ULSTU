import 'package:flutter_app/data/repositories/api_interface.dart';
import 'package:flutter_app/domain/models/card.dart';
import 'package:flutter/material.dart';

class MockRepository extends ApiInterface{
  @override
  Future<List<CardData>?> loadData({String? q}) async{
    return [
      CardData(
        "Gurren Laggan",
        descriptionText:
        "omg bro who the hell do u think Kanima and Simon are? Row row fight to power",
        imageUrl:
        "https://i.pinimg.com/1200x/5f/f2/40/5ff240b0b79e342d1729a058190ad206.jpg",
      ),

      CardData(
        "Cowboy Bebop",
        descriptionText:
        "cowboys in the space? smth like that. if u wannna listen to space jazz, u r welcome",
        icon: Icons.account_box,
        imageUrl:
        "https://i.pinimg.com/1200x/ce/26/74/ce267476fbbe391d72f0c091c27c7071.jpg",
      ),

      CardData(
        "Akira",
        descriptionText:
        "cool boy on the bike. and experiments on children in neo-tokyo",
        icon: Icons.account_box,
        imageUrl:
        "https://i.pinimg.com/736x/3c/f3/da/3cf3da42abdef05e075cdebe52e48068.jpg",
      ),

      CardData(
        "Neon Genesis Evangelion",
        descriptionText: "hedgehog's dillema and many many many other problems",
        imageUrl:
        "https://i.pinimg.com/736x/0d/ee/db/0deedb6bbbbd2b17b2ab4495ca02f9c2.jpg",
      ),

      CardData(
        "Jojo's Bizarre Adventure",
        descriptionText: "new season, new some jojo's relative",
        imageUrl:
        "https://i.pinimg.com/1200x/3d/18/98/3d18985ce820ee790fbfeaf422a81e3c.jpg",
      ),

      CardData(
        "Grand blue",
        descriptionText:
        "men just chilling and vibing and drinking without sobering up and sometimes diving and rarely studying",
        imageUrl:
        "https://i.pinimg.com/736x/e6/56/36/e65636fe7c241dcf163d16f3c574caad.jpg",
      ),
    ];
  }
}