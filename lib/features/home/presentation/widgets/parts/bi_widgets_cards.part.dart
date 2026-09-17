part of '../bi_widgets.dart';

class BISparklineCard extends StatelessWidget {
  final String label;
  final String value;
  final String trend;
  final bool isPositive;
  final Color color;
  final double targetProgress;
  final double width;
  final VoidCallback? onTap;

  const BISparklineCard({
    super.key,
    required this.label,
    required this.value,
    required this.trend,
    this.isPositive = true,
    required this.color,
    this.targetProgress = 0.75,
    this.width = 180,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ZenoContextMenu(
      items: [
        ZenoContextMenuItem(
            label: 'Open Details',
            icon: Icons.open_in_new,
            onTap: onTap ?? () {}),
        ZenoContextMenuItem(
            label: 'Open in New Tab',
            icon: Icons.tab,
            onTap: () => NavigationController()
                .openTab('home/ana/revenue', title: label)),
        ZenoContextMenuItem(
            label: 'Export Data', icon: Icons.download, onTap: () {}),
        ZenoContextMenuItem(
            label: 'Pin to Workspace',
            icon: Icons.push_pin_outlined,
            onTap: () {}),
      ],
      child: InkWell(
        onTap: onTap ??
            () => NavigationController().navigateTo('home/ana/revenue'),
        child: Container(
          width: width,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ZenoTheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ZenoTheme.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      label.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: ZenoTheme.textSecondary,
                          letterSpacing: 0.5),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(isPositive ? Icons.trending_up : Icons.trending_down,
                      size: 12,
                      color: isPositive ? ZenoTheme.neonGreen : Colors.red),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(value,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: ZenoTheme.textPrimary)),
                  const SizedBox(width: 8),
                  Text(trend,
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color:
                              isPositive ? ZenoTheme.neonGreen : Colors.red)),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Target Actual",
                          style: TextStyle(
                              fontSize: 8, color: ZenoTheme.textSecondary)),
                      Text("${(targetProgress * 100).toInt()}%",
                          style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: color)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      value: targetProgress,
                      minHeight: 3,
                      backgroundColor: ZenoTheme.border,
                      color: color,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
