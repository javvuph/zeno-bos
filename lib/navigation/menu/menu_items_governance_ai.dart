import 'package:flutter/material.dart';
import 'menu_models.dart';

const List<ZenoMenuCategory> governanceAndAiCategories = [
  // --- 10. AI ---
  ZenoMenuCategory(
    id: 'ai',
    label: 'AI',
    icon: Icons.auto_awesome_rounded,
    color: Color(0xFFD946EF),
    columns: [
      ZenoMenuColumn(
        title: 'INTELLIGENCE LAYER',
        items: [
          ZenoMenuItem(
              label: 'AI Copilot',
              icon: Icons.assistant_rounded,
              route: 'ai/home',
              isAI: true),
          ZenoMenuItem(
              label: 'Risk Forecast',
              icon: Icons.insights_rounded,
              route: 'ai/risk',
              isAI: true),
          ZenoMenuItem(
              label: 'Sales Online',
              icon: Icons.online_prediction_rounded,
              route: 'ai/sales-forecast',
              isAI: true),
          ZenoMenuItem(
              label: 'Inventory Pred',
              icon: Icons.inventory_rounded,
              route: 'ai/stock-forecast',
              isAI: true),
          ZenoMenuItem(
              label: 'Automation Hub',
              icon: Icons.smart_toy_rounded,
              route: 'ai/automation',
              isAI: true),
        ],
      ),
    ],
  ),

  // --- 11. ADMIN ---
  ZenoMenuCategory(
    id: 'admin',
    label: 'ADMIN',
    icon: Icons.settings_rounded,
    color: Color(0xFF475569),
    columns: [
      ZenoMenuColumn(
        title: 'GOVERNANCE',
        items: [
          ZenoMenuItem(
              label: 'Store Setup',
              icon: Icons.domain_rounded,
              route: 'admin/profile'),
          ZenoMenuItem(
              label: 'Security',
              icon: Icons.key_rounded,
              route: 'admin/security'),
          ZenoMenuItem(
              label: 'Workflows',
              icon: Icons.verified_rounded,
              route: 'admin/workflows'),
          ZenoMenuItem(
              label: 'Governance Hub',
              icon: Icons.gavel_rounded,
              route: 'admin/governance'),
          ZenoMenuItem(
              label: 'Automation Center',
              icon: Icons.smart_toy_outlined,
              route: 'admin/automation'),
          ZenoMenuItem(
              label: 'System Audit',
              icon: Icons.history_edu_rounded,
              route: 'admin/audit'),
          ZenoMenuItem(
              label: 'Backup \u0026 Data',
              icon: Icons.cloud_upload_rounded,
              route: 'admin/backup'),
          ZenoMenuItem(
              label: 'App Settings',
              icon: Icons.settings_applications_rounded,
              route: 'admin/settings'),
          ZenoMenuItem(
              label: 'Integrations',
              icon: Icons.cable_rounded,
              route: 'admin/integrations'),
        ],
      ),
    ],
  ),
];
