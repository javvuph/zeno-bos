import 'package:flutter/foundation.dart';
import '../config/global_context.dart';
import '../../features/administration/domain/models/organization.dart';
import '../../features/administration/domain/models/user_security.dart';
import '../../features/administration/domain/models/hardware.dart';

class GlobalContextManager extends ChangeNotifier {
  GlobalContext _current = const GlobalContext();

  GlobalContext get current => _current;

  void updateCompany(Company company) {
    _current = _current.copyWith(company: company);
    notifyListeners();
  }

  void updateBranch(Branch branch) {
    _current = _current.copyWith(branch: branch);
    notifyListeners();
  }

  void updateWarehouse(GlobalWarehouse warehouse) {
    _current = _current.copyWith(warehouse: warehouse);
    notifyListeners();
  }

  void updateTerminal(POSTerminal terminal) {
    _current = _current.copyWith(terminal: terminal);
    notifyListeners();
  }

  void updateUser(User user) {
    _current = _current.copyWith(user: user);
    notifyListeners();
  }

  /// Master switch for environment reset
  void clearContext() {
    _current = const GlobalContext();
    notifyListeners();
  }
}
