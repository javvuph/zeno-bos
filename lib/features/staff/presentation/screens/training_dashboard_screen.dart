import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/repositories/i_staff_repository.dart';
import '../controllers/staff_controller.dart';

class TrainingDashboardScreen extends StatefulWidget {
  const TrainingDashboardScreen({super.key});

  @override
  State<TrainingDashboardScreen> createState() =>
      _TrainingDashboardScreenState();
}

class _TrainingDashboardScreenState extends State<TrainingDashboardScreen> {
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
    return const Column(
      children: [
        ZenoHeader(
          title: "Learning & Development",
          subtitle:
              "Manage employee certifications, training courses, and skill matrices.",
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: ZenoStatCard(
                            label: "Active Courses",
                            value: "24",
                            icon: Icons.school_outlined,
                            iconColor: Color(0xFFFF9800))),
                    SizedBox(width: 24),
                    Expanded(
                        child: ZenoStatCard(
                            label: "Certifications Issued",
                            value: "850",
                            icon: Icons.verified_outlined,
                            iconColor: Color(0xFF00FF88))),
                  ],
                ),
                SizedBox(height: 24),
                ZenoCard(
                  title: "UPCOMING TRAINING SESSIONS",
                  child: Column(
                    children: [
                      _SessionItem(
                          title: "POS Advanced Workflow",
                          date: "July 28, 2024",
                          attendees: 15),
                      _SessionItem(
                          title: "Inventory Management AI",
                          date: "August 02, 2024",
                          attendees: 42),
                    ],
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

class _SessionItem extends StatelessWidget {
  final String title;
  final String date;
  final int attendees;
  const _SessionItem(
      {required this.title, required this.date, required this.attendees});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          const Icon(Icons.calendar_today, size: 16, color: Color(0xFFFF9800)),
          const SizedBox(width: 16),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(date,
                    style: const TextStyle(
                        fontSize: 10, color: ZenoTheme.textSecondary))
              ])),
          Text("$attendees Attendees",
              style: const TextStyle(
                  fontSize: 11, color: ZenoTheme.textSecondary)),
        ],
      ),
    );
  }
}
