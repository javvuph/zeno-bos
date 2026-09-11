import 'package:flutter/material.dart';

/// ZENO COMMON LAW: RESPONSIVE & ADAPTIVE VIEWPORT
/// 
/// This widget enforces the "No Pixel Left Behind" rule.
class ZenoResponsiveLayout extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const ZenoResponsiveLayout({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Law: Always provide a vertical scroll view to prevent bottom overflows.
        // We use a Column with MainAxisSize.min to allow the child to define its own height.
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              child,
            ],
          ),
        );
      },
    );
  }
}

/// ZENO COMMON LAW: FLEXIBLE HEADER
class ZenoAdaptiveHeader extends StatelessWidget {
  final List<Widget> children;
  final double height;
  final BoxDecoration? decoration;
  final EdgeInsets? padding;

  const ZenoAdaptiveHeader({
    super.key,
    required this.children,
    required this.height,
    this.decoration,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      decoration: decoration,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
