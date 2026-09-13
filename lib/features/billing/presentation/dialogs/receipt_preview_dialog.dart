import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/billing/domain/models/bill.dart';

class ReceiptPreviewDialog extends StatelessWidget {
  final Bill bill;

  const ReceiptPreviewDialog({super.key, required this.bill});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ZenoRadius.sm),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(ZenoSpacing.md),
              color: colors.bgTier3,
              child: Row(
                children: [
                  const Icon(Icons.receipt_long, size: 20),
                  const SizedBox(width: ZenoSpacing.md),
                  const Text('RECEIPT PREVIEW',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close)),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    const Text('ZENO BUSINESS OS',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 18)),
                    const Text('Enterprise POS Solution',
                        style: TextStyle(color: Colors.black, fontSize: 10)),
                    const SizedBox(height: 20),
                    const Divider(color: Colors.black26),
                    _buildInfoRow('Bill ID:', bill.id),
                    _buildInfoRow(
                        'Date:', bill.timestamp.toString().substring(0, 16)),
                    _buildInfoRow(
                        'Customer:', bill.customer?.name ?? 'Walk-in'),
                    const Divider(color: Colors.black26),
                    const SizedBox(height: 10),
                    ...bill.items.map((item) => _buildItemRow(item)),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.black26, thickness: 1.5),
                    _buildTotalRow('SUBTOTAL', bill.subtotal),
                    _buildTotalRow('TAX', bill.totalTax),
                    _buildTotalRow('DISCOUNT', -bill.totalDiscount),
                    const Divider(color: Colors.black26),
                    _buildTotalRow('TOTAL', bill.grandTotal, isBold: true),
                    const SizedBox(height: 30),
                    const Text('THANK YOU FOR SHOPPING',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                    const Text('www.zeno.com',
                        style: TextStyle(color: Colors.black, fontSize: 8)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(ZenoSpacing.lg),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: colors.accentPrimary,
                      foregroundColor: Colors.black),
                  child: const Text('PRINT RECEIPT (MOCK)'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(color: Colors.black54, fontSize: 10)),
          Text(value,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildItemRow(dynamic item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.productName,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${item.quantity} x \$${item.unitPrice}',
                  style: const TextStyle(color: Colors.black54, fontSize: 10)),
              Text('\$${item.totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, double value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: isBold ? 14 : 11,
                  fontWeight: isBold ? FontWeight.w900 : FontWeight.normal)),
          Text('\$${value.toStringAsFixed(2)}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: isBold ? 16 : 11,
                  fontWeight: isBold ? FontWeight.w900 : FontWeight.bold)),
        ],
      ),
    );
  }
}
