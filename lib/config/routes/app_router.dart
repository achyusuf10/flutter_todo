import 'package:auto_route/auto_route.dart';
import 'package:flutter_todo/app/features/home/presentation/pages/home_page.dart';
import 'package:flutter_todo/app/features/splash/presentation/pages/splash_page.dart';
import 'package:flutter_todo/app/features/task/presentation/pages/edit_task_page.dart';
import 'package:flutter_todo/config/routes/route_name.dart';
import 'package:injectable/injectable.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: "Route|Page,Route",
  generateForDir: [
    'lib/config/routes',
    'lib/app/features',
  ],
)
@lazySingleton
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          path: RouteName.splash,
          initial: true,
        ),
        AutoRoute(
          page: HomeRoute.page,
          path: RouteName.home,
        ),
        AutoRoute(
          page: EditTaskRoute.page,
          path: RouteName.editTask,
        ),
      ];
}
