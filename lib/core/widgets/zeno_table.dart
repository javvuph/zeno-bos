import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zeno/app/theme.dart';

enum ZenoTrafficLight { success, warning, danger, neutral, info }

class ZenoTableColumn<T> {
  final String label;
  final double? width;
  final Widget Function(T) builder;
  final String Function(T)? textExtractor;
  final bool isNumeric;
  final bool isSortable;
  final bool isEditable;

  const ZenoTableColumn({
    required this.label,
    this.width,
    required this.builder,
    this.textExtractor,
    this.isNumeric = false,
    this.isSortable = false,
    this.isEditable = false,
  });
}

/// ZenoTable v2.5 — Excel-Grade Spreadsheet Data Grid with Cell-Range Selection & Header Serialization
class ZenoTable<T> extends StatefulWidget {
  final List<T> items;
  final List<ZenoTableColumn<T>> columns;
  final Function(T)? onRowTap;
  final List<T> selectedItems;
  final ValueChanged<List<T>>? onSelectionChanged;
  final ValueChanged<List<T>>? onDeleteRequested;
  final ValueChanged<List<List<String>>>? onPaste;
  final ZenoTrafficLight Function(T)? trafficLightSelector;
  final bool isLoading;

  const ZenoTable({
    super.key,
    required this.items,
    required this.columns,
    this.onRowTap,
    this.selectedItems = const [],
    this.onSelectionChanged,
    this.onDeleteRequested,
    this.onPaste,
    this.trafficLightSelector,
    this.isLoading = false,
  });

  @override
  State<ZenoTable<T>> createState() => _ZenoTableState<T>();
}

class _ZenoTableState<T> extends State<ZenoTable<T>> {
  int _focusedRowIndex = 0;
  int _focusedColIndex = 0;
  int _anchorRowIndex = 0;
  int _anchorColIndex = 0;
  bool _includeHeader = false;

  final FocusNode _gridFocusNode = FocusNode(debugLabel: 'ZenoTableGrid');
  final ScrollController _scrollController = ScrollController();

  int get _minRow => _anchorRowIndex < _focusedRowIndex ? _anchorRowIndex : _focusedRowIndex;
  int get _maxRow => _anchorRowIndex > _focusedRowIndex ? _anchorRowIndex : _focusedRowIndex;
  int get _minCol => _anchorColIndex < _focusedColIndex ? _anchorColIndex : _focusedColIndex;
  int get _maxCol => _anchorColIndex > _focusedColIndex ? _anchorColIndex : _focusedColIndex;

  @override
  void initState() {
    super.initState();
    _clampFocus();
  }

  @override
  void didUpdateWidget(covariant ZenoTable<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _clampFocus();
  }

