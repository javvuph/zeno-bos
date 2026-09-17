part of '../settings_main_screen.dart';

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
    return const SingleChildScrollView(
      padding: EdgeInsets.all(ZenoSpacing.lg),
      child: Column(
        children: [
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
    return const Padding(
      padding: EdgeInsets.all(ZenoSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
    return const SingleChildScrollView(
      padding: EdgeInsets.all(ZenoSpacing.lg),
      child: Column(
        children: [
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
        children: [
          ZenoCard(
            title: "PROJECT REPOSITORY",
            subtitle: "LATEST SOURCE LINK",
            trailing: const Icon(Icons.open_in_new, color: ZenoTheme.accent, size: 18),
            onTap: () => _openRepository(),
            child: const _RepositoryLinkCard(),
          ),
          const SizedBox(height: ZenoSpacing.lg),
          const ZenoCard(
              title: "API KEYS & WEBHOOKS",
              child: _PlaceholderForm(label: "NEW API KEY")),
          const SizedBox(height: ZenoSpacing.lg),
          const ZenoCard(
              title: "BACKUP & SYNC",
              child: _PlaceholderForm(label: "BACKUP FREQUENCY")),
          const SizedBox(height: ZenoSpacing.lg),
          const ZenoCard(
              title: "PERFORMANCE TUNING",
              child: _PlaceholderForm(label: "CACHE LIMIT")),
        ],
      ),
    );
  }
}
