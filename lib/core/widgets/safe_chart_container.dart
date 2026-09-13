import 'package:flutter/material.dart';

class SafeChartContainer extends StatefulWidget {
  final Widget child;
  final double fallbackHeight;

  const SafeChartContainer({
    super.key,
    required this.child,
    this.fallbackHeight = 195,
  });

  @override
  State<SafeChartContainer> createState() => _SafeChartContainerState();
}

class _SafeChartContainerState extends State<SafeChartContainer> {
  bool _isDisposing = false;

  @override
  void deactivate() {
    _isDisposing = true;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    if (!mounted || _isDisposing) {
      return SizedBox(height: widget.fallbackHeight);
    }

    return TickerMode(
      enabled: true,
      child: widget.child,
    );
  }
}
