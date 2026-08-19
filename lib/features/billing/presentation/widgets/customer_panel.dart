import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:zeno/app/theme.dart';
import 'package:zeno/core/widgets/zeno_card.dart';
import 'package:zeno/core/widgets/zeno_inputs.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_studio_controller.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_state.dart';
import 'package:zeno/features/billing/presentation/controllers/billing_event.dart';
import 'package:zeno/features/billing/domain/models/billing_customer.dart';

class CustomerPanel extends StatefulWidget {
  const CustomerPanel({super.key});

  @override
  State<CustomerPanel> createState() => _CustomerPanelState();
}

class _CustomerPanelState extends State<CustomerPanel> {
  bool _isExpanded = true;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<ZenoSemanticColors>()!;

    return BlocBuilder<BillingStudioController, BillingState>(
      builder: (context, state) {
        final customer = state.activeBill.customer;

        return ZenoCard(
          title: "CUSTOMER",
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => setState(() => _isSearching = !_isSearching),
                icon: Icon(_isSearching ? Icons.close : Icons.person_add_alt_1,
                    color: colors.accentPrimary, size: 18),
                tooltip: 'Search Customer (F2)',
              ),
              IconButton(
                onPressed: () => setState(() => _isExpanded = !_isExpanded),
                icon: AnimatedRotation(
                  turns: _isExpanded ? 0 : 0.5,
                  duration: ZenoDuration.std,
                  child: Icon(Icons.keyboard_arrow_up,
                      color: colors.textSecondary, size: 18),
                ),
              ),
            ],
          ),
          padding: EdgeInsets.zero,
          child: AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.all(ZenoSpacing.md),
              child: Column(
                children: [
                  if (_isSearching)
                    Padding(
                      padding: const EdgeInsets.only(bottom: ZenoSpacing.md),
                      child: ZenoTextField(
                        controller: _searchController,
                        label: "SEARCH BY PHONE / NAME",
                        hint: "Type and press enter...",
                        onSubmitted: (val) {
                          context
                              .read<BillingStudioController>()
                              .add(SearchCustomerRequested(val));
                          setState(() => _isSearching = false);
                          _searchController.clear();
                        },
                      ),
                    ),
                  customer == null
                      ? _buildEmptyState(colors)
                      : _buildCustomerInfo(customer, colors),
                ],
              ),
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: ZenoDuration.std,
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: ZenoSpacing.sm),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(ZenoSpacing.sm),
            decoration: BoxDecoration(
              color: colors.bgTier3,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.account_circle_outlined,
                color: colors.textDisabled, size: 24),
          ),
          const SizedBox(width: ZenoSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WALK-IN CUSTOMER',
                  style: ZenoTypography.bodyLG(colors.textPrimary),
                ),
                Text(
                  'Standard retail pricing',
                  style: ZenoTypography.micro(colors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: ZenoDuration.fast);
  }

  Widget _buildCustomerInfo(
      BillingCustomer customer, ZenoSemanticColors colors) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: colors.accentPrimary.withValues(alpha: 0.1),
          child: Text(
            customer.name[0],
            style: TextStyle(
                color: colors.accentPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
        ),
        const SizedBox(width: ZenoSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                customer.name,
                style: ZenoTypography.bodyLG(colors.textPrimary),
              ),
              Row(
                children: [
                  Icon(Icons.phone_outlined,
                      size: 10, color: colors.textSecondary),
                  const SizedBox(width: 4),
                  Text(
                    customer.phone,
                    style: ZenoTypography.caption(colors.textSecondary),
                  ),
                ],
              ),
            ],
          ),
        ),
        _buildLoyaltyBadge(customer, colors),
      ],
    ).animate().fadeIn(duration: ZenoDuration.fast).slideX(begin: 0.05);
  }

  Widget _buildLoyaltyBadge(
      BillingCustomer customer, ZenoSemanticColors colors) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colors.amberGold.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(ZenoRadius.sm),
        border: Border.all(color: colors.amberGold.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, color: colors.amberGold, size: 10),
          const SizedBox(width: 4),
          Text(
            customer.loyaltyTier.toUpperCase(),
            style: TextStyle(
              color: colors.amberGold,
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
