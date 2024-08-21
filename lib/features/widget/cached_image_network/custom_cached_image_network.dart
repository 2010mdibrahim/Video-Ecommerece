import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedImageNetwork extends StatelessWidget {
  final String imageUrl;
  final double height, weight;
  const CustomCachedImageNetwork({super.key, required this.imageUrl, required this.height, required this.weight});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "https://static.vecteezy.com/system/resources/thumbnails/041/714/266/small_2x/ai-generated-professional-man-in-suit-with-arms-crossed-on-transparent-background-stock-png.png",
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: weight,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              colorFilter:
              ColorFilter.mode(Colors.white, BlendMode.colorBurn)),
        ),
      ),
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
