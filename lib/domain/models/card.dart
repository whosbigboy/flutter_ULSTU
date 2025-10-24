part of '../../presentation/home_page/home_page.dart';

class CardData{
  final String text;
  final String descriptionText;
  final IconData icon;
  final String? imageUrl;

  CardData(
      this.text,{
        required this.descriptionText,
        this.icon = Icons.abc,
        this.imageUrl,
      });
}

typedef OnLikeCallBack = void Function(String title, bool isLiked)?;

class _Card extends StatefulWidget {

  final String text;
  final String descriptionText;
  final IconData icon;
  final String? imageUrl;
  final OnLikeCallBack onLike;
  final VoidCallback? onTap;

  const _Card(
      this.text, {
        this.icon = Icons.face,
        required this.descriptionText,
        this.imageUrl,
        this.onLike,
        this.onTap,
      }
  );

  factory _Card.fromData(
      CardData data, {
        OnLikeCallBack onLike,
        VoidCallback? onTap,
      }
  ) => _Card(
          data.text,
          descriptionText: data.descriptionText,
          icon: data.icon,
          imageUrl: data.imageUrl,
          onLike : onLike,
          onTap: onTap,
        );

  @override
  State<_Card> createState() => _CardState();
}

class _CardState extends State<_Card> {
  bool isLiked = false;
  final Color niceOrange = Color.fromRGBO(255, 94, 51, 100);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.all(16),
        constraints: const BoxConstraints(minHeight: 150),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                spreadRadius: 3,
                offset: const Offset(0, 5),
                blurRadius: 8
            ),
          ],
          color: niceOrange,
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
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                      Text(
                        widget.descriptionText,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
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
                      widget.onLike?.call(widget.text, isLiked);
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: isLiked
                          ? const Icon(
                          Icons.favorite,
                          color: Color.fromRGBO(102, 2, 60, 100),
                          key : ValueKey<int>(0)
                      )
                          : const Icon(
                          Icons.favorite_outline,
                          key : ValueKey<int>(1)
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}