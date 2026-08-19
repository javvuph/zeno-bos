import 'package:flutter/material.dart';
import 'package:zeno/core/widgets/templates/zeno_input_form_template.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../controllers/administration_controller.dart';
import '../../domain/models/settings.dart';

class SecurityPolicyScreen extends StatefulWidget {
  const SecurityPolicyScreen({super.key});

  @override
  State<SecurityPolicyScreen> createState() => _SecurityPolicyScreenState();
}

class _SecurityPolicyScreenState extends State<SecurityPolicyScreen> {
  late final AdministrationController controller;

  final _minLengthController = TextEditingController();
  final _timeoutController = TextEditingController();
  late bool _requireSpecial;
  late bool _enable2FA;

  @override
  void initState() {
    super.initState();
    controller = sl<AdministrationController>();
    final policy = controller.settings.securityPolicy;
    _minLengthController.text = policy.minPasswordLength.toString();
    _timeoutController.text = policy.sessionTimeoutMinutes.toString();
    _requireSpecial = policy.requireSpecialChars;
    _enable2FA = policy.enable2FA;
  }

  @override
  void dispose() {
    _minLengthController.dispose();
    _timeoutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZenoInputFormTemplate(
      title: "Global Security Policy",
      breadcrumbs: const ["Admin", "Security", "Policy"],
      onSave: () async {
        final updatedSettings = BusinessSettings(
          securityPolicy: SecurityPolicy(
            minPasswordLength: int.tryParse(_minLengthController.text) ?? 8,
            requireSpecialChars: _requireSpecial,
            sessionTimeoutMinutes: int.tryParse(_timeoutController.text) ?? 60,
            enable2FA: _enable2FA,
          ),
        );
        await controller.updateSettings(updatedSettings);
        if (mounted) Navigator.pop(context);
      },
      onCancel: () => Navigator.pop(context),
      sections: [
        ZenoFormSection(
          title: "Authentication Standards",
          children: [
            ZenoTextField(
              label: "Minimum Password Length",
              controller: _minLengthController,
              keyboardType: TextInputType.number,
            ),
            SwitchListTile(
              title: const Text("Require Special Characters"),
              value: _requireSpecial,
              onChanged: (v) => setState(() => _requireSpecial = v),
            ),
            SwitchListTile(
              title: const Text("Enable Two-Factor Authentication (2FA)"),
              value: _enable2FA,
              onChanged: (v) => setState(() => _enable2FA = v),
            ),
          ],
        ),
        ZenoFormSection(
          title: "Session Governance",
          children: [
            ZenoTextField(
              label: "Session Timeout (Minutes)",
              controller: _timeoutController,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ],
    );
  }
}
