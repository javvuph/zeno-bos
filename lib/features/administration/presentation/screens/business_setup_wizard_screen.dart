import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/models/organization.dart';
import '../../domain/repositories/i_administration_repository.dart';
import '../controllers/administration_controller.dart';

class BusinessSetupWizardScreen extends StatefulWidget {
  const BusinessSetupWizardScreen({super.key});

  @override
  State<BusinessSetupWizardScreen> createState() =>
      _BusinessSetupWizardScreenState();
}

class _BusinessSetupWizardScreenState extends State<BusinessSetupWizardScreen> {
  final controller = AdministrationController(sl<IAdministrationRepository>());
  final _nameController = TextEditingController();
  final _taxIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(_onUpdate);
    _nameController.text = controller.company.name;
    _taxIdController.text = controller.company.taxId;
  }

  void _onUpdate() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_onUpdate);
    _nameController.dispose();
    _taxIdController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    final updatedCompany = Company(
      id: controller.company.id,
      name: _nameController.text,
      taxId: _taxIdController.text,
      gst: controller.company.gst,
      pan: controller.company.pan,
      isDefault: controller.company.isDefault,
    );
    await controller.updateCompany(updatedCompany);
    if (mounted)
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Enterprise Identity Updated")));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final settings = controller.settings;
    final company = controller.company;

    return Column(
      children: [
        ZenoHeader(
          title: "Business Setup Wizard".toUpperCase(),
          subtitle:
              "CONFIGURE GLOBAL BUSINESS IDENTITY, FISCAL LOCALIZATION, AND ACTIVATE THE CORE ZENO TAX ENGINE.",
        ),
        // PROGRESS TRACKER
        _buildStickyProgress(colors),
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(ZenoSpacing.lg),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  children: [
                    ZenoCard(
                      title: "GLOBAL BUSINESS IDENTITY",
                      trailing: IconButton(
                          icon: const Icon(Icons.save_outlined),
                          onPressed: _handleSave),
                      child: Column(
                        children: [
                          _SetupInput(
                              label: "COMPANY LEGAL NAME",
                              controller: _nameController,
                              colors: colors),
                          _SetupInput(
                              label: "TAX IDENTIFICATION",
                              controller: _taxIdController,
                              colors: colors),
                          _SetupStep(
                              icon: Icons.business,
                              label: "VERIFIED NAME",
                              value: company.name.toUpperCase(),
                              isDone: company.name.isNotEmpty,
                              colors: colors),
                          _SetupStep(
                              icon: Icons.qr_code_scanner,
                              label: "TAX IDENTIFICATION (GST/PAN)",
                              value: "${company.gst} / ${company.pan}",
                              isDone: company.gst.isNotEmpty,
                              colors: colors),
                          _SetupStep(
                              icon: Icons.public,
                              label: "JURISDICTION / COUNTRY",
                              value: "UNITED STATES (US)",
                              isDone: true,
                              colors: colors),
                          _SetupStep(
                              icon: Icons.payments_outlined,
                              label: "FUNCTIONAL CURRENCY",
                              value: settings.currencyCode,
                              isDone: settings.currencyCode.isNotEmpty,
                              colors: colors),
                          _SetupStep(
                              icon: Icons.translate,
                              label: "SYSTEM LANGUAGE",
                              value: settings.languageCode.toUpperCase(),
                              isDone: settings.languageCode.isNotEmpty,
                              colors: colors),
                          _SetupStep(
                              icon: Icons.gavel_outlined,
                              label: "GLOBAL TAX ENGINE",
                              value:
                                  "SALES TAX @ ${settings.taxDefaults.salesTaxRate}%",
                              isDone: true,
                              color: colors.statusDanger,
                              colors: colors),
                          _SetupStep(
                              icon: Icons.security,
                              label: "RBAC PERMISSION MATRIX",
                              value: "V/C/E/D/A ENABLED",
                              isDone: true,
                              colors: colors),
                          const SizedBox(height: ZenoSpacing.xl),
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colors.accentPrimary,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(ZenoRadius.lg)),
                              ),
                              child: Text("INITIALIZE GLOBAL BOS ENGINE",
                                  style: ZenoTypography.bodyMD(Colors.black)
                                      .copyWith(
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 1)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: ZenoSpacing.xl),
                    _buildSecurityNote(colors),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStickyProgress(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: ZenoSpacing.lg, vertical: ZenoSpacing.md),
      decoration: BoxDecoration(
          color: colors.bgTier1,
          border: Border(bottom: BorderSide(color: colors.borderSubtle))),
      child: Row(
        children: [
          _ProgressNode(
              label: "IDENTITY", isActive: true, isDone: true, colors: colors),
          _vLine(colors),
          _ProgressNode(label: "LOCALE", isActive: true, colors: colors),
          _vLine(colors),
          _ProgressNode(label: "TAXATION", colors: colors),
          _vLine(colors),
          _ProgressNode(label: "SECURITY", colors: colors),
        ],
      ),
    );
  }

  Widget _vLine(ZenoSemanticColors colors) => Expanded(
      child: Container(
          height: 2,
          color: colors.borderSubtle,
          margin: const EdgeInsets.symmetric(horizontal: ZenoSpacing.md)));

  Widget _buildSecurityNote(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.all(ZenoSpacing.lg),
      decoration: BoxDecoration(
          color: colors.statusInfo.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(ZenoRadius.lg),
          border: Border.all(color: colors.statusInfo.withValues(alpha: 0.2))),
      child: Row(
        children: [
          Icon(Icons.verified_user_outlined, color: colors.statusInfo),
          const SizedBox(width: ZenoSpacing.lg),
          Expanded(
              child: Text(
                  "ALL BUSINESS IDENTITY DATA IS ENCRYPTED AT REST AND COMPLIANT WITH GLOBAL PRIVACY STANDARDS (GDPR/CCPA).",
                  style: ZenoTypography.micro(colors.textSecondary)
                      .copyWith(height: 1.5))),
        ],
      ),
    );
  }
}

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
