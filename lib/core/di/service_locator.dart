import 'package:get_it/get_it.dart';

import '../../cubit/follow_up/follow_up_cubit.dart';
import '../../cubit/theme/theme_cubit.dart';
import '../../services/follow_up_service.dart';
import '../../services/theme_storage_service.dart';



final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  // Services
  getIt
    ..registerLazySingleton<FollowUpService>(() => const MockFollowUpService())
    ..registerLazySingleton<ThemeStorageService>(
      () => const ThemeStorageService(),
    )

    // Cubits
    ..registerLazySingleton<ThemeCubit>(
      () => ThemeCubit(getIt<ThemeStorageService>()),
    )
    ..registerFactory<FollowUpCubit>(
      () => FollowUpCubit(getIt<FollowUpService>()),
    );
}


