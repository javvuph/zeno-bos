import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/settings_controller.dart';

part 'parts/settings_tabs.part.dart';
part 'parts/settings_widgets.part.dart';

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
