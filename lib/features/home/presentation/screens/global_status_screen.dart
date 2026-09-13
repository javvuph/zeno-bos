import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/home_widgets.dart';

class GlobalStatusScreen extends StatelessWidget {
  const GlobalStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ZenoTheme.background,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "GLOBAL SYSTEM STATUS",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2),
            ),
            const Text(
              "Comprehensive health check of the entire ZENO infrastructure.",
              style: TextStyle(color: ZenoTheme.textSecondary),
            ),
            const SizedBox(height: 32),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 2.5,
              children: const [
                _StatusCard(
                    label: "SYSTEM HEALTH",
                    status: "Optimal",
                    color: ZenoTheme.neonGreen),
                _StatusCard(
                    label: "DATABASE SYNC",
                    status: "Synced",
                    color: ZenoTheme.neonGreen),
                _StatusCard(
                    label: "API LATENCY",
                    status: "24ms",
                    color: ZenoTheme.neonCyan),
                _StatusCard(
                    label: "ACTIVE USERS",
                    status: "1,240",
                    color: ZenoTheme.neonGreen),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: CommandCenterWidget(
                    title: "Entity & Branch Health",
                    accentColor: ZenoTheme.neonCyan,
                    child: Column(
                      children: const [
                        _EntityRow(
                            name: "Corporate Headquarters",
                            status: "Online",
                            uptime: "99.9%"),
                        _EntityRow(
                            name: "North Region Hub",
                            status: "Online",
                            uptime: "99.8%"),
                        _EntityRow(
                            name: "South Retail Outlet",
                            status: "Maintenance",
                            uptime: "94.5%",
                            isCritical: true),
                        _EntityRow(
                            name: "East Distribution Center",
                            status: "Online",
                            uptime: "99.9%"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: CommandCenterWidget(
                    title: "Connected Integrations",
                    accentColor: Colors.purple,
                    child: Column(
                      children: const [
                        _IntegrationItem(
                            name: "WhatsApp API", status: "Connected"),
                        _IntegrationItem(
                            name: "Stripe Gateway", status: "Connected"),
                        _IntegrationItem(
                            name: "Google Cloud Storage", status: "Connected"),
                        _IntegrationItem(
                            name: "Amazon Marketplace",
                            status: "Error",
                            isError: true),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final String label;
  final String status;
  final Color color;

  const _StatusCard(
      {required this.label, required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: ZenoTheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ZenoTheme.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label,
              style: const TextStyle(
                  fontSize: 10,
                  color: ZenoTheme.textSecondary,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(status,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w900, color: color)),
        ],
      ),
    );
  }
}

class _EntityRow extends StatelessWidget {
  final String name;
  final String status;
  final String uptime;
  final bool isCritical;

  const _EntityRow(
      {required this.name,
      required this.status,
      required this.uptime,
      this.isCritical = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                  color: isCritical ? Colors.red : ZenoTheme.neonGreen,
                  borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.bold)),
                Text("Uptime: $uptime",
                    style: const TextStyle(
                        fontSize: 11, color: ZenoTheme.textSecondary)),
              ],
            ),
          ),
          Text(status,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isCritical ? Colors.red : ZenoTheme.neonGreen)),
        ],
      ),
    );
  }
}

class _IntegrationItem extends StatelessWidget {
  final String name;
  final String status;
  final bool isError;

  const _IntegrationItem(
      {required this.name, required this.status, this.isError = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(fontSize: 13)),
          Text(status,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: isError ? Colors.red : ZenoTheme.neonCyan)),
        ],
      ),
    );
  }
}
