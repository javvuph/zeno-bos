import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import '../../domain/models/closing_task.dart';

class PeriodProgressStepper extends StatelessWidget {
  final List<ClosingTask> tasks;
  const PeriodProgressStepper({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;
    final completedCount =
        tasks.where((t) => t.status == ClosingTaskStatus.completed).length;
    final totalCount = tasks.length;
    final progress = totalCount > 0 ? completedCount / totalCount : 0.0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.bgTier2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("CLOSING PROGRESS",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                      letterSpacing: 0.5)),
              Text("${(progress * 100).toInt()}%",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                      color: progress == 1
                          ? Colors.green
                          : const Color(0xFF00F0FF))),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: colors.bgTier1,
              color: progress == 1 ? Colors.green : const Color(0xFF00F0FF),
            ),
          ),
          const SizedBox(height: 24),
          _buildCategoryStatus(
              "BANKING", tasks.where((t) => t.category == "Banking")),
          _buildCategoryStatus(
              "FIXED ASSETS", tasks.where((t) => t.category == "Assets")),
          _buildCategoryStatus(
              "TAXATION", tasks.where((t) => t.category == "Tax")),
          _buildCategoryStatus(
              "LEDGER", tasks.where((t) => t.category == "GL")),
        ],
      ),
    );
  }

  Widget _buildCategoryStatus(
      String label, Iterable<ClosingTask> categoryTasks) {
    if (categoryTasks.isEmpty) return const SizedBox.shrink();
    bool isDone =
        categoryTasks.every((t) => t.status == ClosingTaskStatus.completed);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(isDone ? Icons.check_circle_rounded : Icons.circle_outlined,
              size: 14, color: isDone ? Colors.green : Colors.grey),
          const SizedBox(width: 12),
          Text(label,
              style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey)),
          const Spacer(),
          Text(isDone ? "VERIFIED" : "PENDING",
              style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  color: isDone ? Colors.green : Colors.orange)),
        ],
      ),
    );
  }
}
