// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_todo/app/features/task/data/datasources/local/task_local_datasource.dart'
    as _i6;
import 'package:flutter_todo/app/features/task/data/repositories/task_repository_impl.dart'
    as _i8;
import 'package:flutter_todo/app/features/task/domain/repositories/task_repository.dart'
    as _i7;
import 'package:flutter_todo/config/routes/app_router.dart' as _i3;
import 'package:flutter_todo/config/source_config/local/hive_config.dart'
    as _i4;
import 'package:flutter_todo/core/di/module/injection_module.dart' as _i10;
import 'package:flutter_todo/utils/functions/get_context_func.dart' as _i5;
import 'package:flutter_todo/utils/services/dialog_service.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final injectionModules = _$InjectionModules();
  gh.lazySingleton<_i3.AppRouter>(() => _i3.AppRouter());
  await gh.lazySingletonAsync<_i4.HiveConfig>(
    () => injectionModules.boxClient(),
    preResolve: true,
  );
  gh.lazySingleton<_i5.GetContextFunc>(
      () => _i5.GetContextFunc(gh<_i3.AppRouter>()));
  gh.lazySingleton<_i6.TaskLocalDataSource>(
      () => _i6.TaskLocalDataSourceImpl(hive: gh<_i4.HiveConfig>()));
  gh.lazySingleton<_i7.TaskRepository>(() => _i8.TaskRepositoryImpl(
      taskLocalDataSource: gh<_i6.TaskLocalDataSource>()));
  gh.lazySingleton<_i9.DialogService>(
      () => _i9.DialogService(gh<_i5.GetContextFunc>()));
  return getIt;
}

class _$InjectionModules extends _i10.InjectionModules {}
