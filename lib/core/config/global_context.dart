import '../../features/administration/domain/models/organization.dart';
import '../../features/administration/domain/models/user_security.dart';
import '../../features/administration/domain/models/hardware.dart';

class GlobalContext {
  final Company? company;
  final Branch? branch;
  final GlobalWarehouse? warehouse;
  final POSTerminal? terminal;
  final User? user;

  const GlobalContext({
    this.company,
    this.branch,
    this.warehouse,
    this.terminal,
    this.user,
  });

  GlobalContext copyWith({
    Company? company,
    Branch? branch,
    GlobalWarehouse? warehouse,
    POSTerminal? terminal,
    User? user,
  }) {
    return GlobalContext(
      company: company ?? this.company,
      branch: branch ?? this.branch,
      warehouse: warehouse ?? this.warehouse,
      terminal: terminal ?? this.terminal,
      user: user ?? this.user,
    );
  }

  bool get isFullyConfigured =>
      company != null && branch != null && user != null;
}
