import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import '../controllers/settings_controller.dart';

class SettingsMainScreen extends StatefulWidget {
  const SettingsMainScreen({super.key});

  @override
  State<SettingsMainScreen> createState() => _SettingsMainScreenState();
}

class _SettingsMainScreenState extends State<SettingsMainScreen>
    with SingleTickerProviderStateMixin {
  late final SettingsController controller;
  late TabController _tabController;

  final List<String> _categories = [
    'GENERAL',
    'MODULES',
    'COMMUNICATION',
    'HARDWARE',
    'PAYMENTS',
    'SECURITY',
    'SYSTEM'
  ];

  @override
  void initState() {
    super.initState();
    controller = SettingsController();
    _tabController = TabController(length: _categories.length, vsync: this);
    controller.addListener(_onUpdate);
  }

  void _onUpdate() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_onUpdate);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return Column(
      children: [
        ZenoHeader(
          title: "Global Configuration".toUpperCase(),
          subtitle:
              "CORE SYSTEM PREFERENCES, MODULE TUNING, AND ENTERPRISE INTEGRATION SETTINGS.",
          actions: [
            _SettingsAction(
                label: "RESET TO DEFAULT", icon: Icons.refresh, colors: colors),
            const SizedBox(width: ZenoSpacing.md),
            _SettingsAction(
                label: "SAVE CHANGES",
                icon: Icons.save_outlined,
                isPrimary: true,
                colors: colors),
          ],
        ),
        // CATEGORY SELECTOR
        Container(
          height: 60,
          decoration: BoxDecoration(
              color: colors.bgTier1,
              border: Border(bottom: BorderSide(color: colors.borderSubtle))),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: colors.accentPrimary,
            indicatorWeight: 3,
            labelColor: colors.accentPrimary,
            unselectedLabelColor: colors.textDisabled,
            labelStyle: ZenoTypography.caption(colors.accentPrimary)
                .copyWith(fontWeight: FontWeight.w900, letterSpacing: 1),
            tabs: _categories.map((cat) => Tab(text: cat)).toList(),
          ),
        ),
        Expanded(
          child: controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : TabBarView(
                  controller: _tabController,
                  children: [
                    _GeneralSettingsTab(controller: controller, colors: colors),
                    _ModuleSettingsTab(controller: controller, colors: colors),
                    _CommunicationSettingsTab(
                        controller: controller, colors: colors),
                    _HardwareSettingsTab(
                        controller: controller, colors: colors),
                    _PaymentSettingsTab(controller: controller, colors: colors),
                    _SecuritySettingsTab(
                        controller: controller, colors: colors),
                    _SystemSettingsTab(controller: controller, colors: colors),
                  ],
                ),
        ),
      ],
    );
  }
}

class _GeneralSettingsTab extends StatelessWidget {
  final SettingsController controller;
  final ZenoSemanticColors colors;
  const _GeneralSettingsTab({required this.controller, required this.colors});

