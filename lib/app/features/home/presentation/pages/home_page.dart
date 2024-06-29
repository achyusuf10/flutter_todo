import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_todo/app/features/home/presentation/blocs/bloc/home_bloc.dart';
import 'package:flutter_todo/app/features/task/domain/entities/todo_entity.dart';
import 'package:flutter_todo/app/widgets/general_empty_widget.dart';
import 'package:flutter_todo/app/widgets/shimmer_widget.dart';
import 'package:flutter_todo/config/themes/app_colors.dart';
import 'package:flutter_todo/core/state/ui_state.dart';
import 'package:flutter_todo/utils/extensions/date_time_ext.dart';
import 'package:flutter_todo/utils/functions/get_controller_func.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc _bloc;

  @override
  void initState() {
    _bloc = GetControllerFunc.call<HomeBloc>();
    _bloc.add(const HomeEvent.started());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.secondary,
          title: Text(
            'ToDo List',
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          onPressed: () {
            _bloc.add(const HomeEvent.createTodo());
          },
          child: const Icon(
            Icons.add,
          ),
        ),
        body: BlocSelector<HomeBloc, HomeState, UIState<List<TodoEntity>>>(
          selector: (state) => state.stateDataListTodo,
          builder: (context, state) {
            return state.when(
              success: (listData) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: ReorderableListView.builder(
                    onReorder: (oldIndex, newIndex) {
                      _bloc.add(HomeEvent.reOrderToDo(
                        oldIndex: oldIndex,
                        newIndex: newIndex,
                      ));
                    },
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 10)
                            .w,
                    itemBuilder: (context, index) {
                      var curData = listData[index];
                      return GestureDetector(
                        key: ValueKey(curData.id),
                        onTap: () {
                          _bloc.add(HomeEvent.onTapTodo(todo: curData));
                        },
                        child: Container(
                          height: 72.h,
                          margin: EdgeInsets.only(bottom: 10.h),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColors.gray900,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                activeColor: AppColors.primary,
                                value: curData.isCompleted,
                                onChanged: (_) {
                                  _bloc.add(
                                      HomeEvent.onToogleTodo(todo: curData));
                                },
                              ),
                              8.horizontalSpace,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      curData.title,
                                      maxLines: 1,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                        decoration: curData.isCompleted
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                      ),
                                    ),
                                    4.verticalSpace,
                                    if (curData.dueDate != null)
                                      Text(
                                        curData.dueDate.extToFormattedString(
                                          outputDateFormat:
                                              'dd MMM yyyy / HH:mm',
                                        ),
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: AppColors.gray400,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              IconButton(
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  _bloc.add(
                                      HomeEvent.deleteTodo(idTodo: curData.id));
                                },
                                icon: const Icon(
                                  Icons.delete_outline_rounded,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: listData.length,
                  ),
                );
              },
              empty: (message) => Center(
                child: GeneralEmptyErrorWidget.empty(
                  descText: message,
                ),
              ),
              loading: () => const ShimmerWidget.list(
                length: 4,
              ),
              error: (message) => Center(
                child: GeneralEmptyErrorWidget.error(
                  onRefresh: () {
                    _bloc.add(const HomeEvent.started());
                  },
                  descText: message,
                ),
              ),
              idle: () => const SizedBox(),
            );
          },
        ),
      ),
    );
  }
}
