import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/billing/presentation/widgets/smart_cart_grid.dart';
import 'package:zeno/features/billing/presentation/widgets/summary_panel.dart';
import 'package:zeno/features/billing/presentation/widgets/payment_panel.dart';
import 'package:zeno/features/billing/presentation/widgets/customer_panel.dart';
import 'package:zeno/features/billing/presentation/widgets/product_search_panel.dart';

class BillingPanelStructure extends StatefulWidget {
  const BillingPanelStructure({super.key});

  @override
  State<BillingPanelStructure> createState() => _BillingPanelStructureState();
}

class _BillingPanelStructureState extends State<BillingPanelStructure> {
  double _splitRatio = 0.65; // 65% Cart, 35% Catalog
  bool _isNumPadOpen = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Stack(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 1024;

            if (isDesktop) {
              return _buildDesktopLayout(constraints, colors);
            } else {
              return _buildMobileLayout();
            }
          },
        ),

        // FLOATING NUMPAD TOGGLE
        Positioned(
          bottom: 120,
          right: 24,
          child: _NumPadToggle(
            isOpen: _isNumPadOpen,
            onTap: () => setState(() => _isNumPadOpen = !_isNumPadOpen),
            colors: colors,
          ),
        ),

        // SLIDE-OUT NUMPAD
        if (_isNumPadOpen)
          Positioned(
            bottom: 180,
            right: 24,
            child: _TactileNumPad(colors: colors),
          ),
      ],
    );
  }

  Widget _buildDesktopLayout(
      BoxConstraints constraints, ZenoSemanticColors colors) {
    final double totalWidth = constraints.maxWidth;
    final double leftWidth = totalWidth * _splitRatio;

    return Row(
      children: [
        // ZONE 1: SMART CART (Primary Focus)
        SizedBox(
          width: leftWidth,
          child: const Column(
            children: [
              Expanded(child: SmartCartGrid()),
              Divider(height: 1),
              SummaryPanel(),
            ],
          ),
        ),

        // ZONE 2: RESIZABLE SPLITTER
        MouseRegion(
          cursor: SystemMouseCursors.resizeLeftRight,
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                _splitRatio += details.delta.dx / totalWidth;
                _splitRatio = _splitRatio.clamp(0.4, 0.85);
              });
            },
            child: Container(
              width: 6,
              color: colors.bgTier3,
              child: Center(
                child: Container(
                    width: 2,
                    height: 40,
                    color: colors.accentPrimary.withValues(alpha: 0.5)),
              ),
            ),
          ),
        ),

        // ZONE 3: DISCOVERY & UTILITIES
        Expanded(
          child: Container(
            color: colors.bgTier2,
            child: const SingleChildScrollView(
              padding: EdgeInsets.all(ZenoSpacing.md),
              child: Column(
                children: [
                  CustomerPanel(),
                  SizedBox(height: ZenoSpacing.md),
                  ProductSearchPanel(),
                  SizedBox(height: ZenoSpacing.md),
                  PaymentPanel(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return const Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomerPanel(),
                SizedBox(height: 400, child: SmartCartGrid()),
                ProductSearchPanel(),
              ],
            ),
          ),
        ),
        SummaryPanel(),
      ],
    );
  }
}

class _NumPadToggle extends StatelessWidget {
  final bool isOpen;
  final VoidCallback onTap;
  final ZenoSemanticColors colors;

  const _NumPadToggle(
      {required this.isOpen, required this.onTap, required this.colors});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: isOpen ? colors.accentPrimary : colors.bgTier3,
          shape: BoxShape.circle,
          border: Border.all(color: colors.accentPrimary, width: 2),
          boxShadow: [
            BoxShadow(
                color: colors.accentPrimary.withValues(alpha: 0.3),
                blurRadius: 15)
          ],
        ),
        child: Icon(
          isOpen ? Icons.keyboard_hide_rounded : Icons.dialpad_rounded,
          color: isOpen ? Colors.black : colors.accentPrimary,
        ),
      ),
    );
  }
}

class _TactileNumPad extends StatelessWidget {
  final ZenoSemanticColors colors;
  const _TactileNumPad({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.borderSubtle),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 30)
        ],
      ),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: [
          ...List.generate(
              9, (index) => _NumKey(label: '${index + 1}', colors: colors)),
          _NumKey(label: 'C', colors: colors, isAction: true),
          _NumKey(label: '0', colors: colors),
          _NumKey(label: '↵', colors: colors, isAction: true),
        ],
      ),
    );
  }
}

class _NumKey extends StatelessWidget {
  final String label;
  final ZenoSemanticColors colors;
  final bool isAction;

  const _NumKey(
      {required this.label, required this.colors, this.isAction = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(8),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isAction
              ? colors.accentPrimary.withValues(alpha: 0.1)
              : colors.bgTier3,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colors.borderSubtle),
        ),
        child: Text(
          label,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: isAction ? colors.accentPrimary : colors.textPrimary),
        ),
      ),
    );
  }
}
