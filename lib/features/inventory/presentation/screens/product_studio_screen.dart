import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_workspace.dart';
import 'package:zeno/features/inventory/presentation/controllers/product_studio_controller.dart';
import 'package:zeno/features/inventory/domain/models/product_studio_enums.dart';
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
    controller.navigationContext = context;
    
    if (controller.isFullscreen) {
      return Container(color: Colors.white);
    }

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyS, control: true): () => controller.saveProduct(context),
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
    final activeSubCategories = controller.enabledProductTypes;
    final currentSubCategory = controller.activeProfile.isNotEmpty
        ? controller.activeProfile
        : (activeSubCategories.isNotEmpty ? activeSubCategories.first : "Clothing");

    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // LEFT GROUP: ICON, TITLE & TAGS
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 28, height: 28,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)]),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.shopping_bag_rounded, color: Colors.white, size: 15),
              ),
              const SizedBox(width: 8),
              const Text(
                "Product Studio",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), letterSpacing: -0.3),
              ),
              const SizedBox(width: 10),
              _buildProgressBar(controller.calculateCompletionPercentage()),
              const SizedBox(width: 10),
              _tagCompact(controller.activeBusiness.toUpperCase(), const Color(0xFF6366F1)),
              const SizedBox(width: 4),
              _buildSubCategorySelector(activeSubCategories, currentSubCategory),
              const SizedBox(width: 4),
              _tagCompact(controller.product.businessScale.toString().split('.').last.toUpperCase(), const Color(0xFF10B981)),
            ],
          ),

          // RIGHT GROUP: MODES & TOOLS (PUSHED TO FAR RIGHT)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _segmentedModeSelector(),
              const SizedBox(width: 8),
              _utilityButton(Icons.upload_file_rounded, "Import", () => controller.setCreationMode(ProductCreationMode.import)),
              const SizedBox(width: 6),
              _iconTool(Icons.fullscreen_rounded, controller.toggleFullscreen),
              const SizedBox(width: 6),
              _advancedToggle(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubCategorySelector(List<String> activeSubCategories, String currentSubCategory) {
    if (activeSubCategories.length <= 1) {
      return _tagCompact(currentSubCategory.toUpperCase(), const Color(0xFF6366F1));
    }

    String selectedValue = activeSubCategories.firstWhere(
      (s) => s.toLowerCase() == currentSubCategory.toLowerCase(),
      orElse: () => activeSubCategories.first,
    );

    return Container(
      height: 22,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xFF6366F1).withValues(alpha: 0.25), width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          isDense: true,
          icon: const Icon(Icons.arrow_drop_down_rounded, color: Color(0xFF6366F1), size: 14),
          style: const TextStyle(
            color: Color(0xFF6366F1),
            fontWeight: FontWeight.w900,
            fontSize: 8,
            letterSpacing: 0.3,
          ),
          items: activeSubCategories.map((type) {
            return DropdownMenuItem<String>(
              value: type,
              child: Text(
                type.toUpperCase(),
                style: const TextStyle(
                  color: Color(0xFF6366F1),
                  fontWeight: FontWeight.w900,
                  fontSize: 8,
                  letterSpacing: 0.3,
                ),
              ),
            );
          }).toList(),
          onChanged: (newType) {
            if (newType != null) {
              controller.setProfile(controller.activeBusiness, newType);
            }
          },
        ),
      ),
    );
  }

  Widget _tagCompact(String label, Color accentColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: accentColor.withValues(alpha: 0.25), width: 1),
      ),
      child: Text(label, style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: accentColor, letterSpacing: 0.3)),
    );
  }

  Widget _buildProgressBar(double pct) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 42, height: 5,
          decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(10)),
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
        const SizedBox(width: 5),
        Text("${(pct * 100).toInt()}%", style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: Color(0xFF4F46E5))),
      ],
    );
  }

  Widget _segmentedModeSelector() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _modeSegment("MANUAL", Icons.edit_note_rounded, controller.currentMode == ProductCreationMode.manual, () => controller.setCreationMode(ProductCreationMode.manual)),
          _modeSegment("SCAN", Icons.qr_code_scanner_rounded, controller.currentMode == ProductCreationMode.scan, () => controller.setCreationMode(ProductCreationMode.scan)),
          _modeSegment("BULK", Icons.layers_rounded, controller.currentMode == ProductCreationMode.bulkScan, () => controller.setCreationMode(ProductCreationMode.bulkScan)),
        ],
      ),
    );
  }

  Widget _modeSegment(String label, IconData icon, bool isActive, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        constraints: const BoxConstraints(minHeight: 26, minWidth: 72),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isActive ? [BoxShadow(color: const Color(0xFF6366F1).withValues(alpha: 0.12), blurRadius: 4, offset: const Offset(0, 1))] : null,
          border: isActive ? Border.all(color: const Color(0xFF6366F1).withValues(alpha: 0.18), width: 1) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 11, color: isActive ? const Color(0xFF6366F1) : const Color(0xFF64748B)),
            const SizedBox(width: 5),
            Text(label, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: isActive ? const Color(0xFF4F46E5) : const Color(0xFF64748B))),
          ],
        ),
      ),
    );
  }

  Widget _utilityButton(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(7),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        constraints: const BoxConstraints(minHeight: 28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: const Color(0xFF4F46E5)),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: Color(0xFF334155))),
          ],
        ),
      ),
    );
  }

  Widget _iconTool(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(7),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
        ),
        child: Icon(icon, size: 14, color: const Color(0xFF4F46E5)),
      ),
    );
  }

  Widget _advancedToggle() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.scale(
          scale: 0.65,
          child: Switch(
            value: controller.isAdvancedMode,
            onChanged: (v) => controller.toggleViewMode(),
          ),
        ),
        Text("ADVANCED", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: controller.isAdvancedMode ? const Color(0xFF4338CA) : const Color(0xFF64748B))),
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
