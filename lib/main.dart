import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_todo/config/routes/app_router.dart';
import 'package:flutter_todo/config/themes/app_themes.dart';
import 'package:flutter_todo/constants/common/app_const.dart';
import 'package:flutter_todo/core/di/injection.dart';
import 'package:flutter_todo/core/loggers/auto_route_logger.dart';
import 'package:flutter_todo/core/loggers/bloc_event_logger.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await configureDependencies();
      Bloc.observer = BlocEventLogger();
      runApp(const MyApp());
    },
    (error, stack) {
      /// * Todo : Implement Logger like sentry
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppConst.designSize,
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MaterialApp.router(
          theme: AppThemes.theme,
          debugShowCheckedModeBanner: false,
          routerConfig: getIt.get<AppRouter>().config(
                navigatorObservers: () => [
                  AutoRouteEventLogger(),
                ],
              ),
        );
      },
    );
  }
}
