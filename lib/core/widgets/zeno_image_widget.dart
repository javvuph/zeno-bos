import 'dart:io';
import 'package:flutter/material.dart';

class ZenoImageWidget extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? placeholder;

  const ZenoImageWidget({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return placeholder ?? const SizedBox.shrink();
    }
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return Image.network(
        url,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (_, __, ___) => placeholder ?? const Icon(Icons.broken_image_outlined, color: Colors.grey),
      );
    } else {
      try {
        final file = File(url);
        if (file.existsSync()) {
          return Image.file(
            file,
            fit: fit,
            width: width,
            height: height,
            errorBuilder: (_, __, ___) => placeholder ?? const Icon(Icons.broken_image_outlined, color: Colors.grey),
          );
        }
      } catch (_) {}
      return Image.network(
        url,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (_, __, ___) => placeholder ?? const Icon(Icons.broken_image_outlined, color: Colors.grey),
      );
    }
  }
}
