part of '../variant_matrix.dart';

extension _VariantMatrixToolbarState on _VariantMatrixState {
  Widget _buildActionToolbar() {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _toolbarBtn("Generate SKUs", Icons.qr_code_rounded, const Color(0xFF667EEA), () {}),
            const SizedBox(width: 10),
            _toolbarBtn("Generate Barcodes", Icons.barcode_reader, const Color(0xFF667EEA), () {}),
            const SizedBox(width: 10),
            Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Row(
                children: [
                  Text('Bulk Update', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_drop_down, size: 16),
                ],
              ),
            ),
            const SizedBox(width: 16),
            _searchBox(),
          ],
        ),
      ),
    );
  }

  Widget _searchBox() => Container(
    height: 32,
    constraints: const BoxConstraints(minWidth: 160, maxWidth: 220),
    padding: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: const Row(
      children: [
        Icon(Icons.search_rounded, size: 14, color: Colors.grey),
        SizedBox(width: 6),
        Expanded(
          child: TextField(
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF333333)),
            decoration: InputDecoration(
              hintText: "Search variants...",
              hintStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _toolbarBtn(String l, IconData i, Color c, VoidCallback onPressed) => OutlinedButton.icon(
    onPressed: onPressed,
    icon: Icon(i, size: 14, color: c),
    label: Text(l, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: c)),
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(0, 32),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      side: BorderSide(color: c.withValues(alpha: 0.3)),
      backgroundColor: c.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      visualDensity: VisualDensity.compact,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
  );
}
