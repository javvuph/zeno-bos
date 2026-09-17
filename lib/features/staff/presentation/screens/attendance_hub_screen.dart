import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_header.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/di/service_locator.dart';
import '../../domain/models/attendance.dart' as att;
import '../../domain/repositories/i_staff_repository.dart';
import '../controllers/staff_controller.dart';

part 'parts/attendance_hub_widgets.part.dart';

class AttendanceHubScreen extends StatefulWidget {
  const AttendanceHubScreen({super.key});

  @override
  State<AttendanceHubScreen> createState() => _AttendanceHubScreenState();
}

class _AttendanceHubScreenState extends State<AttendanceHubScreen> {
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
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    return Column(
      children: [
        ZenoHeader(
          title: "Attendance Control Hub".toUpperCase(),
          subtitle:
              "MONITOR REAL-TIME SHIFT LOGS, PUNCTUALITY METRICS, AND DAILY PERSONNEL CLOCK-INS.",
          actions: [
            _HubButton(
              label: "CLOCK IN",
              icon: Icons.login_outlined,
              colors: colors,
              onPressed: () => _showClockDialog(context, true),
            ),
            const SizedBox(width: 8),
            _HubButton(
              label: "CLOCK OUT",
              icon: Icons.logout_outlined,
              colors: colors,
              onPressed: () => _showClockDialog(context, false),
            ),
          ],
        ),
        _buildStickySummary(colors),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(ZenoSpacing.lg),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: ZenoCard(
                    title: "ACTIVE SHIFTS",
                    trailing: Text("${controller.currentlyClockedIn} ONLINE",
                        style: ZenoTypography.caption(colors.accentPrimary)
                            .copyWith(fontWeight: FontWeight.bold)),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.recentAttendance.length,
                      itemBuilder: (context, index) {
                        final log = controller.recentAttendance[index];
                        final emp = controller.employees.firstWhere(
                            (e) => e.id == log.employeeId,
                            orElse: () => controller.employees.first);
                        return _AttendanceLogItem(
                            name: emp.name.toUpperCase(),
                            time: log.clockIn.toString().substring(11, 16),
                            status: "ON TIME",
                            colors: colors);
                      },
                    ),
                  ),
                ),
                const SizedBox(width: ZenoSpacing.lg),
                Expanded(
                  flex: 2,
                  child: ZenoCard(
                    title: "PUNCTUALITY ANALYSIS",
                    child: Container(
                      height: 400,
                      decoration: BoxDecoration(
                        color: colors.bgTier3.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(ZenoRadius.lg),
                        border: Border.all(
                            color: colors.borderSubtle,
                            width: 2,
                            style: BorderStyle.solid),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                  color: colors.bgTier4,
                                  shape: BoxShape.circle),
                              child: Icon(Icons.alarm_on_outlined,
                                  size: 48,
                                  color: colors.statusSuccess
                                      .withValues(alpha: 0.5)),
                            ),
                            const SizedBox(height: 24),
                            Text("PUNCTUALITY SCORE: 94.2%",
                                style: ZenoTypography.headlineMD(
                                        colors.textPrimary)
                                    .copyWith(fontWeight: FontWeight.w900)),
                            const SizedBox(height: 8),
                            Text("INITIALIZING REAL-TIME HEATMAP...",
                                style: ZenoTypography.micro(colors.textDisabled)
                                    .copyWith(letterSpacing: 1)),
                          ],
                        ),
                      ),
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

  Widget _buildStickySummary(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: ZenoSpacing.lg, vertical: ZenoSpacing.md),
      margin: const EdgeInsets.only(bottom: ZenoSpacing.md),
      decoration: BoxDecoration(
          color: colors.bgTier1,
          border: Border(bottom: BorderSide(color: colors.borderSubtle))),
      child: Row(
        children: [
          _SummaryItem(
              label: "CURRENTLY PRESENT",
              value: controller.currentlyClockedIn.toString(),
              colors: colors),
          _vDivider(colors),
          _SummaryItem(
              label: "LATE ARRIVALS",
              value: "3",
              colors: colors,
              color: colors.statusWarning),
          _vDivider(colors),
          _SummaryItem(
              label: "TOTAL CAPACITY",
              value: controller.employees.length.toString(),
              colors: colors),
          const Spacer(),
          _FilterChip(
              label: "ALL LOGS", count: 142, isSelected: true, colors: colors),
          const SizedBox(width: ZenoSpacing.sm),
          _FilterChip(
              label: "EXCEPTIONS", count: 5, isWarning: true, colors: colors),
        ],
      ),
    );
  }

  Widget _vDivider(ZenoSemanticColors colors) => Container(
      height: 24,
      width: 1,
      color: colors.borderSubtle,
      margin: const EdgeInsets.symmetric(horizontal: ZenoSpacing.lg));

  void _showClockDialog(BuildContext context, bool isClockIn) {
    String empId = controller.employees.first.id;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isClockIn ? "CLOCK IN" : "CLOCK OUT"),
        content: DropdownButtonFormField<String>(
          initialValue: empId,
          items: controller.employees
              .map((e) => DropdownMenuItem(value: e.id, child: Text(e.name)))
              .toList(),
          onChanged: (v) => empId = v!,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("CANCEL")),
          ElevatedButton(
              onPressed: () async {
                if (isClockIn) {
                  await controller.recordClockIn(
                      empId, att.AttendanceSource.web);
                } else {
                  await controller.recordClockOut(empId);
                }
                if (mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text("CONFIRM")),
        ],
      ),
    );
  }
}
