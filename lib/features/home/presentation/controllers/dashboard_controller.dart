import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeno/features/home/presentation/controllers/personalized_dashboard_cubit.dart';

enum DateFilterPeriod {
  today,
  yesterday,
  thisWeek,
  lastWeek,
  thisMonth,
  lastMonth,
  thisQuarter,
  lastQuarter,
  thisYear,
  financialYear,
  custom,
}

class DashboardController extends ChangeNotifier {
  DateFilterPeriod _selectedPeriod = DateFilterPeriod.thisMonth;
  String _selectedCompany = "ZENO GLOBAL HOLDINGS";
  String _selectedBranch = "MAIN HEADQUARTERS";

  DateFilterPeriod get selectedPeriod => _selectedPeriod;
  String get selectedCompany => _selectedCompany;
  String get selectedBranch => _selectedBranch;

  String get periodLabel {
    switch (_selectedPeriod) {
      case DateFilterPeriod.today:
        return "Today";
      case DateFilterPeriod.yesterday:
        return "Yesterday";
      case DateFilterPeriod.thisWeek:
        return "This Week";
      case DateFilterPeriod.lastWeek:
        return "Last Week";
      case DateFilterPeriod.thisMonth:
        return "This Month";
      case DateFilterPeriod.lastMonth:
        return "Last Month";
      case DateFilterPeriod.thisQuarter:
        return "This Quarter";
      case DateFilterPeriod.lastQuarter:
        return "Last Quarter";
      case DateFilterPeriod.thisYear:
        return "This Year";
      case DateFilterPeriod.financialYear:
        return "Financial Year";
      case DateFilterPeriod.custom:
        return "Custom Range";
    }
  }

  void setPeriod(DateFilterPeriod period, BuildContext context) {
    _selectedPeriod = period;
    notifyListeners();
    _triggerDashboardRefresh(context);
  }

  void setCompany(String company, BuildContext context) {
    _selectedCompany = company;
    notifyListeners();
    _triggerDashboardRefresh(context);
  }

  void setBranch(String branch, BuildContext context) {
    _selectedBranch = branch;
    notifyListeners();
    _triggerDashboardRefresh(context);
  }

  void _triggerDashboardRefresh(BuildContext context) {
    // When global filters change, refresh all authorized widgets
    final cubit = context.read<DashboardCubit>();
    for (var widget in cubit.state.authorizedWidgets) {
      cubit.refreshWidget(widget.id);
    }
  }
}
