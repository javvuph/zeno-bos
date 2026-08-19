import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/features/billing/domain/repositories/i_billing_repository.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_studio_controller.dart';
import 'package:zeno/features/billing/presentation/widgets/billing_top_toolbar.dart';
import 'package:zeno/features/billing/presentation/widgets/studio/billing_sidebar.dart';
import 'package:zeno/features/billing/presentation/widgets/studio/active_customer_banner.dart';
import 'package:zeno/features/billing/presentation/widgets/studio/online_orders_belt.dart';
import 'package:zeno/features/billing/presentation/widgets/studio/smart_cart_grid.dart';
import 'package:zeno/features/billing/presentation/widgets/studio/bill_summary_sidebar.dart';
import 'package:zeno/features/billing/presentation/widgets/studio/billing_status_bar.dart';

class BillingStudioScreen extends StatelessWidget {
  const BillingStudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return BlocProvider(
      create: (context) => BillingStudioController(sl<IBillingRepository>()),
      child: Scaffold(
        backgroundColor: colors.bgTier1,
        body: Column(
          children: [
            const BillingTopToolbar(),
            Expanded(
              child: Row(
                children: [
                  // 1. LEFT ACTION SIDEBAR
                  const BillingSidebar(),

                  // 2. MAIN CENTER AREA
                  Expanded(
                    child: Container(
                      color: const Color(
                          0xFFF8FAFC), // Subtle light background for better contrast
                      child: const Column(
                        children: [
                          OnlineOrdersBelt(),
                          ActiveCustomerBanner(),
                          Expanded(
                            child: SmartCartGrid(),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 3. RIGHT SUMMARY SIDEBAR
                  const BillSummarySidebar(),
                ],
              ),
            ),
            const BillingStatusBar(),
          ],
        ),
      ),
    );
  }
}
