import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

enum ZenoTrafficLight { success, warning, danger, neutral, info }

class ZenoTableColumn<T> {
  final String label;
  final double? width;
  final Widget Function(T) builder;
  final bool isNumeric;
  final bool isSortable;

  const ZenoTableColumn({
    required this.label,
    this.width,
    required this.builder,
    this.isNumeric = false,
    this.isSortable = false,
  });
}

/// ZenoTable v2.1
/// Professional enterprise data grid with optimized hierarchy and alignment.
class ZenoTable<T> extends StatelessWidget {
  final List<T> items;
  final List<ZenoTableColumn<T>> columns;
  final Function(T)? onRowTap;
  final List<T> selectedItems;
  final ZenoTrafficLight Function(T)? trafficLightSelector;
  final bool isLoading;

  const ZenoTable({
    super.key,
    required this.items,
    required this.columns,
    this.onRowTap,
    this.selectedItems = const [],
    this.trafficLightSelector,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    if (items.isEmpty) {
      return _buildEmptyState(colors);
    }

    return Column(
      children: [
        _buildHeader(colors),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) =>
                _buildRow(items[index], index, colors),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(ZenoSemanticColors colors) {
    return Container(
      height: 36, // Standard density
      decoration: BoxDecoration(
        color: colors.bgTier2,
        border: Border(
          bottom: BorderSide(color: colors.borderSubtle),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12), // Traffic light spacer
          ...columns.map((col) => _buildHeaderCell(col, colors)),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(ZenoTableColumn<T> col, ZenoSemanticColors colors) {
    Widget cell = Container(
      width: col.width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: col.isNumeric ? Alignment.centerRight : Alignment.centerLeft,
      child: Text(
        col.label.toUpperCase(),
        style: ZenoTypography.micro(colors.textDisabled).copyWith(
          letterSpacing: 0.8,
          fontWeight: FontWeight.w800,
          fontSize: 8.5,
        ),
      ),
    );

    if (col.width == null) {
      return Expanded(child: cell);
    }
    return cell;
  }

  Widget _buildRow(T item, int index, ZenoSemanticColors colors) {
    final isSelected = selectedItems.contains(item);
    final trafficLight = trafficLightSelector?.call(item);

    return InkWell(
      onTap: () => onRowTap?.call(item),
      child: Container(
        height: 44, // Refined operational height
        decoration: BoxDecoration(
          color: isSelected ? colors.accentPrimary.withValues(alpha: 0.05) : null,
          border: Border(
            bottom: BorderSide(
              color: colors.borderSubtle.withValues(alpha: 0.3),
              width: ZenoBorderWidth.hairline,
            ),
          ),
        ),
        child: Row(
          children: [
            _buildTrafficLight(trafficLight, isSelected, colors),
            ...columns.map((col) => _buildCell(item, col, colors)),
          ],
        ),
      ),
    );
  }

  Widget _buildCell(T item, ZenoTableColumn<T> col, ZenoSemanticColors colors) {
    Widget cell = Container(
      width: col.width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: col.isNumeric ? Alignment.centerRight : Alignment.centerLeft,
      child: DefaultTextStyle(
        style: ZenoTypography.bodyMD(colors.textPrimary).copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        child: col.builder(item),
      ),
    );

    if (col.width == null) {
      return Expanded(child: cell);
    }
    return cell;
  }

  Widget _buildTrafficLight(
      ZenoTrafficLight? light, bool isSelected, ZenoSemanticColors colors) {
    if (light == null && !isSelected) return const SizedBox(width: 12);

    Color? color;
    if (light != null) {
      switch (light) {
        case ZenoTrafficLight.success:
          color = colors.statusSuccess;
          break;
        case ZenoTrafficLight.warning:
          color = colors.statusWarning;
          break;
        case ZenoTrafficLight.danger:
          color = colors.statusDanger;
          break;
        case ZenoTrafficLight.neutral:
          color = colors.textDisabled;
          break;
        case ZenoTrafficLight.info:
          color = colors.statusInfo;
          break;
      }
    }

    return Container(
      width: isSelected ? 4 : 3,
      height: 20,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isSelected ? colors.accentPrimary : color,
        borderRadius: BorderRadius.circular(1),
      ),
    );
  }

  Widget _buildEmptyState(ZenoSemanticColors colors) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.layers_clear_outlined, size: 40, color: colors.textDisabled.withValues(alpha: 0.5)),
          const SizedBox(height: 16),
          Text(
            "NO RECORDS FOUND",
            style: ZenoTypography.caption(colors.textDisabled)
                .copyWith(letterSpacing: 1.5, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
