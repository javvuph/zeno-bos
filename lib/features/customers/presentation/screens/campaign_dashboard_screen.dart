import 'package:flutter/material.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_customer_repository.dart';
import '../controllers/crm_controller.dart';
import 'package:zeno/core/widgets/zeno_table.dart';
import '../../domain/models/campaign.dart';

class CampaignDashboardScreen extends StatefulWidget {
  const CampaignDashboardScreen({super.key});

  @override
  State<CampaignDashboardScreen> createState() =>
      _CampaignDashboardScreenState();
}

class _CampaignDashboardScreenState extends State<CampaignDashboardScreen> {
  late final CRMController controller;

  @override
  void initState() {
    super.initState();
    controller = CRMController(sl<ICustomerRepository>());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("Campaign ROI \u0026 Engagement Tracking Dashboard",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: ZenoTable<Campaign>(
            items: controller.campaigns,
            columns: [
              ZenoTableColumn<Campaign>(
                  label: "CAMPAIGN",
                  width: 250,
                  builder: (c) => Text(c.title.toUpperCase())),
              ZenoTableColumn<Campaign>(
                  label: "TYPE",
                  width: 120,
                  builder: (c) => Text(c.type.name.toUpperCase())),
              ZenoTableColumn<Campaign>(
                  label: "STATUS",
                  width: 120,
                  builder: (c) => Text(c.status.name.toUpperCase())),
              ZenoTableColumn<Campaign>(
                  label: "BUDGET",
                  width: 120,
                  isNumeric: true,
                  builder: (c) => Text("₹${c.budget.toInt()}")),
              ZenoTableColumn<Campaign>(
                  label: "ROI",
                  width: 100,
                  isNumeric: true,
                  builder: (c) => Text("${(c.roi * 100).toInt()}%")),
            ],
          ),
        ),
      ],
    );
  }
}