  @override
  Widget build(BuildContext context) {
    final s = controller.settings.general;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(ZenoSpacing.lg),
      child: Column(
        children: [
          ZenoCard(
            title: "LOCALIZATION & THEME",
            child: Column(
              children: [
                _SettingRow(
                    label: "LANGUAGE",
                    value: s.language,
                    icon: Icons.language,
                    colors: colors),
                _SettingRow(
                    label: "CURRENCY",
                    value: s.currency,
                    icon: Icons.payments_outlined,
                    colors: colors),
                _SettingRow(
                    label: "TIMEZONE",
                    value: s.timezone,
                    icon: Icons.schedule,
                    colors: colors),
                _SettingRow(
                    label: "DATE FORMAT",
                    value: s.dateFormat,
                    icon: Icons.calendar_today,
                    colors: colors),
                _SettingRow(
                  label: "THEME MODE",
                  value: s.themeMode.name.toUpperCase(),
                  icon: Icons.brightness_6_outlined,
                  colors: colors,
                  onTap: () => controller.toggleTheme(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ModuleSettingsTab extends StatelessWidget {
  final SettingsController controller;
  final ZenoSemanticColors colors;
  const _ModuleSettingsTab({required this.controller, required this.colors});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(ZenoSpacing.lg),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        crossAxisSpacing: ZenoSpacing.lg,
        mainAxisSpacing: ZenoSpacing.lg,
        children: [
          _ModuleCard(
              title: "BILLING", icon: Icons.receipt_long, colors: colors),
          _ModuleCard(
              title: "INVENTORY",
              icon: Icons.inventory_2_outlined,
              colors: colors),
          _ModuleCard(
              title: "PURCHASE",
              icon: Icons.shopping_cart_outlined,
              colors: colors),
          _ModuleCard(
              title: "FINANCE",
              icon: Icons.account_balance_wallet_outlined,
              colors: colors),
          _ModuleCard(title: "CRM", icon: Icons.people_outline, colors: colors),
          _ModuleCard(
              title: "STAFF", icon: Icons.badge_outlined, colors: colors),
        ],
      ),
    );
  }
}

class _CommunicationSettingsTab extends StatelessWidget {
  final SettingsController controller;
  final ZenoSemanticColors colors;
  const _CommunicationSettingsTab(
      {required this.controller, required this.colors});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(ZenoSpacing.lg),
      child: Column(
        children: const [
          ZenoCard(
              title: "EMAIL GATEWAY (SMTP)",
              child: _PlaceholderForm(label: "SMTP SERVER")),
          SizedBox(height: ZenoSpacing.lg),
          ZenoCard(
              title: "SMS PROVIDER", child: _PlaceholderForm(label: "API KEY")),
          SizedBox(height: ZenoSpacing.lg),
          ZenoCard(
              title: "WHATSAPP BUSINESS API",
              child: _PlaceholderForm(label: "ACCESS TOKEN")),
        ],
      ),
    );
  }
}

class _HardwareSettingsTab extends StatelessWidget {
  final SettingsController controller;
  final ZenoSemanticColors colors;
  const _HardwareSettingsTab({required this.controller, required this.colors});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(ZenoSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Expanded(
              child: ZenoCard(
                  title: "PRINTER CONFIGURATION",
                  child: _PlaceholderForm(label: "PRINTER NAME"))),
          SizedBox(width: ZenoSpacing.lg),
          Expanded(
              child: ZenoCard(
                  title: "BARCODE SCANNER",
                  child: _PlaceholderForm(label: "SCANNER TYPE"))),
        ],
      ),
    );
  }
}

class _PaymentSettingsTab extends StatelessWidget {
  final SettingsController controller;
  final ZenoSemanticColors colors;
  const _PaymentSettingsTab({required this.controller, required this.colors});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(ZenoSpacing.lg),
      child: Column(
        children: const [
          ZenoCard(
              title: "PAYMENT GATEWAYS",
              child: _PlaceholderForm(label: "STRIPE/RAZORPAY KEY")),
          SizedBox(height: ZenoSpacing.lg),
          ZenoCard(
              title: "UPI INTEGRATION",
              child: _PlaceholderForm(label: "VPA / UPI ID")),
        ],
      ),
    );
  }
}

class _SecuritySettingsTab extends StatelessWidget {
  final SettingsController controller;
  final ZenoSemanticColors colors;
  const _SecuritySettingsTab({required this.controller, required this.colors});
  @override
  Widget build(BuildContext context) {
    final s = controller.settings.security;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(ZenoSpacing.lg),
      child: ZenoCard(
        title: "SECURITY & PRIVACY",
        child: Column(
          children: [
            _SettingToggle(
                label: "TWO-FACTOR AUTHENTICATION (2FA)",
                value: s.enable2FA,
                colors: colors),
            _SettingToggle(
                label: "PRIVACY MODE (BLUR SENSITIVE DATA)",
                value: s.privacyMode,
                colors: colors),
            _SettingRow(
                label: "SESSION TIMEOUT",
                value: "${s.sessionTimeout} MINUTES",
                icon: Icons.timer_outlined,
                colors: colors),
            _SettingRow(
                label: "PASSWORD POLICY",
                value: s.passwordPolicy.toUpperCase(),
                icon: Icons.password,
                colors: colors),
          ],
        ),
      ),
    );
  }
}

