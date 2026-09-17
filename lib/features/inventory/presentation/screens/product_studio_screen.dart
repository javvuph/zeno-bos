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

part 'parts/product_studio_screen_header.part.dart';

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

  Widget _buildBody(ZenoSemanticColors colors) {
    if (controller.currentMode == ProductCreationMode.manual) {
      return AuroraWorkstation(controller: controller, colors: colors);
    }
    if (controller.currentMode == ProductCreationMode.scan) return ScanWorkspace(controller: controller, colors: colors);
    if (controller.currentMode == ProductCreationMode.bulkScan) return BulkScanWorkspace(controller: controller, colors: colors);
    return ImportWorkspace(controller: controller, colors: colors);
  }
}
