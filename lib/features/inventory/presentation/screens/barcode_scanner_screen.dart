import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';

class BarcodeScannerScreen extends StatelessWidget {
  const BarcodeScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ZenoHeader(
          title: "Universal Scanner",
          subtitle:
              "Use your device camera or connected hardware to scan codes.",
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ZenoTheme.border, width: 2),
            ),
            child: Stack(
              children: [
                const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.qr_code_scanner,
                          size: 80, color: ZenoTheme.accent),
                      SizedBox(height: 24),
                      Text("Camera Access Required",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text("Point the camera at a barcode or QR code",
                          style: TextStyle(
                              color: ZenoTheme.textSecondary, fontSize: 12)),
                    ],
                  ),
                ),
                // Scanner Frame
                Center(
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: ZenoTheme.accent.withValues(alpha: 0.5),
                          width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _ScannerAction(icon: Icons.flashlight_on, label: "Flash"),
                      SizedBox(width: 32),
                      _ScannerAction(icon: Icons.history, label: "History"),
                      SizedBox(width: 32),
                      _ScannerAction(icon: Icons.keyboard, label: "Manual"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ScannerAction extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ScannerAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
            backgroundColor: ZenoTheme.surface,
            child: Icon(icon, color: Colors.white, size: 20)),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.white)),
      ],
    );
  }
}
