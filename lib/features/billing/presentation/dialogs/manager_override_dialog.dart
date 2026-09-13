import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';

class ManagerOverrideDialog extends StatefulWidget {
  final String action;
  final Function(bool) onResult;

  const ManagerOverrideDialog({
    super.key,
    required this.action,
    required this.onResult,
  });

  @override
  State<ManagerOverrideDialog> createState() => _ManagerOverrideDialogState();
}

class _ManagerOverrideDialogState extends State<ManagerOverrideDialog> {
  final TextEditingController _pinController = TextEditingController();

  void _verify() {
    // Mock verification - PIN is 1234
    if (_pinController.text == '1234') {
      widget.onResult(true);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Invalid Manager PIN'),
            backgroundColor: Colors.redAccent),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: colors.bgTier2,
          borderRadius: BorderRadius.circular(ZenoRadius.lg),
          border:
              Border.all(color: colors.statusWarning.withValues(alpha: 0.5)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(ZenoSpacing.md),
              decoration: BoxDecoration(
                color: colors.statusWarning.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(ZenoRadius.lg)),
              ),
              child: Row(
                children: [
                  Icon(Icons.lock_person_outlined,
                      color: colors.statusWarning, size: 20),
                  const SizedBox(width: ZenoSpacing.md),
                  Text('MANAGER OVERRIDE',
                      style: ZenoTypography.headlineMD(colors.textPrimary)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(ZenoSpacing.lg),
              child: Column(
                children: [
                  Text(
                    'Action: ${widget.action.toUpperCase()}',
                    style: ZenoTypography.caption(colors.textSecondary),
                  ),
                  const SizedBox(height: ZenoSpacing.lg),
                  TextField(
                    controller: _pinController,
                    obscureText: true,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                        fontSize: 24,
                        letterSpacing: 8,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: '••••',
                      hintStyle: TextStyle(
                          color: colors.textDisabled.withValues(alpha: 0.3)),
                      filled: true,
                      fillColor: colors.bgTier3,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(ZenoRadius.md),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (_) => _verify(),
                  ),
                  const SizedBox(height: ZenoSpacing.xl),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('CANCEL',
                              style: TextStyle(color: colors.textSecondary)),
                        ),
                      ),
                      const SizedBox(width: ZenoSpacing.md),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _verify,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.statusWarning,
                            foregroundColor: Colors.black,
                          ),
                          child: const Text('AUTHORIZE',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
