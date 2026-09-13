import 'dart:io';
import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

Widget buildImagePreview(String? displayImageUrl, ZenoSemanticColors colors) {
  return Stack(
    children: [
      Container(
        height: 85, width: double.infinity,
        decoration: BoxDecoration(
          color: colors.bgTier1, borderRadius: BorderRadius.circular(8), border: Border.all(color: colors.borderSubtle),
          image: displayImageUrl != null && !displayImageUrl.startsWith("mock_")
              ? DecorationImage(image: ResizeImage(FileImage(File(displayImageUrl)), width: 200), fit: BoxFit.cover) : null,
        ),
        child: displayImageUrl == null || displayImageUrl.startsWith("mock_")
            ? Icon(Icons.image_outlined, size: 28, color: colors.textDisabled.withValues(alpha: 0.1)) : null,
      ),
      Positioned(
        top: 6, left: 6,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          decoration: BoxDecoration(color: colors.bgTier1.withValues(alpha: 0.8), borderRadius: BorderRadius.circular(4)),
          child: Row(children: [
            Icon(Icons.auto_awesome, size: 7, color: colors.accentPrimary),
            const SizedBox(width: 3),
            Text("AI READY", style: TextStyle(fontSize: 6.5, fontWeight: FontWeight.w900, color: colors.accentPrimary)),
          ]),
        ),
      ),
    ],
  );
}

Widget buildProductHeader(String title, String displaySku, String description, ZenoSemanticColors colors) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text("ACTIVE", style: TextStyle(fontSize: 7, fontWeight: FontWeight.w900, color: colors.statusSuccess)),
      Text(displaySku, style: TextStyle(fontSize: 7, color: colors.textDisabled, fontWeight: FontWeight.bold)),
    ]),
    const SizedBox(height: 2),
    Text(title.toUpperCase(), maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: colors.textPrimary, letterSpacing: -0.5)),
    if (description.isNotEmpty) ...[
      const SizedBox(height: 2),
      Text(description, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 7, color: colors.textDisabled)),
    ],
  ]);
}
