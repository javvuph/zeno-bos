import 'package:flutter/material.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/features/home/presentation/widgets/bi_widgets.dart';
import 'package:zeno/features/home/presentation/controllers/bi_mock_data.dart';
import 'package:zeno/navigation/navigation_controller.dart';

class AIPredictionGrid extends StatelessWidget {
  const AIPredictionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final predictions = BIMockData.getAIPredictions();

    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.7,
      ),
      itemCount: predictions.length,
      itemBuilder: (context, index) {
        final item = predictions[index];
        return BISectionContainer(
          title: item['title'],
          accentColor: item['color'],
          onTap: () => NavigationController()
              .openTab('home/ai/insights', title: item['title']),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item['value'],
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: item['color']),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['sub'],
                        style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: ZenoTheme.textPrimary),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        item['detail'],
                        style: const TextStyle(
                            fontSize: 10, color: ZenoTheme.textSecondary),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: (item['color'] as Color).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8)),
                  child: Icon(Icons.psychology_outlined,
                      color: item['color'], size: 24),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
