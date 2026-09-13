import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_staff_repository.dart';
import '../controllers/staff_controller.dart';

class PerformanceDashboardScreen extends StatefulWidget {
  const PerformanceDashboardScreen({super.key});

  @override
  State<PerformanceDashboardScreen> createState() =>
      _PerformanceDashboardScreenState();
}

class _PerformanceDashboardScreenState
    extends State<PerformanceDashboardScreen> {
  final controller = StaffController(sl<IStaffRepository>());

  @override
  void initState() {
    super.initState();
    controller.addListener(_onUpdate);
  }

  void _onUpdate() => setState(() {});

  @override
  void dispose() {
    controller.removeListener(_onUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ZenoHeader(
          title: "Performance Command",
          subtitle:
              "Conduct employee appraisals, track KPIs, and manage recognition programs.",
          actions: [
            ElevatedButton(onPressed: null, child: Text("New Review Cycle")),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ZenoCard(
                    title: "OVERALL KPI RATING",
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("4.2",
                              style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF9D50BB))),
                          const Text("Out of 5.0",
                              style: TextStyle(
                                  color: ZenoTheme.textSecondary,
                                  fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 2,
                  child: ZenoCard(
                    title: "PENDING APPRAISALS (12)",
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) =>
                          _AppraisalItem(name: "John Smith", dept: "Sales"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _AppraisalItem extends StatelessWidget {
  final String name;
  final String dept;
  const _AppraisalItem({required this.name, required this.dept});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          const CircleAvatar(
              radius: 14,
              backgroundColor: ZenoTheme.surface,
              child: Icon(Icons.person, size: 14)),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(dept,
                    style: const TextStyle(
                        fontSize: 10, color: ZenoTheme.textSecondary))
              ])),
          OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                  visualDensity: VisualDensity.compact),
              child:
                  const Text("Start Review", style: TextStyle(fontSize: 10))),
        ],
      ),
    );
  }
}
