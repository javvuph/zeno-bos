import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_button.dart';

class AutomationBuilderScreen extends StatefulWidget {
  const AutomationBuilderScreen({super.key});

  @override
  State<AutomationBuilderScreen> createState() => _AutomationBuilderScreenState();
}

class _AutomationBuilderScreenState extends State<AutomationBuilderScreen> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Scaffold(
      body: Column(
        children: [
          ZenoHeader(
            title: "Workflow Architect".toUpperCase(),
            subtitle: "CONSTRUCT INTELLIGENT BUSINESS LOGIC NODES.",
            actions: const [
              ZenoButton(
                  label: "SIMULATION MODE",
                  icon: Icons.play_lesson_rounded,
                  variant: ZenoButtonVariant.secondary,
                  size: ZenoButtonSize.sm),
              SizedBox(width: 12),
              ZenoButton(
                  label: "VALIDATE & SAVE",
                  icon: Icons.check_circle_outline_rounded,
                  size: ZenoButtonSize.sm),
            ],
          ),
          Expanded(
            child: Row(
              children: [
                // 1. COMPONENTS PALETTE
                _buildPalette(colors),
                // 2. CANVAS
                Expanded(child: _buildCanvas(colors)),
                // 3. PROPERTIES PANEL
                _buildPropertiesPanel(colors),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPalette(ZenoSemanticColors colors) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: colors.bgTier2,
        border: Border(right: BorderSide(color: colors.borderSubtle)),
      ),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionHeader("TRIGGERS", Colors.amber, colors),
          _paletteItem(Icons.bolt_rounded, "Business Event", colors),
          _paletteItem(Icons.schedule_rounded, "Scheduled Time", colors),
          _paletteItem(Icons.webhook_rounded, "Webhook Inbound", colors),
          const SizedBox(height: 24),
          _sectionHeader("LOGIC", Colors.blue, colors),
          _paletteItem(Icons.call_split_rounded, "Condition Branch", colors),
          _paletteItem(Icons.timer_outlined, "Wait/Delay", colors),
          _paletteItem(Icons.loop_rounded, "Iterator Loop", colors),
          const SizedBox(height: 24),
          _sectionHeader("ACTIONS", Colors.green, colors),
          _paletteItem(Icons.notifications_active_outlined, "Notification", colors),
          _paletteItem(Icons.email_outlined, "Send Email", colors),
          _paletteItem(Icons.edit_document, "Update Record", colors),
          _paletteItem(Icons.add_box_outlined, "Create Record", colors),
          _paletteItem(Icons.verified_user_outlined, "Approval Step", colors),
        ],
      ),
    );
  }

  Widget _buildCanvas(ZenoSemanticColors colors) {
    return Container(
      color: colors.bgTier1,
      child: Stack(
        children: [
          // GRID BACKGROUND
          CustomPaint(
            painter: GridPainter(colors.borderSubtle.withValues(alpha: 0.5)),
            size: Size.infinite,
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(100),
              child: Column(
                children: [
                  _builderNode("WHEN", "Stock Level < Reorder Point",
                      Icons.bolt_rounded, Colors.amber, colors),
                  _connector(colors),
                  _builderNode("IF", "Warehouse is 'Main HQ'",
                      Icons.call_split_rounded, Colors.blue, colors),
                  _connector(colors),
                  _builderNode("THEN", "Create Purchase Suggestion",
                      Icons.add_box_outlined, Colors.green, colors),
                  _connector(colors),
                  _builderNode("AND", "Notify Procurement Team",
                      Icons.notifications_active_outlined, Colors.green, colors),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertiesPanel(ZenoSemanticColors colors) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: colors.bgTier2,
        border: Border(left: BorderSide(color: colors.borderSubtle)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text("NODE PROPERTIES",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                    color: colors.textSecondary)),
          ),
          const Divider(height: 1),
          Expanded(
            child: Center(
              child: Opacity(
                opacity: 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.touch_app_outlined,
                        size: 48, color: colors.textDisabled),
                    const SizedBox(height: 16),
                    const Text("SELECT A NODE TO EDIT"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String label, Color color, ZenoSemanticColors colors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(width: 4, height: 12, color: color),
          const SizedBox(width: 8),
          Text(label,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: colors.textSecondary)),
        ],
      ),
    );
  }

  Widget _paletteItem(IconData icon, String label, ZenoSemanticColors colors) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.bgTier3,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: colors.textPrimary),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _builderNode(String type, String desc, IconData icon, Color color,
      ZenoSemanticColors colors) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 2),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.1), blurRadius: 12)
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Row(
              children: [
                Icon(icon, size: 14, color: color),
                const SizedBox(width: 8),
                Text(type,
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: color)),
                const Spacer(),
                const Icon(Icons.more_vert_rounded,
                    size: 14, color: Colors.white24),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(desc,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget _connector(ZenoSemanticColors colors) {
    return Container(
      width: 2,
      height: 40,
      color: colors.borderSubtle,
    );
  }
}

class GridPainter extends CustomPainter {
  final Color color;
  GridPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.5;

    for (double i = 0; i < size.width; i += 30) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 30) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
