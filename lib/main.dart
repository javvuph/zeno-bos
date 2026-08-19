import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zeno/core/di/service_locator.dart';
import 'package:zeno/core/widgets/zeno_shell.dart';
import 'package:zeno/features/inventory/presentation/controllers/inventory_bloc.dart';
import 'package:zeno/features/inventory/data/services/ai_product_service.dart';
import 'package:zeno/features/home/presentation/controllers/personalized_dashboard_cubit.dart';
import 'package:zeno/app/zeno_theme_controller.dart';
import 'package:zeno/core/sync/background_sync_worker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Preserve splash screen if we had one

  await setupServiceLocator();
  await BackgroundSyncWorker.initialize();
  await BackgroundSyncWorker.schedulePeriodicSync();

  runApp(const ZenoBOS());
}

class ZenoBOS extends StatelessWidget {
  const ZenoBOS({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = ZenoThemeController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => InventoryBloc(sl<AIProductService>()),
        ),
        BlocProvider(
          create: (_) => DashboardCubit(),
        ),
      ],
      child: ListenableBuilder(
        listenable: themeController,
        builder: (context, _) {
          return MaterialApp(
            title: 'ZENO Business Operating System',
            debugShowCheckedModeBanner: false,
            theme: themeController.currentTheme,
            home: const ZenoShell(),
          );
        },
      ),
    );
  }
}
