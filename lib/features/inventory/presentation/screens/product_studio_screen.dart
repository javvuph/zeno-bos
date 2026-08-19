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
    if (controller.isFullscreen && _fullscreenEntry == null) {
      _showFullscreen();
    } else if (!controller.isFullscreen && _fullscreenEntry != null) {
      _hideFullscreen();
    }
    if (mounted) setState(() {});
  }

  void _showFullscreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _fullscreenEntry = OverlayEntry(
      builder: (context) {
        final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
        return Navigator(
          onGenerateRoute: (settings) => PageRouteBuilder(
            pageBuilder: (context, anim1, anim2) => Material(
              color: colors.bgTier1,
              child: ListenableBuilder(
                listenable: controller,
                builder: (context, _) => _buildMainContent(colors, true),
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
      return Container(color: colors.bgTier1); // Placeholder while overlay is active
    }

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyS, control: true): () => controller.saveProduct(),
      },
      child: ZenoWorkspace(
        header: SizedBox(
          height: 48,
          child: ZenoHeader(
            title: "Product Studio",
            subtitle: "AURORA ENTERPRISE",
            titleSuffix: _buildBusinessSelector(colors),
            actions: _buildHeaderActions(colors),
          ),
        ),
        body: _buildBody(colors),
      ),
    );
  }

  Widget _buildMainContent(ZenoSemanticColors colors, bool isFullscreen) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyS, control: true): () => controller.saveProduct(),
        const SingleActivator(LogicalKeyboardKey.escape): () {
          if (controller.isFullscreen) controller.toggleFullscreen();
        },
      },
      child: Column(
        children: [
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: colors.borderSubtle)),
            ),
            child: Row(
              children: [
                const Text(
                  "Product Studio",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 24),
                _buildBusinessSelector(colors),
                const Spacer(),
                _buildAdvancedToggle(colors),
                const SizedBox(width: 16),
                ZenoButton(
                  label: "EXIT FULLSCREEN",
                  icon: Icons.fullscreen_exit_rounded,
                  variant: ZenoButtonVariant.ghost,
                  onPressed: controller.toggleFullscreen,
                  size: ZenoButtonSize.sm,
                ),
              ],
            ),
          ),
          Expanded(child: _buildBody(colors)),
        ],
      ),
    );
  }

  Widget _buildBusinessSelector(ZenoSemanticColors colors) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      HeaderDropdown<String>(
        value: controller.activeBusiness, 
        items: controller.businessCategoryMap.keys.toList(), 
        onChanged: (v) {
          final firstProfile = controller.businessCategoryMap[v]?[0] ?? "General Product";
          controller.setProfile(v ?? "Retail", firstProfile);
        }
      ),
      const SizedBox(width: 8),
      HeaderDropdown<String>(
        value: controller.activeProfile, 
        items: controller.businessCategoryMap[controller.activeBusiness] ?? ["General Product"], 
        onChanged: (v) => controller.setProfile(controller.activeBusiness, v ?? "")
      ),
      if (controller.product.businessType == "Fashion") ...[
        const SizedBox(width: 8),
        HeaderDropdown<BusinessScale>(value: controller.product.businessScale, items: BusinessScale.values, onChanged: (v) => controller.updateBusinessScale(v ?? BusinessScale.small)),
      ],
      const SizedBox(width: 16),
      _CompactCompletion(controller: controller),
      const SizedBox(width: 24),
      Container(width: 1, height: 20, color: colors.borderSubtle),
      const SizedBox(width: 24),
      ModeButton(label: "Manual", icon: Icons.auto_fix_high_rounded, isActive: controller.currentMode == ProductCreationMode.manual, onPressed: () => controller.setCreationMode(ProductCreationMode.manual), colors: colors),
      const SizedBox(width: 8),
      ModeButton(label: "SCAN", icon: Icons.qr_code_scanner_rounded, isActive: controller.currentMode == ProductCreationMode.scan, onPressed: () => controller.setCreationMode(ProductCreationMode.scan), colors: colors),
      const SizedBox(width: 8),
      ModeButton(label: "BULK", icon: Icons.layers_rounded, isActive: controller.currentMode == ProductCreationMode.bulkScan, onPressed: () => controller.setCreationMode(ProductCreationMode.bulkScan), colors: colors),
      const SizedBox(width: 8),
      ModeButton(label: "IMPORT", icon: Icons.file_download_rounded, isActive: controller.currentMode == ProductCreationMode.import, onPressed: () { controller.setCreationMode(ProductCreationMode.import); controller.pickImportFile(); }, colors: colors),
    ]);
  }

  List<Widget> _buildHeaderActions(ZenoSemanticColors colors) {
    return [
      ZenoButton(
        label: controller.isFullscreen ? "" : "FULLSCREEN",
        icon: controller.isFullscreen ? Icons.fullscreen_exit_rounded : Icons.fullscreen_rounded,
        variant: ZenoButtonVariant.ghost,
        size: ZenoButtonSize.sm,
        onPressed: controller.toggleFullscreen,
      ),
      const SizedBox(width: 16),
      _buildAdvancedToggle(colors),
    ];
  }

  Widget _buildAdvancedToggle(ZenoSemanticColors colors) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      const Text("SIMPLE", style: TextStyle(fontSize: 8, color: Colors.grey)),
      Transform.scale(scale: 0.6, child: Switch(value: controller.isAdvancedMode, onChanged: (_) => controller.toggleViewMode(), activeThumbColor: colors.accentPrimary)),
      Text("ADVANCED", style: TextStyle(fontSize: 8, fontWeight: FontWeight.w900, color: colors.accentPrimary)),
    ]);
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

class _CompactCompletion extends StatelessWidget {
  final ProductStudioController controller;
  const _CompactCompletion({required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final percentage = controller.calculateCompletionPercentage();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80, height: 4,
          decoration: BoxDecoration(color: colors.bgTier3, borderRadius: BorderRadius.circular(2)),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage,
            child: Container(decoration: BoxDecoration(color: colors.accentPrimary, borderRadius: BorderRadius.circular(2))),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          "${(percentage * 100).toInt()}%",
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: colors.accentPrimary),
        ),
      ],
    );
  }
}
