import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/service_locator.dart';
import 'core/theme/theme_basic.dart';
import 'cubit/theme/theme_cubit.dart';
import 'views/follow_up_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  runApp(
    BlocProvider<ThemeCubit>(
      create: (_) => getIt<ThemeCubit>(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {


    return ScreenUtilInit(
      designSize: const Size(390, 844), // typical mobile size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (BuildContext context, ThemeMode mode) {
            return MaterialApp(
              title: 'Follow Ups',
              themeMode: mode,
              theme: ThemeBasic.baseLight,
              darkTheme: ThemeBasic.baseDark,
              debugShowCheckedModeBanner: false,
              home: child,
            );
          },
        );
      },
      child: const FollowUpListScreen(),
    );
  }
}

