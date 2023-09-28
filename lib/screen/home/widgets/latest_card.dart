import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_tz/service/convert%20_date_to_string.dart';

class LatestCard extends StatelessWidget {
  final String? title;
  final String? imageUrl;
  final Function()? onPressed;
  final bool isReaded;
  final DateTime? date;
  const LatestCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onPressed,
    required this.isReaded,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 103,
        margin: const EdgeInsets.symmetric(
          horizontal: 28,
          vertical: 10,
        ),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isReaded ? const Color(0xFFF5F5F5) : Colors.white,
          borderRadius: BorderRadius.circular(9),
          boxShadow: isReaded
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 20,
                    offset: const Offset(4, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(4, 4),
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    blurRadius: 8,
                    offset: Offset(-4, -4),
                  ),
                ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl ?? "",
              imageBuilder: (context, imageProvider) => Container(
                width: 90,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: imageProvider,
                  ),
                ),
              ),
              placeholder: (context, url) => const SizedBox(
                  width: 90,
                  height: 60,
                  child: Center(child: CircularProgressIndicator.adaptive())),
              errorWidget: (context, url, error) => const SizedBox(
                width: 90,
                height: 60,
                child: Center(
                  child: Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(width: 23),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'SF Pro Display',
                      height: 1.3,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    getDate(date.toString()),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'SF Pro Display',
                      color: Color(0xFF9A9A9A),
                      // height: 1.4,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
