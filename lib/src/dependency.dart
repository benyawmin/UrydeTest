import 'package:get_it/get_it.dart';
import 'package:uryde/src/screens/report_screen.dart';

final GetIt getIt = GetIt.instance;

void initialize() {
  // Register your dependencies here
  // App dependencies
  getIt.registerLazySingleton<ReportScreen>(() => ReportScreen());

  // Other dependencies
  // getIt.registerSingleton<YourDependencyClass>(YourDependencyClass());
}
