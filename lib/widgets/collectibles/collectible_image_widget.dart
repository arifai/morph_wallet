import 'package:flutter/material.dart';
import 'package:morph_wallet/utils/bytes.dart';

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
        child: FadeInImage.memoryNetwork(
          placeholder: bytes,
          image: imgUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
