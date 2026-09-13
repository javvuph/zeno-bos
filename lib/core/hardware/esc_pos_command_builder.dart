import 'dart:convert';

class EscPosCommandBuilder {
  final List<int> _buffer = [];

  void reset() => _buffer.addAll([0x1B, 0x40]);
  void setBold(bool on) => _buffer.addAll([0x1B, 0x45, on ? 1 : 0]);
  void setAlign(int align) => _buffer.addAll([0x1B, 0x61, align]); // 0:L, 1:C, 2:R
  
  void text(String text) {
    _buffer.addAll(utf8.encode(text));
    _buffer.add(0x0A); // Newline
  }

  void cut() => _buffer.addAll([0x1D, 0x56, 0x41, 0x03]);

  void addRow(String label, String value, {int width = 32}) {
    int space = width - label.length - value.length;
    if (space < 1) space = 1;
    text("$label${' ' * space}$value");
  }

  List<int> build() => List.unmodifiable(_buffer);
}
