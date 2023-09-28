import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FeaturedCard extends StatelessWidget {
  final String? title;
  final String? imageUrl;
  final Function()? onPressed;
  const FeaturedCard(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? "",
      imageBuilder: (context, imageProvider) => GestureDetector(
        onTap: onPressed,
        child: Container(
          margin: const EdgeInsets.only(left: 28, right: 28),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 20,
                offset: const Offset(4, 4),
              ),
            ],
            image: DecorationImage(
              fit: BoxFit.cover,
              image: imageProvider,
            ),
          ),
          child: Container(
              width: double.infinity,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.only(left: 20, right: 40, bottom: 40),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                title ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 28,
                    fontFamily: 'SF Pro Display',
                    height: 1.2,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              )),
        ),
      ),
      placeholder: (context, url) => const SizedBox(
          width: double.infinity,
          height: 300,
          child: Center(child: CircularProgressIndicator.adaptive())),
      errorWidget: (context, url, error) => const SizedBox(
        width: double.infinity,
        height: 300,
        child: Center(
          child: Icon(Icons.error),
        ),
      ),
    );
  }
}
