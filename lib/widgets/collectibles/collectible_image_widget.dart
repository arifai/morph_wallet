import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CollectibleImageWidget extends StatelessWidget {
  final String imgUrl;
  final Function()? onTap;

  const CollectibleImageWidget({
    Key? key,
    required this.imgUrl,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: CachedNetworkImage(
          placeholder: (context, url) => const Text('...'),
          imageUrl: imgUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