  @override
  void dispose() {
    _gridFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _clampFocus() {
    if (widget.items.isEmpty) {
      _focusedRowIndex = 0;
      _focusedColIndex = 0;
      _anchorRowIndex = 0;
      _anchorColIndex = 0;
      return;
    }
    if (_focusedRowIndex >= widget.items.length) {
      _focusedRowIndex = widget.items.length - 1;
    }
    if (_focusedRowIndex < 0) _focusedRowIndex = 0;

    if (_focusedColIndex >= widget.columns.length) {
      _focusedColIndex = widget.columns.length - 1;
    }
    if (_focusedColIndex < 0) _focusedColIndex = 0;
  }

  void _scrollToFocusedRow() {
    if (!mounted || widget.items.isEmpty) return;
    const rowHeight = 44.0;
    final targetOffset = _focusedRowIndex * rowHeight;
    if (_scrollController.hasClients) {
      final currentOffset = _scrollController.offset;
      final viewport = _scrollController.position.viewportDimension;
      if (targetOffset < currentOffset) {
        _scrollController.jumpTo(targetOffset);
      } else if (targetOffset + rowHeight > currentOffset + viewport) {
        _scrollController.jumpTo(targetOffset + rowHeight - viewport);
      }
    }
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    // IF FOCUS IS INSIDE A TEXTFIELD, LET TEXT EDITING & COPY/PASTE WORK NATIVELY
    final primaryFocus = FocusManager.instance.primaryFocus;
    if (primaryFocus != null && primaryFocus != _gridFocusNode) {
      final isTextField = primaryFocus.context?.widget is EditableText ||
          (primaryFocus.context?.findAncestorWidgetOfExactType<EditableText>() != null);
      if (isTextField) {
        return KeyEventResult.ignored;
      }
    }

    if (widget.items.isEmpty) return KeyEventResult.ignored;

    final isShift = HardwareKeyboard.instance.isShiftPressed;
    final isControl = HardwareKeyboard.instance.isControlPressed ||
        HardwareKeyboard.instance.isMetaPressed;
    final key = event.logicalKey;

    int newRow = _focusedRowIndex;
    int newCol = _focusedColIndex;
    bool handled = false;

    if (key == LogicalKeyboardKey.arrowDown) {
      newRow = (_focusedRowIndex + 1).clamp(0, widget.items.length - 1);
      handled = true;
    } else if (key == LogicalKeyboardKey.arrowUp) {
      newRow = (_focusedRowIndex - 1).clamp(0, widget.items.length - 1);
      handled = true;
    } else if (key == LogicalKeyboardKey.arrowRight) {
      newCol = (_focusedColIndex + 1).clamp(0, widget.columns.length - 1);
      handled = true;
    } else if (key == LogicalKeyboardKey.arrowLeft) {
      newCol = (_focusedColIndex - 1).clamp(0, widget.columns.length - 1);
      handled = true;
    } else if (key == LogicalKeyboardKey.tab) {
      if (isShift) {
        if (_focusedColIndex > 0) {
          newCol = _focusedColIndex - 1;
        } else if (_focusedRowIndex > 0) {
          newRow = _focusedRowIndex - 1;
          newCol = widget.columns.length - 1;
        }
      } else {
        if (_focusedColIndex < widget.columns.length - 1) {
          newCol = _focusedColIndex + 1;
        } else if (_focusedRowIndex < widget.items.length - 1) {
          newRow = _focusedRowIndex + 1;
          newCol = 0;
        }
      }
      handled = true;
    } else if (key == LogicalKeyboardKey.home) {
      newCol = 0;
      if (isControl) newRow = 0;
      handled = true;
    } else if (key == LogicalKeyboardKey.end) {
      newCol = widget.columns.length - 1;
      if (isControl) newRow = widget.items.length - 1;
      handled = true;
    } else if (key == LogicalKeyboardKey.pageUp) {
      newRow = (_focusedRowIndex - 10).clamp(0, widget.items.length - 1);
      handled = true;
    } else if (key == LogicalKeyboardKey.pageDown) {
      newRow = (_focusedRowIndex + 10).clamp(0, widget.items.length - 1);
      handled = true;
    } else if (isControl && key == LogicalKeyboardKey.keyA) {
      final isAllDataSelected = _minRow == 0 &&
          _maxRow == widget.items.length - 1 &&
          _minCol == 0 &&
          _maxCol == widget.columns.length - 1;

      if (isAllDataSelected && !_includeHeader) {
        // Second Ctrl+A: Include Header
        setState(() {
          _includeHeader = true;
        });
      } else {
        // First Ctrl+A: Select all DATA cells
        setState(() {
          _anchorRowIndex = 0;
          _anchorColIndex = 0;
          _focusedRowIndex = widget.items.length - 1;
          _focusedColIndex = widget.columns.length - 1;
          _includeHeader = false;
        });
        widget.onSelectionChanged?.call(List.from(widget.items));
      }
      return KeyEventResult.handled;
    } else if (isControl && key == LogicalKeyboardKey.keyC) {
      _copySelectedToClipboard();
      return KeyEventResult.handled;
    } else if (isControl && key == LogicalKeyboardKey.keyV) {
      _pasteFromClipboard();
      return KeyEventResult.handled;
    } else if (key == LogicalKeyboardKey.f2) {
      _handleF2Edit();
      return KeyEventResult.handled;
    } else if (key == LogicalKeyboardKey.delete) {
      if (widget.selectedItems.isNotEmpty) {
        widget.onDeleteRequested?.call(widget.selectedItems);
      } else if (_focusedRowIndex < widget.items.length) {
        widget.onDeleteRequested?.call([widget.items[_focusedRowIndex]]);
      }
      return KeyEventResult.handled;
    } else if (key == LogicalKeyboardKey.enter || key == LogicalKeyboardKey.space) {
      if (_focusedRowIndex < widget.items.length) {
        widget.onRowTap?.call(widget.items[_focusedRowIndex]);
      }
      return KeyEventResult.handled;
    }

    if (handled) {
      if (newRow != _focusedRowIndex || newCol != _focusedColIndex) {
        setState(() {
          _focusedRowIndex = newRow;
          _focusedColIndex = newCol;
          if (!isShift) {
            _anchorRowIndex = newRow;
            _anchorColIndex = newCol;
            _includeHeader = false;
          }
        });
        _scrollToFocusedRow();

        if (isShift) {
          final rangeSelection = widget.items.sublist(_minRow, _maxRow + 1);
          widget.onSelectionChanged?.call(rangeSelection);
        }
      }
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  void _handleF2Edit() {
    if (_focusedColIndex >= widget.columns.length) return;
    final col = widget.columns[_focusedColIndex];
    if (col.isEditable) {
      if (_focusedRowIndex < widget.items.length) {
        widget.onRowTap?.call(widget.items[_focusedRowIndex]);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Column '${col.label}' is read-only"),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  Future<void> _copySelectedToClipboard() async {
    if (widget.items.isEmpty) return;

    final buffer = StringBuffer();

    // 1. Header Row if included
    if (_includeHeader) {
      final headerCells = <String>[];
      for (int c = _minCol; c <= _maxCol; c++) {
        headerCells.add(widget.columns[c].label);
      }
      buffer.write(headerCells.join('\t'));
      buffer.write('\r\n');
    }

    // 2. Data Rows in selected rectangular range
    for (int r = _minRow; r <= _maxRow; r++) {
      final item = widget.items[r];
      final rowCells = <String>[];
      for (int c = _minCol; c <= _maxCol; c++) {
        final col = widget.columns[c];
        String text = '';
        if (col.textExtractor != null) {
          text = col.textExtractor!(item);
        } else {
          text = item.toString();
        }
        rowCells.add(text);
      }
      buffer.write(rowCells.join('\t'));
      if (r < _maxRow) buffer.write('\r\n');
    }

    final tsv = buffer.toString();
    if (tsv.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: tsv));
      if (mounted) {
        final cellCount = (_maxRow - _minRow + 1) * (_maxCol - _minCol + 1);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Copied $cellCount cell(s) ${_includeHeader ? 'with header ' : ''}to clipboard"),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> _pasteFromClipboard() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text;
    if (text == null || text.trim().isEmpty) return;

    final lines = text.split(RegExp(r'\r?\n'));
    final parsedGrid = <List<String>>[];
    for (final line in lines) {
      if (line.isEmpty) continue;
      parsedGrid.add(line.split('\t'));
    }

    if (parsedGrid.isNotEmpty) {
      widget.onPaste?.call(parsedGrid);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    if (widget.isLoading) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    if (widget.items.isEmpty) {
      return _buildEmptyState(colors);
    }

    return Focus(
      focusNode: _gridFocusNode,
      onKeyEvent: _handleKeyEvent,
      child: Column(
        children: [
          _buildHeader(colors),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: widget.items.length,
              itemBuilder: (context, index) =>
                  _buildRow(widget.items[index], index, colors),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ZenoSemanticColors colors) {
    final isHeaderHighlighted = _includeHeader;

    return InkWell(
      onTap: () {
        _gridFocusNode.requestFocus();
        setState(() {
          _includeHeader = !_includeHeader;
        });
      },
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: isHeaderHighlighted
              ? colors.accentPrimary.withValues(alpha: 0.2)
              : colors.bgTier2,
          border: Border(
            bottom: BorderSide(color: colors.borderSubtle),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 12),
            ...List.generate(widget.columns.length, (colIdx) {
              final col = widget.columns[colIdx];
              final isColInSelectedRange = _includeHeader && colIdx >= _minCol && colIdx <= _maxCol;
              return _buildHeaderCell(col, isColInSelectedRange, colors);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(
      ZenoTableColumn<T> col, bool isSelected, ZenoSemanticColors colors) {
    Widget cell = Container(
      width: col.width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: col.isNumeric ? Alignment.centerRight : Alignment.centerLeft,
      decoration: isSelected
          ? BoxDecoration(
              color: colors.accentPrimary.withValues(alpha: 0.15),
              border: Border.all(color: colors.accentPrimary, width: 1.0),
            )
          : null,
      child: Text(
        col.label.toUpperCase(),
        style: ZenoTypography.micro(colors.textDisabled).copyWith(
          letterSpacing: 0.8,
          fontWeight: FontWeight.w800,
          fontSize: 8.5,
          color: isSelected ? colors.accentPrimary : colors.textDisabled,
        ),
      ),
    );

    if (col.width == null) {
      return Expanded(child: cell);
    }
    return cell;
  }

  Widget _buildRow(T item, int index, ZenoSemanticColors colors) {
    final isRowSelected = widget.selectedItems.contains(item) ||
        (index >= _minRow && index <= _maxRow);
    final isFocusedRow = index == _focusedRowIndex && _gridFocusNode.hasFocus;
    final trafficLight = widget.trafficLightSelector?.call(item);

    Color? rowBgColor;
    if (isRowSelected) {
      rowBgColor = colors.accentPrimary.withValues(alpha: 0.10);
    } else if (isFocusedRow) {
      rowBgColor = colors.accentPrimary.withValues(alpha: 0.05);
    }

    return InkWell(
      onTapDown: (details) {
        _gridFocusNode.requestFocus();
        final isShift = HardwareKeyboard.instance.isShiftPressed;

        setState(() {
          _focusedRowIndex = index;
          if (!isShift) {
            _anchorRowIndex = index;
            _includeHeader = false;
          }
        });
        widget.onRowTap?.call(item);
      },
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: rowBgColor,
          border: Border(
            left: isFocusedRow
                ? BorderSide(color: colors.accentPrimary, width: 3)
                : BorderSide.none,
            bottom: BorderSide(
              color: colors.borderSubtle.withValues(alpha: 0.3),
              width: ZenoBorderWidth.hairline,
            ),
          ),
        ),
        child: Row(
          children: [
            _buildTrafficLight(trafficLight, isRowSelected, colors),
            ...List.generate(widget.columns.length, (colIdx) {
              final col = widget.columns[colIdx];
              final isFocusedCell = isFocusedRow && (colIdx == _focusedColIndex);
              final isCellInSelectedRange = (index >= _minRow && index <= _maxRow) &&
                  (colIdx >= _minCol && colIdx <= _maxCol);

              return _buildCell(
                item,
                col,
                colIdx,
                index,
                isFocusedCell,
                isCellInSelectedRange,
                colors,
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCell(
    T item,
    ZenoTableColumn<T> col,
    int colIdx,
    int rowIdx,
    bool isFocusedCell,
    bool isCellInSelectedRange,
    ZenoSemanticColors colors,
  ) {
    Widget cellChild = InkWell(
      onTap: () {
        _gridFocusNode.requestFocus();
        final isShift = HardwareKeyboard.instance.isShiftPressed;
        setState(() {
          _focusedRowIndex = rowIdx;
          _focusedColIndex = colIdx;
          if (!isShift) {
            _anchorRowIndex = rowIdx;
            _anchorColIndex = colIdx;
            _includeHeader = false;
          }
        });
      },
      child: Container(
        width: col.width,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: col.isNumeric ? Alignment.centerRight : Alignment.centerLeft,
        decoration: isFocusedCell
            ? BoxDecoration(
                border: Border.all(color: colors.accentPrimary, width: 1.5),
                borderRadius: BorderRadius.circular(2),
              )
            : (isCellInSelectedRange
                ? BoxDecoration(
                    color: colors.accentPrimary.withValues(alpha: 0.12),
                    border: Border.all(color: colors.accentPrimary.withValues(alpha: 0.3), width: 0.5),
                  )
                : null),
        child: DefaultTextStyle(
          style: ZenoTypography.bodyMD(colors.textPrimary).copyWith(
            fontSize: 12,
            fontWeight: isFocusedCell ? FontWeight.w800 : FontWeight.w600,
          ),
          child: col.builder(item),
        ),
      ),
    );

    if (col.width == null) {
      return Expanded(child: cellChild);
    }
    return cellChild;
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
          Icon(Icons.layers_clear_outlined,
              size: 40, color: colors.textDisabled.withValues(alpha: 0.5)),
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
