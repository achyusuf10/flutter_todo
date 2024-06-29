import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_todo/config/routes/route_name.dart';
import 'package:flutter_todo/utils/functions/get_context_func.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_cubit.freezed.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final GetContextFunc _context;
  SplashCubit(this._context) : super(const SplashState()) {
    _onInit();
  }

  Future<void> _onInit() async {
    await Future.delayed(const Duration(seconds: 2));
    _context.i.router.replaceNamed(RouteName.home);
  }
}