class _SystemSettingsTab extends StatelessWidget {
  final SettingsController controller;
  final ZenoSemanticColors colors;
  const _SystemSettingsTab({required this.controller, required this.colors});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(ZenoSpacing.lg),
      child: Column(
        children: const [
          ZenoCard(
              title: "API KEYS & WEBHOOKS",
              child: _PlaceholderForm(label: "NEW API KEY")),
          SizedBox(height: ZenoSpacing.lg),
          ZenoCard(
              title: "BACKUP & SYNC",
              child: _PlaceholderForm(label: "BACKUP FREQUENCY")),
          SizedBox(height: ZenoSpacing.lg),
          ZenoCard(
              title: "PERFORMANCE TUNING",
              child: _PlaceholderForm(label: "CACHE LIMIT")),
        ],
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final ZenoSemanticColors colors;
  final VoidCallback? onTap;
  const _SettingRow(
      {required this.label,
      required this.value,
      required this.icon,
      required this.colors,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: colors.borderSubtle.withValues(alpha: 0.5)))),
        child: Row(
          children: [
            Icon(icon, size: 20, color: colors.textDisabled),
            const SizedBox(width: 16),
            Expanded(
                child: Text(label,
                    style: ZenoTypography.caption(colors.textSecondary)
                        .copyWith(fontWeight: FontWeight.bold))),
            Text(value,
                style: ZenoTypography.bodyMD(colors.accentPrimary)
                    .copyWith(fontWeight: FontWeight.w900)),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right, size: 16, color: colors.textDisabled),
          ],
        ),
      ),
    );
  }
}

class _SettingToggle extends StatelessWidget {
  final String label;
  final bool value;
  final ZenoSemanticColors colors;
  const _SettingToggle(
      {required this.label, required this.value, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: colors.borderSubtle.withValues(alpha: 0.5)))),
      child: Row(
        children: [
          Expanded(
              child: Text(label,
                  style: ZenoTypography.caption(colors.textSecondary)
                      .copyWith(fontWeight: FontWeight.bold))),
          Switch(
              value: value,
              onChanged: (v) {},
              activeTrackColor: colors.accentPrimary),
        ],
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final ZenoSemanticColors colors;
  const _ModuleCard(
      {required this.title, required this.icon, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ZenoSpacing.lg),
      decoration: BoxDecoration(
        color: colors.bgTier3,
        borderRadius: BorderRadius.circular(ZenoRadius.lg),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: colors.accentPrimary),
          const SizedBox(height: 16),
          Text(title,
              style: ZenoTypography.caption(colors.textPrimary)
                  .copyWith(fontWeight: FontWeight.w900, letterSpacing: 1)),
        ],
      ),
    );
  }
}

class _PlaceholderForm extends StatelessWidget {
  final String label;
  const _PlaceholderForm({required this.label});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class _SettingsAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final ZenoSemanticColors colors;
  const _SettingsAction(
      {required this.label,
      required this.icon,
      this.isPrimary = false,
      required this.colors});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16),
      label: Text(label,
          style: ZenoTypography.caption(
                  isPrimary ? Colors.black : colors.textPrimary)
              .copyWith(fontWeight: FontWeight.w900)),
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? colors.accentPrimary : colors.bgTier3,
        foregroundColor: isPrimary ? Colors.black : colors.textPrimary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ZenoRadius.md)),
      ),
    );
  }
}
