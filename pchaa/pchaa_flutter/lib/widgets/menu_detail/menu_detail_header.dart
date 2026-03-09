import 'package:flutter/material.dart';
import 'package:pchaa_flutter/utils/url_utils.dart';

class MenuDetailHeader extends StatelessWidget {
  final String? imageUrl;
  final double imageHeight;

  const MenuDetailHeader({
    super.key,
    this.imageUrl,
    this.imageHeight = 200.0,
  });

  @override
  Widget build(BuildContext context) {
    final displayUrl = UrlUtils.getDisplayableImageUrl(imageUrl);
    final ImageProvider imageProvider = displayUrl.isEmpty
        ? const AssetImage("assets/images/food.jpg")
        : NetworkImage(displayUrl);
    return Stack(
      children: [
        Container(
          height: imageHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: imageHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.3),
                Colors.black.withValues(alpha: 0.5),
              ],
            ),
            color: Colors.white,
          ),
        ),
        Positioned(
          top: 30,
          left: 10,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}
