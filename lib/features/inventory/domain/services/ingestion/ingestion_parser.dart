import 'dart:convert';

class IngestionParser {
  /// Parses CSV string into a list of maps.
  /// Handles basic quoted values and different line endings.
  List<Map<String, String>> parseCSV(String csvContent) {
    final List<Map<String, String>> results = [];
    final lines = const LineSplitter().convert(csvContent);
    if (lines.isEmpty) return results;

    final headers = _parseCSVLine(lines[0]);
    for (int i = 1; i < lines.length; i++) {
      if (lines[i].trim().isEmpty) continue;
      final values = _parseCSVLine(lines[i]);
      final Map<String, String> row = {};
      for (int j = 0; j < headers.length; j++) {
        if (j < values.length) {
          row[headers[j].trim()] = values[j].trim();
        }
      }
      results.add(row);
    }
    return results;
  }

  List<String> _parseCSVLine(String line) {
    final List<String> result = [];
    bool inQuotes = false;
    StringBuffer currentField = StringBuffer();

    for (int i = 0; i < line.length; i++) {
      String char = line[i];
      if (char == '"') {
        inQuotes = !inQuotes;
      } else if (char == ',' && !inQuotes) {
        result.add(currentField.toString());
        currentField.clear();
      } else {
        currentField.write(char);
      }
    }
    result.add(currentField.toString());
    return result;
  }
}
