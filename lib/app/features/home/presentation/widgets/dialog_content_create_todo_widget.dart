import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_todo/app/widgets/main_button_widget.dart';
import 'package:flutter_todo/app/widgets/main_text_form_field_widget.dart';

class DialogContentCreateTodoWidget extends StatefulWidget {
  final Function(String titleTask) onTapTitleTask;
  const DialogContentCreateTodoWidget({
    super.key,
    required this.onTapTitleTask,
  });

  @override
  State<DialogContentCreateTodoWidget> createState() =>
      _DialogContentCreateTodoWidgetState();
}

class _DialogContentCreateTodoWidgetState
    extends State<DialogContentCreateTodoWidget> {
  final TextEditingController _titleTaskController = TextEditingController();

  bool _isButtonEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Input Your Task',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        10.verticalSpace,
        MainTextFormFieldWidget(
          controller: _titleTaskController,
          hintText: 'Please input your title task',
          onChanged: (value) {
            if (value.length > 4) {
              _isButtonEnabled = true;
            } else {
              _isButtonEnabled = false;
            }
            setState(() {});
          },
        ),
        24.verticalSpace,
        MainButtonWidget(
          text: 'Submit',
          onTap: _isButtonEnabled
              ? () {
                  widget.onTapTitleTask(_titleTaskController.text);
                }
              : null,
        )
      ],
    );
  }
}
