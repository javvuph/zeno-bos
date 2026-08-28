import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';
import 'package:zeno/features/inventory/domain/models/product_studio_enums.dart';
import 'package:zeno/core/widgets/zeno_button.dart';
import 'widgets/product_studio_widgets.dart';
import 'package:zeno/features/inventory/presentation/screens/workspaces/scan_workspace.dart';
import 'package:zeno/features/inventory/presentation/screens/workspaces/bulk_scan_workspace.dart';
import 'package:zeno/features/inventory/presentation/screens/workspaces/import_workspace.dart';
import 'aurora/aurora_workstation.dart';

class ProductStudioScreen extends StatefulWidget {
  const ProductStudioScreen({super.key});
  @override
  State<ProductStudioScreen> createState() => _ProductStudioScreenState();
}

class _ProductStudioScreenState extends State<ProductStudioScreen> {
  final controller = ProductStudioController();
  OverlayEntry? _fullscreenEntry;

  @override
  void initState() { 
    super.initState(); 
    controller.addListener(_handleStateChange); 
  }

  void _handleStateChange() {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (controller.isFullscreen && _fullscreenEntry == null) {
        _showFullscreen();
      } else if (!controller.isFullscreen && _fullscreenEntry != null) {
        _hideFullscreen();
      }
      setState(() {});
    });
  }

  void _showFullscreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _fullscreenEntry = OverlayEntry(
      builder: (context) {
        final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
        return Navigator(
          onGenerateRoute: (settings) => PageRouteBuilder(
            pageBuilder: (context, anim1, anim2) => Material(
              color: Colors.white,
              child: ListenableBuilder(
                listenable: controller,
                builder: (context, _) => _buildMainContent(colors),
              ),
            ),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
    );
    Overlay.of(context, rootOverlay: true).insert(_fullscreenEntry!);
  }

  void _hideFullscreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _fullscreenEntry?.remove();
    _fullscreenEntry = null;
  }

  @override
  void dispose() { 
    _hideFullscreen();
    controller.removeListener(_handleStateChange); 
    super.dispose(); 
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    
    if (controller.isFullscreen) {
      return Container(color: Colors.white);
    }

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyS, control: true): () => controller.saveProduct(),
      },
      child: ZenoWorkspace(
        header: _buildSubHeader(colors),
        body: _buildBody(colors),
      ),
    );
  }

  Widget _buildMainContent(ZenoSemanticColors colors) {
    return Column(
      children: [
        _buildSubHeader(colors),
        Expanded(child: _buildBody(colors)),
      ],
    );
  }

  Widget _buildSubHeader(ZenoSemanticColors colors) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Colors.white, 
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          // IDENTITY ICON
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF6366F1).withOpacity(0.2)),
            ),
            child: const Icon(Icons.shopping_bag_outlined, color: Color(0xFF6366F1), size: 24),
          ),
          const SizedBox(width: 16),
          // TITLE & PROGRESS
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Product Studio",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1E293B), letterSpacing: -0.2),
                    ),
                    const SizedBox(width: 12),
                    _buildProgressBar(controller.calculateCompletionPercentage()),
                  ],
                ),
                const SizedBox(height: 4),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const Text("AURORA ENTERPRISE", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8), letterSpacing: 0.5)),
                      const SizedBox(width: 8),
                      const Text("•", style: TextStyle(color: Color(0xFFCBD5E1))),
                      const SizedBox(width: 8),
                      _tagWithLock(controller.activeBusiness.toUpperCase(), Colors.orange),
                      const SizedBox(width: 6),
                      _dropdownTag(controller.activeProfile.toUpperCase()),
                      const SizedBox(width: 6),
                      _tagWithLock(controller.product.businessScale.toString().split('.').last.toUpperCase(), Colors.orange),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // MODES & TOOLS
          _segmentedModeSelector(),
          const SizedBox(width: 12),
          _utilityButton(Icons.upload_file_rounded, "Import", () => controller.setCreationMode(ProductCreationMode.import)),
          const SizedBox(width: 8),
          _iconTool(Icons.fullscreen_rounded, controller.toggleFullscreen),
          const SizedBox(width: 8),
          _iconTool(Icons.wb_sunny_outlined, () {}),
          const SizedBox(width: 12),
          _advancedToggle(),
        ],
      ),
    );
  }

  Widget _buildProgressBar(double pct) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 64, height: 6,
          decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(10)),
          child: LayoutBuilder(
            builder: (context, constraints) => Stack(
              children: [
                Container(
                  width: constraints.maxWidth * pct,
                  decoration: BoxDecoration(color: const Color(0xFF6366F1), borderRadius: BorderRadius.circular(10)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text("${(pct * 100).toInt()}% complete", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF64748B))),
      ],
    );
  }

  Widget _tagWithLock(String label, Color lockColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.lock_rounded, size: 10, color: lockColor),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF475569))),
        ],
      ),
    );
  }

  Widget _dropdownTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF475569))),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down_rounded, size: 14, color: Color(0xFF64748B)),
        ],
      ),
    );
  }

  Widget _segmentedModeSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _modeSegment("Manual", Icons.edit_note_rounded, controller.currentMode == ProductCreationMode.manual, () => controller.setCreationMode(ProductCreationMode.manual)),
          _modeSegment("Scan", Icons.qr_code_scanner_rounded, controller.currentMode == ProductCreationMode.scan, () => controller.setCreationMode(ProductCreationMode.scan)),
          _modeSegment("Bulk", Icons.layers_rounded, controller.currentMode == ProductCreationMode.bulkScan, () => controller.setCreationMode(ProductCreationMode.bulkScan)),
        ],
      ),
    );
  }

  Widget _modeSegment(String label, IconData icon, bool isActive, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isActive ? [const BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))] : null,
          border: isActive ? Border.all(color: const Color(0xFF6366F1).withOpacity(0.1)) : null,
        ),
        child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: isActive ? const Color(0xFF6366F1) : const Color(0xFF64748B))),
      ),
    );
  }

  Widget _utilityButton(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: const Color(0xFF64748B)),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF475569))),
          ],
        ),
      ),
    );
  }

  Widget _iconTool(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Icon(icon, size: 16, color: const Color(0xFF64748B)),
      ),
    );
  }

  Widget _advancedToggle() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.scale(
          scale: 0.7,
          child: Switch(
            value: controller.isAdvancedMode, 
            onChanged: (v) => controller.toggleViewMode(),
            activeColor: const Color(0xFF6366F1),
          ),
        ),
        const Text("ADVANCED", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFF6366F1))),
      ],
    );
  }

  Widget _buildBody(ZenoSemanticColors colors) {
    if (controller.currentMode == ProductCreationMode.manual) {
      return AuroraWorkstation(controller: controller, colors: colors);
    }
    if (controller.currentMode == ProductCreationMode.scan) return ScanWorkspace(controller: controller, colors: colors);
    if (controller.currentMode == ProductCreationMode.bulkScan) return BulkScanWorkspace(controller: controller, colors: colors);
    return ImportWorkspace(controller: controller, colors: colors);
  }
}
