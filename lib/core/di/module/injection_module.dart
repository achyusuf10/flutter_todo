import 'package:flutter_todo/config/source_config/local/hive_config.dart';
import 'package:flutter_todo/config/source_config/local/hive_config_impl.dart';
import 'package:injectable/injectable.dart';

@module
abstract class InjectionModules {
  @lazySingleton
  @preResolve
  Future<HiveConfig> boxClient() => HiveConfigImpl.instance();
}
