part of '../business_setup_wizard_screen.dart';

class _ProgressNode extends StatelessWidget {
  final String label;
  final bool isActive;
  final bool isDone;
  final ZenoSemanticColors colors;
  const _ProgressNode(
      {required this.label,
      this.isActive = false,
      this.isDone = false,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    final color = isDone
        ? colors.statusSuccess
        : (isActive ? colors.accentPrimary : colors.textDisabled);
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color.withValues(alpha: 0.3))),
          child: Center(
              child: Icon(isDone ? Icons.check : Icons.circle,
                  size: 12, color: color)),
        ),
        const SizedBox(width: 8),
        Text(label,
            style: ZenoTypography.micro(color)
                .copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _SetupInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final ZenoSemanticColors colors;
  const _SetupInput(
      {required this.label, required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: ZenoTypography.micro(colors.textDisabled),
          filled: true,
          fillColor: colors.bgTier3,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
        ),
        style: ZenoTypography.bodyMD(colors.textPrimary),
      ),
    );
  }
}

class _SetupStep extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isDone;
  final Color? color;
  final ZenoSemanticColors colors;

  const _SetupStep(
      {required this.icon,
      required this.label,
      required this.value,
      required this.isDone,
      this.color,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    final activeColor = color ?? colors.accentPrimary;
    final bool done = isDone;
    return Padding(
      padding: const EdgeInsets.only(bottom: ZenoSpacing.lg),
      child: AnimatedContainer(
        duration: ZenoDuration.std,
        padding: const EdgeInsets.all(ZenoSpacing.md),
        decoration: BoxDecoration(
          color: colors.bgTier3.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(ZenoRadius.md),
          border: Border.all(
              color: (done ? colors.statusSuccess : activeColor)
                  .withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: (done ? colors.statusSuccess : activeColor)
                      .withValues(alpha: 0.1),
                  shape: BoxShape.circle),
              child: Icon(icon,
                  size: 18, color: done ? colors.statusSuccess : activeColor),
            ),
            const SizedBox(width: ZenoSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: ZenoTypography.micro(colors.textDisabled)
                          .copyWith(letterSpacing: 1)),
                  const SizedBox(height: 2),
                  Text(value,
                      style: ZenoTypography.bodyMD(colors.textPrimary)
                          .copyWith(fontWeight: FontWeight.w900)),
                ],
              ),
            ),
            if (done)
              Icon(Icons.check_circle, size: 18, color: colors.statusSuccess)
            else
              Icon(Icons.arrow_forward_ios,
                  size: 12, color: activeColor.withValues(alpha: 0.5)),
          ],
        ),
      ),
    );
  }
}
