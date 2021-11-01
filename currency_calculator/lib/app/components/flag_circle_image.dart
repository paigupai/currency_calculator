import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FlagCircleImage extends StatelessWidget {
  const FlagCircleImage({
    Key? key,
    required this.imageUrl,
    this.imageHeight = 40,
    this.imageWidth = 40,
    this.padding = const EdgeInsets.all(8.0),
    this.radius = 40,
    this.boxFit = BoxFit.fitHeight,
  }) : super(key: key);

  final String imageUrl;
  final double imageHeight;
  final double imageWidth;
  final EdgeInsetsGeometry padding;
  final double radius;
  final BoxFit boxFit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          height: imageHeight,
          width: imageWidth,
          fit: boxFit,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
